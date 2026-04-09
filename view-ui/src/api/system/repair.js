import request from '@/utils/request'

// 查询维修单列表
export function listRepair(query) {
  return request({
    url: '/system/repair/list',
    method: 'get',
    params: query
  })
}

// 查询已审核的维修单（用于生成支付订单）
export function listDealRepair() {
  return request({
    url: '/system/repair/listDeal',
    method: 'get'
  })
}

// 查询维修单详细
export function getRepair(id) {
  return request({
    url: '/system/repair/' + id,
    method: 'get'
  })
}

// 新增维修单
export function addRepair(data) {
  return request({
    url: '/system/repair',
    method: 'post',
    data: data
  })
}

// 修改维修单
export function updateRepair(data) {
  return request({
    url: '/system/repair',
    method: 'put',
    data: data
  })
}

// 删除维修单（支持批量）
export function delRepair(ids) {
  return request({
    url: '/system/repair/' + ids,
    method: 'delete'
  })
}
//上传维修图片
export function uploadRepairImage(file) {
  const formData = new FormData()
  formData.append('file', file)
  return request({
    url: '/system/repair/uploadRepairImage',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}

// 提交维修评分
export function rateRepair(data) {
  return request({
    url: '/system/repair/rate',
    method: 'post',
    data: data
  })
}

// 获取维修单评分
export function getRepairRate(id) {
  return request({
    url: '/system/repair/rate/' + id,
    method: 'get'
  })
}

