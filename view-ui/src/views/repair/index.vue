<template>
  <div class="app-container">
    <!-- 搜索区域 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" label-width="80px">
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option v-for="dict in dict.type.sys_repair_status" :key="dict.value" :label="dict.label"
            :value="dict.value" />
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
      <el-table-column label="操作" align="center" width="220">
        <template slot-scope="scope">
          <el-button size="mini" type="text" @click="viewDetail(scope.row)">详情</el-button>
          <!-- 待处理状态：显示处理按钮 -->
          <el-button size="mini" type="text" v-if="scope.row.status === '0'"
            @click="markAsDealt(scope.row)">分配工人</el-button>
          <!-- 维修中状态：显示维修完成按钮 -->
          <el-button size="mini" type="text" v-if="scope.row.status === '2'"
            @click="markAsComplete(scope.row)">维修完成</el-button>
          <el-button size="mini" type="text" style="color: red;" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize"
      @pagination="getList" />

    <!-- 详情弹窗 -->
    <el-dialog title="维修单详情" :visible.sync="detailVisible" width="800px" append-to-body @close="handleDetailClose">
      <!-- 步骤条 - 显示维修进度 -->
      <div class="repair-steps" v-if="detail.id">
        <el-steps :active="stepActive" align-center class="custom-steps">
          <el-step title="提交申请" :description="getStepDesc(0)" :status="getStepStatus(0)">
            <template slot="icon">
              <i class="el-icon-success step-icon" :class="{ 'active': stepActive >= 0 }"></i>
            </template>
          </el-step>
          <el-step title="维修中" :description="getStepDesc(1)" :status="getStepStatus(1)">
            <template slot="icon">
              <i class="el-icon-success step-icon" :class="{ 'active': stepActive >= 1 }"></i>
            </template>
          </el-step>
          <el-step title="维修完成" :description="getStepDesc(2)" :status="getStepStatus(2)">
            <template slot="icon">
              <i class="el-icon-success step-icon" :class="{ 'active': stepActive >= 2 }"></i>
            </template>
          </el-step>
          <el-step title="已评价" :description="getStepDesc(3)" :status="getStepStatus(3)">
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
              <el-image v-if="detail.imageUrl" :src="getFullUrl(detail.imageUrl)"
                :preview-src-list="[getFullUrl(detail.imageUrl)]"
                style="width: 100px; height: 100px; margin-right: 10px;" fit="cover">
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
              <el-rate v-model="detail.score" disabled show-score text-color="#ff9900" score-template="{value} 分"
                style="margin-bottom: 10px;"></el-rate>
            </div>
            <div v-if="detail.comment" class="rate-comment">
              <p><strong>评语：</strong>{{ detail.comment }}</p>
            </div>
            <div v-else class="rate-comment">
              <p><strong>评语：</strong>无评语</p>
            </div>
          </div>
        </div>

        <!-- 未评分但已完成 -->
        <div v-else-if="detail.status === '1' || detail.status === '3'">
          <el-alert title="维修已完成，等待用户评价" type="info" :closable="false" show-icon></el-alert>
        </div>
      </div>
    </el-dialog>

    <!-- 分配工人弹窗 -->
    <el-dialog title="分配工人" :visible.sync="dealVisible" width="500px" append-to-body @close="handleDealDialogClose">
      <el-form :model="dealForm" :rules="dealRules" ref="dealForm" label-width="100px">
        <el-form-item label="选择工人" prop="workerId" required>
          <el-select v-model="dealForm.workerId" placeholder="请选择工人" style="width: 100%;" filterable
            @change="handleWorkerChange" :loading="workerLoading">
            <el-option v-for="worker in workerList" :key="worker.workerId"
              :label="`${worker.workerName} (${worker.phoneNumber}) - ${worker.workerType}`" :value="worker.workerId">
              <span style="float: left">{{ worker.workerName }}</span>
              <span style="float: right; color: #8492a6; font-size: 13px">
                {{ worker.phoneNumber }} - {{ worker.workerType }}
              </span>
            </el-option>
          </el-select>
          <div v-if="workerList.length === 0" style="color: #909399; font-size: 12px; margin-top: 5px;">
            暂无可用工人数据，请先添加工人信息
          </div>
        </el-form-item>
        <el-form-item label="维修人姓名" prop="assigneeName">
          <el-input v-model="dealForm.assigneeName" placeholder="自动从选择的工人填充" readonly
            style="background-color: #f5f7fa;" />
        </el-form-item>
        <el-form-item label="维修人电话" prop="assigneePhone">
          <el-input v-model="dealForm.assigneePhone" placeholder="自动从选择的工人填充" readonly
            style="background-color: #f5f7fa;" />
        </el-form-item>
        <el-form-item label="维修备注">
          <el-input v-model="dealForm.remark" type="textarea" placeholder="可填写维修备注信息" :rows="3" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dealVisible = false">取消</el-button>
        <el-button type="primary" @click="submitDeal" :loading="submitting">确定分配</el-button>
      </div>
    </el-dialog>

    <!-- 维修完成确认弹窗 -->
    <el-dialog title="确认完成维修" :visible.sync="completeVisible" width="400px" append-to-body>
      <div style="text-align: center;">
        <i class="el-icon-success" style="font-size: 48px; color: #67c23a; margin-bottom: 20px;"></i>
        <p style="font-size: 16px; margin-bottom: 10px;">确定要将该维修单标记为完成吗？</p>
        <p style="color: #909399; font-size: 14px;">确认后，维修状态将变为"已完成"</p>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="completeVisible = false">取消</el-button>
        <el-button type="success" @click="submitComplete" :loading="completing">确认完成</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import { listRepair, getRepair, updateRepair, delRepair } from "@/api/system/repair";
import { listWorker } from "@/api/system/worker";  // 导入工人列表API

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
      dealVisible: false,
      completeVisible: false,
      detail: {},
      // 步骤条激活状态
      stepActive: 0,
      // 分配工人表单
      dealForm: {
        id: null,
        workerId: null,
        assigneeName: '',
        assigneePhone: '',
        remark: ''
      },
      // 维修完成表单
      currentRepairId: null,
      completing: false,
      // 工人相关数据
      workerList: [],
      workerLoading: false,
      submitting: false,
      // 表单验证规则
      dealRules: {
        workerId: [
          { required: true, message: '请选择维修工人', trigger: 'blur' }
        ],
        assigneeName: [
          { required: true, message: '维修人姓名不能为空', trigger: 'blur' }
        ],
        assigneePhone: [
          { required: true, message: '维修人电话不能为空', trigger: 'blur' }
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
      if (!url) return ''; // 防止空值
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
      } else if (status === '1') {
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
      switch (stepIndex) {
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
      };
      return map[status] || 'info';
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
      }).catch(error => {
        console.error("获取维修单详情失败:", error);
        this.$message.error("获取详情失败");
      });
    },

    // 分配工人处理
    markAsDealt(row) {
      // 重置表单
      this.dealForm = {
        id: row.id,
        workerId: null,
        assigneeName: row.assigneeName || '',
        assigneePhone: row.assigneePhone || '',
        remark: ''
      };

      // 获取工人列表
      this.loadWorkers();
      this.dealVisible = true;
    },

    // 维修完成处理
    markAsComplete(row) {
      this.currentRepairId = row.id;
      this.completeVisible = true;
    },

    // 加载工人列表
    loadWorkers() {
      this.workerLoading = true;

      // 只查询空闲状态的工人
      listWorker({
        workStatus: '0', // 空闲状态的工人
        pageNum: 1,
        pageSize: 1000 // 假设工人数量不会太多
      }).then(res => {
        this.workerList = res.rows || [];
        this.workerLoading = false;

        // 如果维修单已有维修人信息，尝试匹配
        if (this.dealForm.assigneeName && this.workerList.length > 0) {
          const matchedWorker = this.workerList.find(worker =>
            worker.workerName === this.dealForm.assigneeName
          );
          if (matchedWorker) {
            this.dealForm.workerId = matchedWorker.workerId;
            this.dealForm.assigneeName = matchedWorker.workerName;
            this.dealForm.assigneePhone = matchedWorker.phoneNumber;
          }
        }
      }).catch(error => {
        console.error("加载工人列表失败:", error);
        this.workerList = [];
        this.workerLoading = false;
        this.$message.warning("加载工人列表失败，请检查网络连接");
      });
    },

    // 工人选择变化事件
    handleWorkerChange(workerId) {
      if (!workerId) {
        this.dealForm.assigneeName = '';
        this.dealForm.assigneePhone = '';
        return;
      }

      const selectedWorker = this.workerList.find(worker => worker.workerId === workerId);
      if (selectedWorker) {
        this.dealForm.assigneeName = selectedWorker.workerName;
        this.dealForm.assigneePhone = selectedWorker.phoneNumber;

        // 自动清空验证状态
        this.$nextTick(() => {
          if (this.$refs.dealForm) {
            this.$refs.dealForm.clearValidate(['assigneeName', 'assigneePhone']);
          }
        });
      }
    },
    // 提交分配工人
    submitDeal() {
      this.$refs.dealForm.validate(valid => {
        if (!valid) {
          this.$message.warning("请填写完整的维修信息");
          return;
        }

        this.submitting = true;

        // 设置维修开始时间
        const now = new Date();
        const formattedAssignTime = this.formatDate(now, 'yyyy-MM-dd HH:mm:ss');

        const payload = {
          id: this.dealForm.id,
          assigneeName: this.dealForm.assigneeName,
          assigneePhone: this.dealForm.assigneePhone,
          status: '2', // 标记为维修中（注意：不是已完成）
          assignTime: formattedAssignTime, // 维修开始时间
          remark: this.dealForm.remark,
          updateBy: this.getUsername()
        };

        updateRepair(payload).then(() => {
          this.$message.success('工人分配成功，维修状态已更新为维修中');
          this.dealVisible = false;
          this.getList(); // 刷新列表
        }).catch(error => {
          console.error("分配工人失败:", error);
          this.$message.error("分配失败：" + (error.message || "请稍后重试"));
        }).finally(() => {
          this.submitting = false;
        });
      });
    },

    // 提交维修完成
    submitComplete() {
      this.completing = true;

      const now = new Date();
      const formattedCompleteTime = this.formatDate(now, 'yyyy-MM-dd HH:mm:ss');

      const payload = {
        id: this.currentRepairId,
        status: '1', // 标记为已完成
        completedTime: formattedCompleteTime, // 维修完成时间
        updateBy: this.getUsername()
      };

      updateRepair(payload).then(() => {
        this.$message.success('维修已完成');
        this.completeVisible = false;
        this.getList(); // 刷新列表
      }).catch(error => {
        console.error("维修完成操作失败:", error);
        this.$message.error("操作失败：" + (error.message || "请稍后重试"));
      }).finally(() => {
        this.completing = false;
        this.currentRepairId = null;
      });
    },

    // 日期格式化方法
    formatDate(date, format) {
      if (!date) return '';

      const d = new Date(date);
      const year = d.getFullYear();
      const month = (d.getMonth() + 1).toString().padStart(2, '0');
      const day = d.getDate().toString().padStart(2, '0');
      const hour = d.getHours().toString().padStart(2, '0');
      const minute = d.getMinutes().toString().padStart(2, '0');
      const second = d.getSeconds().toString().padStart(2, '0');

      if (format === 'yyyy-MM-dd HH:mm:ss') {
        return `${year}-${month}-${day} ${hour}:${minute}:${second}`;
      } else if (format === 'yyyy-MM-dd') {
        return `${year}-${month}-${day}`;
      }

      return `${year}-${month}-${day} ${hour}:${minute}:${second}`;
    },

    // 处理删除
    handleDelete(row) {
      this.$confirm('确定要删除该维修单吗？', '提示', {
        type: 'warning',
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(() => {
        delRepair(row.id).then(() => {
          this.$message.success('删除成功');
          this.getList();
        }).catch(error => {
          console.error("删除失败:", error);
          this.$message.error("删除失败：" + (error.message || "请稍后重试"));
        });
      }).catch(() => {
        // 用户取消删除
      });
    },

    // 处理弹窗关闭事件
    handleDealDialogClose() {
      // 重置表单
      this.dealForm = {
        id: null,
        workerId: null,
        assigneeName: '',
        assigneePhone: '',
        remark: ''
      };
      this.workerList = [];
      this.submitting = false;

      // 清除验证状态
      if (this.$refs.dealForm) {
        this.$refs.dealForm.clearValidate();
      }
    },

    // 处理详情弹窗关闭
    handleDetailClose() {
      this.detail = {};
      this.stepActive = 0;
    },

    // 获取当前用户名（简单实现）
    getUsername() {
      // 这里需要根据你的实际登录信息获取用户名
      // 如果是简单的演示，可以返回固定值
      return 'admin';
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
.repair-steps>>>.is-process .el-step__title {
  color: #e6a23c !important;
  font-weight: bold;
  font-size: 15px;
}

/* 步骤描述文字样式 */
.repair-steps>>>.el-step__description {
  font-size: 13px;
  color: #909399;
}

/* 已完成步骤描述文字 */
.repair-steps>>>.is-finish .el-step__description {
  color: #67c23a;
}

/* 当前步骤描述文字 */
.repair-steps>>>.is-process .el-step__description {
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
.repair-steps>>>.is-process .el-step__head .step-icon.active {
  color: #e6a23c !important;
}

/* 已完成步骤图标颜色 - 绿色 */
.repair-steps>>>.is-finish .el-step__head .step-icon.active {
  color: #67c23a !important;
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

.rate-time,
.rate-by {
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

.el-select {
  width: 100%;
}

.el-input.is-disabled .el-input__inner {
  background-color: #f5f7fa;
  color: #909399;
  cursor: not-allowed;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .repair-steps>>>.el-steps {
    flex-direction: column;
    align-items: flex-start;
  }

  .repair-steps>>>.el-step {
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