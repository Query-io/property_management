<template>
  <div class="app-container">
    <!-- 搜索栏 -->
    <el-card id="search">
      <el-row>
        <el-col :span="20">
          <el-form :inline="true" :model="searchModel" class="form-inline">
            <el-form-item label="停车场名称">
              <el-input
                v-model="searchModel.parkName"
                placeholder="请输入停车场名称"
                clearable
                size="mini"
              ></el-input>
            </el-form-item>
            <el-form-item label="停车场地址">
              <el-input
                v-model="searchModel.parkAddress"
                placeholder="请输入停车场地址"
                clearable
                size="mini"
              ></el-input>
            </el-form-item>

            <el-form-item>
              <el-button
                type="primary"
                @click="getParkInfoList"
                icon="el-icon-search"
                size="mini"
              >查询</el-button
              >
            </el-form-item>
            <el-form-item>
              <el-button
                type="primary"
                @click="openEdit(null)"
                icon="el-icon-plus"
                size="mini"
                plain
              >新增</el-button
              >
            </el-form-item>
          </el-form>
        </el-col>

        <el-col :span="4" align="right">
          <el-form>
            <el-form-item>
              <el-button
                @click="resetForm"
                icon="el-icon-refresh"
                size="mini"
                plain
              >重置</el-button>
            </el-form-item>
          </el-form>
        </el-col>
      </el-row>
    </el-card>

    <!-- 搜索结果 -->
    <el-card>
      <el-table
        v-loading="loading"
        :data="parkInfoList" stripe style="width: 100%">
        <el-table-column type="selection" width="50" align="center" />
        <el-table-column type="index" label="序号" align="center" />
        <el-table-column prop="parkName" label="停车场名称" align="center" />
        <el-table-column prop="parkAddress" label="停车场地址" align="center" />
        <el-table-column prop="parkPic" label="停车场图片" align="center">
          <template slot-scope="scope">
            <el-popover placement="top-start" title="" trigger="click">
              <img :src="getFullUrl(scope.row.parkPic)" alt="" style="width: 300px;height: 300px"/>
              <img slot="reference" :src="getFullUrl(scope.row.parkPic)" style="width: 40px;height: 40px" />
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column prop="parkRule" label="收费标准(每小时/元)" align="center" />
        <el-table-column prop="parkAmount" label="车位数量" align="center" />
        <el-table-column prop="parkSpare" label="剩余车位数" align="center" />

        <el-table-column label="操作" align="center">
          <template slot-scope="scope">
            <el-tooltip class="item" effect="dark" content="修改" placement="top">
              <el-button
                @click="openEdit(scope.row.parkId)"
                type="primary"
                icon="el-icon-edit"
                size="mini"
                circle
              ></el-button>
            </el-tooltip>
            <el-tooltip class="item" effect="dark" content="删除" placement="top">
              <el-button
                @click="deleteParkInfoById(scope.row)"
                type="danger"
                icon="el-icon-delete"
                size="mini"
                circle
              ></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页组件 -->
      <pagination
        v-if="total > 0"
        :total="total"
        :page.sync="searchModel.pageNum"
        :limit.sync="searchModel.pageSize"
        @pagination="getParkInfoList"
      ></pagination>
    </el-card>

    <!-- 角色信息编辑对话框 -->
    <el-dialog
      :title="title"
      :visible.sync="dialogFormVisible"
      top="3%"
    >
      <el-form :model="parkInfoForm" :rules="rules" ref="parkInfoFormRef">
        <el-form-item prop="parkName" label="停车场名称" :label-width="formLabelWidth">
          <el-input
            v-model="parkInfoForm.parkName"
            autocomplete="off"
            clearable
          ></el-input>
        </el-form-item>

        <el-form-item prop="parkAddress" label="停车场地址" :label-width="formLabelWidth">
          <el-input
            v-model="parkInfoForm.parkAddress"
            autocomplete="off"
            clearable
          ></el-input>
        </el-form-item>

        <el-form-item prop="parkRule" label="收费规则" :label-width="formLabelWidth">
          <el-input
            v-model.number="parkInfoForm.parkRule"
            autocomplete="off"
            clearable
          ></el-input>
        </el-form-item>

        <el-form-item prop="parkAmount" label="车位数" :label-width="formLabelWidth">
          <el-input
            v-model.number="parkInfoForm.parkAmount"
            autocomplete="off"
            clearable
          ></el-input>
        </el-form-item>

        <el-form-item prop="parkSpare" label="剩余车位数" :label-width="formLabelWidth">
          <el-input
            v-model.number="parkInfoForm.parkSpare"
            autocomplete="off"
            clearable
          ></el-input>
        </el-form-item>

        <el-form-item prop="parkPic" label="停车场图片" :label-width="formLabelWidth">
          <el-upload
            ref="upload"
            :limit="1"
            :on-success="handleUploadSuccess"
            :before-upload="beforeUpload"
            :http-request="customUpload"
          >
            <el-button size="small" type="primary">点击上传</el-button>
            <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过2M</div>
          </el-upload>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveParkInfo">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import {
  listParkInfo,
  getParkInfo,
  addParkInfo,
  updateParkInfo,
  delParkInfo,
  delParkInfos
} from "@/api/system/parkInfo";
import {upload} from "@/api/system/common";

export default {
  data() {
    return {
      loading: false,
      uploadAction: process.env.VUE_APP_BASE_API + '/system/common/upload',
      formLabelWidth: "130px",
      parkInfoForm: {},
      dialogFormVisible: false,
      title: "",
      total: 0,
      searchModel: {
        pageNum: 1,
        pageSize: 10,
        parkName: "",
        parkAddress: "",
        parkRule: "",
        parkAmount: "",
      },
      parkInfoList: [],
      rules: {
        parkName: [
          { required: true, message: "请输入停车场名称", trigger: "blur" },
        ],
        parkAddress: [
          { required: true, message: "请输入停车场地址", trigger: "blur" },
        ],
        parkRule: [
          { required: true, message: "请输入收费规则", trigger: "blur" },
        ],
        parkAmount: [
          { required: true, message: "请输入车位数量", trigger: "blur" },
        ],
        parkSpare: [
          { required: true, message: "请输入剩余车位数", trigger: "blur" },
        ],
      },
    };
  },
  methods: {
    getFullUrl(url) {
      if (!url) return ''; // 防止空值
      return process.env.VUE_APP_BASE_API + url;
    },
    // 限制图片上传大小和类型
    beforeUpload(file) {
      const isJPG = file.type === 'image/jpeg' || file.type === 'image/png';
      const isLt2M = file.size / 1024 / 1024 < 2;
      if (!isJPG) {
        this.$message.error('上传图片只能是 JPG 或 PNG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    },

    // 图片上传成功，获取返回的 URL
    handleUploadSuccess(res) {
      this.parkInfoForm.parkPic = res.fileName;
    },
    //图片上传
    customUpload({ file }) {
        upload(file).then(res => {
          this.$message.success('上传成功')
          this.parkInfoForm.parkPic = res.fileName // 后台返回格式里含 url 字段
        })
        .catch(() => {
          this.$message.error('上传失败')
        })
    },
    // 获取停车场列表
    getParkInfoList() {
      this.loading = true;
      listParkInfo(this.searchModel).then((res) => {
        this.parkInfoList = res.rows;
        console.log(JSON.stringify(this.parkInfoList))
        this.total = res.total;
        this.loading = false;
      });
    },

    // 新增或修改停车场信息
    saveParkInfo() {
      this.$refs.parkInfoFormRef.validate((valid) => {
        if (valid) {
          const saveMethod = this.parkInfoForm.parkId
            ? updateParkInfo
            : addParkInfo;

          saveMethod(this.parkInfoForm).then((res) => {
            this.$message({
              message: res.message,
              type: "success",
            });
            this.dialogFormVisible = false;
            this.getParkInfoList();
          });
        }
      });
    },

    // 打开编辑对话框
    openEdit(parkId) {
      if (parkId) {
        this.title = "修改停车场信息";
        getParkInfo(parkId).then((res) => {
          this.parkInfoForm = res.data;
        });
      } else {
        this.title = "新增停车场信息";
        this.parkInfoForm = {};
      }
      this.dialogFormVisible = true;
    },

    // 删除停车场
    deleteParkInfoById(park) {
      this.$confirm("确认删除该停车场吗?", "提示", {
        confirmButtonText: "删除",
        cancelButtonText: "取消",
        type: "warning",
      }).then(() => {
        delParkInfo(park.parkId).then((res) => {
          this.$message({
            message: res.message,
            type: "success",
          });
          this.getParkInfoList();
        });
      });
    },

    // 重置表单
    resetForm() {
      this.searchModel = {
        pageNum: 1,
        pageSize: 10,
        parkName: "",
        parkAddress: "",
        parkRule: "",
        parkAmount: "",
      };
      this.getParkInfoList();
    },

    // 分页切换
    pagination(val) {
      this.searchModel.pageNum = val.pageNum;
      this.searchModel.pageSize = val.pageSize;
      this.getParkInfoList();
    }
  },

  mounted() {
    this.getParkInfoList();
  },
};
</script>
