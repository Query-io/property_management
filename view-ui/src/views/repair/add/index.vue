<template>
  <div class="repair-apply-container">
    <el-card class="repair-card">
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="所属房产" prop="propertyId">
          <el-select v-model="form.propertyId" placeholder="请选择房产" clearable>
            <el-option
              v-for="item in propertyList"
              :key="item.propertyId"
              :label="item.propertyAddress"
              :value="item.propertyId"
            />
          </el-select>
        </el-form-item>

        <el-form-item label="维修项目" prop="repairItem">
          <el-input v-model="form.repairItem" placeholder="请输入维修项目" />
        </el-form-item>

        <el-form-item label="问题描述" prop="repairDescription">
          <el-input
            v-model="form.repairDescription"
            type="textarea"
            rows="4"
            placeholder="请描述维修问题"
          />
        </el-form-item>

        <el-form-item label="联系电话" prop="applicantPhone">
          <el-input v-model="form.applicantPhone" placeholder="请输入联系电话" />
        </el-form-item>

        <el-form-item label="上传图片">
          <el-upload
            class="upload-demo"
            :http-request="customUpload"
            :show-file-list="false"
            :action="''"
          >
            <el-button icon="el-icon-upload" size="small">上传图片</el-button>
          </el-upload>

          <div v-if="form.imageUrl" class="image-preview">
            <el-card :body-style="{ padding: '10px' }" shadow="hover">
              <img :src="getFullUrl(form.imageUrl)" style="max-width: 100%; max-height: 350px;" />
              <div style="text-align: right; margin-top: 5px;">
                <el-button size="mini" type="danger" icon="el-icon-delete" @click="form.imageUrl = ''">
                  删除图片
                </el-button>
              </div>
            </el-card>
          </div>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="handleSubmit">提交报修</el-button>
          <el-button @click="resetForm">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import {listByOwnerId, listByUserId} from '@/api/system/property';
import { uploadRepairImage, addRepair } from '@/api/system/repair';

export default {
  name: 'RepairApply',
  data() {
    return {
      propertyList: [],
      form: {
        propertyId: null,
        repairItem: '',
        repairDescription: '',
        applicantPhone: '',
        imageUrl: '',
        applicantId: ''
      },
      rules: {
        propertyId: [{ required: true, message: '请选择房产', trigger: 'change' }],
        repairItem: [{ required: true, message: '请输入维修项目', trigger: 'blur' }],
        repairDescription: [{ required: true, message: '请输入描述', trigger: 'blur' }],
        applicantPhone: [{ required: true, message: '请输入联系电话', trigger: 'blur' }]
      }
    };
  },
  created() {
    const userId = this.$store.state.user.id;
    this.form.applicantId = userId;
    this.loadProperties(userId);
  },
  methods: {
    getFullUrl(url) {
      console.log("url:" + url)
      if (!url) return ''; // 防止空值
      return process.env.VUE_APP_BASE_API + url;
    },
    loadProperties(userId) {
      listByUserId(userId).then(res => {
        this.propertyList = res.data;
      });
    },
    customUpload(option) {
      uploadRepairImage(option.file)
        .then(res => {
          console.log(res)
          this.form.imageUrl = res.imgUrl;
          this.$message.success('图片上传成功');
        })
        .catch(() => {
          this.$message.error('上传失败');
        });
    },
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (!valid) return;
        const selectedProperty = this.propertyList.find(p => p.propertyId === this.form.propertyId);
        if (selectedProperty) {
          this.form.propertyAddress = selectedProperty.propertyAddress;
        }

        this.form.status = '0'; // 默认设为已提交
        addRepair(this.form).then(() => {
          this.$message.success('提交成功');
          this.resetForm();
        });
      });
    },
    resetForm() {
      this.$refs.form.resetFields();
      this.form.imageUrl = '';
    }
  }
};
</script>

<style scoped>
.repair-apply-container {
  display: flex;
  justify-content: center;
  align-items: flex-start;
  padding: 30px;
  background: #f5f7fa;
  min-height: 500px;
}

.repair-card {
  width: 1000px;
}

.image-preview {
  margin-top: 10px;
  display: flex;
  justify-content: center;
}
</style>
