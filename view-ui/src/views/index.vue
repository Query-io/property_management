<template>
  <div class="app-container home">
    <el-row :gutter="20">
      <el-col :sm="24" :lg="12" style="padding-left: 20px">
        <h2>现代化物业管理系统</h2>
        <p>
          本系统是一款基于SpringBoot与Vue开发的现代化物业管理平台，适用于各类住宅小区、商业写字楼、园区管理等场景。
          提供业主管理、报修服务、缴费通知、公告发布等一站式服务， 前后端分离架构。
        </p>
      </el-col>

      <el-col :sm="24" :lg="12" style="padding-left: 50px">
      </el-col>
    </el-row>

    <el-divider />

    <!-- 系统公告区域 -->
    <el-row>
      <el-col :span="24">
        <el-card>
          <div slot="header" class="clearfix">
            <span>通知公告</span>
          </div>
          <div class="body">
            <div v-if="noticeList.length > 0">
              <el-timeline>
                <el-timeline-item
                  v-for="item in noticeList"
                  :key="item.noticeId"
                  :timestamp="item.noticeType === '1' ? '通知' : '公告'"
                  placement="top"
                >
                  <h4>{{ item.noticeTitle }}</h4>
                  <p v-html="item.noticeContent"></p>
                </el-timeline-item>
              </el-timeline>
            </div>
            <p v-else>暂无公告。</p>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 招商信息区域（不可点击，仅展示） -->
    <el-row style="margin-top: 20px;">
      <el-col :span="24">
        <el-card>
          <div slot="header" class="clearfix">
            <span>招商信息</span>
          </div>
          <div class="body">
            <div v-if="investmentList.length > 0">
              <div v-for="item in investmentList" :key="item.id" class="investment-item">
                <div class="investment-title">{{ item.title || '无标题' }}</div>
                <div class="investment-detail">
                  <span class="investment-status" :class="'status-' + item.status">{{ formatStatus(item.status) }}</span>
                  <span class="investment-contact">{{ item.contactPerson || '无' }}</span>
                  <span class="investment-phone">{{ item.contactPhone || '无' }}</span>
                </div>
                <div class="investment-time">{{ parseTime(item.publishTime || item.createTime, '{y}-{m}-{d}') }}</div>
              </div>
            </div>
            <p v-else>暂无招商信息。</p>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-divider />

    <!-- 隐藏的音频元素，用于播放提示音 -->
    <audio ref="notificationAudio" preload="auto" style="display: none;">
      <source :src="audioSrc" type="audio/mpeg">
      您的浏览器不支持音频播放。
    </audio>

    <!-- 待缴费账单提醒弹窗 -->
    <el-dialog
      title="缴费提醒"
      :visible.sync="showUnpaidDialog"
      width="400px"
      :show-close="false"
      :close-on-click-modal="false"
      :close-on-press-escape="false"
      custom-class="unpaid-notice-dialog"
      :modal="false"
      :style="dialogStyle"
      @open="playNotificationSound"  
    >
      <div style="text-align: center;">
        <el-alert
          :title="`您有 ${unpaidCount} 笔待缴费账单`"
          type="warning"
          :closable="false"
          style="margin-bottom: 15px;"
        >
        </el-alert>
        <div v-if="unpaidList.length > 0">
          <p style="color: #606266; margin-bottom: 10px;">待缴费订单：</p>
          <div v-for="order in unpaidList" :key="order.id" style="margin-bottom: 8px; padding: 8px; background: #f8f9fa; border-radius: 4px;">
            <p style="margin: 3px 0; font-size: 13px;">
              <span style="color: #909399;">{{ order.orderNo }} - </span>
              <span style="color: #f56c6c;">¥{{ order.totalAmount }}</span>
              <span style="color: #909399; font-size: 12px; margin-left: 10px;">{{ formatOrderType(order.orderType) }}</span>
            </p>
            <p style="margin: 3px 0; font-size: 12px; color: #909399;">
              提交时间: {{ parseTime(order.createTime, '{y}-{m}-{d}') }}
            </p>
          </div>
        </div>
        
        <el-button
          type="primary"
          size="small"
          @click="goToPayment"
          style="margin-top: 15px;"
        >
          立即缴费
        </el-button>
        <el-button
          size="small"
          @click="closeDialog"
          style="margin-top: 15px; margin-left: 10px;"
        >
          稍后提醒
        </el-button>
        
        <div style="margin-top: 15px;">
          <el-checkbox v-model="hideForToday" @change="handleHideChange">
            今天不再提醒
          </el-checkbox>
        </div>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import { listNormalNotice } from '@/api/system/notice'
import { listOrderByUser } from '@/api/system/order'
import { listInfo } from '@/api/investment/info'
import { parseTime } from '@/utils/ruoyi'

export default {
  name: "Index",
  data() {
    return {
      version: "3.8.9",
      noticeList: [],
      investmentList: [],
      
      showUnpaidDialog: false,
      unpaidList: [],
      unpaidCount: 0,
      hideForToday: false,
      checkedForUnpaid: false,
      
      dialogStyle: {
        position: 'fixed',
        right: '20px',
        bottom: '20px',
        margin: '0',
        zIndex: '9999'
      },
      
      audioSrc: '/audio/notification.mp3'
    };
  },
  created() {
    this.getNoticeList()
    this.getInvestmentList()
    setTimeout(() => {
      this.checkUnpaidOrders()
    }, 1000)
  },
  methods: {
    parseTime,
    
    goTarget(href) {
      window.open(href, "_blank");
    },
    
    formatOrderType(orderType) {
      const dict = this.$store.getters.dictData?.sys_order_type || []
      const item = dict.find(item => item.value === orderType)
      return item ? item.label : orderType
    },
    
    // 格式化招商状态
    formatStatus(status) {
      const statusMap = {
        0: '待招商',
        1: '已签约',
        2: '已关闭'
      }
      return statusMap[status] || '未知'
    },
    
    async getNoticeList() {
      try {
        const res = await listNormalNotice()
        this.noticeList = res.data || []
      } catch (err) {
        console.error("获取公告失败", err)
      }
    },
    
    async getInvestmentList() {
      try {
        const params = {
          pageNum: 1,
          pageSize: 5,
          orderByColumn: 'create_time',
          isAsc: 'desc'
        }
        const res = await listInfo(params)
        if (res.code === 200) {
          this.investmentList = res.rows || []
        } else {
          console.error('获取招商信息失败', res.msg)
        }
      } catch (error) {
        console.error('获取招商信息异常', error)
      }
    },
    
    async checkUnpaidOrders() {
      if (this.checkedForUnpaid) {
        return
      }
      
      const today = new Date().toDateString()
      const hiddenDate = localStorage.getItem('hideUnpaidNotice')
      if (hiddenDate === today) {
        console.log('今天已关闭提醒')
        this.checkedForUnpaid = true
        return
      }
      
      try {
        const params = {
          pageNum: 1,
          pageSize: 5,
          status: '1'
        }
        
        console.log('开始查询待缴费订单...')
        
        const res = await listOrderByUser(params)
        console.log('待缴费订单查询结果:', res)
        
        if (res.code === 200 && res.rows && res.rows.length > 0) {
          this.unpaidList = res.rows
          this.unpaidCount = res.total || res.rows.length
          
          console.log(`发现${this.unpaidCount}笔待缴费订单`)
          
          setTimeout(() => {
            this.showUnpaidDialog = true
          }, 1500)
        } else {
          console.log('暂无待缴费订单')
        }
        
        this.checkedForUnpaid = true
        
      } catch (error) {
        console.error("检查待缴费订单失败:", error)
        this.checkedForUnpaid = true
      }
    },
    
    playNotificationSound() {
      try {
        const audio = this.$refs.notificationAudio
        if (audio) {
          audio.currentTime = 0
          audio.volume = 0.5
          const playPromise = audio.play()
          
          if (playPromise !== undefined) {
            playPromise.catch(error => {
              console.log('音频播放被阻止:', error)
              this.playFallbackSound()
            })
          }
        } else {
          this.playFallbackSound()
        }
      } catch (error) {
        console.error('播放音频时出错:', error)
        this.playFallbackSound()
      }
    },
    
    playFallbackSound() {
      try {
        const audioContext = new (window.AudioContext || window.webkitAudioContext)()
        const oscillator = audioContext.createOscillator()
        const gainNode = audioContext.createGain()
        
        oscillator.connect(gainNode)
        gainNode.connect(audioContext.destination)
        
        oscillator.frequency.value = 800
        oscillator.type = 'sine'
        
        gainNode.gain.setValueAtTime(0, audioContext.currentTime)
        gainNode.gain.linearRampToValueAtTime(0.3, audioContext.currentTime + 0.1)
        gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.6)
        
        oscillator.start(audioContext.currentTime)
        oscillator.stop(audioContext.currentTime + 0.6)
        
      } catch (error) {
        console.error('备选音频播放失败:', error)
      }
    },
    
    goToPayment() {
      this.showUnpaidDialog = false
      this.$router.push('/order/order/user')
    },
    
    closeDialog() {
      this.showUnpaidDialog = false
      if (this.hideForToday) {
        const today = new Date().toDateString()
        localStorage.setItem('hideUnpaidNotice', today)
        console.log('已设置今天不再提醒')
      }
    },
    
    handleHideChange() {
      console.log('不再提醒选项变化:', this.hideForToday)
    }
  }
};
</script>

<style scoped lang="scss">
.home {
  blockquote {
    padding: 10px 20px;
    margin: 0 0 20px;
    font-size: 17.5px;
    border-left: 5px solid #eee;
  }
  hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #eee;
  }
  .col-item {
    margin-bottom: 20px;
  }

  ul {
    padding: 0;
    margin: 0;
  }

  font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: #676a6c;
  overflow-x: hidden;

  ul {
    list-style-type: none;
  }

  h4 {
    margin-top: 0px;
  }

  h2 {
    margin-top: 10px;
    font-size: 26px;
    font-weight: 100;
  }

  p {
    margin-top: 10px;

    b {
      font-weight: 700;
    }
  }

  .update-log {
    ol {
      display: block;
      list-style-type: decimal;
      margin-block-start: 1em;
      margin-block-end: 1em;
      margin-inline-start: 0;
      margin-inline-end: 0;
      padding-inline-start: 40px;
    }
  }
}

/* 招商信息列表样式（仅展示，不可点击） */
.investment-item {
  padding: 12px 0;
  border-bottom: 1px dashed #eee;
  
  &:last-child {
    border-bottom: none;
  }
  
  .investment-title {
    font-size: 15px;
    font-weight: 500;
    color: #333;
    margin-bottom: 8px;
  }
  
  .investment-detail {
    display: flex;
    align-items: center;
    font-size: 13px;
    color: #666;
    margin-bottom: 6px;
    flex-wrap: wrap;
    
    .investment-status {
      display: inline-block;
      padding: 2px 8px;
      border-radius: 4px;
      background-color: #f0f9eb;
      color: #67c23a;
      margin-right: 15px;
      
      &.status-0 {
        background-color: #ecf5ff;
        color: #409eff;
      }
      &.status-1 {
        background-color: #f0f9eb;
        color: #67c23a;
      }
      &.status-2 {
        background-color: #fef0f0;
        color: #f56c6c;
      }
    }
    
    .investment-contact, .investment-phone {
      margin-right: 15px;
      
      &::before {
        content: '👤';
        margin-right: 4px;
        opacity: 0.7;
      }
    }
    .investment-phone::before {
      content: '📞';
    }
  }
  
  .investment-time {
    font-size: 12px;
    color: #999;
    text-align: right;
  }
}

/* 右下角弹窗样式 */
:deep(.unpaid-notice-dialog) {
  position: fixed !important;
  right: 20px !important;
  bottom: 20px !important;
  margin: 0 !important;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  
  .el-dialog__header {
    padding: 15px 20px 10px;
    border-bottom: 1px solid #ebeef5;
    .el-dialog__title {
      font-size: 16px;
      color: #f56c6c;
    }
  }
  
  .el-dialog__body {
    padding: 20px;
  }
  
  .el-dialog__headerbtn {
    top: 15px;
  }
}
</style>