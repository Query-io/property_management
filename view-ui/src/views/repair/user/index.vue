<template>
  <div class="app-container">
    <!-- 搜索区域 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" label-width="80px">
      <el-form-item label="申请人" prop="applicantName">
        <el-input v-model="queryParams.applicantName" placeholder="请输入申请人姓名" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option v-for="dict in dict.type.sys_repair_status" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="维修项目" prop="repairItem">
        <el-input v-model="queryParams.repairItem" placeholder="请输入维修项目" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 表格 -->
    <el-table v-loading="loading" :data="repairList">
      <el-table-column prop="id" label="ID" align="center" />
      <el-table-column prop="applicantId" label="申请人ID" align="center" />
      <el-table-column prop="applicantName" label="申请人姓名" align="center" />
      <el-table-column prop="repairItem" label="维修项目" align="center" />
      <el-table-column prop="submitTime" label="提交时间" align="center">
        <template slot-scope="scope">{{ parseTime(scope.row.submitTime) }}</template>
      </el-table-column>
      <el-table-column prop="status" label="状态" align="center">
        <template slot-scope="scope">
          {{ dict.label.sys_repair_status[scope.row.status] }}
          <el-tag v-if="scope.row.score" size="mini" type="success" style="margin-left: 5px;">
            已评分: {{ scope.row.score }}分
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="assigneeName" label="维修人" align="center" />
      <el-table-column prop="assignTime" label="维修开始时间" align="center">
        <template slot-scope="scope">{{ parseTime(scope.row.assignTime) }}</template>
      </el-table-column>
      <el-table-column prop="completedTime" label="完成时间" align="center">
        <template slot-scope="scope">{{ parseTime(scope.row.completedTime) }}</template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="200">
        <template slot-scope="scope">
          <el-button size="mini" type="text" @click="viewDetail(scope.row)">详情</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <!-- 详情弹窗 -->
    <el-dialog title="维修单详情" :visible.sync="detailVisible" width="800px" append-to-body @close="handleDetailClose">
      <!-- 步骤条 - 显示维修进度 -->
      <div class="repair-steps" v-if="detail.id">
        <el-steps :active="stepActive" align-center class="custom-steps">
          <el-step 
            title="提交申请" 
            :description="getStepDesc(0)" 
            :status="getStepStatus(0)"
          >
            <template slot="icon">
              <i class="el-icon-success step-icon" :class="{ 'active': stepActive >= 0 }"></i>
            </template>
          </el-step>
          <el-step 
            title="维修中" 
            :description="getStepDesc(1)"
            :status="getStepStatus(1)"
          >
            <template slot="icon">
              <i class="el-icon-success step-icon" :class="{ 'active': stepActive >= 1 }"></i>
            </template>
          </el-step>
          <el-step 
            title="维修完成" 
            :description="getStepDesc(2)"
            :status="getStepStatus(2)"
          >
            <template slot="icon">
              <i class="el-icon-success step-icon" :class="{ 'active': stepActive >= 2 }"></i>
            </template>
          </el-step>
          <el-step 
            title="已评价" 
            :description="getStepDesc(3)"
            :status="getStepStatus(3)"
          >
            <template slot="icon">
              <i class="el-icon-success step-icon" :class="{ 'active': stepActive >= 3 }"></i>
            </template>
          </el-step>
        </el-steps>
      </div>

      <el-divider></el-divider>

      <!-- 基本信息 -->
      <div class="base-info">
        <h3 class="info-title">基本信息</h3>
        <el-descriptions :column="2" border>
          <el-descriptions-item label="报修单号">{{ detail.repairNo || detail.id }}</el-descriptions-item>
          <el-descriptions-item label="报修状态">
            <el-tag :type="getStatusTagType(detail.status)" size="medium">
              {{ dict.label.sys_repair_status[detail.status] }}
            </el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="申请人">{{ detail.applicantName }}</el-descriptions-item>
          <el-descriptions-item label="联系电话">{{ detail.applicantPhone }}</el-descriptions-item>
          <el-descriptions-item label="房产地址">{{ detail.propertyAddress }}</el-descriptions-item>
          <el-descriptions-item label="维修项目">{{ detail.repairItem }}</el-descriptions-item>
          <el-descriptions-item label="维修描述" :span="2">{{ detail.repairDescription || '无' }}</el-descriptions-item>
          <el-descriptions-item label="图片" :span="2">
            <div class="image-preview">
              <el-image
                v-if="detail.imageUrl"
                :src="getFullUrl(detail.imageUrl)"
                :preview-src-list="[getFullUrl(detail.imageUrl)]"
                style="width: 100px; height: 100px; margin-right: 10px;"
                fit="cover"
              >
                <div slot="error" class="image-slot">
                  <i class="el-icon-picture-outline"></i>
                </div>
              </el-image>
              <span v-else>无图片</span>
            </div>
          </el-descriptions-item>
          <el-descriptions-item label="提交时间">{{ parseTime(detail.submitTime) }}</el-descriptions-item>
        </el-descriptions>
      </div>

      <!-- 维修信息 -->
      <div class="repair-info" v-if="detail.assigneeName || detail.assignTime">
        <el-divider>维修信息</el-divider>
        <el-descriptions :column="2" border>
          <el-descriptions-item label="维修人">{{ detail.assigneeName || '未分配' }}</el-descriptions-item>
          <el-descriptions-item label="维修人电话">{{ detail.assigneePhone || '未分配' }}</el-descriptions-item>
          <el-descriptions-item label="维修开始时间">{{ parseTime(detail.assignTime) }}</el-descriptions-item>
          <el-descriptions-item label="维修完成时间">{{ parseTime(detail.completedTime) }}</el-descriptions-item>
          <el-descriptions-item label="维修备注" :span="2">{{ detail.repairRemark || '无' }}</el-descriptions-item>
        </el-descriptions>
      </div>

      <!-- 评分区域 -->
      <div class="rate-section" v-if="detail.status === '1' || detail.status === '3'">
        <el-divider>维修评价</el-divider>
        
        <!-- 已评分显示 -->
        <div v-if="detail.score" class="rate-info">
          <div class="rate-header">
            <span class="rate-title">评分信息</span>
            <div class="rate-meta">
              <span class="rate-time" v-if="detail.rateTime">评价时间：{{ parseTime(detail.rateTime) }}</span>
              <span class="rate-by" v-if="detail.rateBy">评价人：{{ detail.rateBy }}</span>
            </div>
          </div>
          <div class="rate-content">
            <div class="rate-stars">
              <el-rate
                v-model="detail.score"
                disabled
                show-score
                text-color="#ff9900"
                score-template="{value} 分"
                style="margin-bottom: 10px;"
              ></el-rate>
            </div>
            <div v-if="detail.comment" class="rate-comment">
              <p><strong>评语：</strong>{{ detail.comment }}</p>
            </div>
            <div v-else class="rate-comment">
              <p><strong>评语：</strong>无评语</p>
            </div>
          </div>
        </div>
        
        <!-- 未评分但已完成 - 显示评分表单 -->
        <div v-else-if="detail.status === '1' || detail.status === '3'" class="rate-form">
          <div class="rate-form-header">
            <span class="form-title">请对本次维修进行评价</span>
            <span class="form-subtitle">您的评价将帮助我们改进服务质量</span>
          </div>
          <el-form :model="rateForm" :rules="rateRules" ref="rateFormRef" label-width="80px">
            <el-form-item label="评分" prop="score" required>
              <div class="rate-guidance">
                <el-rate
                  v-model="rateForm.score"
                  :colors="['#99A9BF', '#F7BA2A', '#FF9900']"
                  show-text
                  text-color="#ff9900"
                  :texts="['很差', '较差', '一般', '较好', '很好']"
                  @change="handleRateChange"
                ></el-rate>
                <div class="rate-hint" v-if="rateForm.score > 0">
                  {{ getRateHint(rateForm.score) }}
                </div>
              </div>
            </el-form-item>
            <el-form-item label="评语" prop="comment">
              <el-input
                v-model="rateForm.comment"
                type="textarea"
                :rows="4"
                placeholder="请填写评语（选填，500字以内）"
                maxlength="500"
                show-word-limit
              ></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="submitRate" :loading="rating">提交评价</el-button>
              <el-button @click="cancelRate">取消</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import { listRepair, getRepair, rateRepair } from "@/api/system/repair";

export default {
  name: "RepairList",
  dicts: ['sys_repair_status'],
  data() {
    return {
      loading: false,
      repairList: [],
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        applicantName: undefined,
        status: undefined,
        repairItem: undefined
      },
      detailVisible: false,
      detail: {},
      // 步骤条激活状态
      stepActive: 0,
      // 评分表单
      rateForm: {
        id: null,
        score: 0,
        comment: ''
      },
      rating: false,
      // 评分验证规则
      rateRules: {
        score: [
          { required: true, message: '请选择评分', trigger: 'blur' },
          { type: 'number', min: 1, max: 5, message: '评分必须在1-5分之间', trigger: 'blur' }
        ]
      }
    };
  },
  watch: {
    'detail.status': {
      handler(newVal) {
        this.calculateStepActive();
      },
      immediate: true
    },
    'detail.score': {
      handler(newVal) {
        this.calculateStepActive();
      },
      immediate: true
    }
  },
  created() {
    this.getList();
  },
  methods: {
    getFullUrl(url) {
      if (!url) return '';
      return process.env.VUE_APP_BASE_API + url;
    },
    
    // 计算步骤条激活状态
    calculateStepActive() {
      if (!this.detail || !this.detail.status) {
        this.stepActive = 0;
        return;
      }
      
      const status = this.detail.status;
      const hasScore = !!this.detail.score;
      const hasAssignee = !!this.detail.assigneeName;
      
      if (hasScore) {
        // 已评价
        this.stepActive = 3;
      } else if (status === '1' || status === '3') {
        // 已完成但未评价
        this.stepActive = 2;
      } else if (hasAssignee && status === '2') {
        // 维修中
        this.stepActive = 1;
      } else {
        // 已提交，待处理
        this.stepActive = 0;
      }
    },
    
    // 获取步骤状态
    getStepStatus(stepIndex) {
      if (stepIndex < this.stepActive) {
        return 'finish'; // 已完成
      } else if (stepIndex === this.stepActive) {
        return 'process'; // 当前进行中
      } else {
        return 'wait'; // 未开始
      }
    },
    
    // 获取步骤描述
    getStepDesc(stepIndex) {
      switch(stepIndex) {
        case 0: // 提交申请
          return this.detail.submitTime ? 
            `已提交 (${this.parseTime(this.detail.submitTime, '{y}-{m}-{d}')})` : 
            '待提交';
            
        case 1: // 维修中
          if (this.detail.assigneeName) {
            return `已分配 (${this.detail.assigneeName})`;
          } else if (this.detail.assignTime) {
            return `已分配 (${this.parseTime(this.detail.assignTime, '{y}-{m}-{d}')})`;
          } else {
            return '未分配';
          }
            
        case 2: // 维修完成
          if (this.detail.completedTime) {
            return `已完成 (${this.parseTime(this.detail.completedTime, '{y}-{m}-{d}')})`;
          } else if (this.detail.assigneeName) {
            return '维修中';
          } else {
            return '待完成';
          }
            
        case 3: // 已评价
          if (this.detail.score) {
            return `评价完成 (${this.detail.score}分)`;
          } else if (this.detail.completedTime) {
            return '待评价';
          } else {
            return '未评价';
          }
            
        default:
          return '';
      }
    },
    
    // 获取状态标签类型
    getStatusTagType(status) {
      const map = {
        '0': 'warning',  // 待处理
        '1': 'success',  // 已完成
        '2': 'info',     // 维修中
        '3': 'success'   // 已完成
      };
      return map[status] || 'info';
    },
    
    // 获取评分提示语
    getRateHint(score) {
      const hints = {
        1: '很不满意，有重大问题',
        2: '不太满意，有待改进',
        3: '一般，基本符合预期',
        4: '比较满意，服务不错',
        5: '非常满意，超出预期'
      };
      return hints[score] || '';
    },
    
    getList() {
      this.loading = true;
      listRepair(this.queryParams).then(res => {
        this.repairList = res.rows;
        this.total = res.total;
        this.loading = false;
      }).catch(() => {
        this.loading = false;
      });
    },
    
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    
    resetQuery() {
      this.queryParams = { pageNum: 1, pageSize: 10 };
      this.getList();
    },
    
    viewDetail(row) {
      getRepair(row.id).then(res => {
        this.detail = res.data;
        this.detailVisible = true;
        
        // 计算步骤条状态
        this.calculateStepActive();
        
        // 重置评分表单
        this.resetRateForm();
        
        // 如果已完成且未评分，初始化评分表单
        if ((this.detail.status === '1' || this.detail.status === '3') && !this.detail.score) {
          this.rateForm.id = this.detail.id;
        }
      }).catch(error => {
        console.error("获取维修单详情失败:", error);
        this.$message.error("获取详情失败");
      });
    },
    
    // 处理评分变化
    handleRateChange(value) {
      this.rateForm.score = value;
    },
    
    // 提交评分
    submitRate() {
      this.$refs.rateFormRef.validate(valid => {
        if (!valid) {
          this.$message.warning("请选择评分");
          return;
        }
        
        this.rating = true;
        
        const rateData = {
          id: this.rateForm.id,
          score: this.rateForm.score,
          comment: this.rateForm.comment
        };
        
        rateRepair(rateData).then(response => {
          this.$message.success("评价提交成功");
          
          // 重新获取维修单详情，更新显示
          getRepair(this.detail.id).then(res => {
            this.detail = res.data;
            this.calculateStepActive();
          });
          
          // 刷新列表，更新表格中的评分显示
          this.getList();
          
        }).catch(error => {
          console.error("评价提交失败:", error);
          
          let errorMsg = "评价提交失败";
          if (error.response && error.response.data && error.response.data.msg) {
            errorMsg = error.response.data.msg;
          }
          
          this.$message.error(errorMsg);
          
        }).finally(() => {
          this.rating = false;
        });
      });
    },
    
    // 取消评分
    cancelRate() {
      this.resetRateForm();
    },
    
    // 重置评分表单
    resetRateForm() {
      this.rateForm = {
        id: null,
        score: 0,
        comment: ''
      };
      if (this.$refs.rateFormRef) {
        this.$refs.rateFormRef.clearValidate();
      }
    },
    
    // 处理详情弹窗关闭
    handleDetailClose() {
      this.detail = {};
      this.stepActive = 0;
      this.resetRateForm();
    }
  }
};
</script>

<style scoped>
.app-container {
  padding: 20px;
}

.el-form--inline .el-form-item {
  margin-bottom: 10px;
}

.el-table {
  margin-top: 20px;
}

.el-dialog__body {
  padding: 20px;
}

/* 步骤条样式 */
.repair-steps {
  margin-bottom: 30px;
}

/* 当前步骤文字改为黄色 */
.repair-steps >>> .is-process .el-step__title {
  color: #e6a23c !important;
  font-weight: bold;
  font-size: 15px;
}

/* 步骤描述文字样式 */
.repair-steps >>> .el-step__description {
  font-size: 13px;
  color: #909399;
}

/* 已完成步骤描述文字 */
.repair-steps >>> .is-finish .el-step__description {
  color: #67c23a;
}

/* 当前步骤描述文字 */
.repair-steps >>> .is-process .el-step__description {
  color: #e6a23c !important;
  font-weight: 500;
}

/* 步骤图标样式 */
.step-icon {
  font-size: 24px;
  color: #c0c4cc;
}

.step-icon.active {
  color: #409eff;
}

/* 当前步骤图标颜色 - 黄色 */
.repair-steps >>> .is-process .el-step__head .step-icon.active {
  color: #e6a23c !important;
}

/* 已完成步骤图标颜色 - 绿色 */
.repair-steps >>> .is-finish .el-step__head .step-icon.active {
  color: #67c23a !important;
}

.timeline-container {
  margin-top: 20px;
  padding: 15px;
  background-color: #f8f9fa;
  border-radius: 8px;
}

.timeline-content {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.timeline-title {
  font-weight: bold;
  color: #303133;
}

.timeline-desc {
  color: #606266;
  font-size: 14px;
}

.timeline-operator {
  color: #909399;
  font-size: 12px;
}

/* 基本信息样式 */
.base-info {
  margin-bottom: 20px;
}

.info-title {
  margin-bottom: 15px;
  padding-bottom: 10px;
  border-bottom: 3px solid #409eff;
  color: #303133;
  font-size: 18px;
}

.image-preview {
  display: flex;
  align-items: center;
}

.image-slot {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  background: #f5f7fa;
  color: #909399;
  font-size: 30px;
}

/* 维修信息样式 */
.repair-info {
  margin: 20px 0;
}

/* 评分区域样式 */
.rate-section {
  margin-top: 20px;
}

.rate-info {
  border: 1px solid #ebeef5;
  border-radius: 8px;
  padding: 20px;
  background-color: #f8f9fa;
}

.rate-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
  padding-bottom: 10px;
  border-bottom: 1px solid #e8e8e8;
}

.rate-meta {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 5px;
}

.rate-title {
  font-size: 16px;
  font-weight: bold;
  color: #303133;
}

.rate-time, .rate-by {
  font-size: 14px;
  color: #909399;
}

.rate-content {
  padding: 10px 0;
}

.rate-comment {
  margin-top: 15px;
  padding: 15px;
  background-color: white;
  border-radius: 6px;
  border-left: 4px solid #409eff;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.rate-comment p {
  margin: 0;
  color: #606266;
  line-height: 1.8;
}

/* 评分表单样式 */
.rate-form {
  border: 1px solid #dcdfe6;
  border-radius: 8px;
  padding: 25px;
  background-color: white;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.rate-form-header {
  margin-bottom: 25px;
  text-align: center;
}

.form-title {
  display: block;
  font-size: 18px;
  font-weight: bold;
  color: #303133;
  margin-bottom: 5px;
}

.form-subtitle {
  font-size: 14px;
  color: #909399;
}

.rate-guidance {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.rate-hint {
  padding: 8px 12px;
  background-color: #f0f9eb;
  border: 1px solid #e1f3d8;
  border-radius: 4px;
  color: #67c23a;
  font-size: 14px;
}

/* 未完成提示样式 */
.rate-notice {
  padding: 15px;
  border-radius: 8px;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .repair-steps >>> .el-steps {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .repair-steps >>> .el-step {
    margin-bottom: 10px;
  }
  
  .rate-header {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .rate-meta {
    align-items: flex-start;
    margin-top: 10px;
  }
}
</style>