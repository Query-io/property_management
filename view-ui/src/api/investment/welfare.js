import request from '@/utils/request'

// 查询业主福利申领列表
export function listWelfare(query) {
  return request({
    url: '/investment/welfare/list',
    method: 'get',
    params: query
  })
}

// 查询业主福利申领详细
export function getWelfare(id) {
  return request({
    url: '/investment/welfare/' + id,
    method: 'get'
  })
}

// 新增业主福利申领
export function addWelfare(data) {
  return request({
    url: '/investment/welfare',
    method: 'post',
    data: data
  })
}

// 修改业主福利申领
export function updateWelfare(data) {
  return request({
    url: '/investment/welfare',
    method: 'put',
    data: data
  })
}

// 删除业主福利申领
export function delWelfare(ids) {
  return request({
    url: '/investment/welfare/' + ids,
    method: 'delete'
  })
}

// 导出业主福利申领
export function exportWelfare(query) {
  return request({
    url: '/investment/welfare/export',
    method: 'get',
    params: query
  })
}

// 查询业主列表（用于下拉框）
export function listOwners() {
  return request({
    url: '/system/owner/listAll',
    method: 'get'
  })
}

// 查询房产列表（用于下拉框） - 根据业主ID
export function listPropertiesByOwnerId(ownerId) {
  return request({
    url: '/system/property/listByOwnerId',
    method: 'get',
    params: { ownerId }
  })
}