<template>
  <div class="order-form-container">
    <!-- 1. 费用提示 -->
    <el-alert
      title="提示：水费按 1 吨 5 元；电费按 1 度 0.9 元；维修费按实际项目计费"
      type="info"
      show-icon
      class="mb16"
    />

    <el-card class="mb16">
      <el-form :model="form" ref="formRef" label-width="100px" :rules="rules">
        <!-- 2. 订单类型 -->
        <el-form-item label="订单类型" prop="orderType">
          <el-select v-model="form.orderType" placeholder="请选择订单类型">
            <el-option
              v-for="opt in filteredOrderTypes"
              :key="opt.value"
              :label="opt.label"
              :value="opt.value"
            />
          </el-select>
        </el-form-item>

        <el-form-item v-if="form.orderType !== '维修'" label="房产" prop="propertyId" :rules="[{ required: true, message: '请选择房产', trigger: 'change' }]">
          <el-select v-model="form.propertyId" placeholder="请选择收租的房产">
            <el-option
              v-for="prop in propertyOptions"
              :key="prop.propertyId"
              :label="prop.propertyAddress"
              :value="prop.propertyId"
            />
          </el-select>
        </el-form-item>

        <el-form-item v-if="form.orderType === '维修'" label="维修单" prop="associationId" :rules="[{ required: true, message: '请选择维修单', trigger: 'change' }]">
          <el-select v-model="form.associationId" placeholder="请选择维修单">
            <el-option
              v-for="prop in repairOptions"
              :key="prop.id"
              :label="prop.repairItem"
              :value="prop.id"
            />
          </el-select>
        </el-form-item>
        <!-- 3. 明细卡片 -->
        <div v-for="(item, idx) in form.items" :key="idx" class="detail-card">
          <el-card shadow="hover" class="mb12">
            <div slot="header" class="clearfix">
              <span>明细 {{ idx + 1 }}</span>
              <el-button
                v-if="form.items.length > 1"
                type="text"
                icon="el-icon-delete"
                @click="removeItem(idx)"
                class="remove-btn"
              />
            </div>

            <el-form-item :prop="'items.' + idx + '.itemName'" label-width="80px" :rules="[{ required: true, message: '请输入明细名称', trigger: 'blur' }]">
              <el-input v-model="item.itemName" placeholder="明细名称" />
            </el-form-item>

            <template v-if="form.orderType === '维修'">
              <el-form-item :prop="'items.' + idx + '.quantity'" label="数量" :rules="[{ required: true, message: '请输入数量', trigger: 'blur' }]">
                <el-input-number v-model="item.quantity" :min="1" @change="recalcItemAmount(idx)" />
              </el-form-item>
              <el-form-item :prop="'items.' + idx + '.unitPrice'" label="单价" :rules="[{ required: true, message: '请输入单价', trigger: 'blur' }]">
                <el-input-number v-model="item.unitPrice" :min="0" :step="0.01" @change="recalcItemAmount(idx)" />
              </el-form-item>
              <el-form-item label="金额">
                <el-input v-model="item.amount" :disabled="true" />
              </el-form-item>
            </template>

            <template v-else>
              <el-form-item :prop="'items.' + idx + '.amount'" label="金额" :rules="[{ required: true, message: '请输入金额', trigger: 'blur' }]">
                <el-input-number v-model="item.amount" :min="0" :step="0.01" />
              </el-form-item>
            </template>

            <el-form-item :prop="'items.' + idx + '.description'" label="描述">
              <el-input type="textarea" v-model="item.description" placeholder="可选填写" :rows="2" />
            </el-form-item>
          </el-card>
        </div>

        <!-- 添加明细 -->
        <el-form-item>
          <el-button type="primary" icon="el-icon-plus" @click="addItem">添加明细</el-button>
        </el-form-item>

        <!-- 4. 订单总金额 -->
        <el-form-item label="订单总额">
          <el-input v-model="totalAmount" disabled />
        </el-form-item>

        <!-- 5. 操作按钮 -->
        <el-form-item>
          <el-button type="primary" @click="submitForm">提交订单</el-button>
          <el-button @click="resetForm">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { generatedSysOrder } from '@/api/system/order'
import { rentedList } from '@/api/system/property'
import { listDealRepair } from '@/api/system/repair'
export default {
  name: 'OrderCreate',
  dicts: ['sys_order_type'],
  data() {
    return {
      propertyOptions: [],
      repairOptions:[],
      form: {
        orderType: '',
        remark: '',
        items: [
          { itemName: '', quantity: 1, unitPrice: 0.00, amount: 0.00, description: '' }
        ]
      },
      rules: {
        orderType: [{ required: true, message: '请选择订单类型', trigger: 'change' }],
      }
    }
  },
  mounted() {
    rentedList().then(res => {
      this.propertyOptions = res.data || []
    })
    listDealRepair().then(res => {
      this.repairOptions = res.data || []
    })
  },
  computed: {
    filteredOrderTypes() {
      return this.dict.type.sys_order_type.filter(opt => opt.value !== '停车费')
    },
    // 动态计算总金额
    totalAmount() {
      return this.form.items.reduce((sum, it) => sum + Number(it.amount || 0), 0).toFixed(2)
    }
  },
  methods: {
    // 新增一条明细
    addItem() {
      this.form.items.push({ itemName: '', quantity: 1, unitPrice: 0.00, amount: 0.00, description: '' })
    },
    // 删除明细
    removeItem(idx) {
      this.form.items.splice(idx, 1)
    },
    // 当维修类型时，数量或单价变动，重新计算该明细金额
    recalcItemAmount(idx) {
      const it = this.form.items[idx]
      it.amount = (it.quantity * it.unitPrice).toFixed(2)
    },
    // 重置整个表单
    resetForm() {
      this.$refs.formRef.resetFields()
      this.form.items = [{ itemName: '', quantity: 1, unitPrice: 0.00, amount: 0.00, description: '' }]
      this.form.orderType = ''
      this.form.propertyId = null
      this.form.associationId = null
    },
    // 提交
    submitForm() {
      this.$refs.formRef.validate(valid => {
        if (!valid) return
        // 组织 payload
        const payload = {
          orderType: this.form.orderType,
          totalAmount: this.totalAmount,
          remark: this.form.remark,
          items: this.form.items,
          propertyId: this.form.propertyId,
          associationId: this.form.associationId,
        }
        generatedSysOrder(payload).then(() => {
          this.$message.success('订单已生成')
          this.resetForm() // 清空表单
        })
      })
    },
  }
}
</script>

<style scoped>
.order-form-container {
  padding: 20px;
}
.detail-card {
  position: relative;
}
.remove-btn {
  position: absolute;
  right: 0;
  top: 0;
}
.mb12 {
  margin-bottom: 12px;
}
.mb16 {
  margin-bottom: 16px;
}
</style>
