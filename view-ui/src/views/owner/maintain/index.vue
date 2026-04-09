<template>
  <div class="app-container">
    <!-- 基本信息 -->
    <el-row>
      <el-col :span="24" class="card-box">
        <el-card>
          <div slot="header"><span><i class="el-icon-user"></i> 业主基本信息</span></div>
          <div v-if="ownerInfo">
            <!-- 编辑表单 -->
            <el-form :model="ownerInfo" label-width="120px" :rules="formRules" ref="ownerForm">
              <el-form-item label="业主姓名">
                <span>{{ user.userName }}</span> <!-- 显示 userName，且不可编辑 -->
              </el-form-item>
              <el-form-item label="出生日期" prop="dateOfBirth">
                <el-date-picker v-model="ownerInfo.dateOfBirth" type="date" placeholder="选择出生日期"></el-date-picker>
              </el-form-item>
              <el-form-item label="身份证号" prop="identityNo">
                <el-input v-model="ownerInfo.identityNo" placeholder="请输入身份证号"></el-input>
              </el-form-item>
              <el-form-item label="联系电话" prop="phoneNumber">
                <el-input v-model="ownerInfo.phoneNumber" placeholder="请输入联系电话"></el-input>
              </el-form-item>
              <el-form-item label="联系地址">
                <el-input v-model="ownerInfo.address" placeholder="请输入联系地址"></el-input>
              </el-form-item>
              <el-form-item label="积分">
                <el-input v-model="ownerInfo.occupation" placeholder="积分" disabled></el-input>
              </el-form-item>
              <el-form-item label="车牌号码">
                <el-input v-model="ownerInfo.signature" placeholder="请输入车牌号码"></el-input>
              </el-form-item>
            </el-form>
            <div>
              <el-button type="primary" @click="submitForm" v-if="!ownerInfo.ownerId">提交录入</el-button> <!-- 提交录入按钮 -->
              <el-button type="primary" @click="updateOwner" v-else>提交修改</el-button> <!-- 修改按钮 -->
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 房产信息 -->
    <el-row>
      <el-col :span="24" class="card-box">
        <el-card>
          <div slot="header"><span><i class="el-icon-home"></i> 房产信息</span></div>
          <div v-if="propertyList.length">
            <el-row :gutter="20">
              <el-col :span="8" v-for="(property, index) in propertyList" :key="index">
                <el-card :body-style="{ padding: '20px' }">
                  <img :src="getFullImageUrl(property.imageUrl)" alt="房产图片" style="width: 100%; height: 180px; object-fit: cover;" />
                  <div style="padding: 10px;">
                    <p><strong>房产地址:</strong> {{ property.propertyAddress }}</p>
                    <p><strong>所属区域:</strong> {{ property.region }}</p>
                    <p><strong>所属楼栋:</strong> {{ property.buildingNo }}</p>
                    <p><strong>楼层:</strong> {{ property.floor }}</p>
                    <p><strong>房屋类型:</strong> {{ property.propertyType }}</p>
                  </div>
                </el-card>
              </el-col>
            </el-row>
          </div>
          <div v-else>
            <p>没有房产信息。</p>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { getOwnerByUser, addOwner, updateOwner } from "@/api/system/owner";
import { listByOwnerId } from "@/api/system/property";
import { getUserProfile } from "@/api/system/user";

export default {
  data() {
    return {
      ownerInfo: {
        ownerId: null,// 初始化为空的业主信息对象
        ownerName: '',
        dateOfBirth: '',
        identityNo: '',
        phoneNumber: '',
        address: '',
        occupation: '',
        signature: ''
      },
      propertyList: [], // 房产信息列表
      user: {}, // 当前用户信息
      formRules: { // 添加验证规则
        dateOfBirth: [{ required: true, message: "请选择出生日期", trigger: "blur" }],
        identityNo: [{ required: true, message: "请输入身份证号", trigger: "blur" }],
        phoneNumber: [{ required: true, message: "请输入联系电话", trigger: "blur" }]
      }
    };
  },
  created() {
    this.getUser();
    this.fetchOwnerInfo();  // 获取当前用户的业主信息
  },
  methods: {
    getFullImageUrl(url) {
      if (!url) return ''; // 防止空值
      return process.env.VUE_APP_BASE_API + url;
    },
    async fetchOwnerInfo() {
      try {
        const response = await getOwnerByUser();
        if (response.data) {
          this.ownerInfo = response.data;
          console.log(this.ownerInfo.ownerId)
          this.fetchPropertyInfo();  // 获取房产信息
        }
      } catch (error) {
        console.error("获取业主信息失败", error);
      }
    },

    async fetchPropertyInfo() {
      if (this.ownerInfo) {
        try {
          const response = await listByOwnerId(this.ownerInfo.ownerId);
          if (response.data) {
            this.propertyList = response.data;
          }
        } catch (error) {
          console.error("获取房产信息失败", error);
        }
      }
    },

    // 提交表单
    async submitForm() {
      this.$refs.ownerForm.validate(async (valid) => {
        if (valid) {
          try {
            const newOwner = {
              ownerName: this.user.userName,  // 直接传入 userName
              userId: this.user.userId,  // 将 userId 传入接口
              phoneNumber: this.ownerInfo.phoneNumber,
              address: this.ownerInfo.address,
              occupation: this.ownerInfo.occupation,
              signature: this.ownerInfo.signature,
              dateOfBirth: this.ownerInfo.dateOfBirth,
              identityNo: this.ownerInfo.identityNo
            };
            await addOwner(newOwner);
            this.$message.success("业主信息录入成功！");
            await this.fetchOwnerInfo(); // 等到接口写入成功后再拉取

          } catch (error) {
            console.error("录入业主信息失败", error);
          }
        }
      });
    },

    // 修改业主信息
    async updateOwner() {
      this.$refs.ownerForm.validate(async (valid) => {
        if (valid) {
          try {
            await updateOwner(this.ownerInfo);
            this.$message.success("信息修改成功");
            await this.fetchOwnerInfo();  // 更新修改后的信息
          } catch (error) {
            console.error("修改业主信息失败", error);
          }
        }
      });
    },

    getUser() {
      getUserProfile().then(response => {
        this.user = response.data;
      });
    }
  },
};
</script>

<style scoped>
.card-box {
  margin-bottom: 20px;
}
</style>
