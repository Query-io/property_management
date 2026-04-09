<!-- view-ui/src/views/facility/damage/index.vue -->
<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="设施编号" prop="facilityCode">
        <el-input
          v-model="queryParams.facilityCode"
          placeholder="请输入设施编号"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="设施名称" prop="facilityName">
        <el-input
          v-model="queryParams.facilityName"
          placeholder="请输入设施名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="损坏类型" prop="damageType">
        <el-select v-model="queryParams.damageType" placeholder="请选择损坏类型" clearable size="small">
          <el-option label="人为损坏" value="1" />
          <el-option label="自然损坏" value="2" />
          <el-option label="老化损坏" value="3" />
        </el-select>
      </el-form-item>
      <el-form-item label="处理状态" prop="handleStatus">
        <el-select v-model="queryParams.handleStatus" placeholder="请选择处理状态" clearable size="small">
          <el-option label="未处理" value="0" />
          <el-option label="处理中" value="1" />
          <el-option label="已处理" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item label="处理方式" prop="handleMethod">
        <el-select v-model="queryParams.handleMethod" placeholder="请选择处理方式" clearable size="small">
          <el-option label="维修" value="1" />
          <el-option label="更换" value="2" />
          <el-option label="报废" value="3" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:damage:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:damage:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:damage:remove']"
        >删除</el-button>
      </el-col>
      <!-- <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:damage:export']"
        >导出</el-button>
      </el-col> -->
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="damageList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="设施编号" align="center" prop="facilityCode" width="120" />
      <el-table-column label="设施名称" align="center" prop="facilityName" width="150" />
      <el-table-column label="损坏日期" align="center" prop="damageDate" width="120">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.damageDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="损坏类型" align="center" prop="damageType" width="100">
        <template slot-scope="scope">
          <span v-if="scope.row.damageType === '1'">人为损坏</span>
          <span v-else-if="scope.row.damageType === '2'">自然损坏</span>
          <span v-else-if="scope.row.damageType === '3'">老化损坏</span>
        </template>
      </el-table-column>
      <el-table-column label="损坏描述" align="center" prop="damageDescription" width="200" :show-overflow-tooltip="true" />
      <el-table-column label="上报人" align="center" prop="reporter" width="100" />
      <el-table-column label="上报电话" align="center" prop="reporterPhone" width="120" />
      <el-table-column label="处理状态" align="center" prop="handleStatus" width="100">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.handleStatus === '0'" type="info">未处理</el-tag>
          <el-tag v-else-if="scope.row.handleStatus === '1'" type="warning">处理中</el-tag>
          <el-tag v-else-if="scope.row.handleStatus === '2'" type="success">已处理</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="处理方式" align="center" prop="handleMethod" width="100">
        <template slot-scope="scope">
          <span v-if="scope.row.handleMethod === '1'">维修</span>
          <span v-else-if="scope.row.handleMethod === '2'">更换</span>
          <span v-else-if="scope.row.handleMethod === '3'">报废</span>
        </template>
      </el-table-column>
      <el-table-column label="处理人" align="center" prop="handlePerson" width="100" />
      <el-table-column label="处理日期" align="center" prop="handleDate" width="120">
        <template slot-scope="scope">
          <span v-if="scope.row.handleDate">{{ parseTime(scope.row.handleDate, '{y}-{m}-{d}') }}</span>
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="150">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:damage:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:damage:remove']"
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

    <!-- 添加或修改损坏报废登记对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="700px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="设施编号" prop="facilityCode">
              <el-input v-model="form.facilityCode" placeholder="请输入设施编号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="设施名称" prop="facilityName">
              <el-input v-model="form.facilityName" placeholder="请输入设施名称" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="损坏日期" prop="damageDate">
              <el-date-picker
                v-model="form.damageDate"
                type="date"
                placeholder="选择损坏日期"
                value-format="yyyy-MM-dd"
                style="width: 100%;"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="损坏类型" prop="damageType">
              <el-select v-model="form.damageType" placeholder="请选择损坏类型">
                <el-option label="人为损坏" value="1" />
                <el-option label="自然损坏" value="2" />
                <el-option label="老化损坏" value="3" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="损坏描述" prop="damageDescription">
          <el-input v-model="form.damageDescription" type="textarea" placeholder="请输入损坏描述" />
        </el-form-item>
        <el-row>
          <el-col :span="12">
            <el-form-item label="上报人" prop="reporter">
              <el-input v-model="form.reporter" placeholder="请输入上报人" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="上报电话" prop="reporterPhone">
              <el-input v-model="form.reporterPhone" placeholder="请输入上报电话" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="处理状态" prop="handleStatus">
              <el-select v-model="form.handleStatus" placeholder="请选择处理状态">
                <el-option label="未处理" value="0" />
                <el-option label="处理中" value="1" />
                <el-option label="已处理" value="2" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="处理方式" prop="handleMethod">
              <el-select v-model="form.handleMethod" placeholder="请选择处理方式">
                <el-option label="维修" value="1" />
                <el-option label="更换" value="2" />
                <el-option label="报废" value="3" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="处理人" prop="handlePerson">
              <el-input v-model="form.handlePerson" placeholder="请输入处理人" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="处理日期" prop="handleDate">
              <el-date-picker
                v-model="form.handleDate"
                type="date"
                placeholder="选择处理日期"
                value-format="yyyy-MM-dd"
                style="width: 100%;"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="处理结果" prop="handleResult">
          <el-input v-model="form.handleResult" type="textarea" placeholder="请输入处理结果" />
        </el-form-item>
        <el-form-item label="备注" prop="remarks">
          <el-input v-model="form.remarks" type="textarea" placeholder="请输入内容" />
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
import { listDamage, getDamage, delDamage, addDamage, updateDamage } from "@/api/system/damage";

export default {
  name: "Damage",
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
      // 损坏报废登记表格数据
      damageList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        facilityCode: null,
        facilityName: null,
        damageType: null,
        handleStatus: null,
        handleMethod: null,
        reporter: null,
        handlePerson: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        facilityCode: [
          { required: true, message: "设施编号不能为空", trigger: "blur" }
        ],
        facilityName: [
          { required: true, message: "设施名称不能为空", trigger: "blur" }
        ],
        damageDate: [
          { required: true, message: "损坏日期不能为空", trigger: "blur" }
        ],
        damageType: [
          { required: true, message: "损坏类型不能为空", trigger: "change" }
        ],
        damageDescription: [
          { required: true, message: "损坏描述不能为空", trigger: "blur" }
        ],
        reporter: [
          { required: true, message: "上报人不能为空", trigger: "blur" }
        ],
        reporterPhone: [
          { required: true, message: "上报电话不能为空", trigger: "blur" }
        ],
        handleStatus: [
          { required: true, message: "处理状态不能为空", trigger: "change" }
        ]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询损坏报废登记列表 */
    getList() {
      this.loading = true;
      listDamage(this.queryParams).then(response => {
        this.damageList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        damageId: null,
        facilityId: null,
        facilityCode: null,
        facilityName: null,
        damageDate: null,
        damageType: null,
        damageDescription: null,
        reporter: null,
        reporterPhone: null,
        handleStatus: "0",
        handleMethod: null,
        handlePerson: null,
        handleDate: null,
        handleResult: null,
        attachments: null,
        remarks: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.damageId);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加损坏报废登记";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const damageId = row.damageId || this.ids;
      getDamage(damageId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改损坏报废登记";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.damageId != null) {
            updateDamage(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addDamage(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const damageIds = row.damageId || this.ids;
      this.$modal.confirm('是否确认删除损坏报废登记编号为"' + damageIds + '"的数据项？').then(() => {
        return delDamage(damageIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download("system/damage/export", {
        ...this.queryParams
      }, `damage_${new Date().getTime()}.xlsx`);
    }
  }
};
</script>