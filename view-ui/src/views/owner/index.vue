<template>
  <div class="app-container">
    <!-- 搜索栏 -->
    <el-form :inline="true" :model="queryParams" class="search-form">
      <el-form-item label="业主姓名">
        <el-input
          v-model="queryParams.ownerName"
          placeholder="请输入业主姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 数据表格 -->
    <el-table
      :data="ownerList"
      v-loading="loading"
      border
      highlight-current-row
      style="width: 100%"
    >
      <el-table-column label="业主姓名" prop="ownerName" />
      <el-table-column label="出生日期" prop="dateOfBirth" width="120" />
      <el-table-column label="身份证号" prop="identityNo" width="180" />
      <el-table-column label="联系电话" prop="phoneNumber" width="130" />
      <el-table-column label="积分" prop="occupation" align="center">
        <template slot-scope="scope">
          <el-tag :type="getPointsType(scope.row.occupation)">
            {{ scope.row.occupation || 0 }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="联系地址" prop="address" />
      <el-table-column label="个性签名" prop="signature" show-overflow-tooltip />
      <el-table-column label="操作" align="center" width="160">
        <template slot="default" slot-scope="scope">
          <el-button type="text" size="small" @click="handleView(scope.row)">详情</el-button>
          <el-button type="text" size="small" @click="handleEdit(scope.row)">编辑</el-button>
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

    <!-- 编辑弹窗 -->
    <el-dialog :title="title" :visible.sync="open" width="600px">
      <el-form :model="form" ref="formRef" label-width="100px">
        <el-form-item label="业主姓名">
          <el-input v-model="form.ownerName" :disabled="viewMode" />
        </el-form-item>
        <el-form-item label="出生日期">
          <el-date-picker 
            v-model="form.dateOfBirth" 
            type="date" 
            placeholder="选择日期" 
            value-format="yyyy-MM-dd"
            :disabled="viewMode" 
            style="width: 100%;"
          />
        </el-form-item>
        <el-form-item label="身份证号">
          <el-input v-model="form.identityNo" :disabled="viewMode" />
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input v-model="form.phoneNumber" :disabled="viewMode" />
        </el-form-item>
        <el-form-item label="联系地址">
          <el-input v-model="form.address" :disabled="viewMode" />
        </el-form-item>
        <el-form-item label="个性签名">
          <el-input v-model="form.signature" type="textarea" :rows="2" :disabled="viewMode" />
        </el-form-item>

        <!-- 积分信息（仅在查看模式下显示） -->
        <el-form-item label="积分" v-if="viewMode">
          <el-input v-model="form.occupation" disabled>
            <template slot="append">
              <el-tag :type="getPointsType(form.occupation)" size="small">
                {{ form.occupation || 0 }}
              </el-tag>
            </template>
          </el-input>
          <div style="margin-top: 8px; font-size: 12px; color: #909399;">
            提示：如需调整积分，请在积分管理页面操作
          </div>
        </el-form-item>

        <!-- 房产信息（仅在查看模式下显示） -->
        <el-form-item label="房产信息" v-if="viewMode">
          <el-table
            v-if="properties.length > 0"
            :data="properties"
            border
            style="width: 100%"
          >
            <el-table-column label="房产地址" prop="propertyAddress" />
            <el-table-column label="楼栋" prop="buildingNo" />
            <el-table-column label="楼层" prop="floor" />
            <el-table-column label="门牌号" prop="roomNo" />
            <el-table-column label="房屋类型" prop="propertyType" />
          </el-table>
          <p v-else style="color: #909399;">没有房产信息</p>
        </el-form-item>
      </el-form>
      <template slot="footer">
        <el-button @click="open = false">关闭</el-button>
        <el-button v-if="!viewMode" type="primary" @click="submitForm" :loading="submitLoading">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import { listOwner, getOwner, updateOwner } from '@/api/system/owner'
import { listByOwnerId } from "@/api/system/property";

export default {
  data() {
    return {
      ownerList: [],
      total: 0,
      loading: false,
      submitLoading: false,
      open: false,
      viewMode: false,
      title: '',
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        ownerName: ''
      },
      form: {
        ownerId: null,
        ownerName: '',
        dateOfBirth: '',
        identityNo: '',
        address: '',
        occupation: '',
        phoneNumber: '',
        signature: '',
        userId: null
      },
      properties: [] // 用于存储房产信息
    }
  },
  methods: {
    async getList() {
      this.loading = true
      try {
        const res = await listOwner(this.queryParams)
        this.ownerList = res.rows
        this.total = res.total
      } catch (error) {
        this.$message.error('获取业主列表失败')
      } finally {
        this.loading = false
      }
    },
    resetQuery() {
      this.queryParams.ownerName = ''
      this.handleQuery()
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    async handleView(row) {
      try {
        const res = await getOwner(row.ownerId)
        Object.assign(this.form, res.data)

        // 获取房产信息
        const propertyRes = await listByOwnerId(row.ownerId)
        this.properties = propertyRes.data

        this.viewMode = true
        this.title = '业主详情'
        this.open = true
      } catch (error) {
        this.$message.error('获取业主详情失败')
      }
    },
    async handleEdit(row) {
      try {
        const res = await getOwner(row.ownerId)
        Object.assign(this.form, res.data)
        this.viewMode = false
        this.title = '编辑业主信息'
        this.open = true
      } catch (error) {
        this.$message.error('获取业主信息失败')
      }
    },
    async submitForm() {
      try {
        this.submitLoading = true
        await updateOwner(this.form)
        this.$message.success('保存成功')
        this.open = false
        this.getList()
      } catch (error) {
        this.$message.error('保存失败')
      } finally {
        this.submitLoading = false
      }
    },
    // 积分标签类型
    getPointsType(points) {
      points = parseInt(points) || 0
      if (points >= 100) return 'success'
      if (points >= 50) return 'warning'
      return 'info'
    }
  },
  mounted() {
    this.getList()
  }
}
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