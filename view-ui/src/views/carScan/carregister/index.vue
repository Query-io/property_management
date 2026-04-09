<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="业主姓名" prop="ownerName">
        <el-input
          v-model="queryParams.ownerName"
          placeholder="请输入业主姓名"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="车牌号码" prop="plateNumber">
        <el-input
          v-model="queryParams.plateNumber"
          placeholder="请输入车牌号码"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="车辆品牌" prop="carBrand">
        <el-input
          v-model="queryParams.carBrand"
          placeholder="请输入车辆品牌"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="停车位号" prop="parkingSpace">
        <el-input
          v-model="queryParams.parkingSpace"
          placeholder="请输入停车位号"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable size="small">
          <el-option label="正常" value="0" />
          <el-option label="过期" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item label="登记日期">
        <el-date-picker
          v-model="dateRange"
          size="small"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="cyan" icon="el-icon-search" size="small" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="small" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          icon="el-icon-plus"
          size="small"
          @click="handleAdd"
          v-hasPermi="['car:register:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          icon="el-icon-edit"
          size="small"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['car:register:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="el-icon-delete"
          size="small"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['car:register:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="carRegisterList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="车辆ID" align="center" prop="carId" />
      <el-table-column label="业主姓名" align="center" prop="ownerName" />
      <el-table-column label="车牌号码" align="center" prop="plateNumber" />
      <el-table-column label="车辆品牌" align="center" prop="carBrand" />
      <el-table-column label="车辆型号" align="center" prop="carModel" />
      <el-table-column label="车辆颜色" align="center" prop="carColor" />
      <el-table-column label="停车位号" align="center" prop="parkingSpace" />
      <el-table-column label="登记日期" align="center" prop="registerDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.registerDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="有效期至" align="center" prop="expireDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.expireDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status === '0'" type="success">正常</el-tag>
          <el-tag v-else-if="scope.row.status === '1'" type="warning">过期</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['car:register:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['car:register:remove']"
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

    <!-- 添加或修改车辆登记对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="业主姓名" prop="ownerId">
              <el-select v-model="form.ownerId" placeholder="请选择业主" filterable style="width: 100%" @change="handleOwnerChange">
                <el-option
                  v-for="owner in ownerOptions"
                  :key="owner.ownerId"
                  :label="owner.ownerName + ' (' + owner.phoneNumber + ')'"
                  :value="owner.ownerId"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="车牌号码" prop="plateNumber">
              <el-input v-model="form.plateNumber" placeholder="请输入车牌号码" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="车辆品牌" prop="carBrand">
              <el-input v-model="form.carBrand" placeholder="请输入车辆品牌" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="车辆型号" prop="carModel">
              <el-input v-model="form.carModel" placeholder="请输入车辆型号" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="车辆颜色" prop="carColor">
              <el-input v-model="form.carColor" placeholder="请输入车辆颜色" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="停车位号" prop="parkingSpace">
              <el-input v-model="form.parkingSpace" placeholder="请输入停车位号" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="登记日期" prop="registerDate">
              <el-date-picker
                v-model="form.registerDate"
                type="date"
                placeholder="选择登记日期"
                value-format="yyyy-MM-dd"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="有效期至" prop="expireDate">
              <el-date-picker
                v-model="form.expireDate"
                type="date"
                placeholder="选择有效期至"
                value-format="yyyy-MM-dd"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择状态">
                <el-option label="正常" value="0" />
                <el-option label="过期" value="1" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
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
import { listCarRegister, getCarRegister, delCarRegister, addCarRegister, updateCarRegister, listOwners } from "@/api/system/dict/carRegister";

export default {
  name: "CarRegister",
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
      // 车辆登记表格数据
      carRegisterList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 业主选项
      ownerOptions: [],
      // 日期范围
      dateRange: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        ownerName: null,
        plateNumber: null,
        carBrand: null,
        parkingSpace: null,
        status: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        ownerId: [
          { required: true, message: "业主不能为空", trigger: "blur" }
        ],
        plateNumber: [
          { required: true, message: "车牌号码不能为空", trigger: "blur" }
        ],
        registerDate: [
          { required: true, message: "登记日期不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
    this.getOwnerOptions();
  },
  methods: {
    /** 查询车辆登记列表 */
    getList() {
      this.loading = true;
      listCarRegister(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.carRegisterList = response.rows;
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
    /** 业主选择变化 */
    handleOwnerChange(ownerId) {
      const selectedOwner = this.ownerOptions.find(owner => owner.ownerId === ownerId);
      if (selectedOwner) {
        this.form.ownerName = selectedOwner.ownerName;
      }
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        carId: null,
        ownerId: null,
        ownerName: null,
        plateNumber: null,
        carBrand: null,
        carModel: null,
        carColor: null,
        parkingSpace: null,
        registerDate: null,
        expireDate: null,
        status: "0",
        remark: null
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
      this.dateRange = [];
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.carId);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加车辆登记";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const carId = row.carId || this.ids;
      getCarRegister(carId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改车辆登记";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.carId != null) {
            updateCarRegister(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addCarRegister(this.form).then(response => {
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
      const carIds = row.carId || this.ids;
      this.$modal.confirm('是否确认删除车辆登记编号为"' + carIds + '"的数据项？').then(function() {
        return delCarRegister(carIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    }
  }
};
</script>