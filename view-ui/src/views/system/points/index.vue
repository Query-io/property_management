<template>
  <div class="app-container">
    <!-- 搜索表单 -->
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
      <el-form-item label="联系电话" prop="phoneNumber">
        <el-input
          v-model="queryParams.phoneNumber"
          placeholder="请输入联系电话"
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
          v-hasPermi="['system:ownerPoints:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:ownerPoints:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:ownerPoints:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="pointsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="业主ID" align="center" prop="ownerId" />
      <el-table-column label="业主姓名" align="center" prop="ownerName" />
      <el-table-column label="用户ID" align="center" prop="userId" />
      <el-table-column label="积分" align="center" prop="points">
        <template slot-scope="scope">
          <el-tag :type="getPointsType(scope.row.points)">
            {{ scope.row.points || 0 }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="联系电话" align="center" prop="phoneNumber" />
      <el-table-column label="联系地址" align="center" prop="address" :show-overflow-tooltip="true" />
      <el-table-column label="更新时间" align="center" prop="updateTime" width="160">
        <template slot-scope="scope">
          {{ formatTime(scope.row.updateTime) }}
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="350">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:ownerPoints:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-circle-plus-outline"
            @click="handleAdjustPoints(scope.row)"
            v-hasPermi="['system:ownerPoints:updatePoints']"
          >调整积分</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-time"
            @click="handleHistory(scope.row)"
            v-hasPermi="['system:ownerPoints:history']"
          >查看记录</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:ownerPoints:remove']"
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

    <!-- 添加或修改业主积分对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="业主姓名" prop="ownerName">
          <el-input v-model="form.ownerName" placeholder="请输入业主姓名" />
        </el-form-item>
        <el-form-item label="用户ID" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入用户ID" />
        </el-form-item>
        <el-form-item label="积分" prop="points">
          <el-input v-model="form.points" placeholder="请输入积分" type="number" min="0" />
        </el-form-item>
        <el-form-item label="联系电话" prop="phoneNumber">
          <el-input v-model="form.phoneNumber" placeholder="请输入联系电话" />
        </el-form-item>
        <el-form-item label="联系地址" prop="address">
          <el-input v-model="form.address" placeholder="请输入联系地址" />
        </el-form-item>
        <el-form-item label="身份证号" prop="identityNo">
          <el-input v-model="form.identityNo" placeholder="请输入身份证号" />
        </el-form-item>
        <el-form-item label="出生日期" prop="dateOfBirth">
          <el-date-picker clearable size="small"
            v-model="form.dateOfBirth"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择出生日期">
          </el-date-picker>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 调整积分对话框 -->
    <el-dialog title="调整积分" :visible.sync="adjustOpen" width="400px" append-to-body>
      <el-form ref="adjustForm" :model="adjustForm" :rules="adjustRules" label-width="80px">
        <el-form-item label="业主姓名">
          <el-input v-model="adjustForm.ownerName" disabled />
        </el-form-item>
        <el-form-item label="当前积分">
          <el-input v-model="adjustForm.currentPoints" disabled />
        </el-form-item>
        <el-form-item label="调整类型" prop="adjustType">
          <el-radio-group v-model="adjustForm.adjustType" @change="calculateNewPoints">
            <el-radio label="ADD">增加</el-radio>
            <el-radio label="SUBTRACT">减少</el-radio>
            <el-radio label="SET">直接设置</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="积分值" prop="adjustPoints">
          <el-input 
            v-model="adjustForm.adjustPoints" 
            placeholder="请输入积分值" 
            type="number"
            min="0"
            @input="calculateNewPoints"
          />
        </el-form-item>
        <el-form-item label="调整后积分">
          <el-input v-model="adjustForm.newPoints" disabled />
        </el-form-item>
        <el-form-item label="调整原因" prop="reason">
          <el-input v-model="adjustForm.reason" type="textarea" placeholder="请输入调整原因" rows="3" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitAdjust" :loading="adjustLoading">确 定</el-button>
        <el-button @click="cancelAdjust" :disabled="adjustLoading">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 历史记录弹窗 -->
    <el-dialog 
      title="积分调整历史记录" 
      :visible.sync="historyOpen" 
      width="800px"
      append-to-body
    >
      <div v-if="selectedOwner" class="history-header">
        <h3>{{ selectedOwner.ownerName }} 的积分调整历史</h3>
        <p>当前积分：<span class="current-points">{{ selectedOwner.points || 0 }}</span></p>
      </div>
      
      <div class="history-container">
        <el-timeline v-if="historyList.length > 0">
          <el-timeline-item 
            v-for="(item, index) in historyList" 
            :key="index"
            :timestamp="formatTime(item.createTime)"
            placement="top"
            :type="getTimelineType(item.adjustType)"
            size="large"
          >
            <el-card class="history-card">
              <div class="history-item">
                <div class="history-header">
                  <span class="history-type">{{ getAdjustTypeText(item.adjustType) }}</span>
                  <span class="history-operator">操作人：{{ item.createBy || '系统' }}</span>
                </div>
                <div class="history-content">
                  <div class="points-change">
                    <div class="points-row">
                      <span class="points-label">调整前：</span>
                      <span class="old-points">{{ item.oldPoints || 0 }}</span>
                    </div>
                    <div class="points-row">
                      <span class="points-label">调整后：</span>
                      <span class="new-points">{{ item.newPoints || 0 }}</span>
                    </div>
                    <div class="points-row" v-if="item.adjustPoints !== 0">
                      <span class="points-label">调整值：</span>
                      <span class="adjust-points" :class="item.adjustType.toLowerCase()">
                        {{ item.adjustType === 'ADD' ? '+' : '' }}{{ item.adjustPoints }}
                      </span>
                    </div>
                  </div>
                  <div class="reason" v-if="item.reason">
                    <div class="reason-label">调整原因：</div>
                    <div class="reason-content">{{ item.reason }}</div>
                  </div>
                </div>
              </div>
            </el-card>
          </el-timeline-item>
        </el-timeline>
        
        <div v-else class="empty-history">
          <i class="el-icon-info"></i>
          <p>暂无积分调整记录</p>
        </div>
      </div>
      
      <div slot="footer" class="dialog-footer">
        <el-button @click="historyOpen = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listPoints, getPoints, delPoints, addPoints, updatePoints, adjustPoints, getHistoryByOwnerId } from "@/api/system/ownerPoints";

export default {
  name: "OwnerPoints",
  data() {
    const validateAdjustPoints = (rule, value, callback) => {
      if (value === '' || value === undefined || value === null) {
        callback(new Error('积分值不能为空'));
      } else if (!/^[0-9]*$/.test(value)) {
        callback(new Error('积分必须为数字'));
      } else if (parseInt(value) < 0) {
        callback(new Error('积分不能为负数'));
      } else if (this.adjustForm.adjustType === 'SUBTRACT' && parseInt(value) > this.adjustForm.currentPoints) {
        callback(new Error('减少的积分不能超过当前积分'));
      } else {
        callback();
      }
    };
    
    return {
      loading: true,
      adjustLoading: false,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      pointsList: [],
      title: "",
      open: false,
      adjustOpen: false,
      historyOpen: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        ownerName: null,
        phoneNumber: null,
        userId: null,
        points: null
      },
      form: {},
      adjustForm: {
        ownerId: null,
        ownerName: '',
        userId: null,
        currentPoints: 0,
        adjustType: 'ADD',
        adjustPoints: '',
        newPoints: 0,
        reason: '',
        updateTime: null
      },
      historyList: [],
      selectedOwner: null,
      rules: {
        ownerName: [
          { required: true, message: "业主姓名不能为空", trigger: "blur" }
        ],
        userId: [
          { required: true, message: "用户ID不能为空", trigger: "blur" },
          { pattern: /^[0-9]*$/, message: "用户ID必须为数字" }
        ],
        points: [
          { required: true, message: "积分不能为空", trigger: "blur" },
          { pattern: /^[0-9]*$/, message: "积分必须为数字" },
          { validator: (rule, value, callback) => {
            if (parseInt(value) < 0) {
              callback(new Error('积分不能为负数'));
            } else {
              callback();
            }
          }, trigger: 'blur' }
        ]
      },
      adjustRules: {
        adjustPoints: [
          { required: true, validator: validateAdjustPoints, trigger: 'blur' }
        ],
        adjustType: [
          { required: true, message: "请选择调整类型", trigger: "change" }
        ],
        reason: [
          { required: true, message: "请填写调整原因", trigger: "blur" },
          { min: 2, max: 200, message: "原因长度在 2 到 200 个字符", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    getList() {
      this.loading = true;
      listPoints(this.queryParams).then(response => {
        this.pointsList = response.rows;
        this.total = response.total;
        this.loading = false;
      }).catch(() => {
        this.loading = false;
      });
    },
    cancel() {
      this.open = false;
      this.reset();
    },
    cancelAdjust() {
      this.adjustOpen = false;
      this.resetAdjustForm();
    },
    reset() {
      this.form = {
        ownerId: null,
        ownerName: null,
        userId: null,
        points: null,
        phoneNumber: null,
        address: null,
        identityNo: null,
        dateOfBirth: null
      };
      this.resetForm("form");
    },
    resetAdjustForm() {
      this.adjustForm = {
        ownerId: null,
        ownerName: '',
        userId: null,
        currentPoints: 0,
        adjustType: 'ADD',
        adjustPoints: '',
        newPoints: 0,
        reason: '',
        updateTime: null
      };
      if (this.$refs.adjustForm) {
        this.$refs.adjustForm.clearValidate();
      }
    },
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.ownerId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加业主积分";
    },
    handleUpdate(row) {
      this.reset();
      const ownerId = row.ownerId || this.ids[0];
      getPoints(ownerId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改业主积分";
      });
    },
    handleAdjustPoints(row) {
      this.resetAdjustForm();
      // 获取最新的业主信息
      getPoints(row.ownerId).then(response => {
        const data = response.data;
        this.adjustForm.ownerId = data.ownerId;
        this.adjustForm.ownerName = data.ownerName;
        this.adjustForm.userId = data.userId;
        this.adjustForm.currentPoints = data.points || 0;
        this.adjustForm.newPoints = data.points || 0;
        this.adjustForm.updateTime = data.updateTime;
        this.adjustOpen = true;
      }).catch(() => {
        this.$message.error('获取业主信息失败');
      });
    },
    handleHistory(row) {
      this.selectedOwner = row;
      this.historyList = [];
      this.historyOpen = true;
      
      // 获取历史记录数据
      getHistoryByOwnerId(row.ownerId).then(response => {
        if (response.code === 200) {
          this.historyList = response.data || [];
        } else {
          this.$message.error(response.msg || '获取历史记录失败');
        }
      }).catch(error => {
        console.error('获取历史记录错误:', error);
        this.$message.error('获取历史记录失败');
      });
    },
    calculateNewPoints() {
      const current = parseInt(this.adjustForm.currentPoints) || 0;
      const adjust = parseInt(this.adjustForm.adjustPoints) || 0;
      
      if (this.adjustForm.adjustType === 'ADD') {
        this.adjustForm.newPoints = current + adjust;
      } else if (this.adjustForm.adjustType === 'SUBTRACT') {
        this.adjustForm.newPoints = Math.max(0, current - adjust);
      } else if (this.adjustForm.adjustType === 'SET') {
        this.adjustForm.newPoints = adjust;
      }
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.ownerId != null) {
            updatePoints(this.form).then(response => {
              if (response.code === 200) {
                this.$message.success("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.$message.error(response.msg || "修改失败");
              }
            }).catch(() => {
              this.$message.error("修改失败");
            });
          } else {
            addPoints(this.form).then(response => {
              if (response.code === 200) {
                this.$message.success("新增成功");
                this.open = false;
                this.getList();
              } else {
                this.$message.error(response.msg || "新增失败");
              }
            }).catch(() => {
              this.$message.error("新增失败");
            });
          }
        }
      });
    },
    submitAdjust() {
      this.$refs["adjustForm"].validate(valid => {
        if (valid) {
          this.adjustLoading = true;
          
          // 确保调整积分是整数
          const adjustPointsValue = parseInt(this.adjustForm.adjustPoints) || 0;
          
          // 计算新的积分值
          let newPoints;
          const currentPoints = parseInt(this.adjustForm.currentPoints) || 0;
          
          switch(this.adjustForm.adjustType) {
            case 'ADD':
              newPoints = currentPoints + adjustPointsValue;
              break;
            case 'SUBTRACT':
              newPoints = Math.max(0, currentPoints - adjustPointsValue);
              break;
            case 'SET':
              newPoints = adjustPointsValue;
              break;
            default:
              newPoints = currentPoints;
          }
          
          const params = {
            ownerPoints: {
              ownerId: this.adjustForm.ownerId,
              points: newPoints,
              updateBy: this.$store.state.user.name || 'system',
              updateTime: this.adjustForm.updateTime
            },
            adjustType: this.adjustForm.adjustType,
            adjustPoints: adjustPointsValue,
            reason: this.adjustForm.reason
          };
          
          console.log('发送调整积分参数:', params);
          
          adjustPoints(params).then(response => {
            this.adjustLoading = false;
            console.log('调整积分响应:', response);
            if (response.code === 200) {
              this.$message.success("积分调整成功");
              this.adjustOpen = false; // 确保关闭弹窗
              this.getList(); // 刷新列表
              
              // 重置表单
              this.resetAdjustForm();
            } else {
              this.$message.error(response.msg || "积分调整失败");
            }
          }).catch(error => {
            this.adjustLoading = false;
            console.error('调整积分错误:', error);
            this.$message.error(error || "积分调整失败");
          });
        }
      });
    },
    handleDelete(row) {
      const ownerIds = row.ownerId || this.ids;
      this.$confirm('是否确认删除业主积分编号为"' + ownerIds + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(() => {
          return delPoints(ownerIds);
        }).then(response => {
          if (response.code === 200) {
            this.$message.success("删除成功");
            this.getList();
          } else {
            this.$message.error(response.msg || "删除失败");
          }
        }).catch(() => {});
    },
    formatTime(time) {
      if (!time) return '';
      try {
        const date = new Date(time);
        return date.toLocaleString('zh-CN', {
          year: 'numeric',
          month: '2-digit',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit',
          second: '2-digit',
          hour12: false
        }).replace(/\//g, '-');
      } catch (e) {
        return time;
      }
    },
    getTimelineType(adjustType) {
      switch(adjustType) {
        case 'ADD': return 'success';
        case 'SUBTRACT': return 'danger';
        case 'SET': return 'warning';
        default: return 'primary';
      }
    },
    getAdjustTypeText(adjustType) {
      const map = {
        'ADD': '增加积分',
        'SUBTRACT': '减少积分',
        'SET': '设置积分'
      };
      return map[adjustType] || adjustType;
    },
    getPointsType(points) {
      points = parseInt(points) || 0;
      if (points >= 100) return 'success';
      if (points >= 50) return 'warning';
      return 'info';
    }
  }
};
</script>

<style scoped>
.history-header {
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 1px solid #e4e7ed;
}

.history-header h3 {
  margin: 0 0 10px 0;
  color: #303133;
}

.history-header .current-points {
  font-size: 20px;
  font-weight: bold;
  color: #67C23A;
}

.history-container {
  max-height: 500px;
  overflow-y: auto;
  padding-right: 10px;
}

.history-card {
  margin-bottom: 10px;
}

.history-item {
  padding: 10px;
}

.history-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.history-type {
  font-size: 16px;
  font-weight: bold;
  color: #409EFF;
}

.history-operator {
  color: #909399;
  font-size: 13px;
}

.points-change {
  display: flex;
  flex-wrap: wrap;
  gap: 15px;
  margin-bottom: 15px;
}

.points-row {
  display: flex;
  align-items: center;
  margin-right: 20px;
}

.points-label {
  color: #606266;
  margin-right: 5px;
  font-weight: 500;
}

.old-points {
  font-size: 16px;
  font-weight: bold;
  color: #909399;
}

.new-points {
  font-size: 16px;
  font-weight: bold;
  color: #67C23A;
}

.adjust-points {
  font-size: 16px;
  font-weight: bold;
  padding: 2px 8px;
  border-radius: 4px;
  margin-left: 5px;
}

.adjust-points.add {
  color: #67C23A;
  background: #f0f9eb;
}

.adjust-points.subtract {
  color: #F56C6C;
  background: #fef0f0;
}

.reason {
  background: #f5f7fa;
  border-radius: 4px;
  padding: 10px;
  margin-top: 10px;
}

.reason-label {
  font-weight: bold;
  color: #606266;
  margin-bottom: 5px;
}

.reason-content {
  color: #606266;
  line-height: 1.5;
  word-break: break-all;
}

.empty-history {
  text-align: center;
  padding: 50px 0;
  color: #909399;
}

.empty-history i {
  font-size: 48px;
  margin-bottom: 16px;
}

.empty-history p {
  margin: 0;
  font-size: 14px;
}
</style>