import request from '@/utils/request'

// 查询违规信息记录列表
export function listViolation(query) {
  return request({
    url: '/system/violation/list',
    method: 'get',
    params: query
  })
}

// 查询违规信息记录详细
export function getViolation(violationId) {
  return request({
    url: '/system/violation/' + violationId,
    method: 'get'
  })
}

// 新增违规信息记录
export function addViolation(data) {
  return request({
    url: '/system/violation',
    method: 'post',
    data: data
  })
}

// 修改违规信息记录
export function updateViolation(data) {
  return request({
    url: '/system/violation',
    method: 'put',
    data: data
  })
}

// 删除违规信息记录
export function delViolation(violationId) {
  return request({
    url: '/system/violation/' + violationId,
    method: 'delete'
  })
}

// 批量删除违规信息记录
export function delViolationByIds(violationIds) {
  return request({
    url: '/system/violation/' + violationIds,
    method: 'delete'
  })
}

// 处理违规记录
export function processViolation(violationId) {
  return request({
    url: '/system/violation/process/' + violationId,
    method: 'put'
  })
}

// 撤销违规记录
export function cancelViolation(violationId) {
  return request({
    url: '/system/violation/cancel/' + violationId,
    method: 'put'
  })
}

// 导出违规信息记录
export function exportViolation(query) {
  return request({
    url: '/system/violation/export',
    method: 'post',
    data: query
  })
}

// 获取统计信息
export function getStatistics() {
  return request({
    url: '/system/violation/statistics',
    method: 'get'
  })
}

// 根据车牌号查询违规记录
export function getViolationByPlate(plateNum) {
  return request({
    url: '/system/violation/byPlate/' + plateNum,
    method: 'get'
  })
}

// 上传证据图片
export function uploadEvidence(data) {
  return request({
    url: '/system/violation/uploadEvidence',
    method: 'post',
    data: data
  })
}