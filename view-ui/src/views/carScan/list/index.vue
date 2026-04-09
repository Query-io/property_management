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
      <el-form-item label="车辆类型">
        <el-select
          v-model="queryParams.type"
          placeholder="请选择车辆类型"
          clearable
          style="width: 120px;"
        >
          <el-option label="已注册" :value="1" />
          <el-option label="未注册" :value="0" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 数据表格 -->
    <el-table
      :data="vehicleList"
      v-loading="loading"
      border
      highlight-current-row
      style="width: 100%;"
      :fit="true"
    >
      <el-table-column label="编号" type="index" width="60" align="center" />
      <el-table-column label="车牌号" prop="plateNum" min-width="120" align="center" />
      <el-table-column label="车牌颜色" prop="plateColor" min-width="100" align="center" />
      <el-table-column label="方向" prop="direction" width="80" align="center">
        <template slot-scope="scope">
          <el-tag :type="scope.row.direction === 0 ? 'primary' : 'success'">
            {{ scope.row.direction === 0 ? '驶入' : '驶出' }}
          </el-tag>
        </template>
      </el-table-column>
      <!-- 新增：是否注册车辆列 -->
      <el-table-column label="是否注册车辆" prop="type" width="120" align="center">
        <template slot-scope="scope">
          <el-tag :type="scope.row.type === 1 ? 'success' : 'warning'">
            {{ scope.row.type === 1 ? '已注册' : '未注册' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="停车场名称" prop="parkName" min-width="150" :show-overflow-tooltip="true" />
      <el-table-column label="用户名称" prop="userName" min-width="120" align="center" />
      <el-table-column label="创建时间" prop="createTime" min-width="160" align="center" />
      <el-table-column label="扫描图片" width="150" align="center">
        <template slot-scope="scope">
          <el-image
            style="width: 100px; height: 100px; object-fit: cover; cursor: pointer;"
            :src="getFullImageUrl(scope.row.picture)"
            :preview-src-list="[getFullImageUrl(scope.row.picture)]"
            preview-teleported
            fit="cover"
          >
            <div slot="error" class="image-slot">
              <i class="el-icon-picture-outline" style="font-size: 24px;"></i>
              <div style="font-size: 12px; margin-top: 5px;">暂无图片</div>
            </div>
          </el-image>
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
  </div>
</template>

<script>
import { listByUser } from '@/api/system/carScan';

export default {
  data() {
    return {
      vehicleList: [],       // 车辆进出记录列表
      total: 0,              // 总记录数
      loading: false,        // 加载状态
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        plateNum: '',        // 车牌号
        plateColor: '',      // 车牌颜色
        type: undefined      // 新增：车辆类型查询条件
      }
    };
  },
  methods: {
    // 获取完整图片URL
    getFullImageUrl(url) {
      if (!url) return ''; // 防止空值
      return process.env.VUE_APP_BASE_API + url;
    },

    // 获取车辆进出场记录列表
    async getList() {
      this.loading = true;
      try {
        const res = await listByUser(this.queryParams);
        this.vehicleList = res.rows;
        this.total = res.total;
      } catch (error) {
        this.$message.error('获取记录失败');
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
      this.queryParams.type = undefined;
      this.handleQuery();
    }
  },
  mounted() {
    this.getList(); // 初始化加载数据
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

.image-slot {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 100px;
  height: 100px;
  background-color: #f5f7fa;
  border-radius: 4px;
  color: #909399;
}

.el-image {
  border-radius: 4px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.el-image:hover {
  transform: scale(1.05);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.el-tag {
  font-weight: bold;
}
</style>