<template>
  <div class="app-container">
    <!-- 搜索表单 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="投诉人" prop="userName">
        <el-input
          v-model="queryParams.userName"
          placeholder="请输入投诉人姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="联系方式" prop="contact">
        <el-input
          v-model="queryParams.contact"
          placeholder="请输入联系方式"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
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

    <!-- 工具栏 -->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

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
      <el-table-column label="反馈时间" align="center" prop="replyTime" width="150">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.replyTime) }}</span>
        </template>
      </el-table-column>

      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            v-if="!scope.row.replyContent"
            size="mini"
            type="text"
            icon="el-icon-reply"
            @click="handleReply(scope.row)"
          >回复</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 回复对话框 -->
    <el-dialog :title="'填写处理意见'" :visible.sync="openReplyDialog" width="780px" append-to-body>
      <el-form ref="replyForm" :model="form" label-width="80px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="反馈内容" prop="replyContent">
              <el-input type="textarea" v-model="form.replyContent" placeholder="请输入反馈内容" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitReply">确 定</el-button>
        <el-button @click="cancelReply">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {listFeedback, getFeedback, delFeedback, updateFeedback, listFeedbackByAdmin} from "@/api/system/feedback";

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
      listFeedbackByAdmin(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
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
    /** 删除反馈 */
    handleDelete(row) {
      const feedbackIds = row.id || this.ids;
      this.$modal.confirm(`是否确认删除编号为"${feedbackIds}"的数据项？`).then(() => {
        return delFeedback(feedbackIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {
      });
    },
    /** 回复按钮点击 */
    handleReply(row) {
      this.form.replyContent = '';
      this.currentFeedbackId = row.id;
      this.openReplyDialog = true;
    },
    /** 确认提交回复 */
    submitReply() {
      if (!this.form.replyContent) {
        this.$message.warning("请输入反馈内容！");
        return;
      }

      const data = {
        id: this.currentFeedbackId,
        replyContent: this.form.replyContent,
        replyUserName: this.$store.state.user.name
      };

      updateFeedback(data).then(() => {
        this.$modal.msgSuccess("反馈已回复");
        this.openReplyDialog = false;
        this.getList();
      });
    },
    /** 取消回复 */
    cancelReply() {
      this.openReplyDialog = false;
      this.form.replyContent = "";
      this.currentFeedbackId = null;
    }
  }
};
</script>
