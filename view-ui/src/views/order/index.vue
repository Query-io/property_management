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
          <el-option
            v-for="dict in dict.type.sys_order_type"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
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
      <!-- 添加实付金额列 -->
      <el-table-column prop="actualAmount" label="实付金额" align="center">
        <template slot-scope="scope">
          <span v-if="scope.row.status === '0'">
            {{ scope.row.actualAmount !== null && scope.row.actualAmount !== undefined ? scope.row.actualAmount : scope.row.totalAmount }}
          </span>
          <span v-else>-</span>
        </template>
      </el-table-column>
      <!-- 添加积分使用列 -->
      <el-table-column prop="pointsUsed" label="使用积分" align="center">
        <template slot-scope="scope">
          <span v-if="scope.row.status === '0'">
            <el-tag v-if="scope.row.pointsUsed && scope.row.pointsUsed > 0" type="success" size="small">
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
        <template  slot="default" slot-scope="scope">
          <el-button type="text" size="mini" icon="el-icon-view" @click="viewDetails(scope.row)">详情</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <!-- 详情对话框 -->
    <el-dialog :visible.sync="showDetailDialog" width="800px" title="订单详情" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="订单编号">{{ currentOrder.orderNo }}</el-descriptions-item>
        <el-descriptions-item label="订单类型">{{ currentOrder.orderType }}</el-descriptions-item>
        <el-descriptions-item label="业主ID">{{ currentOrder.userId }}</el-descriptions-item>
        <el-descriptions-item label="业主姓名">{{ currentOrder.userName }}</el-descriptions-item>
        <el-descriptions-item label="房产ID" v-if="currentOrder.propertyId">{{ currentOrder.propertyId }}</el-descriptions-item>
        <el-descriptions-item label="房产地址" v-if="currentOrder.propertyId">{{ currentOrder.propertyAddress }}</el-descriptions-item>
        <el-descriptions-item label="订单总额">{{ currentOrder.totalAmount }}</el-descriptions-item>
        <!-- 添加实付金额详情 -->
        <el-descriptions-item label="实付金额">
          <span v-if="currentOrder.status === '0'">
            {{ currentOrder.actualAmount !== null && currentOrder.actualAmount !== undefined ? currentOrder.actualAmount : currentOrder.totalAmount }}
          </span>
          <span v-else>-</span>
        </el-descriptions-item>
        <!-- 添加积分使用详情 -->
        <el-descriptions-item label="使用积分">
          <span v-if="currentOrder.status === '0'">
            <el-tag v-if="currentOrder.pointsUsed && currentOrder.pointsUsed > 0" type="success" size="small">
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
        <el-descriptions-item label="关联单id" v-if="currentOrder.associationId">{{currentOrder.associationId}}</el-descriptions-item>
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
  </div>
</template>

<script>
import {
  listOrderItems,
  listOrderByUser, listOrderByAdmin,
} from "@/api/system/order";
export default {
  name: "UserOrder",
  dicts: ['sys_order_type'],
  data() {
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
      payingOrderId:null,
      payDialogVisible: false,
      qrCodeUrl: '',
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
  methods: {
    getList() {
      this.loading = true;
      listOrderByAdmin(this.queryParams).then(res => {
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
    // 添加时间格式化方法
    parseTime(time) {
      if (!time) return '';
      try {
        const date = new Date(time);
        return date.toLocaleString('zh-CN', {
          year: 'numeric',
          month: '2-digit',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit',
          second: '2-digit',
          hour12: false
        }).replace(/\//g, '-');
      } catch (e) {
        return time;
      }
    }
  }
};
</script>