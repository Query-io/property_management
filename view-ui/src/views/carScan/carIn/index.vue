<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!-- 上传区域 -->
      <el-col :span="12" style="padding-left: 50px; padding-right: 50px; ">
        <el-card class="box-card" style="height: 600px">
          <div slot="header" class="clearfix">
            <span>车辆扫描</span>
          </div>

          <el-upload class="upload-demo" drag :before-upload="beforeUpload" :show-file-list="false"
            :http-request="handleUpload" action="''" ref="upload">
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

            <el-form-item label="停车场" prop="parkId">
              <el-select v-model="form.parkId" placeholder="请选择停车场">
                <el-option v-for="park in parks" :key="park.parkId" :label="park.parkName" :value="park.parkId" />
              </el-select>
            </el-form-item>

            <el-form-item label="操作" prop="plateNum">
              <el-button type="primary" @click="handleSubmit" :disabled="!form.parkId || !form.plateNum">入场</el-button>
              <el-button type="default" @click="resetForm">重置</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </el-col>
    </el-row>

    <!-- 车主信息弹窗 -->
    <el-dialog title="车辆识别结果" :visible.sync="ownerDialogVisible" width="500px" :before-close="handleDialogClose">
      <div v-if="isRegisteredVehicle">
        <el-descriptions :column="1" border>
          <el-descriptions-item label="车牌号">{{ form.plateNum }}</el-descriptions-item>
          <el-descriptions-item label="车牌颜色">{{ form.plateColor }}</el-descriptions-item>
          <el-descriptions-item label="车主姓名">{{ registeredCarInfo.ownerName }}</el-descriptions-item>
          <el-descriptions-item label="联系电话">{{ registeredCarInfo.phoneNumber }}</el-descriptions-item>
          <el-descriptions-item label="车辆品牌">{{ registeredCarInfo.carBrand }}</el-descriptions-item>
          <el-descriptions-item label="车辆型号">{{ registeredCarInfo.carModel }}</el-descriptions-item>
          <el-descriptions-item label="车辆颜色">{{ registeredCarInfo.carColor }}</el-descriptions-item>
          <el-descriptions-item label="停车位">{{ registeredCarInfo.parkingSpace }}</el-descriptions-item>
          <el-descriptions-item label="登记日期">{{ registeredCarInfo.registerDate }}</el-descriptions-item>
          <el-descriptions-item label="到期日期">{{ registeredCarInfo.expireDate }}</el-descriptions-item>
        </el-descriptions>
        <div style="margin-top: 20px; color: #67C23A; font-weight: bold;">
          ✓ 已识别为已登记车辆
        </div>
      </div>
      <div v-else>
        <el-alert title="陌生车辆" type="warning" :closable="false" description="该车牌未在系统中登记，请按陌生车辆处理。" show-icon>
        </el-alert>
        <div style="margin-top: 20px;">
          <p><strong>车牌号：</strong>{{ form.plateNum }}</p>
          <p><strong>车牌颜色：</strong>{{ form.plateColor }}</p>
        </div>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="handleDialogClose">关 闭</el-button>
        <el-button type="primary" @click="confirmDialog">确 认</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { carScan, addEntryCar, getCarByPlateNumber, listAllCars } from '@/api/system/carScan';
import { listActiveParkInfo } from '@/api/system/parkInfo';

export default {
  data() {
    return {
      carScanData: null, // 存储扫描的车牌信息
      parks: [], // 停车场列表
      registeredCars: [], // 已登记车辆列表
      form: {
        parkId: '',
        plateNum: '',
        plateColor: '',
        picture: '',
      },
      ownerDialogVisible: false, // 车主信息弹窗显示控制
      isRegisteredVehicle: false, // 是否为已登记车辆
      registeredCarInfo: null, // 已登记车辆信息
      rules: {
        parkId: [{ required: true, message: '请选择停车场', trigger: 'blur' }],
        plateNum: [
          { required: true, message: '车牌号不能为空', trigger: 'blur' }
        ],
      }
    };
  },
  created() {
    this.loadActiveParks();
    this.loadRegisteredCars();
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

    // 加载已登记车辆列表
    loadRegisteredCars() {
      listAllCars().then(response => {
        if (response.code === 200) {
          this.registeredCars = response.rows || [];
        }
      });
    },

    // 检查是否为已登记车辆
    checkVehicleRegistration(plateNum) {
      // 方法1：从已加载的列表中查找
      const foundCar = this.registeredCars.find(car =>
        car.plateNumber === plateNum
      );

      if (foundCar) {
        this.isRegisteredVehicle = true;
        this.registeredCarInfo = foundCar;
        return true;
      }

      // 方法2：调用单个查询接口作为备用
      return getCarByPlateNumber(plateNum).then(response => {
        if (response.code === 200 && response.data) {
          this.isRegisteredVehicle = true;
          this.registeredCarInfo = response.data;
          return true;
        } else {
          this.isRegisteredVehicle = false;
          this.registeredCarInfo = null;
          return false;
        }
      }).catch(error => {
        console.error('查询车辆信息失败:', error);
        this.isRegisteredVehicle = false;
        this.registeredCarInfo = null;
        return false;
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
    async handleScanSuccess(response) {
      if (response.code === 200) {
        this.carScanData = response.data; // 保存识别结果
        this.form.plateNum = this.carScanData.plateNum; // 设置车牌号
        this.form.plateColor = this.carScanData.plateColor; // 设置车牌颜色
        this.form.picture = this.carScanData.picture; // 图片地址

        // 检查是否为已登记车辆
        try {
          const isRegistered = await this.checkVehicleRegistration(this.form.plateNum);
          console.log('车辆登记状态:', isRegistered ? '已登记' : '未登记');
        } catch (error) {
          console.error('检查车辆登记状态失败:', error);
          this.isRegisteredVehicle = false;
          this.registeredCarInfo = null;
        }

        // 显示弹窗
        this.ownerDialogVisible = true;
      } else {
        this.$message.error(response.msg);
      }
    },

    // 上传车牌图片并调用 carScan 接口识别
    handleUpload({ file }) {
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

    // 弹窗确认按钮
    confirmDialog() {
      this.ownerDialogVisible = false;
      if (this.isRegisteredVehicle) {
        this.$message.success('已确认已登记车辆信息');
      } else {
        this.$message.warning('已确认为陌生车辆');
      }
    },

    // 弹窗关闭
    handleDialogClose() {
      this.ownerDialogVisible = false;
      this.isRegisteredVehicle = false;
      this.registeredCarInfo = null;
    },

    // 提交车辆入场
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (!valid) {
          this.$message.error('表单验证失败，请检查输入项');
          return;
        }

        const carScanPayload = {
          plateNum: this.form.plateNum,
          plateColor: this.form.plateColor,
          parkId: this.form.parkId,
          picture: this.form.picture,
          type: this.isRegisteredVehicle ? 1 : 0, // 新增：传递车辆类型
          isRegistered: this.isRegisteredVehicle, // 添加是否已登记标志
          carInfo: this.isRegisteredVehicle ? this.registeredCarInfo : null // 添加车辆信息
        };

        addEntryCar(carScanPayload)
          .then(response => {
            if (response.code === 200) {
              if (this.isRegisteredVehicle) {
                this.$message.success('已登记车辆已成功入场');
              } else {
                this.$message.warning('陌生车辆已成功入场，请注意管理');
              }
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
      this.form.parkId = '';
      this.form.plateNum = '';
      this.form.plateColor = '';
      this.form.picture = '';
      this.carScanData = null;
      this.isRegisteredVehicle = false;
      this.registeredCarInfo = null;
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
  height: 256px;
  /* 设置高度，以便内容居中 */
  border: 2px dashed #409eff;
  /* 添加边框 */
  border-radius: 10px;
  /* 圆角效果 */
  background-color: #f9f9f9;
  /* 背景色 */
  text-align: center;
  /* 文字居中 */
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
  max-height: 400px;
  /* 根据卡片高度调整 */
  object-fit: contain;
  border-radius: 4px;
}

/* 调整原有上传区域高度 */
.upload-demo {
  height: 400px;
  /* 与卡片高度一致 */
}
</style>