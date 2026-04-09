<template>
  <div class="app-container">
    <!-- 搜索表单 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="订单编号" prop="orderNo">
        <el-input v-model="queryParams.orderNo" placeholder="请输入订单编号" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="业主姓名" prop="userName">
        <el-input v-model="queryParams.userName" placeholder="请输入业主姓名" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="订单类型" prop="orderType">
        <el-select v-model="queryParams.orderType" placeholder="请选择类型" clearable>
          <el-option v-for="dict in dict.type.sys_order_type" :key="dict.value" :label="dict.label"
            :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 订单表格 -->
    <el-table v-loading="loading" :data="orderList" highlight-current-row>
      <el-table-column prop="orderNo" label="订单编号" align="center" />
      <el-table-column prop="orderType" label="订单类型" align="center" />
      <el-table-column prop="userId" label="业主ID" align="center" />
      <el-table-column prop="userName" label="业主姓名" align="center" />
      <el-table-column prop="propertyId" label="房产ID" align="center" v-if="showPropertyColumn" />
      <el-table-column prop="propertyAddress" label="房产地址" align="center" v-if="showPropertyColumn" />
      <el-table-column prop="totalAmount" label="订单总额" align="center" />
      <!-- 修改实付金额列：未支付时显示为空 -->
      <el-table-column prop="actualAmount" label="实付金额" align="center">
        <template slot-scope="scope">
          <span v-if="scope.row.status === '0'">
            {{ scope.row.actualAmount !== null && scope.row.actualAmount !== undefined ? scope.row.actualAmount : scope.row.totalAmount }}
          </span>
          <span v-else>-</span>
        </template>
      </el-table-column>
      <!-- 修改积分使用列：未支付时显示为空 -->
      <el-table-column prop="pointsUsed" label="使用积分" align="center">
        <template slot-scope="scope">
          <span v-if="scope.row.status === '0'">
            <el-tag v-if="scope.row.pointsUsed && scope.row.pointsUsed > 0" type="success">
              {{ scope.row.pointsUsed }}
            </el-tag>
            <span v-else>-</span>
          </span>
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="提交时间" align="center">
        <template slot-scope="scope">{{ parseTime(scope.row.createTime) }}</template>
      </el-table-column>
      <el-table-column label="支付状态" prop="status" width="80">
        <template slot="default" slot-scope="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'danger'">
            {{ scope.row.status === '0' ? '已支付' : '待支付' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="payTime" label="支付时间" align="center">
        <template slot-scope="scope">
          <span v-if="scope.row.status === '0'">{{ parseTime(scope.row.payTime) }}</span>
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center">
        <template slot="default" slot-scope="scope">
          <el-button type="text" size="mini" icon="el-icon-view" @click="viewDetails(scope.row)">详情</el-button>
          <el-button v-if="scope.row.status === '1'" type="text" size="small" @click="handlePay(scope.row)">
            支付
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize"
      @pagination="getList" />

    <!-- 详情对话框 -->
    <el-dialog :visible.sync="showDetailDialog" width="800px" title="订单详情" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="订单编号">{{ currentOrder.orderNo }}</el-descriptions-item>
        <el-descriptions-item label="订单类型">{{ currentOrder.orderType }}</el-descriptions-item>
        <el-descriptions-item label="业主ID">{{ currentOrder.userId }}</el-descriptions-item>
        <el-descriptions-item label="业主姓名">{{ currentOrder.userName }}</el-descriptions-item>
        <el-descriptions-item label="房产ID" v-if="currentOrder.propertyId">{{ currentOrder.propertyId
          }}</el-descriptions-item>
        <el-descriptions-item label="房产地址" v-if="currentOrder.propertyId">{{ currentOrder.propertyAddress
          }}</el-descriptions-item>
        <el-descriptions-item label="订单总额">{{ currentOrder.totalAmount }}</el-descriptions-item>
        <!-- 修改详情中的实付金额显示：未支付时显示为空 -->
        <el-descriptions-item label="实付金额">
          <span v-if="currentOrder.status === '0'">
            {{ currentOrder.actualAmount !== null && currentOrder.actualAmount !== undefined ? currentOrder.actualAmount : currentOrder.totalAmount }}
          </span>
          <span v-else>-</span>
        </el-descriptions-item>
        <!-- 修改详情中的积分使用显示：未支付时显示为空 -->
        <el-descriptions-item label="积分使用">
          <span v-if="currentOrder.status === '0'">
            <el-tag v-if="currentOrder.pointsUsed && currentOrder.pointsUsed > 0" type="success">
              {{ currentOrder.pointsUsed }}
            </el-tag>
            <span v-else>无</span>
          </span>
          <span v-else>-</span>
        </el-descriptions-item>
        <el-descriptions-item label="提交时间">{{ parseTime(currentOrder.createTime) }}</el-descriptions-item>
        <el-descriptions-item label="支付时间">
          <span v-if="currentOrder.status === '0'">{{ parseTime(currentOrder.payTime) }}</span>
          <span v-else>-</span>
        </el-descriptions-item>
        <el-descriptions-item label="关联单id"
          v-if="currentOrder.associationId">{{ currentOrder.associationId }}</el-descriptions-item>
      </el-descriptions>

      <el-divider>订单明细</el-divider>
      <el-row :gutter="20">
        <el-col :span="12" v-for="item in orderItems" :key="item.id">
          <el-card shadow="hover">
            <p v-if="item.itemName"><strong>明细名称：</strong>{{ item.itemName }}</p>
            <p v-if="item.item"><strong>数量：</strong>{{ item.quantity }}</p>
            <p v-if="item.unitPrice"><strong>单价：</strong>{{ item.unitPrice }}</p>
            <p v-if="item.amount"><strong>金额：</strong>{{ item.amount }}</p>
            <p v-if="item.description"><strong>描述：</strong>{{ item.description }}</p>
          </el-card>
        </el-col>
      </el-row>
    </el-dialog>

    <!-- 支付对话框 -->
    <el-dialog title="模拟支付二维码" :visible.sync="payDialogVisible" width="450px" @close="handlePayDialogClose">
      <div style="text-align: center;">
        <img :src="qrCodeUrl" style="width: 200px; height: 200px;" alt="二维码" />
        <p style="margin-top: 10px; color: gray; font-size: 12px;">仅供模拟扫码支付</p>
      </div>

      <!-- 积分抵扣区域 -->
      <el-divider>积分抵扣</el-divider>

      <div style="margin-bottom: 15px; padding: 10px; background-color: #f8f9fa; border-radius: 4px;">
        <p style="margin: 5px 0; font-size: 14px;">
          <span style="color: #606266;">订单总额：</span>
          <span style="font-weight: bold; color: #f56c6c;">¥{{ currentOrder.totalAmount || 0 }}</span>
        </p>
        <p style="margin: 5px 0; font-size: 14px;">
          <span style="color: #606266;">当前积分：</span>
          <span style="font-weight: bold; color: #67c23a;">{{ userPointsData && userPointsData.points ? userPointsData.points : 0 }}</span>
          <span style="font-size: 12px; color: #909399;"> (10积分抵1元)</span>
        </p>
        <p style="margin: 5px 0; font-size: 14px;" v-if="usePoints && pointsForm.pointsToUse > 0">
          <span style="color: #606266;">抵扣金额：</span>
          <span style="font-weight: bold; color: #e6a23c;">¥{{ deductionAmount || 0 }}</span>
        </p>
        <p style="margin: 5px 0; font-size: 14px;" v-if="usePoints && pointsForm.pointsToUse > 0">
          <span style="color: #606266;">实际支付：</span>
          <span style="font-weight: bold; color: #409eff;">¥{{ actualAmount || 0 }}</span>
        </p>
      </div>

      <el-form :model="pointsForm" ref="pointsForm" size="small" label-width="0">
        <el-form-item>
          <el-checkbox v-model="usePoints" @change="handlePointsCheckboxChange">
            使用积分抵扣
          </el-checkbox>
        </el-form-item>

        <el-form-item v-if="usePoints" prop="pointsToUse" :rules="[{ validator: validatePoints, trigger: 'blur' }]">
          <el-input v-model.number="pointsForm.pointsToUse" placeholder="请输入要抵扣的积分" type="number" :min="0"
            :max="userPointsData && userPointsData.points ? userPointsData.points : 0" @input="handlePointsInput" style="width: 100%; margin-bottom: 10px;">
            <template slot="append">分</template>
          </el-input>

          <!-- 添加滑块 -->
          <div style="margin-top: 15px;">
            <el-slider v-model="pointsForm.pointsToUse" :min="0" :max="userPointsData && userPointsData.points ? userPointsData.points : 0" :step="10" show-stops
              :format-tooltip="formatPointsTooltip" @change="handleSliderChange"
              style="width: 90%; margin: 0 auto;"></el-slider>
            <div style="text-align: center; margin-top: 5px; font-size: 12px; color: #909399;">
              滑动选择抵扣积分
            </div>
          </div>

          <!-- 快捷操作按钮 -->
          <div style="margin-top: 15px; text-align: center;">
            <el-button type="text" size="mini" @click="useMaxPoints" style="margin-right: 15px;">
              使用最大抵扣
            </el-button>
            <el-button type="text" size="mini" @click="useHalfPoints">
              使用一半积分
            </el-button>
          </div>
        </el-form-item>
      </el-form>

      <div style="text-align: center; margin-top: 20px;">
        <el-button type="success" @click="simulatePay" :loading="payLoading">
          模拟扫码支付
        </el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import {
  listOrderByAdmin,
  getOrder,
  listOrderItems,
  listOrderByUser,
  generateParQr,
  payOrder
} from "@/api/system/order";

// 导入积分相关API - 修改为导入 adjustPoints 和 getPointsByUserId
import { getPointsByUserId, adjustPoints } from "@/api/system/ownerPoints";

export default {
  name: "UserOrder",
  dicts: ['sys_order_type'],
  data() {
    // 积分验证规则
    const validatePoints = (rule, value, callback) => {
      const userPoints = this.userPointsData && this.userPointsData.points ? this.userPointsData.points : 0;
      
      if (value === '' || value === null) {
        callback(new Error('请输入抵扣积分'));
      } else if (value < 0) {
        callback(new Error('积分不能为负数'));
      } else if (value > userPoints) {
        callback(new Error(`积分不能超过${userPoints}`));
      } else if (value % 10 !== 0) {
        callback(new Error('积分必须是10的倍数'));
      } else {
        callback();
      }
    };

    return {
      loading: false,
      total: 0,
      showSearch: true,
      showDetailDialog: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        orderNo: undefined,
        userName: undefined,
        orderType: undefined
      },
      orderList: [],
      currentOrder: {},
      orderItems: [],
      payingOrderId: null,
      payDialogVisible: false,
      qrCodeUrl: '',
      payLoading: false,

      // 积分相关数据
      userPointsData: null, // 存储用户积分完整信息
      usePoints: false, // 是否使用积分抵扣
      pointsForm: {
        pointsToUse: 0 // 要使用的积分
      },

      // 计算金额
      deductionAmount: 0, // 抵扣金额
      actualAmount: 0, // 实际支付金额

      // 验证规则
      validatePoints
    };
  },
  computed: {
    showPropertyColumn() {
      return this.orderList.some(order => order.propertyId);
    }
  },
  created() {
    this.getList();
  },
  watch: {
    // 监听积分输入变化
    'pointsForm.pointsToUse': function (newVal) {
      this.calculateAmounts();
    },
    // 监听是否使用积分
    usePoints: function (newVal) {
      if (newVal) {
        this.pointsForm.pointsToUse = 0;
        this.calculateAmounts();
      } else {
        this.deductionAmount = 0;
        this.actualAmount = this.currentOrder.totalAmount || 0;
      }
    }
  },
  methods: {
    getList() {
      this.loading = true;
      listOrderByUser(this.queryParams).then(res => {
        this.orderList = res.rows;
        this.total = res.total;
        this.loading = false;
      });
    },
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    resetQuery() {
      this.queryParams = {
        pageNum: 1,
        pageSize: 10,
        orderNo: undefined,
        userName: undefined,
        orderType: undefined
      };
      this.getList();
    },
    viewDetails(row) {
      this.currentOrder = row;
      listOrderItems(row.id).then(res => {
        this.orderItems = res.data;
        this.showDetailDialog = true;
      });
    },
    // 修改支付对话框中获取积分的逻辑
    async handlePay(row) {
      this.currentOrder = row;
      this.payingOrderId = row.id;

      try {
        // 1. 获取用户完整积分信息 - 包括ownerId, updateTime等
        const pointsRes = await getPointsByUserId(row.userId);
        console.log('获取用户积分信息:', pointsRes.data);
        
        // 保存完整的积分信息
        this.userPointsData = pointsRes.data || {};
        if (!this.userPointsData || !this.userPointsData.ownerId) {
          this.$message.error("未找到该用户的积分信息");
          return;
        }

        // 2. 生成支付二维码
        const qrRes = await generateParQr(row.id);
        this.qrCodeUrl = qrRes.data;

        // 3. 初始化金额和表单
        this.deductionAmount = 0;
        this.actualAmount = row.totalAmount || 0;
        this.usePoints = false;
        this.pointsForm.pointsToUse = 0;

        // 4. 显示支付对话框
        this.payDialogVisible = true;

      } catch (error) {
        console.error("获取积分或生成二维码失败:", error);
        this.$message.error("支付准备失败，请重试");
      }
    },

    // 计算抵扣金额和实际支付金额
    calculateAmounts() {
      if (!this.usePoints || !this.pointsForm.pointsToUse) {
        this.deductionAmount = 0;
        this.actualAmount = this.currentOrder.totalAmount || 0;
        return;
      }

      // 10积分抵1元
      this.deductionAmount = this.pointsForm.pointsToUse / 10;
      this.actualAmount = Math.max(0, (this.currentOrder.totalAmount || 0) - this.deductionAmount);

      // 四舍五入保留两位小数
      this.deductionAmount = Math.round(this.deductionAmount * 100) / 100;
      this.actualAmount = Math.round(this.actualAmount * 100) / 100;
    },

    // 积分输入处理
    handlePointsInput(value) {
      // 确保是整数
      this.pointsForm.pointsToUse = Math.floor(value);
      this.calculateAmounts();
    },

    // 滑块变化处理
    handleSliderChange(value) {
      // 确保滑块选择的积分是10的倍数
      this.pointsForm.pointsToUse = Math.floor(value / 10) * 10;
      this.calculateAmounts();
    },

    // 滑块工具提示格式化
    formatPointsTooltip(value) {
      return `${value}分 (¥${value / 10})`;
    },

    // 使用最大可抵扣积分
    useMaxPoints() {
      const maxPoints = this.userPointsData && this.userPointsData.points ? this.userPointsData.points : 0;
      this.pointsForm.pointsToUse = Math.floor(maxPoints / 10) * 10;
      this.calculateAmounts();
    },

    // 使用一半积分
    useHalfPoints() {
      const maxPoints = this.userPointsData && this.userPointsData.points ? this.userPointsData.points : 0;
      const halfPoints = Math.floor(maxPoints / 2);
      this.pointsForm.pointsToUse = Math.floor(halfPoints / 10) * 10;
      this.calculateAmounts();
    },

    // 积分复选框变化处理
    handlePointsCheckboxChange(val) {
      this.usePoints = val;
      if (!val) {
        this.pointsForm.pointsToUse = 0;
        this.calculateAmounts();
      }
    },

    // 模拟支付
    async simulatePay() {
      if (!this.payingOrderId) return;

      // 验证表单
      if (this.usePoints) {
        try {
          await this.$refs.pointsForm.validate();
        } catch (error) {
          this.$message.error("请正确填写积分抵扣信息");
          return;
        }
      }

      this.payLoading = true;
      try {
        // 构建支付参数
        const payParams = {
          id: this.payingOrderId,
          status: "0"
        };

        // 如果使用积分抵扣，添加积分抵扣信息
        if (this.usePoints && this.pointsForm.pointsToUse > 0) {
          payParams.pointsUsed = this.pointsForm.pointsToUse;
          payParams.deductionAmount = this.deductionAmount;
          payParams.actualAmount = this.actualAmount;
        } else {
          // 如果没有使用积分，实付金额等于订单总额
          payParams.actualAmount = this.currentOrder.totalAmount;
        }

        console.log('支付参数:', payParams);
        
        // 1. 先支付订单
        const payResult = await payOrder(payParams);
        
        // 2. 如果使用了积分，使用 adjustPoints 方法扣除积分并记录历史
        if (this.usePoints && this.pointsForm.pointsToUse > 0 && this.userPointsData) {
          // 计算扣除后的积分
          const currentPoints = this.userPointsData.points || 0;
          const newPoints = currentPoints - this.pointsForm.pointsToUse;
          
          // 构建积分调整参数
          const adjustParams = {
            ownerPoints: {
              ownerId: this.userPointsData.ownerId, // 使用 ownerId
              points: newPoints, // 新的积分值
              updateBy: this.$store.getters.name || 'system', // 获取当前用户名
              updateTime: this.userPointsData.updateTime // 传递updateTime用于乐观锁
            },
            adjustType: 'SUBTRACT', // 调整类型为扣减
            reason: `系统缴费扣减积分，订单号：${this.currentOrder.orderNo}，抵扣金额：¥${this.deductionAmount}` // 详细的扣分原因
          };
          
          console.log('积分调整参数:', adjustParams);
          
          // 调用积分调整接口（会记录历史）
          const adjustResult = await adjustPoints(adjustParams);
          
          if (adjustResult.code === 200) {
            // 更新本地积分显示
            this.userPointsData.points = newPoints;
            this.userPointsData.updateTime = adjustResult.data?.updateTime || new Date();
            
            this.$message.success(`支付成功！已使用${this.pointsForm.pointsToUse}积分抵扣${this.deductionAmount}元`);
          } else {
            console.warn('积分调整记录失败，但支付已完成:', adjustResult.msg);
            this.$message.success(`支付成功！但积分记录失败：${adjustResult.msg}`);
          }
        } else {
          this.$message.success("支付成功！");
        }

        this.payDialogVisible = false;
        this.getList(); // 刷新订单列表

      } catch (error) {
        console.error("支付或积分扣除失败:", error);
        this.$message.error("支付失败，请重试");
      } finally {
        this.payLoading = false;
      }
    },

    // 支付对话框关闭处理
    handlePayDialogClose() {
      this.usePoints = false;
      this.pointsForm.pointsToUse = 0;
      this.userPointsData = null;
      this.deductionAmount = 0;
      this.actualAmount = 0;
      if (this.$refs.pointsForm) {
        this.$refs.pointsForm.clearValidate();
      }
    }
  }
};
</script>

<style scoped>
.el-slider {
  margin-top: 10px;
}

.el-divider {
  margin: 20px 0;
}

.el-form-item {
  margin-bottom: 15px;
}
</style>