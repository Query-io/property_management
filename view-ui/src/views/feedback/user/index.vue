<template>
  <div class="app-container">
    <!-- 搜索表单 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="投诉时间" prop="createTime">
        <el-date-picker
          v-model="dateRange"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>


    <!-- 用户反馈表格 -->
    <el-table v-loading="loading" :data="feedbackList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="编号" align="center" prop="id" width="100" />
      <el-table-column label="投诉人" align="center" prop="userName" width="120" />
      <el-table-column label="联系方式" align="center" prop="contact" width="150" />
      <el-table-column label="投诉内容" align="center" prop="content" width="200">
        <template slot-scope="scope">
          <el-tooltip class="item" effect="dark" :content="scope.row.content" placement="top">
            <span>{{ scope.row.content.length > 12 ? scope.row.content.slice(0, 12) + '...' : scope.row.content }}</span>
          </el-tooltip>
        </template>
      </el-table-column>
      <el-table-column label="投诉时间" align="center" prop="createTime" width="150">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="处理人" align="center" prop="replyUserName" width="120" />
      <el-table-column label="反馈内容" align="center" prop="replyContent" width="200">
        <template slot-scope="scope">
          <el-tooltip class="item" effect="dark" :content="scope.row.replyContent" placement="top">
            <span>{{ scope.row.replyContent && scope.row.replyContent.length > 12 ? scope.row.replyContent.slice(0, 12) + '...' : scope.row.replyContent }}</span>
          </el-tooltip>
        </template>
      </el-table-column>
    </el-table>
    <el-table-column label="反馈时间" align="center" prop="replyTime" width="150">
      <template slot-scope="scope">
        <span>{{ parseTime(scope.row.replyTime) }}</span>
      </template>
    </el-table-column>
    <!-- 分页 -->
    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script>
import {listFeedbackByUser} from "@/api/system/feedback";

export default {
  name: "UserFeedback",
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      feedbackList: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userName: undefined,
        contact: undefined,
        status: undefined,
        createTime: undefined,
      },
      dateRange: [],
      form: {
        replyContent: ''
      },
      openReplyDialog: false,
      currentFeedbackId: null
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询列表 */
    getList() {
      this.loading = true;
      listFeedbackByUser(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.feedbackList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 搜索 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置搜索 */
    resetQuery() {
      this.resetForm("queryForm");
      this.dateRange = [];
      this.handleQuery();
    },
    /** 选中项变化 */
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },
  }
};
</script>
