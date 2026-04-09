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
      <el-form-item label="收益类型" prop="incomeType">
        <el-select v-model="queryParams.incomeType" placeholder="请选择收益类型" clearable size="small">
          <el-option
            v-for="dict in incomeTypeOptions"
            :key="dict.dictValue"
            :label="dict.dictLabel"
            :value="dict.dictValue"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="付款方" prop="payerName">
        <el-input
          v-model="queryParams.payerName"
          placeholder="请输入付款方"
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
          v-hasPermi="['investment:income:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['investment:income:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['investment:income:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="incomeList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" align="center" prop="id" />
      <el-table-column label="招商项目" align="center" prop="investmentTitle" />
      <el-table-column label="收益类型" align="center" prop="incomeType" :formatter="incomeTypeFormat" />
      <el-table-column label="金额" align="center" prop="amount" />
      <el-table-column label="付款方" align="center" prop="payerName" />
      <el-table-column label="付款日期" align="center" prop="paymentDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.paymentDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['investment:income:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['investment:income:remove']"
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

    <!-- 添加或修改收益明细对话框 -->
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
        <el-form-item label="收益类型" prop="incomeType">
          <el-select v-model="form.incomeType" placeholder="请选择收益类型">
            <el-option
              v-for="dict in incomeTypeOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="dict.dictValue"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="金额" prop="amount">
          <el-input v-model="form.amount" placeholder="请输入金额" />
        </el-form-item>
        <el-form-item label="付款日期" prop="paymentDate">
          <el-date-picker clearable size="small"
            v-model="form.paymentDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择付款日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="计费周期开始" prop="periodStart">
          <el-date-picker clearable size="small"
            v-model="form.periodStart"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择开始日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="计费周期结束" prop="periodEnd">
          <el-date-picker clearable size="small"
            v-model="form.periodEnd"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择结束日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="付款方名称" prop="payerName">
          <el-input v-model="form.payerName" placeholder="请输入付款方名称" />
        </el-form-item>
        <el-form-item label="付款方电话" prop="payerPhone">
          <el-input v-model="form.payerPhone" placeholder="请输入付款方电话" />
        </el-form-item>
        <el-form-item label="付款方式" prop="paymentMethod">
          <el-select v-model="form.paymentMethod" placeholder="请选择付款方式">
            <el-option
              v-for="dict in paymentMethodOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="dict.dictValue"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="发票编号" prop="invoiceNo">
          <el-input v-model="form.invoiceNo" placeholder="请输入发票编号" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
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
import { listIncome, getIncome, delIncome, addIncome, updateIncome, exportIncome } from "@/api/investment/income";
import { listInfo } from "@/api/investment/info";
// 引入ElementUI原生Message，替换未定义的msgSuccess
import { Message } from 'element-ui';

export default {
  name: "Income",
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
      // 收益明细表格数据
      incomeList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 收益类型字典
      incomeTypeOptions: [],
      // 付款方式字典
      paymentMethodOptions: [],
      // 招商项目选项
      investmentOptions: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        investmentId: null,
        incomeType: null,
        payerName: null,
        paymentMethod: null,
        paymentDate: null
      },
      // 表单参数
      form: {},
      // 表单校验（优化触发方式）
      rules: {
        investmentId: [
          { required: true, message: "招商项目不能为空", trigger: "change" } // 下拉框用change更合理
        ],
        incomeType: [
          { required: true, message: "收益类型不能为空", trigger: "change" }
        ],
        amount: [
          { required: true, message: "金额不能为空", trigger: "blur" }
        ],
        paymentDate: [
          { required: true, message: "付款日期不能为空", trigger: "change" } // 日期选择用change
        ]
      }
    };
  },
  created() {
    this.getList();
    this.getInvestmentList();
    this.getDicts("income_type").then(response => {
      this.incomeTypeOptions = response.data;
    }).catch(err => {
      Message.error('加载收益类型字典失败：' + err.message);
    });
    this.getDicts("payment_method").then(response => {
      this.paymentMethodOptions = response.data;
    }).catch(err => {
      Message.error('加载付款方式字典失败：' + err.message);
    });
  },
  methods: {
    /** 查询收益明细列表 */
    getList() {
      this.loading = true;
      listIncome(this.queryParams).then(response => {
        this.incomeList = response.rows;
        this.total = response.total;
        this.loading = false;
      }).catch(err => {
        Message.error('获取收益明细列表失败：' + (err.message || '网络异常'));
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
    // 收益类型字典翻译（添加兜底）
    incomeTypeFormat(row, column) {
      return this.selectDictLabel(this.incomeTypeOptions, row.incomeType) || '未知类型';
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置（改用原生resetFields）
    reset() {
      this.form = {
        id: null,
        investmentId: null,
        incomeType: null,
        amount: null,
        paymentDate: null,
        periodStart: null,
        periodEnd: null,
        payerName: null,
        payerPhone: null,
        paymentMethod: null,
        invoiceNo: null,
        remark: null
      };
      // 重置表单校验状态，避免残留校验提示
      if (this.$refs.form) {
        this.$refs.form.resetFields();
      }
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作（彻底重置参数） */
    resetQuery() {
      this.queryParams = {
        pageNum: 1,
        pageSize: 10,
        investmentId: null,
        incomeType: null,
        payerName: null,
        paymentMethod: null,
        paymentDate: null
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
      this.title = "添加收益明细";
    },
    /** 修改按钮操作（优化id取值） */
    handleUpdate(row) {
      this.reset();
      // 兼容行内修改和批量选择，避免id为空
      const id = row?.id || (this.ids.length > 0 ? this.ids[0] : null);
      if (!id) {
        Message.warning('请选择要修改的收益明细');
        return;
      }
      getIncome(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改收益明细";
      }).catch(err => {
        Message.error('获取收益明细详情失败：' + err.message);
      });
    },
    /** 提交按钮（核心修复：弹窗关闭） */
    submitForm() {
      this.$refs.form.validate(async (valid) => {
        if (!valid) return; // 校验失败直接返回

        try {
          // 区分新增/修改接口
          if (this.form.id) {
            await updateIncome(this.form);
            Message.success("修改收益明细成功");
          } else {
            await addIncome(this.form);
            Message.success("新增收益明细成功");
          }
          // 强制关闭弹窗（核心：这行必执行）
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
        Message.warning('请选择要删除的收益明细');
        return;
      }

      this.$confirm('是否确认删除收益明细编号为"' + ids + '"的数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(async () => { // 箭头函数保留this指向
        await delIncome(ids);
        this.getList();
        Message.success("删除成功");
      }).catch(() => {
        Message.info("已取消删除");
      });
    },
    /** 导出按钮操作（修复this指向） */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有收益明细数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(async () => { // 箭头函数保留this指向
        const response = await exportIncome(queryParams);
        this.download(response.msg);
        Message.success("导出成功");
      }).catch(() => {
        Message.info("已取消导出");
      });
    }
  }
};
</script>