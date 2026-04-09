<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="招商项目" prop="investmentId">
        <el-select
          v-model="queryParams.investmentId"
          placeholder="请选择招商项目"
          clearable
          size="small"
          style="width: 240px"
        >
          <el-option
            v-for="item in investmentOptions"
            :key="item.id"
            :label="item.title"
            :value="item.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="进度类型" prop="progressType">
        <el-select v-model="queryParams.progressType" placeholder="请选择进度类型" clearable size="small">
          <el-option
            v-for="dict in progressTypeOptions"
            :key="dict.dictValue"
            :label="dict.dictLabel"
            :value="dict.dictValue"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="跟进人" prop="trackPerson">
        <el-input
          v-model="queryParams.trackPerson"
          placeholder="请输入跟进人"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['investment:progress:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['investment:progress:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['investment:progress:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="progressList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" align="center" prop="id" />
      <el-table-column label="招商项目" align="center" prop="investmentTitle" />
      <el-table-column label="进度类型" align="center" prop="progressType" :formatter="progressTypeFormat" />
      <el-table-column label="进度描述" align="center" prop="progressDesc" />
      <el-table-column label="跟进人" align="center" prop="trackPerson" />
      <el-table-column label="进度日期" align="center" prop="progressDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.progressDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['investment:progress:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['investment:progress:remove']"
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

    <!-- 添加或修改招商进度对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="招商项目" prop="investmentId">
          <el-select v-model="form.investmentId" placeholder="请选择招商项目">
            <el-option
              v-for="item in investmentOptions"
              :key="item.id"
              :label="item.title"
              :value="item.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="进度类型" prop="progressType">
          <el-select v-model="form.progressType" placeholder="请选择进度类型">
            <el-option
              v-for="dict in progressTypeOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="dict.dictValue"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="进度描述" prop="progressDesc">
          <el-input v-model="form.progressDesc" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="下一步计划" prop="nextPlan">
          <el-input v-model="form.nextPlan" type="textarea" placeholder="请输入下一步计划" />
        </el-form-item>
        <el-form-item label="跟进人" prop="trackPerson">
          <el-input v-model="form.trackPerson" placeholder="请输入跟进人" />
        </el-form-item>
        <el-form-item label="进度日期" prop="progressDate">
          <el-date-picker clearable size="small"
            v-model="form.progressDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择进度日期">
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
import { listProgress, getProgress, delProgress, addProgress, updateProgress, exportProgress } from "@/api/investment/progress";
import { listInfo } from "@/api/investment/info";
// 引入ElementUI的Message，替换未定义的msgSuccess
import { Message } from 'element-ui';

export default {
  name: "Progress",
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
      // 招商进度表格数据
      progressList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 进度类型字典
      progressTypeOptions: [],
      // 招商项目选项
      investmentOptions: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        investmentId: null,
        progressType: null,
        trackPerson: null,
        progressDate: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        investmentId: [
          { required: true, message: "招商项目不能为空", trigger: "change" } // 下拉框用change触发更合适
        ],
        progressType: [
          { required: true, message: "进度类型不能为空", trigger: "change" }
        ],
        progressDesc: [
          { required: true, message: "进度描述不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
    this.getInvestmentList();
    this.getDicts("progress_type").then(response => {
      this.progressTypeOptions = response.data;
    });
  },
  methods: {
    /** 查询招商进度列表 */
    getList() {
      this.loading = true;
      listProgress(this.queryParams).then(response => {
        this.progressList = response.rows;
        this.total = response.total;
        this.loading = false;
      }).catch(err => {
        Message.error('获取进度列表失败：' + (err.message || '网络异常'));
        this.loading = false;
      });
    },
    /** 查询招商项目列表 */
    getInvestmentList() {
      listInfo({ pageNum: 1, pageSize: 1000 }).then(response => {
        this.investmentOptions = response.rows;
      }).catch(err => {
        Message.error('获取招商项目列表失败：' + err.message);
      });
    },
    // 进度类型字典翻译
    progressTypeFormat(row, column) {
      return this.selectDictLabel(this.progressTypeOptions, row.progressType) || '未知类型';
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
        investmentId: null,
        progressType: null,
        progressDesc: null,
        progressDate: null,
        nextPlan: null,
        trackPerson: null
      };
      // 改用ElementUI原生的resetFields重置表单校验状态
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
      // 彻底重置查询参数，避免resetForm失效
      this.queryParams = {
        pageNum: 1,
        pageSize: 10,
        investmentId: null,
        progressType: null,
        trackPerson: null,
        progressDate: null
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
      this.title = "添加招商进度";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      // 兼容行内修改和批量选择修改，避免id取值异常
      const id = row?.id || (this.ids.length > 0 ? this.ids[0] : null);
      if (!id) {
        Message.warning('请选择要修改的招商进度');
        return;
      }
      getProgress(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改招商进度";
      }).catch(err => {
        Message.error('获取进度详情失败：' + err.message);
      });
    },
    /** 提交按钮（核心修复：弹窗关闭问题） */
    submitForm() {
      // 手动触发表单校验，避免回调this指向问题
      this.$refs.form.validate(async (valid) => {
        if (!valid) return; // 校验失败直接返回

        try {
          // 区分新增/修改接口
          if (this.form.id) {
            await updateProgress(this.form);
            Message.success("修改招商进度成功");
          } else {
            await addProgress(this.form);
            Message.success("新增招商进度成功");
          }
          // 强制关闭弹窗（核心：这行代码必然执行）
          this.open = false;
          // 刷新列表
          this.getList();
        } catch (err) {
          // 失败提示，不关闭弹窗
          Message.error(this.form.id ? '修改失败：' + err.message : '新增失败：' + err.message);
        }
      });
    },
    /** 删除按钮操作（修复this指向） */
    handleDelete(row) {
      const ids = row?.id || this.ids;
      if (!ids || ids.length === 0) {
        Message.warning('请选择要删除的招商进度');
        return;
      }

      this.$confirm('是否确认删除招商进度编号为"' + ids + '"的数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(async () => { // 箭头函数保留this指向
        await delProgress(ids);
        this.getList();
        Message.success("删除成功");
      }).catch(() => {
        Message.info("已取消删除");
      });
    },
    /** 导出按钮操作（修复this指向） */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有招商进度数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(async () => { // 箭头函数保留this指向
        const response = await exportProgress(queryParams);
        this.download(response.msg);
        Message.success("导出成功");
      }).catch(() => {
        Message.info("已取消导出");
      });
    }
  }
};
</script>