<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="招商标题" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入招商标题"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="招商位置" prop="location">
        <el-input
          v-model="queryParams.location"
          placeholder="请输入招商位置"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable size="small">
          <el-option label="待招商" value="0" />
          <el-option label="已签约" value="1" />
          <el-option label="已关闭" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="cyan" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['investment:info:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['investment:info:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['investment:info:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="infoList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" align="center" prop="id" />
      <el-table-column label="招商标题" align="center" prop="title" />
      <el-table-column label="招商位置" align="center" prop="location" />
      <el-table-column label="面积(㎡)" align="center" prop="area" />
      <el-table-column label="租金单价" align="center" prop="rentPrice" />
      <el-table-column label="联系人" align="center" prop="contactPerson" />
      <!-- 状态列：使用标签样式显示 -->
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template slot-scope="scope">
          <el-tag
            :type="getStatusType(scope.row.status)"
            effect="light"
            size="small"
          >
            {{ getStatusText(scope.row.status) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="发布时间" align="center" prop="publishTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.publishTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['investment:info:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['investment:info:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改招商信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="招商标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入招商标题" />
        </el-form-item>
        <el-form-item label="招商内容" prop="content">
          <el-input v-model="form.content" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="招商位置" prop="location">
          <el-input v-model="form.location" placeholder="请输入招商位置" />
        </el-form-item>
        <el-form-item label="面积" prop="area">
          <el-input v-model="form.area" placeholder="请输入面积" />
        </el-form-item>
        <el-form-item label="租金单价" prop="rentPrice">
          <el-input v-model="form.rentPrice" placeholder="请输入租金单价" />
        </el-form-item>
        <el-form-item label="联系人" prop="contactPerson">
          <el-input v-model="form.contactPerson" placeholder="请输入联系人" />
        </el-form-item>
        <el-form-item label="联系电话" prop="contactPhone">
          <el-input v-model="form.contactPhone" placeholder="请输入联系电话" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="0">待招商</el-radio>
            <el-radio label="1">已签约</el-radio>
            <el-radio label="2">已关闭</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="发布时间" prop="publishTime">
          <el-date-picker clearable size="small"
            v-model="form.publishTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择发布时间">
          </el-date-picker>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listInfo, getInfo, delInfo, addInfo, updateInfo, exportInfo } from "@/api/investment/info";
import { Message } from 'element-ui';

export default {
  name: "Info",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 招商信息表格数据
      infoList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        title: null,
        location: null,
        status: null,
        contactPerson: null,
        publishTime: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        title: [{ required: true, message: "招商标题不能为空", trigger: "blur" }],
        location: [{ required: true, message: "招商位置不能为空", trigger: "blur" }]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询招商信息列表 */
    getList() {
      this.loading = true;
      listInfo(this.queryParams).then(response => {
        this.infoList = response.rows;
        this.total = response.total;
        this.loading = false;
      }).catch(err => {
        Message.error('获取列表失败：' + (err.message || '网络异常'));
        this.loading = false;
      });
    },

    /** 获取状态对应的标签类型 */
    getStatusType(status) {
      const typeMap = {
        '0': 'warning',    // 待招商 - 黄色
        '1': 'success',    // 已签约 - 绿色
        '2': 'info',       // 已关闭 - 灰色
        0: 'warning',
        1: 'success',
        2: 'info'
      };
      return typeMap[status] || 'info';
    },

    /** 获取状态对应的文本 */
    getStatusText(status) {
      const textMap = {
        '0': '待招商',
        '1': '已签约',
        '2': '已关闭',
        0: '待招商',
        1: '已签约',
        2: '已关闭'
      };
      return textMap[status] || '未知状态';
    },

    /** 旧的状态格式化方法（保持兼容） */
    statusFormat(row, column) {
      return this.getStatusText(row.status);
    },

    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },

    // 表单重置
    reset() {
      this.form = {
        id: null,
        title: null,
        content: null,
        location: null,
        area: null,
        rentPrice: null,
        contactPerson: null,
        contactPhone: null,
        status: "0",  // 默认待招商
        publishTime: null
      };
      if (this.$refs.form) {
        this.$refs.form.resetFields();
      }
    },

    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },

    /** 重置按钮操作 */
    resetQuery() {
      this.queryParams = {
        pageNum: 1,
        pageSize: 10,
        title: null,
        location: null,
        status: null,
        contactPerson: null,
        publishTime: null
      };
      this.handleQuery();
    },

    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },

    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加招商信息";
    },

    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row?.id || (this.ids.length > 0 ? this.ids[0] : null);
      if (!id) {
        Message.warning('请选择要修改的招商信息');
        return;
      }
      getInfo(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改招商信息";
      }).catch(err => {
        Message.error('获取招商信息详情失败：' + (err.message || '网络异常'));
      });
    },

    /** 提交按钮 */
    submitForm() {
      if (!this.form.title) {
        Message.warning('招商标题不能为空');
        return;
      }
      if (!this.form.location) {
        Message.warning('招商位置不能为空');
        return;
      }

      const apiFunc = this.form.id ? updateInfo : addInfo;
      apiFunc(this.form).then(() => {
        Message.success(this.form.id ? '修改招商信息成功' : '新增招商信息成功');
        this.open = false;
        this.getList();
      }).catch(err => {
        Message.error(this.form.id ? '修改失败：' + err.message : '新增失败：' + err.message);
      });
    },

    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row?.id || this.ids;
      if (!ids || ids.length === 0) {
        Message.warning('请选择要删除的招商信息');
        return;
      }

      this.$confirm('是否确认删除选中的招商信息？', '警告', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        return delInfo(ids);
      }).then(() => {
        this.getList();
        Message.success('删除成功');
      }).catch(() => {
        Message.info('已取消删除');
      });
    },

    /** 导出按钮操作 */
    handleExport() {
      this.$confirm('是否确认导出所有招商信息数据？', '警告', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        return exportInfo(this.queryParams);
      }).then(response => {
        this.download(response.msg);
        Message.success('导出成功');
      }).catch(() => {
        Message.info('已取消导出');
      });
    }
  }
};
</script>

<style scoped>
/* 可选的额外样式，增强标签效果 */
.el-tag {
  font-weight: 500;
  border-radius: 12px;
  padding: 0 8px;
  height: 24px;
  line-height: 22px;
  min-width: 60px;
  text-align: center;
}

/* 为不同状态标签添加轻微阴影，增强视觉效果 */
.el-tag--warning {
  background-color: #fdf6ec;
  border-color: #f5dab1;
  color: #e6a23c;
}

.el-tag--success {
  background-color: #f0f9eb;
  border-color: #c2e7b0;
  color: #67c23a;
}

.el-tag--info {
  background-color: #f4f4f5;
  border-color: #d3d4d6;
  color: #909399;
}
</style>