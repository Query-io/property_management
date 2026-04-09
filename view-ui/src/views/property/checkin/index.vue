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
      <el-form-item label="房产地址" prop="propertyAddress">
        <el-input
          v-model="queryParams.propertyAddress"
          placeholder="请输入房产地址"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="楼栋号" prop="buildingNo">
        <el-input
          v-model="queryParams.buildingNo"
          placeholder="请输入楼栋号"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="房间号" prop="roomNo">
        <el-input
          v-model="queryParams.roomNo"
          placeholder="请输入房间号"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="入住日期">
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
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable size="small">
          <el-option
            v-for="dict in statusOptions"
            :key="dict.dictValue"
            :label="dict.dictLabel"
            :value="dict.dictValue"
          />
        </el-select>
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
          v-hasPermi="['property:checkin:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          icon="el-icon-edit"
          size="small"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['property:checkin:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="el-icon-delete"
          size="small"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['property:checkin:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="checkinList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="入住ID" align="center" prop="checkInId" />
      <el-table-column label="业主姓名" align="center" prop="ownerName" />
      <el-table-column label="房产地址" align="center" prop="propertyAddress" width="180" />
      <el-table-column label="楼栋号" align="center" prop="buildingNo" />
      <el-table-column label="房间号" align="center" prop="roomNo" />
      <el-table-column label="入住日期" align="center" prop="checkInDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.checkInDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="预计时长(月)" align="center" prop="expectedDuration" />
      <el-table-column label="合同编号" align="center" prop="contractNumber" />
      <el-table-column label="租金金额" align="center" prop="rentalAmount">
        <template slot-scope="scope">
          <span>¥{{ scope.row.rentalAmount }}</span>
        </template>
      </el-table-column>
      <el-table-column label="押金金额" align="center" prop="depositAmount">
        <template slot-scope="scope">
          <span>¥{{ scope.row.depositAmount }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status === '0'" type="success">正常</el-tag>
          <el-tag v-else-if="scope.row.status === '1'" type="warning">已退房</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['property:checkin:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['property:checkin:remove']"
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

    <!-- 添加或修改入住登记对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="业主姓名" prop="ownerId">
              <el-select v-model="form.ownerId" placeholder="请选择业主" filterable style="width: 100%" @change="handleOwnerChange">
                <el-option
                  v-for="owner in ownerOptions"
                  :key="owner.ownerId"
                  :label="owner.ownerName"
                  :value="owner.ownerId"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="房产地址" prop="propertyId">
              <!-- 【修改1】添加loading禁用和加载中提示 -->
              <el-select 
                v-model="form.propertyId" 
                placeholder="请先选择业主" 
                filterable 
                style="width: 100%" 
                @change="handlePropertyChange" 
                :disabled="!form.ownerId || loading"
              >
                <el-option
                  v-for="property in propertyOptions"
                  :key="property.propertyId"
                  :label="property.propertyAddress + ' ' + property.roomNo"
                  :value="property.propertyId"
                />
                <!-- 加载中提示选项 -->
                <el-option v-if="loading && form.ownerId" label="加载中..." disabled />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="入住日期" prop="checkInDate">
              <el-date-picker
                v-model="form.checkInDate"
                type="date"
                placeholder="选择入住日期"
                value-format="yyyy-MM-dd"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="预计居住时长" prop="expectedDuration">
              <el-input-number v-model="form.expectedDuration" :min="1" :max="120" placeholder="请输入预计居住时长(月)" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="合同编号" prop="contractNumber">
              <el-input v-model="form.contractNumber" placeholder="请输入合同编号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择状态">
                <el-option label="正常" value="0" />
                <el-option label="已退房" value="1" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="租金金额" prop="rentalAmount">
              <el-input v-model="form.rentalAmount" placeholder="请输入租金金额" type="number" step="0.01">
                <template slot="append">元</template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="押金金额" prop="depositAmount">
              <el-input v-model="form.depositAmount" placeholder="请输入押金金额" type="number" step="0.01">
                <template slot="append">元</template>
              </el-input>
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
import { listCheckin, getCheckin, delCheckin, addCheckin, updateCheckin, listOwners, listPropertiesByOwnerId } from "@/api/system/dict/checkin";

export default {
  name: "Checkin",
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
      // 入住登记表格数据
      checkinList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 业主选项
      ownerOptions: [],
      // 房产选项
      propertyOptions: [],
      // 日期范围
      dateRange: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        ownerName: null,
        propertyAddress: null,
        buildingNo: null,
        roomNo: null,
        status: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        ownerId: [
          { required: true, message: "业主不能为空", trigger: "blur" }
        ],
        propertyId: [
          { required: true, message: "房产不能为空", trigger: "blur" }
        ],
        checkInDate: [
          { required: true, message: "入住日期不能为空", trigger: "blur" }
        ],
        contractNumber: [
          { required: true, message: "合同编号不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
    this.getOwnerOptions();
  },
  methods: {
    /** 查询入住登记列表 */
    getList() {
      this.loading = true;
      listCheckin(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.checkinList = response.rows;
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
    /** 查询房产选项 - 根据业主ID 
     * 【修改2】改为返回Promise，方便后续等待加载完成
     */
    getPropertyOptionsByOwnerId(ownerId) {
      return new Promise((resolve, reject) => {
        if (!ownerId) {
          this.propertyOptions = [];
          resolve();
          return;
        }
        listPropertiesByOwnerId(ownerId).then(response => {
          this.propertyOptions = response.data || [];
          resolve();
        }).catch(error => {
          this.propertyOptions = [];
          reject(error);
        });
      });
    },
    /** 业主选择变化 */
    handleOwnerChange(ownerId) {
      // 清空之前选择的房产信息
      this.form.propertyId = null;
      this.form.propertyAddress = null;
      this.form.buildingNo = null;
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
        this.form.propertyAddress = selectedProperty.propertyAddress;
        this.form.buildingNo = selectedProperty.buildingNo;
        this.form.roomNo = selectedProperty.roomNo;
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
        checkInId: null,
        propertyId: null,
        ownerId: null,
        ownerName: null,
        checkInDate: null,
        expectedDuration: 12,
        contractNumber: null,
        rentalAmount: null,
        depositAmount: null,
        status: "0",
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
      this.dateRange = [];
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.checkInId);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加入住登记";
    },
    /** 修改按钮操作 
     * 【修改3】调整逻辑，先清空propertyId，等待房产选项加载完成后再赋值
     */
    handleUpdate(row) {
      this.reset();
      const checkInId = row.checkInId || this.ids;
      // 显示加载状态
      this.loading = true;
      
      getCheckin(checkInId).then(response => {
        // 深拷贝数据，避免引用问题
        this.form = { ...response.data }; 
        this.open = true;
        this.title = "修改入住登记";
        
        // 获取业主ID
        const ownerId = this.form.ownerId;
        if (ownerId) {
          // 先暂存房产ID并清空，避免初始显示数字
          const tempPropertyId = this.form.propertyId;
          this.form.propertyId = null;
          
          // 加载该业主的房产信息，加载完成后再赋值房产ID
          this.getPropertyOptionsByOwnerId(ownerId).then(() => {
            // 等待DOM更新完成后再赋值
            this.$nextTick(() => {
              this.form.propertyId = tempPropertyId;
              this.loading = false;
            });
          }).catch(() => {
            this.loading = false;
          });
        } else {
          this.loading = false;
        }
      }).catch(() => {
        this.loading = false;
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.checkInId != null) {
            updateCheckin(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addCheckin(this.form).then(response => {
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
      const checkInIds = row.checkInId || this.ids;
      this.$modal.confirm('是否确认删除入住登记编号为"' + checkInIds + '"的数据项？').then(function() {
        return delCheckin(checkInIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    }
  }
};
</script>