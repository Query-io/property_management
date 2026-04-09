<template>
  <div class="app-container">
    <!-- 搜索栏 -->
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="100px">
      <el-form-item label="车牌号码" prop="plateNum">
        <el-input
          v-model="queryParams.plateNum"
          placeholder="请输入车牌号码"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="违规类型" prop="violationType">
        <el-select v-model="queryParams.violationType" placeholder="请选择违规类型" clearable size="small">
          <el-option
            v-for="dict in violationTypeOptions"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="处理状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择处理状态" clearable size="small">
          <el-option
            v-for="dict in statusOptions"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="违规时间">
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
        <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="small" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 操作按钮 -->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="small"
          @click="handleAdd"
          v-hasPermi="['system:violation:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="small"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:violation:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="small"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:violation:remove']"
        >删除</el-button>
      </el-col>
      <!-- <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="small"
          @click="handleExport"
          v-hasPermi="['system:violation:export']"
        >导出</el-button>
      </el-col> -->
      <el-col :span="1.5">
        <el-button
          type="info"
          plain
          icon="el-icon-s-data"
          size="small"
          @click="handleStatistics"
        >统计</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 数据表格 -->
    <el-table v-loading="loading" :data="violationList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="违规编号" align="center" prop="violationId" width="100" />
      <el-table-column label="车牌号码" align="center" prop="plateNum" width="120" />
      <el-table-column label="违规类型" align="center" prop="violationType" width="120">
        <template slot-scope="scope">
          <dict-tag :options="violationTypeOptions" :value="scope.row.violationType"/>
        </template>
      </el-table-column>
      <el-table-column label="违规时间" align="center" prop="violationTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.violationTime, '{y}-{m}-{d} {h}:{i}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="违规地点" align="center" prop="location" />
      <el-table-column label="罚款金额" align="center" prop="penaltyAmount" width="100">
        <template slot-scope="scope">
          <span>¥{{ scope.row.penaltyAmount }}</span>
        </template>
      </el-table-column>
      <el-table-column label="处理状态" align="center" prop="status" width="100">
        <template slot-scope="scope">
          <dict-tag :options="statusOptions" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="处理人员" align="center" prop="processorName" width="100" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="250">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleView(scope.row)"
            v-hasPermi="['system:violation:query']"
          >查看</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:violation:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-check"
            @click="handleProcess(scope.row)"
            v-hasPermi="['system:violation:process']"
            v-if="scope.row.status == 0"
          >处理</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-close"
            @click="handleCancel(scope.row)"
            v-hasPermi="['system:violation:cancel']"
            v-if="scope.row.status != 2"
          >撤销</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页组件 -->
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="车牌号码" prop="plateNum">
          <el-input v-model="form.plateNum" placeholder="请输入车牌号码" />
        </el-form-item>
        <el-form-item label="违规类型" prop="violationType">
          <el-select v-model="form.violationType" placeholder="请选择违规类型">
            <el-option
              v-for="dict in violationTypeOptions"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="违规时间" prop="violationTime">
          <el-date-picker
            v-model="form.violationTime"
            type="datetime"
            placeholder="选择违规时间"
            value-format="yyyy-MM-dd HH:mm:ss"
          />
        </el-form-item>
        <el-form-item label="违规地点" prop="location">
          <el-input v-model="form.location" placeholder="请输入违规地点" />
        </el-form-item>
        <el-form-item label="违规描述" prop="description">
          <el-input
            v-model="form.description"
            type="textarea"
            placeholder="请输入违规描述"
            :rows="3"
          />
        </el-form-item>
        <el-form-item label="证据图片">
          <imageUpload v-model="form.evidenceImg"/>
        </el-form-item>
        <el-form-item label="罚款金额" prop="penaltyAmount">
          <el-input-number
            v-model="form.penaltyAmount"
            :min="0"
            :step="10"
            placeholder="请输入罚款金额"
          />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 查看详情对话框 -->
    <el-dialog title="违规信息详情" :visible.sync="viewOpen" width="700px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="违规编号">{{ form.violationId }}</el-descriptions-item>
        <el-descriptions-item label="车牌号码">{{ form.plateNum }}</el-descriptions-item>
        <el-descriptions-item label="违规类型">
          <dict-tag :options="violationTypeOptions" :value="form.violationType"/>
        </el-descriptions-item>
        <el-descriptions-item label="违规时间">
          {{ parseTime(form.violationTime, '{y}-{m}-{d} {h}:{i}:{s}') }}
        </el-descriptions-item>
        <el-descriptions-item label="违规地点">{{ form.location }}</el-descriptions-item>
        <el-descriptions-item label="罚款金额">¥{{ form.penaltyAmount }}</el-descriptions-item>
        <el-descriptions-item label="处理状态">
          <dict-tag :options="statusOptions" :value="form.status"/>
        </el-descriptions-item>
        <el-descriptions-item label="处理人员">{{ form.processorName }}</el-descriptions-item>
        <el-descriptions-item label="处罚日期">
          {{ parseTime(form.penaltyDate, '{y}-{m}-{d} {h}:{i}:{s}') }}
        </el-descriptions-item>
        <el-descriptions-item label="违规描述" :span="2">{{ form.description }}</el-descriptions-item>
        <el-descriptions-item label="证据图片" :span="2">
          <imagePreview :src="form.evidenceImg" v-if="form.evidenceImg"/>
          <span v-else>无</span>
        </el-descriptions-item>
        <el-descriptions-item label="创建时间">
          {{ parseTime(form.createTime, '{y}-{m}-{d} {h}:{i}:{s}') }}
        </el-descriptions-item>
        <el-descriptions-item label="更新时间">
          {{ parseTime(form.updateTime, '{y}-{m}-{d} {h}:{i}:{s}') }}
        </el-descriptions-item>
        <el-descriptions-item label="备注" :span="2">{{ form.remark }}</el-descriptions-item>
      </el-descriptions>
      <div slot="footer" class="dialog-footer">
        <el-button @click="viewOpen = false">关 闭</el-button>
      </div>
    </el-dialog>

    <!-- 统计对话框 -->
    <el-dialog title="违规统计信息" :visible.sync="statisticsOpen" width="800px" append-to-body>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-card shadow="hover">
            <div slot="header">违规类型统计</div>
            <div id="typeChart" style="height: 300px;"></div>
          </el-card>
        </el-col>
        <el-col :span="12">
          <el-card shadow="hover">
            <div slot="header">处理状态统计</div>
            <div id="statusChart" style="height: 300px;"></div>
          </el-card>
        </el-col>
      </el-row>
    </el-dialog>
  </div>
</template>

<script>
import { listViolation, getViolation, delViolation, addViolation, updateViolation, processViolation, cancelViolation, exportViolation, getStatistics } from "@/api/system/violation";
import * as echarts from 'echarts';

export default {
  name: "Violation",
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
      // 违规信息表格数据
      violationList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 是否显示查看弹出层
      viewOpen: false,
      // 是否显示统计弹出层
      statisticsOpen: false,
      // 日期范围
      dateRange: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        plateNum: undefined,
        violationType: undefined,
        status: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        plateNum: [
          { required: true, message: "车牌号码不能为空", trigger: "blur" }
        ],
        violationType: [
          { required: true, message: "违规类型不能为空", trigger: "change" }
        ],
        violationTime: [
          { required: true, message: "违规时间不能为空", trigger: "change" }
        ],
        penaltyAmount: [
          { required: true, message: "罚款金额不能为空", trigger: "blur" }
        ]
      },
      // 违规类型字典
      violationTypeOptions: [
        { value: 'PARKING_ILLEGAL', label: '违章停车' },
        { value: 'SPEEDING', label: '超速行驶' },
        { value: 'HANDICAP_PARKING', label: '占用残疾人车位' },
        { value: 'BLOCKING_FIRE_LANE', label: '堵塞消防通道' },
        { value: 'UNAUTHORIZED_PARKING', label: '未授权停车' }
      ],
      // 处理状态字典
      statusOptions: [
        { value: 0, label: '未处理' },
        { value: 1, label: '已处理' },
        { value: 2, label: '已撤销' }
      ],
      // ECharts实例
      typeChart: null,
      statusChart: null
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询违规信息记录列表 */
    getList() {
      this.loading = true;
      listViolation(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.violationList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 处理查询 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置查询 */
    resetQuery() {
      this.dateRange = [];
      this.resetForm("queryForm");
      this.handleQuery();
    },
    /** 选择项变化 */
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.violationId);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加违规信息记录";
    },
    /** 查看按钮操作 */
    handleView(row) {
      this.reset();
      const violationId = row.violationId || this.ids[0];
      getViolation(violationId).then(response => {
        this.form = response.data;
        this.viewOpen = true;
      });
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const violationId = row.violationId || this.ids[0];
      getViolation(violationId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改违规信息记录";
      });
    },
    /** 处理按钮操作 */
    handleProcess(row) {
      const violationId = row.violationId || this.ids[0];
      this.$modal.confirm('确认要处理该违规记录吗？').then(() => {
        return processViolation(violationId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("处理成功");
      }).catch(() => {});
    },
    /** 撤销按钮操作 */
    handleCancel(row) {
      const violationId = row.violationId || this.ids[0];
      this.$modal.confirm('确认要撤销该违规记录吗？').then(() => {
        return cancelViolation(violationId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("撤销成功");
      }).catch(() => {});
    },
    /** 提交表单 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.violationId !== undefined) {
            updateViolation(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addViolation(this.form).then(response => {
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
      const violationIds = row.violationId || this.ids;
      this.$modal.confirm('是否确认删除违规信息记录编号为"' + violationIds + '"的数据项？').then(() => {
        return delViolation(violationIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$modal.confirm('是否确认导出所有违规信息记录数据项？').then(() => {
        this.exportLoading = true;
        return exportViolation(queryParams);
      }).then(response => {
        this.$download.name(response.msg);
        this.exportLoading = false;
      }).catch(() => {});
    },
    /** 统计按钮操作 */
    handleStatistics() {
      this.statisticsOpen = true;
      this.$nextTick(() => {
        this.loadStatistics();
      });
    },
    /** 加载统计数据 */
    loadStatistics() {
      getStatistics().then(response => {
        const data = response.data;
        const typeData = data.find(item => item.type === 'violationTypeStats')?.data || [];
        const statusData = data.find(item => item.type === 'statusStats')?.data || {};
        
        // 渲染违规类型统计图
        if (this.typeChart) {
          echarts.dispose(this.typeChart);
        }
        this.typeChart = echarts.init(document.getElementById('typeChart'));
        const typeOption = {
          tooltip: {
            trigger: 'item'
          },
          legend: {
            top: '5%',
            left: 'center'
          },
          series: [
            {
              name: '违规类型',
              type: 'pie',
              radius: ['40%', '70%'],
              avoidLabelOverlap: false,
              itemStyle: {
                borderRadius: 10,
                borderColor: '#fff',
                borderWidth: 2
              },
              label: {
                show: false,
                position: 'center'
              },
              emphasis: {
                label: {
                  show: true,
                  fontSize: '16',
                  fontWeight: 'bold'
                }
              },
              labelLine: {
                show: false
              },
              data: typeData
            }
          ]
        };
        this.typeChart.setOption(typeOption);
        
        // 渲染处理状态统计图
        if (this.statusChart) {
          echarts.dispose(this.statusChart);
        }
        this.statusChart = echarts.init(document.getElementById('statusChart'));
        const statusOption = {
          tooltip: {
            trigger: 'item'
          },
          legend: {
            top: '5%',
            left: 'center'
          },
          series: [
            {
              name: '处理状态',
              type: 'pie',
              radius: ['40%', '70%'],
              avoidLabelOverlap: false,
              itemStyle: {
                borderRadius: 10,
                borderColor: '#fff',
                borderWidth: 2
              },
              label: {
                show: false,
                position: 'center'
              },
              emphasis: {
                label: {
                  show: true,
                  fontSize: '16',
                  fontWeight: 'bold'
                }
              },
              labelLine: {
                show: false
              },
              data: [
                { value: statusData.pending || 0, name: '未处理' },
                { value: statusData.processed || 0, name: '已处理' },
                { value: statusData.cancelled || 0, name: '已撤销' }
              ]
            }
          ]
        };
        this.statusChart.setOption(statusOption);
        
        // 响应窗口变化
        window.addEventListener('resize', () => {
          this.typeChart?.resize();
          this.statusChart?.resize();
        });
      });
    },
    /** 取消按钮 */
    cancel() {
      this.open = false;
      this.viewOpen = false;
      this.reset();
    },
    /** 表单重置 */
    reset() {
      this.form = {
        violationId: undefined,
        plateNum: undefined,
        violationType: undefined,
        violationTime: undefined,
        location: undefined,
        description: undefined,
        evidenceImg: undefined,
        status: 0,
        penaltyAmount: 0,
        penaltyDate: undefined,
        processorId: undefined,
        remark: undefined
      };
      this.resetForm("form");
    }
  }
};
</script>