<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!-- 上传区域 -->
      <el-col :span="12" style="padding-left: 50px; padding-right: 50px;">
        <el-card class="box-card" style="height: 600px">
          <div slot="header" class="clearfix">
            <span>车辆扫描</span>
          </div>

          <el-upload
            class="upload-demo"
            drag
            :before-upload="beforeUpload"
            :show-file-list="false"
            :http-request="handleUpload"
            action="''"
            ref="upload"
          >
            <!-- 上传后的图片预览 -->
            <div v-if="form.picture" class="preview-container">
              <img :src="getFullUrl(form.picture)" class="preview-image" alt="车牌图片">
            </div>

            <!-- 默认上传提示（图片未上传时显示） -->
            <template v-else>
              <i class="el-icon-upload"></i>
              <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
              <div class="el-upload__tip">只能上传 JPG 或 PNG 文件，且不超过 500KB</div>
            </template>
          </el-upload>
        </el-card>
      </el-col>

      <!-- 表单区域 -->
      <el-col :span="12" style="padding-left: 50px; padding-right: 50px;">
        <el-card class="box-card" style="height: 600px">
          <div slot="header" class="clearfix">
            <span>车辆信息</span>
          </div>

          <el-form :model="form" ref="form" label-width="120px" :rules="rules">
            <el-form-item label="车牌号" prop="plateNum">
              <el-input v-model="form.plateNum" :disabled="true"></el-input>
            </el-form-item>

            <el-form-item label="车牌颜色" prop="plateColor">
              <el-input v-model="form.plateColor" :disabled="true"></el-input>
            </el-form-item>

            <el-form-item label="操作" prop="plateNum">
              <el-button type="primary" @click="handleSubmit" :disabled="!form.plateNum">出场</el-button>
              <el-button type="default" @click="resetForm">重置</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { carScan, exitCar } from '@/api/system/carScan';
import { listActiveParkInfo } from '@/api/system/parkInfo';

export default {
  data() {
    return {
      carScanData: null, // 存储扫描的车牌信息
      parks: [], // 停车场列表
      form: {
        plateNum: '',
        plateColor: '',
        picture: '',
      },
      rules: {
        plateNum: [
          { required: true, message: '车牌号不能为空', trigger: 'blur' }
        ],
      }
    };
  },
  created() {
    this.loadActiveParks();
  },
  methods: {
    getFullUrl(url) {
      if (!url) return ''; // 防止空值
      return process.env.VUE_APP_BASE_API + url;
    },
    loadActiveParks() {
      listActiveParkInfo().then(response => {
        this.parks = response.data;
      });
    },

    // 上传文件前的校验
    beforeUpload(file) {
      const isImage = file.type === 'image/jpeg' || file.type === 'image/png';
      if (!isImage) {
        this.$message.error('只能上传 JPG 或 PNG 文件');
      }
      return isImage;
    },

    // 处理车牌扫描成功
    handleScanSuccess(response) {
      if (response.code === 200) {
        this.carScanData = response.data; // 保存识别结果
        this.form.plateNum = this.carScanData.plateNum; // 设置车牌号
        this.form.plateColor = this.carScanData.plateColor; // 设置车牌颜色
        this.form.picture = this.carScanData.picture; // 图片地址
      } else {
        this.$message.error(response.msg);
      }
    },

    // 上传车牌图片并调用 carScan 接口识别
    handleUpload({file}) {
      console.log(file)
      carScan(file).then(response => {
        if (response.code === 200) {
          this.handleScanSuccess(response); // 处理识别结果
        } else {
          this.$message.error(response.msg || '车牌识别失败');
        }
      }).catch(error => {
        this.$message.error('车牌识别请求失败');
      });
    },

    // 提交车辆出场
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (!valid) {
          this.$message.error('表单验证失败，请检查输入项');
          return;
        }

        const carScanPayload = {
          plateNum: this.form.plateNum,
          plateColor: this.form.plateColor,
          picture: this.form.picture
        };

        exitCar(carScanPayload)
          .then(response => {
            if (response.code === 200) {
              this.$message.success('车辆已成功出库！');
              this.resetForm();
            } else {
              this.$message.error(response.msg);
            }
          })
          .catch(error => {
            this.$message.error(error.message);
          });
      });
    },

    // 重置表单
    resetForm() {
      this.form.plateNum = '';
      this.form.plateColor = '';
      this.carScanData = null;
      this.$refs.form.resetFields(); // 重置表单字段
    }
  }
};
</script>

<style scoped>
.upload-demo {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 256px; /* 设置高度，以便内容居中 */
  border: 2px dashed #409eff; /* 添加边框 */
  border-radius: 10px; /* 圆角效果 */
  background-color: #f9f9f9; /* 背景色 */
  text-align: center; /* 文字居中 */
}
.upload-demo i {
  font-size: 40px;
  color: #409eff;
}
.el-upload__text {
  font-size: 16px;
  color: #333;
}

.el-upload__tip {
  font-size: 12px;
  color: #999;
}

.box-card {
  padding: 50px;
}

/* 新增图片预览样式 */
.preview-container {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.preview-image {
  max-width: 100%;
  max-height: 400px; /* 根据卡片高度调整 */
  object-fit: contain;
  border-radius: 4px;
}

/* 调整原有上传区域高度 */
.upload-demo {
  height: 400px; /* 与卡片高度一致 */
}
</style>
