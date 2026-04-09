<template>
  <div class="app-container">
    <!-- 搜索栏 -->
    <el-form :inline="true" :model="queryParams" class="search-form">
      <el-form-item label="车牌号">
        <el-input
          v-model="queryParams.plateNum"
          placeholder="请输入车牌号"
          clearable
          @keyup.enter.native="handleQuery"
          style="width: 200px;"
        />
      </el-form-item>
      <el-form-item label="车牌颜色">
        <el-input
          v-model="queryParams.plateColor"
          placeholder="请输入车牌颜色"
          clearable
          @keyup.enter.native="handleQuery"
          style="width: 200px;"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table
      :data="orderList"
      v-loading="loading"
      border
      highlight-current-row
      style="width: 100%;"
      :fit="true"
    >
      <!-- 编号列 -->
      <el-table-column label="编号" type="index" width="60" align="center" />

      <!-- 新增停车场名称列 -->
      <el-table-column label="停车场名称" prop="parkName" min-width="150" :show-overflow-tooltip="true" />

      <!-- 新增用户名称列 -->
      <el-table-column label="用户名称" prop="userName" min-width="120" align="center" />

      <el-table-column label="车牌号" prop="plateNum" min-width="120" align="center" />
      <el-table-column label="车牌颜色" prop="plateColor" min-width="100" align="center" />
      <el-table-column label="进入时间" prop="entryTime" min-width="160" align="center" />
      <el-table-column label="离开时间" prop="exitTime" min-width="160" align="center" />
      <!-- 修改停车时长列显示格式 -->
      <el-table-column label="停车时长" min-width="120" align="center">
        <template slot-scope="scope">
          {{ formatParkingDuration(scope.row.parkingDuration) }}
        </template>
      </el-table-column>
      <el-table-column label="停车费用" prop="parkFee" min-width="100" align="center">
        <template slot-scope="scope">
          <span style="color: #f56c6c; font-weight: bold;">¥{{ scope.row.parkFee || 0 }}</span>
        </template>
      </el-table-column>
      <el-table-column label="支付状态" prop="status" width="100" align="center">
        <template slot="default" slot-scope="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'danger'" size="small">
            {{ scope.row.status === '0' ? '已支付' : '待支付' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" min-width="220">
        <template slot="default" slot-scope="scope">
          <el-button 
            type="text" 
            size="small" 
            icon="el-icon-view"
            @click="handleView(scope.row)"
          >详情</el-button>
          <el-button
            v-if="scope.row.status === '1' && scope.row.exitTime"
            type="text"
            size="small"
            icon="el-icon-shopping-cart-2"
            @click="handlePay(scope.row)"
          >
            支付
          </el-button>
          <el-button 
            type="text" 
            size="small" 
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            style="color: #f56c6c;"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>


    <!-- 分页 -->
    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 删除确认弹窗 -->
    <el-dialog
      title="确认删除"
      :visible.sync="deleteDialogVisible"
      width="400px"
      append-to-body
    >
      <div style="text-align: center; padding: 20px 0;">
        <i class="el-icon-warning" style="font-size: 48px; color: #e6a23c;"></i>
        <p style="margin: 15px 0; font-size: 16px;">
          确定要删除车牌号为 <span style="color: #f56c6c; font-weight: bold;">"{{ deleteForm.plateNum }}"</span> 的停车订单吗？
        </p>
        <p style="color: #909399; font-size: 14px;">此操作不可恢复，请谨慎操作。</p>
      </div>
      <template slot="footer">
        <el-button @click="deleteDialogVisible = false">取消</el-button>
        <el-button type="danger" @click="confirmDelete" :loading="deleteLoading">确认删除</el-button>
      </template>
    </el-dialog>

    <!-- 详情弹窗 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form :model="form" ref="formRef" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="停车场名称">
              <el-input v-model="form.parkName" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="用户名称">
              <el-input v-model="form.userName" disabled />
            </el-form-item>
          </el-col>
        </el-row>
        
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="车牌号">
              <el-input v-model="form.plateNum" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="车牌颜色">
              <el-input v-model="form.plateColor" disabled />
            </el-form-item>
          </el-col>
        </el-row>
        
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="进入时间">
              <el-input v-model="form.entryTime" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="离开时间">
              <el-input v-model="form.exitTime" disabled />
            </el-form-item>
          </el-col>
        </el-row>
        
        <el-row :gutter="20">
          <el-col :span="12">
            <!-- 修改详情弹窗中的停车时长显示 -->
            <el-form-item label="停车时长">
              <el-input :value="formatParkingDuration(form.parkingDuration)" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="停车费用">
              <el-input v-model="form.parkFee" disabled>
                <template slot="append">元</template>
              </el-input>
            </el-form-item>
          </el-col>
        </el-row>
        
        <el-form-item label="支付状态">
          <el-tag :type="form.status === '0' ? 'success' : 'danger'" size="medium">
            {{ form.status === '0' ? '已支付' : '待支付' }}
          </el-tag>
        </el-form-item>
      </el-form>
      <template slot="footer">
        <el-button @click="open = false">关闭</el-button>
      </template>
    </el-dialog>

    <!-- 支付对话框 -->
    <el-dialog 
      title="模拟支付二维码" 
      :visible.sync="payDialogVisible" 
      width="400px"
      append-to-body
    >
      <div style="text-align: center;">
        <img :src="qrCodeUrl" style="width: 200px; height: 200px; border: 1px solid #ebeef5;" alt="二维码" />
        <p style="margin-top: 10px; color: gray; font-size: 12px;">仅供模拟扫码支付</p>
        <div style="margin: 20px 0;">
          <p style="margin: 5px 0; font-size: 14px;">
            订单金额：<span style="color: #f56c6c; font-weight: bold; font-size: 18px;">¥{{ currentOrder ? currentOrder.parkFee : 0 }}</span>
          </p>
        </div>
        <el-button type="success" @click="simulatePay" :loading="payLoading">
          <i class="el-icon-check" style="margin-right: 5px;"></i>模拟扫码支付
        </el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listParkOrder, deleteParkOrder } from '@/api/system/parkOrder';
import {generateParQr,parkingPay} from '@/api/system/order'

export default {
  data() {
    return {
      orderList: [], // 停车订单列表
      total: 0,      // 总记录数
      loading: false, // 加载状态
      open: false,    // 弹窗控制
      title: '',      // 弹窗标题
      deleteDialogVisible: false, // 删除确认弹框
      deleteLoading: false, // 删除加载状态
      deleteId: null, // 记录待删除的订单ID
      deleteForm: {}, // 用于展示删除弹框中的详细信息
      payLoading: false, // 支付加载状态
      currentOrder: null, // 当前操作的订单
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        plateNum: '',
        plateColor: ''
      },
      form: {
        id: null,
        plateNum: '',
        plateColor: '',
        entryTime: '',
        exitTime: '',
        parkingDuration: '',
        parkFee: ''
      },
      payDialogVisible: false,
      qrCodeUrl: '',
      payingOrderId: null
    };
  },
  methods: {
    // 获取停车订单列表
    async getList() {
      this.loading = true;
      try {
        const res = await listParkOrder(this.queryParams);
        this.orderList = res.rows;
        this.total = res.total;
      } catch (error) {
        this.$message.error('获取订单列表失败');
      } finally {
        this.loading = false;
      }
    },

    // 查询操作
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },

    // 重置查询条件
    resetQuery() {
      this.queryParams.plateNum = '';
      this.queryParams.plateColor = '';
      this.handleQuery();
    },

    // 查看停车订单详情
    handleView(row) {
      this.form = { ...row }; // 填充表单
      this.title = '停车订单详情';
      this.open = true;
    },

    // 删除停车订单，显示确认弹窗
    handleDelete(row) {
      this.deleteId = row.id; // 保存待删除的订单ID
      this.deleteForm = { ...row }; // 显示当前行的车牌号等信息
      this.deleteDialogVisible = true; // 打开删除确认弹窗
    },

    // 确认删除操作
    async confirmDelete() {
      this.deleteLoading = true;
      try {
        await deleteParkOrder(this.deleteId);  // 调用删除接口
        this.$message.success('删除成功');
        this.getList();  // 刷新列表
        this.deleteDialogVisible = false;  // 关闭确认弹窗
      } catch (error) {
        this.$message.error('删除失败');
      } finally {
        this.deleteLoading = false;
      }
    },

    //生成支付二维码
    async handlePay(row) {
      this.payingOrderId = row.id;
      this.currentOrder = row;
      const res = await generateParQr(row.id); // 返回二维码 base64 图片地址
      this.qrCodeUrl = res.data;
      this.payDialogVisible = true;
    },
    
    // 模拟支付按钮
    async simulatePay() {
      this.payLoading = true;
      try {
        await parkingPay(this.payingOrderId);
        this.$message.success('支付成功');
        this.payDialogVisible = false;
        this.getList();
      } catch (error) {
        this.$message.error('支付失败');
      } finally {
        this.payLoading = false;
      }
    },

    // 格式化停车时长显示
    formatParkingDuration(minutes) {
      if (!minutes && minutes !== 0) return '';
      
      const mins = parseInt(minutes);
      if (isNaN(mins)) return '';
      
      // 如果不满1小时
      if (mins < 60) {
        return `${mins}分钟`;
      } else {
        const hours = Math.floor(mins / 60);
        const remainingMins = mins % 60;
        
        if (remainingMins === 0) {
          return `${hours}小时`;
        } else {
          return `${hours}小时${remainingMins}分钟`;
        }
      }
    }
  },
  mounted() {
    this.getList(); // 初始化加载停车订单列表
  }
};
</script>

<style scoped>
.app-container {
  padding: 20px;
}

.search-form {
  margin-bottom: 20px;
}

.el-table {
  font-size: 14px;
}

.el-table--border {
  border: 1px solid #ebeef5;
  border-right: 0;
  border-bottom: 0;
}

.el-button--text {
  padding: 4px 8px;
}

.el-button--text + .el-button--text {
  margin-left: 8px;
}
</style>