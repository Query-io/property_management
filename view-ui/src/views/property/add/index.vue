<template>
  <div class="property-add-container">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>房产信息录入</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="$router.back()">返回</el-button>
      </div>

      <el-form ref="propertyForm" :model="form" label-width="100px" :rules="rules">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="房产地址" prop="propertyAddress">
              <el-input v-model="form.propertyAddress" placeholder="请输入房产地址"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="所属区域" prop="region">
              <el-input v-model="form.region" placeholder="请输入所属区域"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="6">
            <el-form-item label="楼栋">
              <el-input v-model="form.buildingNo" placeholder="请输入楼栋"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="单元号">
              <el-input v-model="form.unitNo" placeholder="请输入单元号"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="楼层">
              <el-input type="number" v-model="form.floor" placeholder="请输入楼层"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="房间号">
              <el-input v-model="form.roomNo" placeholder="请输入房间号"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="建筑面积">
              <el-input v-model="form.buildingArea" placeholder="请输入建筑面积"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="使用面积">
              <el-input v-model="form.usableArea" placeholder="请输入使用面积"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="房屋类型">
              <el-select v-model="form.propertyType" placeholder="请选择房屋类型">
                <el-option label="住宅" value="住宅"></el-option>
                <el-option label="商用" value="商用"></el-option>
                <el-option label="办公" value="办公"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态">
              <el-select v-model="form.status" placeholder="请选择状态">
                <el-option label="空置" value="0"></el-option>
                <el-option label="占用" value="1"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item class="form-footer">
          <el-button type="primary" @click="submitForm">提交</el-button>
          <el-button @click="resetForm">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { addProperty } from '@/api/system/property';
export default {
  name: 'PropertyAdd',
  data() {
    return {
      form: {
        propertyAddress: '',
        region: '',
        buildingNo: '',
        unitNo: '',
        floor: null,
        roomNo: '',
        buildingArea: null,
        usableArea: null,
        ownerId: null,
        owner: '',
        propertyType: '',
        status: '0'
      },
      rules: {
        propertyAddress: [{ required: true, message: '请输入房产地址', trigger: 'blur' }],
        region: [{ required: true, message: '请输入所属区域', trigger: 'blur' }],
        unitNo: [{ required: true, message: '请输入单元号', trigger: 'blur' }],
        roomNo: [{ required: true, message: '请输入房间号', trigger: 'blur' }],

      }
    }
  },
  methods: {
    submitForm() {
      this.$refs.propertyForm.validate(valid => {
        if (valid) {
          addProperty(this.form).then(() => {
            this.$message.success('新增成功');
            this.$router.back();
          });
        }
      });
    },
    resetForm() {
      this.$refs.propertyForm.resetFields();
    }
  }
}
</script>

<style scoped>
.property-add-container {
  padding: 30px;
  max-width: 1300px;
  max-height: 1000px;
  margin: 0 auto;
}
.box-card {
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.form-footer {
  display: flex;
  justify-content: center; /* 水平居中 */
  gap: 12px;                /* 按钮间距 */
  margin-top: 20px;
}
</style>
