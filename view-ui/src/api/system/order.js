import request from '@/utils/request'

//支付二维码生成
export function generateParQr(orderId) {
  return request({
    url: '/system/order/generateParQr/' + orderId,
    method: 'get'
  })
}


// 用户获取订单列表
export function listOrderByUser(query) {
  return request({
    url: '/system/order/listByUser',
    method: 'get',
    params: query
  })
}

// 管理员获取订单列表
export function listOrderByAdmin(query) {
  return request({
    url: '/system/order/listByAdmin',
    method: 'get',
    params: query
  })
}

// 获取订单详情
export function getOrder(id) {
  return request({
    url: '/system/order/' + id,
    method: 'get'
  })
}

// 新增订单
export function generatedSysOrder(data) {
  return request({
    url: '/system/order',
    method: 'post',
    data: data
  })
}

// 模拟支付
export function payOrder(data) {
  return request({
    url: '/system/order/pay',
    method: 'put',
    data: data
  })
}

// 删除订单
export function delOrder(id) {
  return request({
    url: '/system/order/' + id,
    method: 'delete'
  })
}

// 获取订单明细列表
export function listOrderItems(orderId) {
  return request({
    url: '/system/order/item/list/' + orderId,
    method: 'get'
  })
}

// 停车费模拟支付
export function parkingPay(parkOrderId) {
  return request({
    url: '/system/order/parkingPay/' + parkOrderId,
    method: 'get'
  })
}
// 添加订单明细
export function addOrderItem(data) {
  return request({
    url: '/system/order/item',
    method: 'post',
    data: data
  })
}

// 修改订单明细
export function updateOrderItem(data) {
  return request({
    url: '/system/order/item',
    method: 'put',
    data: data
  })
}

// 删除订单明细（通过订单ID）
export function deleteOrderItems(orderId) {
  return request({
    url: '/system/order/item/' + orderId,
    method: 'delete'
  })
}

