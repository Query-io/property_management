<template>
  <div class="property-container">
    <!-- 查询表单 -->
    <el-row :gutter="20" class="mb20">
      <el-col :span="24">
        <el-form :model="queryParams" inline size="small">
          <el-form-item label="房产地址">
            <el-input v-model="queryParams.propertyAddress" placeholder="请输入房产地址" clearable />
          </el-form-item>
          <el-form-item label="所属区域">
            <el-input v-model="queryParams.region" placeholder="请输入区域" clearable />
          </el-form-item>
          <el-form-item label="房屋类型">
            <el-select v-model="queryParams.propertyType" placeholder="请选择类型" clearable>
              <el-option label="住宅" value="住宅"></el-option>
              <el-option label="商用" value="商用"></el-option>
              <el-option label="办公" value="办公"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="状态">
            <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
              <el-option label="空置" value="0"></el-option>
              <el-option label="出租" value="1"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>

    <!-- 操作按钮 -->
    <el-row :gutter="20" class="mb20">
      <el-col :span="12">
        <el-button type="danger" icon="el-icon-delete" :disabled="!multipleSelection.length" @click="() => handleDelete()">删除</el-button>
      </el-col>
    </el-row>

    <!-- 房产信息表格 -->
    <el-table
      :data="propertyList"
      v-loading="loading"
      @selection-change="handleSelectionChange"
      border
      style="width: 100%">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="propertyId" label="ID" width="60"></el-table-column>
      <el-table-column prop="propertyAddress" label="房产地址" min-width="150"></el-table-column>
      <el-table-column prop="region" label="所属区域" width="100"></el-table-column>
      <el-table-column prop="buildingNo" label="楼栋" width="80"></el-table-column>
      <el-table-column prop="unitNo" label="单元" width="80"></el-table-column>
      <el-table-column prop="floor" label="楼层" width="80"></el-table-column>
      <el-table-column prop="roomNo" label="房间号" width="80"></el-table-column>
      <el-table-column prop="buildingArea" label="建筑面积(㎡)" width="120"></el-table-column>
      <el-table-column prop="usableArea" label="使用面积(㎡)" width="120"></el-table-column>
      <!-- 图片列 -->
      <el-table-column label="图片" align="center" width="120">
        <template slot-scope="scope">
          <el-image
            style="width: 80px; height: 80px"
            :src="getFullImageUrl(scope.row.imageUrl)"
            :preview-src-list="[getFullImageUrl(scope.row.imageUrl)]"
            preview-teleported
            fit="cover"
          >
            <div slot="error" class="image-slot">
              <i class="el-icon-picture-outline"></i>
            </div>
          </el-image>
        </template>

      </el-table-column>
      <el-table-column prop="owner" label="业主" width="100"></el-table-column>
      <el-table-column prop="manager" label="负责人" width="100"></el-table-column>
      <el-table-column label="操作" width="180">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleEdit(scope.row)">修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
          >删除</el-button>

          <el-dropdown trigger="click">
      <span class="el-dropdown-link" style="margin-left: 10px; color: #409EFF; cursor: pointer;">
        更多<i class="el-icon-arrow-down el-icon--right"></i>
      </span>
            <el-dropdown-menu slot="dropdown" >
              <el-dropdown-item @click.native="handleUpload(scope.row)">上传图片</el-dropdown-item>
              <el-dropdown-item @click.native="handleRent(scope.row)">出租</el-dropdown-item>
              <!-- 可以预留更多操作项 -->
            </el-dropdown-menu>
          </el-dropdown>
        </template>
      </el-table-column>
    </el-table>
    <pagination
      v-if="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList">
    </pagination>

    <!-- 修改对话框 -->
    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="600px" append-to-body>
      <el-form ref="propertyForm" :model="form" label-width="100px">
        <el-form-item label="房产地址" prop="propertyAddress">
          <el-input v-model="form.propertyAddress" placeholder="请输入房产地址"></el-input>
        </el-form-item>
        <el-form-item label="所属区域" prop="region">
          <el-input v-model="form.region" placeholder="请输入所属区域"></el-input>
        </el-form-item>
        <el-form-item label="楼栋">
          <el-input v-model="form.buildingNo" placeholder="请输入楼栋"></el-input>
        </el-form-item>
        <el-form-item label="单元号">
          <el-input v-model="form.unitNo" placeholder="请输入单元号"></el-input>
        </el-form-item>
        <el-form-item label="楼层">
          <el-input type="number" v-model="form.floor" placeholder="请输入楼层"></el-input>
        </el-form-item>
        <el-form-item label="房间号">
          <el-input v-model="form.roomNo" placeholder="请输入房间号"></el-input>
        </el-form-item>
        <el-form-item label="建筑面积">
          <el-input v-model="form.buildingArea" placeholder="请输入建筑面积"></el-input>
        </el-form-item>
        <el-form-item label="使用面积">
          <el-input v-model="form.usableArea" placeholder="请输入使用面积"></el-input>
        </el-form-item>
        <el-form-item label="房屋类型">
          <el-select v-model="form.propertyType" placeholder="请选择房屋类型">
            <el-option label="住宅" value="住宅"></el-option>
            <el-option label="商用" value="商用"></el-option>
            <el-option label="办公" value="办公"></el-option>
          </el-select>
        </el-form-item>
<!--        <el-form-item label="状态">
          <el-select v-model="form.status" placeholder="请选择状态">
            <el-option label="空置" value="0"></el-option>
            <el-option label="占用" value="1"></el-option>
          </el-select>
        </el-form-item>-->
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确定</el-button>
        <el-button @click="dialogVisible = false">取消</el-button>
      </div>
    </el-dialog>

    <!-- 图片上传对话框 -->
    <el-dialog title="上传房产图片" :visible.sync="uploadDialogVisible" width="500px" append-to-body>
      <el-upload
        ref="upload"
        class="upload-demo"
        :action="uploadAction"
        :limit="1"
        :auto-upload="false"
        :file-list="fileList"
        :on-change="handleFileChange"
        :on-success="handleUploadSuccess"
        :on-remove="handleFileRemove">
        <el-button size="small" type="primary">选择图片</el-button>
        <div slot="tip" class="el-upload__tip">只能上传图片，且大小不超过500KB</div>
      </el-upload>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitUpload">上传</el-button>
        <el-button @click="uploadDialogVisible = false">取消</el-button>
      </div>
    </el-dialog>

    <!-- 业主绑定-->
    <el-dialog title="房屋出租" :visible.sync="rentDialogVisible" width="400px">
      <el-form :model="rentForm" label-width="80px">
        <el-form-item label="选择业主">
          <el-select v-model="rentForm.ownerId" filterable remote reserve-keyword placeholder="请输入关键词搜索业主"
                     :remote-method="searchOwners" :loading="ownerLoading">
            <el-option
              v-for="item in ownerOptions"
              :key="item.ownerId"
              :label="item.ownerName"
              :value="item.ownerId"
            />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="rentDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitRent">确定</el-button>
      </template>
    </el-dialog>
  </div>

</template>

<script>
import {
  listProperty,
  addProperty,
  updateProperty,
  deleteProperty,
  changePropertyStatus,
  uploadPropertyImage,
  bindOwner,
} from '@/api/system/property'
import {listOwner} from '@/api/system/owner'
export default {
  name: 'PropertyIndex',
  data() {
    return {
      loading: false,
      total: 0,
      propertyList: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        propertyAddress: '',
        region: '',
        propertyType: '',
        status: ''
      },
      dialogVisible: false,
      dialogTitle: '',
      form: {
        propertyId: null,
        propertyAddress: '',
        region: '',
        buildingNo: '',
        unitNo: '',
        floor: null,
        roomNo: '',
        buildingArea: null,
        usableArea: null,
        ownerId: null,
        owner: '',
        managerId: null,
        manager: '',
        propertyType: '',
        status: '0'
      },
      fileList: [],
      uploadDialogVisible: false,
      uploadAction: process.env.VUE_APP_BASE_API + '/system/property/uploadImage',
      currentPropertyId: null, // 用于图片上传绑定房产ID
      selectedProperties: [], // 表格选中数据
      rentDialogVisible: false,
      rentForm: {
        propertyId: null,
        ownerId: null,
      },
      ownerOptions: [],
      ownerLoading: false,

    }
  },
  computed: {
    singleSelection() {
      return this.selectedProperties.length === 1 ? this.selectedProperties[0] : null;
    },
    multipleSelection() {
      return this.selectedProperties;
    }
  },
  created() {
    this.getList();
  },
  methods: {
    // 打开出租弹窗
    handleRent(row) {
      this.rentForm.propertyId = row.propertyId;
      this.rentForm.ownerId = null;
      this.rentDialogVisible = true;
    },
    // 提交绑定
    submitRent() {
      const owner = this.ownerOptions.find(item => item.ownerId === this.rentForm.ownerId);
      if (!owner) {
        this.$message.warning('请选择有效的业主');
        return;
      }
      const payload = {
        propertyId: this.rentForm.propertyId,
        ownerId: owner.ownerId,
        owner: owner.ownerName,
      };
      bindOwner(payload).then(() => {
        this.$message.success('绑定成功');
        this.rentDialogVisible = false;
        this.getList();
      });
    },
    searchOwners(query) {
      if (query !== '') {
        this.ownerLoading = true;
        listOwner({ ownerName: query }).then(response => {
          this.ownerOptions = response.rows;
          this.ownerLoading = false;
        });
      } else {
        this.ownerOptions = [];
      }
    },
    getFullImageUrl(url) {
      if (!url) return ''; // 防止空值
      return process.env.VUE_APP_BASE_API + url;
    },
    getList() {
      this.loading = true;
      listProperty(this.queryParams).then(response => {
        this.propertyList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    resetQuery() {
      this.queryParams = {
        pageNum: 1,
        pageSize: 10,
        propertyAddress: '',
        region: '',
        propertyType: '',
        status: ''
      };
      this.getList();
    },
    handleSelectionChange(val) {
      this.selectedProperties = val;
    },
    handleEdit(row) {
      let data = row ? row : this.singleSelection;
      if (!data) {
        this.$message.warning('请选择一条数据进行修改');
        return;
      }
      this.dialogTitle = '修改房产信息';
      // 深拷贝防止直接修改列表数据
      this.form = Object.assign({}, data);
      this.dialogVisible = true;
    },
    submitForm() {
      this.$refs.propertyForm.validate(valid => {
        if (valid) {
          if (this.form.propertyId) {
            updateProperty(this.form).then(() => {
              this.$message.success('修改成功');
              this.dialogVisible = false;
              this.getList();
            });
          } else {
            this.$message.warning('请先选择需要修改的数据');
          }
        }
      });
    },
    handleDelete(row) {
      let ids = [];
      if (row) {
        ids.push(row.propertyId);
      } else if (this.selectedProperties.length) {
        ids = this.selectedProperties.map(item => item.propertyId);
      } else {
        this.$message.warning('请先选择需要删除的数据');
        return;
      }
      this.$confirm('是否确认删除选中的房产信息？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(() => {
        deleteProperty(ids).then(() => {
          this.$message.success('删除成功');
          this.getList();
        });
      });
    },
    handleStatusChange(row) {
      const newStatus = row.status
      this.$confirm(`确认将该房产状态修改为 ${newStatus === '0' ? '空置' : '占用'} 吗？`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(() => {
        changePropertyStatus(row.propertyId, newStatus).then(() => {
          this.$message.success('状态修改成功');
          row.status = newStatus;
        });
      }).catch(() => {
        // 取消时还原
        row.status = row.status === '0' ? '1' : '0';
      });
    },
    handleUpload(row) {
      let data = row ? row : this.singleSelection;
      if (!data) {
        this.$message.warning('请选择一条数据进行图片上传');
        return;
      }
      this.currentPropertyId = data.propertyId;
      this.uploadDialogVisible = true;
      // 清空之前的文件列表
      this.fileList = [];
    },
    handleFileChange(file, fileList) {
      this.fileList = fileList;
    },
    handleFileRemove(file, fileList) {
      this.fileList = fileList;
    },
    submitUpload() {
      if (this.fileList.length === 0) {
        this.$message.warning('请先选择图片');
        return;
      }
      const file = this.fileList[0].raw;
      // 调用上传接口，并传入 currentPropertyId 和选中的文件
      uploadPropertyImage(this.currentPropertyId, file)
        .then(response => {
          this.$message.success('上传成功');
          // 上传成功后刷新房产列表
          this.getList();
          // 关闭上传对话框并清空文件列表
          this.uploadDialogVisible = false;
          this.fileList = [];
        })
        .catch(error => {
          this.$message.error('上传失败，请联系管理员');
        });
    },
    handleUploadSuccess(response, file, fileList) {
      this.$message.success('上传成功');
      // 上传成功后，刷新列表更新图片地址显示
      this.getList();
      this.uploadDialogVisible = false;
      this.fileList = [];
    }
  }
};
</script>

<style scoped>
.property-container {
  padding: 20px;
}
.mb20 {
  margin-bottom: 20px;
}
</style>
