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
      <el-form-item label="维护类型" prop="maintainType">
        <el-select v-model="queryParams.maintainType" placeholder="请选择维护类型" clearable size="small">
          <el-option label="日常维护" value="1" />
          <el-option label="故障维修" value="2" />
          <el-option label="定期保养" value="3" />
        </el-select>
      </el-form-item>
      <el-form-item label="维护结果" prop="maintainResult">
        <el-select v-model="queryParams.maintainResult" placeholder="请选择维护结果" clearable size="small">
          <el-option label="正常" value="1" />
          <el-option label="待观察" value="2" />
          <el-option label="未修复" value="3" />
        </el-select>
      </el-form-item>
      <el-form-item label="维护日期" prop="maintainDate">
        <el-date-picker
          v-model="queryParams.maintainDate"
          type="date"
          placeholder="选择维护日期"
          value-format="yyyy-MM-dd"
          size="small"
        />
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
          v-hasPermi="['system:maintenance:add']"
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
          v-hasPermi="['system:maintenance:edit']"
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
          v-hasPermi="['system:maintenance:remove']"
        >删除</el-button>
      </el-col>
      <!-- <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:maintenance:export']"
        >导出</el-button>
      </el-col> -->
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="maintenanceList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="设施编号" align="center" prop="facilityCode" width="120" />
      <el-table-column label="设施名称" align="center" prop="facilityName" width="150" />
      <el-table-column label="维护类型" align="center" prop="maintainType" width="100">
        <template slot-scope="scope">
          <span v-if="scope.row.maintainType === '1'">日常维护</span>
          <span v-else-if="scope.row.maintainType === '2'">故障维修</span>
          <span v-else-if="scope.row.maintainType === '3'">定期保养</span>
        </template>
      </el-table-column>
      <el-table-column label="维护日期" align="center" prop="maintainDate" width="120">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.maintainDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="维护内容" align="center" prop="maintainContent" width="200" :show-overflow-tooltip="true" />
      <el-table-column label="维护人" align="center" prop="maintainPerson" width="100" />
      <el-table-column label="维护部门" align="center" prop="maintainDept" width="120" />
      <el-table-column label="维护费用" align="center" prop="cost" width="100">
        <template slot-scope="scope">
          <span v-if="scope.row.cost">¥{{ scope.row.cost }}</span>
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="维护结果" align="center" prop="maintainResult" width="100">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.maintainResult === '1'" type="success">正常</el-tag>
          <el-tag v-else-if="scope.row.maintainResult === '2'" type="warning">待观察</el-tag>
          <el-tag v-else-if="scope.row.maintainResult === '3'" type="danger">未修复</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="150">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:maintenance:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:maintenance:remove']"
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

    <!-- 添加或修改维修维护记录对话框 -->
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
            <el-form-item label="维护类型" prop="maintainType">
              <el-select v-model="form.maintainType" placeholder="请选择维护类型">
                <el-option label="日常维护" value="1" />
                <el-option label="故障维修" value="2" />
                <el-option label="定期保养" value="3" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="维护日期" prop="maintainDate">
              <el-date-picker
                v-model="form.maintainDate"
                type="date"
                placeholder="选择维护日期"
                value-format="yyyy-MM-dd"
                style="width: 100%;"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="维护内容" prop="maintainContent">
          <el-input v-model="form.maintainContent" type="textarea" placeholder="请输入维护内容" />
        </el-form-item>
        <el-row>
          <el-col :span="12">
            <el-form-item label="维护人" prop="maintainPerson">
              <el-input v-model="form.maintainPerson" placeholder="请输入维护人" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="维护部门" prop="maintainDept">
              <el-input v-model="form.maintainDept" placeholder="请输入维护部门" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="维护费用" prop="cost">
              <el-input v-model="form.cost" placeholder="请输入维护费用">
                <template slot="append">元</template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="维护结果" prop="maintainResult">
              <el-select v-model="form.maintainResult" placeholder="请选择维护结果">
                <el-option label="正常" value="1" />
                <el-option label="待观察" value="2" />
                <el-option label="未修复" value="3" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="下次维护日期" prop="nextMaintainDate">
          <el-date-picker
            v-model="form.nextMaintainDate"
            type="date"
            placeholder="选择下次维护日期"
            value-format="yyyy-MM-dd"
            style="width: 100%;"
          />
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
import { listMaintenance, getMaintenance, delMaintenance, addMaintenance, updateMaintenance } from "@/api/system/maintenance";

export default {
  name: "Maintenance",
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
      // 维修维护记录表格数据
      maintenanceList: [],
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
        maintainType: null,
        maintainResult: null,
        maintainDate: null
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
        maintainType: [
          { required: true, message: "维护类型不能为空", trigger: "change" }
        ],
        maintainDate: [
          { required: true, message: "维护日期不能为空", trigger: "blur" }
        ],
        maintainContent: [
          { required: true, message: "维护内容不能为空", trigger: "blur" }
        ],
        maintainPerson: [
          { required: true, message: "维护人不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询维修维护记录列表 */
    getList() {
      this.loading = true;
      listMaintenance(this.queryParams).then(response => {
        this.maintenanceList = response.rows;
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
        recordId: null,
        facilityId: null,
        facilityCode: null,
        facilityName: null,
        maintainType: null,
        maintainDate: null,
        maintainContent: null,
        maintainPerson: null,
        maintainDept: null,
        cost: null,
        maintainResult: null,
        nextMaintainDate: null,
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
      this.ids = selection.map(item => item.recordId);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加维修维护记录";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const recordId = row.recordId || this.ids;
      getMaintenance(recordId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改维修维护记录";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.recordId != null) {
            updateMaintenance(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addMaintenance(this.form).then(response => {
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
      const recordIds = row.recordId || this.ids;
      this.$modal.confirm('是否确认删除维修维护记录编号为"' + recordIds + '"的数据项？').then(() => {
        return delMaintenance(recordIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download("system/maintenance/export", {
        ...this.queryParams
      }, `maintenance_${new Date().getTime()}.xlsx`);
    }
  }
};
</script>