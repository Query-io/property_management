<template>
  <div class="property-add-container">
    <el-card class="form-card">
      <div slot="header" class="form-title">添加公告</div>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="公告标题" prop="noticeTitle">
              <el-input v-model="form.noticeTitle" placeholder="请输入公告标题" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="公告类型" prop="noticeType">
              <el-select v-model="form.noticeType" placeholder="请选择公告类型">
                <el-option
                  v-for="dict in dict.type.sys_notice_type"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="状态">
              <el-radio-group v-model="form.status">
                <el-radio
                  v-for="dict in dict.type.sys_notice_status"
                  :key="dict.value"
                  :label="dict.value"
                >{{ dict.label }}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="内容">
              <editor v-model="form.noticeContent" :min-height="192" />
            </el-form-item>
          </el-col>
          <el-col :span="24" class="form-actions">
            <el-button type="primary" @click="handleSubmit">提交</el-button>
            <el-button @click="handleCancel">返回</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { addNotice } from "@/api/system/notice";

export default {
  name: "NoticeForm",
  dicts: ['sys_notice_status', 'sys_notice_type'],
  data() {
    return {
      form: {
        noticeTitle: '',
        noticeType: '',
        noticeContent: '',
        status: '0',
      },
      rules: {
        noticeTitle: [{ required: true, message: "公告标题不能为空", trigger: "blur" }],
        noticeType: [{ required: true, message: "公告类型不能为空", trigger: "change" }]
      }
    };
  },
  methods: {
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          addNotice(this.form).then(() => {
            this.$message.success("新增成功");
            this.$router.push("/notice/notice");
          });
        }
      });
    },
    handleCancel() {
      this.$router.back();
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
