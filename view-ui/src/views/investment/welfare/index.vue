<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="业主姓名" prop="ownerName">
        <el-input v-model="queryParams.ownerName" placeholder="请输入业主姓名" clearable size="small"
          @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="房间号" prop="roomNo">
        <el-input v-model="queryParams.roomNo" placeholder="请输入房间号" clearable size="small"
          @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="福利类型" prop="welfareType">
        <el-select v-model="queryParams.welfareType" placeholder="请选择福利类型" clearable size="small">
          <el-option v-for="dict in welfareTypeOptions" :key="dict.dictValue" :label="dict.dictLabel"
            :value="dict.dictValue" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable size="small">
          <el-option v-for="dict in statusOptions" :key="dict.dictValue" :label="dict.dictLabel"
            :value="dict.dictValue" />
        </el-select>
      </el-form-item>
      <el-form-item label="领取方式" prop="receiveMethod">
        <el-select v-model="queryParams.receiveMethod" placeholder="请选择领取方式" clearable size="small">
          <el-option v-for="dict in receiveMethodOptions" :key="dict.dictValue" :label="dict.dictLabel"
            :value="dict.dictValue" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="cyan" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" icon="el-icon-plus" size="mini" @click="handleAdd"
          v-hasPermi="['investment:welfare:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate"
          v-hasPermi="['investment:welfare:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete"
          v-hasPermi="['investment:welfare:remove']">删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="welfareList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" align="center" prop="id" width="60" />
      <el-table-column label="业主姓名" align="center" prop="ownerName" width="100" />
      <el-table-column label="房间号" align="center" prop="roomNo" width="100" />
      <el-table-column label="福利类型" align="center" prop="welfareType" :formatter="welfareTypeFormat" width="100" />
      <el-table-column label="福利名称" align="center" prop="welfareName" width="120" />
      <el-table-column label="福利描述" align="center" prop="welfareDesc" width="150" show-overflow-tooltip />
      <el-table-column label="申领时间" align="center" prop="applyTime" width="120">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.applyTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="领取时间" align="center" prop="receiveTime" width="120">
        <template slot-scope="scope">
          <span>{{ scope.row.receiveTime ? parseTime(scope.row.receiveTime, '{y}-{m}-{d}') : '未领取' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="领取方式" align="center" prop="receiveMethod" :formatter="receiveMethodFormat" width="100" />
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === 0 ? 'primary' : scope.row.status === 1 ? 'success' : 'danger'">
            {{ scope.row.status === 0 ? '待领取' : scope.row.status === 1 ? '已领取' : '已过期' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="备注" align="center" prop="remark" width="150" show-overflow-tooltip />
      <el-table-column label="操作人" align="center" width="100">
        <template slot-scope="scope">
          <div>
            <div>创建: {{ scope.row.createBy || '系统' }}</div>
            <div v-if="scope.row.updateBy">更新: {{ scope.row.updateBy }}</div>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="150">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)"
            v-hasPermi="['investment:welfare:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)"
            v-hasPermi="['investment:welfare:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize"
      @pagination="getList" />

    <!-- 添加或修改业主福利申领对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="业主" prop="ownerId">
          <el-select v-model="form.ownerId" placeholder="请选择业主" filterable style="width: 100%"
            @change="handleOwnerChange">
            <el-option v-for="owner in ownerOptions" :key="owner.ownerId" :label="owner.ownerName"
              :value="owner.ownerId" />
          </el-select>
        </el-form-item>
        <el-form-item label="房产" prop="propertyId">
          <el-select v-model="form.propertyId" placeholder="请先选择业主" filterable style="width: 100%"
            @change="handlePropertyChange" :disabled="!form.ownerId">
            <el-option v-for="property in propertyOptions" :key="property.propertyId"
              :label="property.propertyAddress + ' ' + property.roomNo" :value="property.propertyId" />
          </el-select>
        </el-form-item>
        <el-form-item label="福利类型" prop="welfareType">
          <el-select v-model="form.welfareType" placeholder="请选择福利类型" style="width: 100%">
            <el-option v-for="dict in welfareTypeOptions" :key="dict.dictValue" :label="dict.dictLabel"
              :value="dict.dictValue" />
          </el-select>
        </el-form-item>
        <el-form-item label="福利名称" prop="welfareName">
          <el-input v-model="form.welfareName" placeholder="请输入福利名称" />
        </el-form-item>
        <el-form-item label="福利描述" prop="welfareDesc">
          <el-input v-model="form.welfareDesc" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="申领时间" prop="applyTime">
          <el-date-picker clearable size="small" v-model="form.applyTime" type="date" value-format="yyyy-MM-dd"
            placeholder="选择申领时间" style="width: 100%">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="领取时间" prop="receiveTime">
          <el-date-picker clearable size="small" v-model="form.receiveTime" type="date" value-format="yyyy-MM-dd"
            placeholder="选择领取时间" style="width: 100%">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="领取方式" prop="receiveMethod">
          <el-select v-model="form.receiveMethod" placeholder="请选择领取方式" style="width: 100%">
            <el-option v-for="dict in receiveMethodOptions" :key="dict.dictValue" :label="dict.dictLabel"
              :value="dict.dictValue" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio :label="0">待领取</el-radio>
            <el-radio :label="1">已领取</el-radio>
            <el-radio :label="2">已过期</el-radio>
          </el-radio-group>
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
import { listWelfare, getWelfare, delWelfare, addWelfare, updateWelfare } from "@/api/investment/welfare";
import { listOwners, listPropertiesByOwnerId } from "@/api/investment/welfare";

export default {
  name: "Welfare",
  data() {
    return {
      loading: true,
      propertyLoading: false,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      welfareList: [],
      title: "",
      open: false,
      welfareTypeOptions: [],
      statusOptions: [],
      receiveMethodOptions: [],
      ownerOptions: [],
      propertyOptions: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        ownerName: null,
        roomNo: null,
        welfareType: null,
        status: null,
        receiveMethod: null,
        applyTime: null
      },
      form: {
        id: null,
        ownerId: null,
        ownerName: null,
        propertyId: null,
        roomNo: null,
        welfareType: null,
        welfareName: null,
        welfareDesc: null,
        applyTime: null,
        receiveTime: null,
        receiveMethod: null,
        status: 0,
        remark: null
      },
      rules: {
        ownerId: [
          { required: true, message: "业主不能为空", trigger: "change" }
        ],
        propertyId: [
          { required: true, message: "房产不能为空", trigger: "change" }
        ],
        welfareType: [
          { required: true, message: "福利类型不能为空", trigger: "change" }
        ],
        welfareName: [
          { required: true, message: "福利名称不能为空", trigger: "blur" }
        ],
        applyTime: [
          { required: true, message: "申领时间不能为空", trigger: "change" }
        ]
      }
    };
  },
  created() {
    this.getList();
    this.getDicts("welfare_type").then(response => {
      this.welfareTypeOptions = response.data;
    });
    this.getDicts("receive_method").then(response => {
      this.receiveMethodOptions = response.data;
    });
    this.getOwnerOptions();
  },
  methods: {
    /** 查询业主福利申领列表 */
    getList() {
      this.loading = true;
      listWelfare(this.queryParams).then(response => {
        this.welfareList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 查询业主选项 */
    getOwnerOptions() {
      listOwners().then(response => {
        this.ownerOptions = response.data;
      });
    },
    /** 查询房产选项 - 根据业主ID */
    getPropertyOptionsByOwnerId(ownerId) {
      if (!ownerId) {
        this.propertyOptions = [];
        return;
      }
      listPropertiesByOwnerId(ownerId).then(response => {
        this.propertyOptions = response.data || [];
      });
    },
    /** 业主选择变化 */
    handleOwnerChange(ownerId) {
      // 清空之前选择的房产信息
      this.form.propertyId = null;
      this.form.roomNo = null;

      // 获取选中的业主信息
      const selectedOwner = this.ownerOptions.find(owner => owner.ownerId === ownerId);
      if (selectedOwner) {
        this.form.ownerName = selectedOwner.ownerName;
      }

      // 加载该业主的房产信息
      this.getPropertyOptionsByOwnerId(ownerId);
    },
    /** 房产选择变化 */
    handlePropertyChange(propertyId) {
      const selectedProperty = this.propertyOptions.find(property => property.propertyId === propertyId);
      if (selectedProperty) {
        this.form.roomNo = selectedProperty.roomNo;
      }
    },
    /** 福利类型字典翻译 */
    welfareTypeFormat(row, column) {
      return this.selectDictLabel(this.welfareTypeOptions, row.welfareType);
    },
    /** 领取方式字典翻译 */
    receiveMethodFormat(row, column) {
      return this.selectDictLabel(this.receiveMethodOptions, row.receiveMethod);
    },
    /** 取消按钮 */
    cancel() {
      this.open = false;
      this.reset();
    },
    /** 表单重置 */
    reset() {
      this.form = {
        id: null,
        ownerId: null,
        ownerName: null,
        propertyId: null,
        roomNo: null,
        welfareType: null,
        welfareName: null,
        welfareDesc: null,
        applyTime: null,
        receiveTime: null,
        receiveMethod: null,
        status: 0,
        remark: null
      };
      this.resetForm("form");
      this.propertyOptions = [];
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
    /** 多选框选中数据 */
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加业主福利申领";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids[0];

      getWelfare(id).then(response => {
        const data = response.data;
        // 直接赋值
        this.form = {
          id: data.id,
          ownerId: data.ownerId,
          ownerName: data.ownerName,
          propertyId: data.propertyId,
          roomNo: data.roomNo,
          welfareType: data.welfareType,
          welfareName: data.welfareName,
          welfareDesc: data.welfareDesc,
          applyTime: data.applyTime,
          receiveTime: data.receiveTime,
          receiveMethod: data.receiveMethod,
          status: data.status,
          remark: data.remark
        };

        this.open = true;
        this.title = "修改业主福利申领";

        // 加载房产信息
        if (this.form.ownerId) {
          this.getPropertyOptionsByOwnerId(this.form.ownerId);
        }
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          const submitData = { ...this.form };

          if (submitData.id != null) {
            updateWelfare(submitData).then(response => {
              this.$message.success("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addWelfare(submitData).then(response => {
              this.$message.success("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$confirm('是否确认删除业主福利申领编号为"' + ids + '"的数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        return delWelfare(ids);
      }).then(() => {
        this.getList();
        this.$message.success("删除成功");
      }).catch(() => { });
    }
  }
};
</script>