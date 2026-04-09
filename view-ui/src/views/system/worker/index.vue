<template>
  <div class="app-container">
    <!-- 搜索表单 -->
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="工人姓名" prop="workerName">
        <el-input v-model="queryParams.workerName" placeholder="请输入工人姓名" clearable size="small"
          @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="联系电话" prop="phoneNumber">
        <el-input v-model="queryParams.phoneNumber" placeholder="请输入联系电话" clearable size="small"
          @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="工种" prop="workerType">
        <el-select v-model="queryParams.workerType" placeholder="请选择工种" clearable size="small">
          <el-option v-for="dict in workerTypeOptions" :key="dict.dictValue" :label="dict.dictLabel"
            :value="dict.dictValue" />
        </el-select>
      </el-form-item>
      <el-form-item label="工作状态" prop="workStatus">
        <el-select v-model="queryParams.workStatus" placeholder="请选择工作状态" clearable size="small">
          <el-option v-for="dict in workStatusOptions" :key="dict.dictValue" :label="dict.dictLabel"
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
          v-hasPermi="['system:worker:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate"
          v-hasPermi="['system:worker:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete"
          v-hasPermi="['system:worker:remove']">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="cyan" icon="el-icon-trophy" size="mini" @click="handleExportReward"
          v-hasPermi="['system:repair:export']">导出奖惩信息</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 导出奖惩信息对话框 -->
    <el-dialog title="导出奖惩信息" :visible.sync="exportRewardDialogVisible" width="500px" append-to-body>
      <el-form :model="exportRewardForm" label-width="100px">
        <el-form-item label="导出类型">
          <el-radio-group v-model="exportRewardForm.exportType">
            <el-radio label="1">报修奖惩明细</el-radio>
            <!-- <el-radio label="2">工人奖惩统计</el-radio> -->
          </el-radio-group>
        </el-form-item>
        <el-form-item label="工人姓名">
          <el-input v-model="exportRewardForm.workerName" placeholder="请输入工人姓名（可选）" />
        </el-form-item>
        <el-form-item label="工种">
          <el-select v-model="exportRewardForm.workerType" placeholder="请选择工种（可选）" clearable>
            <el-option v-for="dict in workerTypeOptions" :key="dict.dictValue" :label="dict.dictLabel"
              :value="dict.dictValue" />
          </el-select>
        </el-form-item>
        <el-form-item label="时间范围">
          <el-date-picker v-model="exportRewardForm.timeRange" type="daterange" range-separator="至" start-placeholder="开始日期"
            end-placeholder="结束日期" value-format="yyyy-MM-dd" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="confirmExportReward">确 定</el-button>
        <el-button @click="exportRewardDialogVisible = false">取 消</el-button>
      </div>
    </el-dialog>

    <el-table v-loading="loading" :data="workerList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="工人ID" align="center" prop="workerId" />
      <el-table-column label="工人姓名" align="center" prop="workerName" />
      <!-- 性别列：显示中文，存储数字 -->
      <el-table-column label="性别" align="center" prop="gender">
        <template slot-scope="scope">
          <el-tag size="small" type="info">
            {{ getGenderText(scope.row.gender) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="年龄" align="center" prop="age" />
      <el-table-column label="联系电话" align="center" prop="phoneNumber" />
      <!-- 工种列：直接显示数据库中存储的中文 -->
      <el-table-column label="工种" align="center" prop="workerType" />
      <!-- 工作状态列：显示中文，存储数字 -->
      <el-table-column label="工作状态" align="center" prop="workStatus">
        <template slot-scope="scope">
          <el-tag size="small" :type="getStatusTagType(scope.row.workStatus)">
            {{ getWorkStatusText(scope.row.workStatus) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="入职日期" align="center" prop="entryDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.entryDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)"
            v-hasPermi="['system:worker:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)"
            v-hasPermi="['system:worker:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize"
      @pagination="getList" />

    <!-- 添加或修改工人信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body @close="handleDialogClose">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="工人姓名" prop="workerName">
              <el-input v-model="form.workerName" placeholder="请输入工人姓名" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="性别" prop="gender">
              <el-radio-group v-model="form.gender">
                <el-radio v-for="dict in genderOptions" :key="dict.dictValue" :label="dict.dictValue">{{ dict.dictLabel }}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="年龄" prop="age">
              <el-input-number v-model="form.age" controls-position="right" :min="18" :max="65" placeholder="请输入年龄" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="phoneNumber">
              <el-input v-model="form.phoneNumber" placeholder="请输入联系电话" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="身份证号" prop="idCard">
              <el-input v-model="form.idCard" placeholder="请输入身份证号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="工种" prop="workerType">
              <el-select v-model="form.workerType" placeholder="请选择工种">
                <el-option v-for="dict in workerTypeOptions" :key="dict.dictValue" :label="dict.dictLabel"
                  :value="dict.dictValue" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="工作状态" prop="workStatus">
              <el-select v-model="form.workStatus" placeholder="请选择工作状态">
                <el-option v-for="dict in workStatusOptions" :key="dict.dictValue" :label="dict.dictLabel"
                  :value="dict.dictValue" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="入职日期" prop="entryDate">
              <el-date-picker clearable size="small" v-model="form.entryDate" type="date" value-format="yyyy-MM-dd"
                placeholder="选择入职日期">
              </el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="家庭住址" prop="address">
              <el-input v-model="form.address" placeholder="请输入家庭住址" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="紧急联系人" prop="emergencyContact">
              <el-input v-model="form.emergencyContact" placeholder="请输入紧急联系人" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="紧急联系电话" prop="emergencyPhone">
              <el-input v-model="form.emergencyPhone" placeholder="请输入紧急联系电话" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm" :loading="submitLoading">确 定</el-button>
        <el-button @click="cancel" :disabled="submitLoading">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listWorker, getWorker, delWorker, addWorker, updateWorker, exportWorker } from "@/api/system/worker";
import { exportRepairReward, exportWorkerRewardStat } from "@/api/system/repairReward";

export default {
  name: "Worker",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 提交按钮加载状态
      submitLoading: false,
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
      // 工人信息表格数据
      workerList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 导出奖惩信息对话框
      exportRewardDialogVisible: false,
      // 性别字典
      genderOptions: [],
      // 工种字典
      workerTypeOptions: [],
      // 工作状态字典
      workStatusOptions: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        workerName: null,
        phoneNumber: null,
        workerType: null,
        workStatus: null,
        gender: null,
        address: null,
        idCard: null
      },
      // 导出表单参数
      exportRewardForm: {
        exportType: '1',
        workerName: null,
        workerType: null,
        timeRange: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        workerName: [
          { required: true, message: "工人姓名不能为空", trigger: "blur" }
        ],
        phoneNumber: [
          { required: true, message: "联系电话不能为空", trigger: "blur" },
          { pattern: /^1[3-9]\d{9}$/, message: "请输入正确的手机号码", trigger: "blur" }
        ],
        workerType: [
          { required: true, message: "工种不能为空", trigger: "change" }
        ],
        workStatus: [
          { required: true, message: "工作状态不能为空", trigger: "change" }
        ],
        age: [
          { required: true, message: "年龄不能为空", trigger: "blur" },
          { type: 'number', min: 18, max: 65, message: '年龄必须在18到65之间', trigger: 'blur' }
        ],
        idCard: [
          { pattern: /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/, message: "请输入正确的身份证号码", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
    this.getDicts("sys_gender").then(response => {
      this.genderOptions = response.data;
    });
    this.getDicts("sys_worker_type").then(response => {
      this.workerTypeOptions = response.data;
    });
    this.getDicts("sys_work_status").then(response => {
      this.workStatusOptions = response.data;
    });
  },
  methods: {
    /** 性别转文字 */
    getGenderText(gender) {
      const genderMap = {
        0: '男',
        1: '女',
        2: '未知',
        '0': '男',
        '1': '女',
        '2': '未知'
      }
      return genderMap[gender] || '未知'
    },
    
    /** 工作状态转文字 */
    getWorkStatusText(status) {
      const statusMap = {
        0: '空闲',
        1: '忙碌',
        2: '请假',
        3: '离职',
        '0': '空闲',
        '1': '忙碌',
        '2': '请假',
        '3': '离职'
      }
      return statusMap[status] || '未知状态'
    },
    
    /** 工作状态对应标签颜色 */
    getStatusTagType(status) {
      const typeMap = {
        0: 'success', // 空闲-绿色
        1: 'warning', // 忙碌-黄色
        2: 'info',    // 请假-蓝色
        3: 'danger',  // 离职-红色
        '0': 'success',
        '1': 'warning',
        '2': 'info',
        '3': 'danger'
      }
      return typeMap[status] || 'info'
    },
    
    /** 查询工人信息列表 */
    getList() {
      this.loading = true;
      listWorker(this.queryParams).then(response => {
        this.workerList = response.rows;
        this.total = response.total;
        this.loading = false;
      }).catch(() => {
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    
    // 弹窗关闭事件
    handleDialogClose() {
      this.reset();
    },
    
    // 表单重置
    reset() {
      this.form = {
        workerId: null,
        workerName: null,
        gender: "0",
        age: null,
        phoneNumber: null,
        idCard: null,
        address: null,
        workerType: null,
        entryDate: null,
        workStatus: "0",
        emergencyContact: null,
        emergencyPhone: null,
        remark: null
      };
      this.submitLoading = false;
      // 重置表单验证状态
      if (this.$refs.formRef) {
        this.$refs.formRef.clearValidate();
      }
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
      this.ids = selection.map(item => item.workerId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加工人信息";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const workerId = row.workerId || this.ids;
      getWorker(workerId).then(response => {
        const data = response.data;
        
        // 对于工种：如果数据库存储的是中文，需要转换为字典值以便表单显示
        if (data.workerType && this.workerTypeOptions.length > 0) {
          const exactMatch = this.workerTypeOptions.find(
            item => item.dictLabel === data.workerType
          );
          if (exactMatch) {
            data.workerType = exactMatch.dictValue;
          } else {
            const similarMatch = this.workerTypeOptions.find(
              item => (item.dictLabel && item.dictLabel.includes(data.workerType)) ||
                      (data.workerType && data.workerType.includes(item.dictLabel))
            );
            if (similarMatch) {
              data.workerType = similarMatch.dictValue;
            }
          }
        }
        
        this.form = data;
        this.open = true;
        this.title = "修改工人信息";
      }).catch(error => {
        console.error('获取工人信息失败:', error);
        this.$message.error("获取工人信息失败");
      });
    },
    /** 提交按钮 - 修复版本 */
    submitForm() {
      this.$refs.formRef.validate(valid => {
        if (!valid) {
          console.log('表单验证未通过');
          this.$message.warning('请填写完整的表单信息');
          return;
        }
        
        console.log('表单验证通过，开始提交，表单数据:', this.form);
        
        // 创建提交数据的副本
        let submitData = JSON.parse(JSON.stringify(this.form));
        
        // 只对工种进行转换：将字典值转换为字典标签（中文）
        if (submitData.workerType && this.workerTypeOptions.length > 0) {
          const workerTypeOption = this.workerTypeOptions.find(
            item => item.dictValue === submitData.workerType.toString()
          );
          if (workerTypeOption) {
            submitData.workerType = workerTypeOption.dictLabel; // 存储中文标签
            console.log('工种转换:', submitData.workerType, '->', workerTypeOption.dictLabel);
          }
        }
        
        console.log('最终提交的数据:', submitData);
        
        // 设置提交加载状态
        this.submitLoading = true;
        
        // 根据是否有workerId决定是更新还是新增
        const apiCall = submitData.workerId != null 
          ? updateWorker(submitData) 
          : addWorker(submitData);
        
        apiCall.then(response => {
          console.log('API响应:', response);
          
          // 判断响应是否成功
          if (response && (response.code === 200 || response.code === 0 || response.status === 200)) {
            const successMsg = submitData.workerId != null ? "修改成功" : "新增成功";
            this.$message.success(successMsg);
            
            // 确保弹窗关闭
            this.open = false;
            
            // 刷新列表数据
            this.getList();
            
            // 重置表单
            this.reset();
          } else {
            const errorMsg = response ? (response.msg || response.message || "操作失败") : "操作失败";
            this.$message.error(errorMsg);
          }
        }).catch(error => {
          console.error('API调用失败:', error);
          let errorMsg = "操作失败";
          
          if (error.response && error.response.data) {
            const data = error.response.data;
            errorMsg = data.msg || data.message || errorMsg;
          } else if (error.message) {
            errorMsg = error.message;
          }
          
          this.$message.error(errorMsg);
        }).finally(() => {
          // 无论成功还是失败，都重置提交状态
          this.submitLoading = false;
        });
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const workerIds = row.workerId || this.ids;
      this.$confirm('是否确认删除工人信息编号为"' + workerIds + '"的数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        return delWorker(workerIds);
      }).then(response => {
        if (response && (response.code === 200 || response.code === 0 || response.status === 200)) {
          this.$message.success("删除成功");
          this.getList();
        } else {
          this.$message.error(response ? (response.msg || "删除失败") : "删除失败");
        }
      }).catch(() => {
        // 用户取消删除
        console.log('用户取消删除');
      });
    },
    // 导出奖惩信息 - 打开对话框
    handleExportReward() {
      // 初始化表单数据
      this.exportRewardForm = {
        exportType: '1',
        workerName: this.queryParams.workerName || null,
        workerType: this.queryParams.workerType || null,
        timeRange: null
      };
      this.exportRewardDialogVisible = true;
    },
    // 确认导出奖惩信息
    confirmExportReward() {
      this.$confirm('是否确认导出奖惩信息?', "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        // 构建参数
        const params = {};
        
        if (this.exportRewardForm.workerName) {
          params.workerName = this.exportRewardForm.workerName;
        }
        
        if (this.exportRewardForm.workerType) {
          params.workerType = this.exportRewardForm.workerType;
        }
        
        // 添加时间范围
        if (this.exportRewardForm.timeRange && this.exportRewardForm.timeRange.length === 2) {
          params.beginTime = this.exportRewardForm.timeRange[0];
          params.endTime = this.exportRewardForm.timeRange[1];
        }
        
        console.log('导出参数:', params);
        
        // 根据导出类型调用不同的API
        let exportPromise;
        if (this.exportRewardForm.exportType === '1') {
          exportPromise = exportRepairReward(params);
        } else {
          exportPromise = exportWorkerRewardStat(params);
        }
        
        exportPromise.then(response => {
          console.log('导出响应:', response);
          if (response instanceof Blob) {
            const url = window.URL.createObjectURL(response);
            const link = document.createElement('a');
            link.href = url;
            
            let fileName = '奖惩信息导出.xlsx';
            if (this.exportRewardForm.exportType === '1') {
              fileName = '报修奖惩明细.xlsx';
            } else {
              fileName = '工人奖惩统计.xlsx';
            }
            link.download = fileName;
            
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            window.URL.revokeObjectURL(url);
          } else {
            // 如果不是Blob，尝试使用框架的下载方法
            this.download(response.msg || '奖惩信息导出.xlsx');
          }
          
          this.exportRewardDialogVisible = false;
          this.$message.success("导出成功");
        }).catch(error => {
          console.error('导出失败:', error);
          this.$message.error("导出失败: " + (error.message || '未知错误'));
        });
      }).catch(() => {
        console.log('用户取消导出');
      });
    }
  }
};
</script>