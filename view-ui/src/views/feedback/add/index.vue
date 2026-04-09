<template>
  <div class="property-add-container">
    <el-card class="form-card">
      <div slot="header" class="form-title">提交投诉</div>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="投诉人">
              <el-input v-model="form.userName" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系方式" prop="contact">
              <el-input v-model="form.contact" placeholder="请输入联系方式" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="投诉内容" prop="content">
              <el-input
                type="textarea"
                v-model="form.content"
                :rows="6"
                placeholder="请输入投诉内容"
              />
            </el-form-item>
          </el-col>
          <el-col :span="24" class="form-actions">
            <el-button type="primary" @click="handleSubmit">提交</el-button>
            <el-button @click="handleReset">重置</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { getUserProfile } from "@/api/system/user";
import { addFeedback } from "@/api/system/feedback"; // 你可能需要根据你的实际路径调整

export default {
  name: "AddComplaint",
  data() {
    return {
      form: {
        userName: '',
        contact: '',
        content: ''
      },
      rules: {
        contact: [{ required: true, message: "联系方式不能为空", trigger: "blur" }],
        content: [{ required: true, message: "投诉内容不能为空", trigger: "blur" }]
      }
    };
  },
  created() {
    this.initUser();
  },
  methods: {
    /** 获取用户信息 */
    initUser() {
      getUserProfile().then(response => {
        this.form.userName = response.data.userName;
      });
    },
    /** 提交表单 */
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          this.$confirm('确认提交该投诉信息吗？', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            addFeedback(this.form).then(() => {
              this.$message.success("投诉已提交");
              this.$router.back();
            });
          }).catch(() => {
            this.$message.info('已取消提交');
          });
        }
      });
    },
    /** 重置表单 */
    handleReset() {
      this.form.contact = '';
      this.form.content = '';
    }
  }
};
</script>

<style scoped>
.property-add-container {
  display: flex;
  justify-content: center;
  padding: 40px 20px;
}

.form-card {
  width: 800px;
  padding: 20px;
}

.form-title {
  font-size: 18px;
  font-weight: bold;
}

.form-actions {
  text-align: center;
  margin-top: 20px;
}
</style>
