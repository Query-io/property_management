<!-- 位置：view-ui/src/views/facility/facility/index.vue -->
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
      <el-form-item label="设施类型" prop="facilityType">
        <el-select v-model="queryParams.facilityType" placeholder="请选择设施类型" clearable size="small">
          <el-option label="健身器材" value="健身器材" />
          <el-option label="儿童游乐" value="儿童游乐" />
          <el-option label="休闲椅" value="休闲椅" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable size="small">
          <el-option label="正常" value="0" />
          <el-option label="维修中" value="1" />
          <el-option label="已报废" value="2" />
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
          v-hasPermi="['system:facility:add']"
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
          v-hasPermi="['system:facility:edit']"
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
          v-hasPermi="['system:facility:remove']"
        >删除</el-button>
      </el-col>
      <!-- <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:facility:export']"
        >导出</el-button>
      </el-col> -->
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="facilityList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="设施编号" align="center" prop="facilityCode" width="120" />
      <el-table-column label="设施名称" align="center" prop="facilityName" width="150" />
      <el-table-column label="设施类型" align="center" prop="facilityType" width="100" />
      <el-table-column label="所在位置" align="center" prop="location" width="200" />
      <el-table-column label="状态" align="center" prop="status" width="80">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status === '0'" type="success">正常</el-tag>
          <el-tag v-else-if="scope.row.status === '1'" type="warning">维修中</el-tag>
          <el-tag v-else-if="scope.row.status === '2'" type="danger">已报废</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="责任人" align="center" prop="responsibilityPerson" width="100" />
      <el-table-column label="联系电话" align="center" prop="contactPhone" width="120" />
      <el-table-column label="下次维护日期" align="center" prop="nextMaintainDate" width="120">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.nextMaintainDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="150">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:facility:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:facility:remove']"
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

    <!-- 添加或修改公共设施信息对话框 -->
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
            <el-form-item label="设施类型" prop="facilityType">
              <el-select v-model="form.facilityType" placeholder="请选择设施类型">
                <el-option label="健身器材" value="健身器材" />
                <el-option label="儿童游乐" value="儿童游乐" />
                <el-option label="休闲椅" value="休闲椅" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择状态">
                <el-option label="正常" value="0" />
                <el-option label="维修中" value="1" />
                <el-option label="已报废" value="2" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="所在位置" prop="location">
          <el-input v-model="form.location" placeholder="请输入所在位置" />
        </el-form-item>
        <el-row>
          <el-col :span="12">
            <el-form-item label="安装日期" prop="installDate">
              <el-date-picker
                v-model="form.installDate"
                type="date"
                placeholder="选择安装日期"
                value-format="yyyy-MM-dd"
                style="width: 100%;"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="采购价格" prop="purchasePrice">
              <el-input v-model="form.purchasePrice" placeholder="请输入采购价格">
                <template slot="append">元</template>
              </el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="生产厂家" prop="manufacturer">
          <el-input v-model="form.manufacturer" placeholder="请输入生产厂家" />
        </el-form-item>
        <el-form-item label="规格型号" prop="specifications">
          <el-input v-model="form.specifications" placeholder="请输入规格型号" />
        </el-form-item>
        <el-row>
          <el-col :span="12">
            <el-form-item label="维护周期" prop="maintainCycle">
              <el-input v-model="form.maintainCycle" placeholder="请输入维护周期">
                <template slot="append">天</template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="保修期" prop="warrantyPeriod">
              <el-input v-model="form.warrantyPeriod" placeholder="请输入保修期">
                <template slot="append">月</template>
              </el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <!-- 新增：上次维护日期 & 下次维护日期 -->
        <el-row>
          <el-col :span="12">
            <el-form-item label="上次维护日期" prop="lastMaintainDate">
              <el-date-picker
                v-model="form.lastMaintainDate"
                type="date"
                placeholder="选择上次维护日期"
                value-format="yyyy-MM-dd"
                style="width: 100%;"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="下次维护日期" prop="nextMaintainDate">
              <el-date-picker
                v-model="form.nextMaintainDate"
                type="date"
                placeholder="选择下次维护日期"
                value-format="yyyy-MM-dd"
                style="width: 100%;"
              />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="责任部门" prop="responsibilityDept">
              <el-input v-model="form.responsibilityDept" placeholder="请输入责任部门" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="责任人" prop="responsibilityPerson">
              <el-input v-model="form.responsibilityPerson" placeholder="请输入责任人" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="联系电话" prop="contactPhone">
          <el-input v-model="form.contactPhone" placeholder="请输入联系电话" />
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
import { listFacility, getFacility, delFacility, addFacility, updateFacility } from "@/api/system/facility";

export default {
  name: "Facility",
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
      // 公共设施信息表格数据
      facilityList: [],
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
        facilityType: null,
        status: null,
        location: null
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
        facilityType: [
          { required: true, message: "设施类型不能为空", trigger: "change" }
        ],
        status: [
          { required: true, message: "状态不能为空", trigger: "change" }
        ]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询公共设施信息列表 */
    getList() {
      this.loading = true;
      listFacility(this.queryParams).then(response => {
        this.facilityList = response.rows;
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
        facilityId: null,
        facilityCode: null,
        facilityName: null,
        facilityType: null,
        location: null,
        installDate: null,
        manufacturer: null,
        specifications: null,
        status: "0",
        maintainCycle: null,
        lastMaintainDate: null,
        nextMaintainDate: null,
        responsibilityDept: null,
        responsibilityPerson: null,
        contactPhone: null,
        purchasePrice: null,
        warrantyPeriod: null,
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
      this.ids = selection.map(item => item.facilityId);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加公共设施信息";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const facilityId = row.facilityId || this.ids;
      getFacility(facilityId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改公共设施信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.facilityId != null) {
            updateFacility(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addFacility(this.form).then(response => {
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
      const facilityIds = row.facilityId || this.ids;
      this.$modal.confirm('是否确认删除公共设施信息编号为"' + facilityIds + '"的数据项？').then(() => {
        return delFacility(facilityIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download("system/facility/export", {
        ...this.queryParams
      }, `facility_${new Date().getTime()}.xlsx`);
    }
  }
};
</script>