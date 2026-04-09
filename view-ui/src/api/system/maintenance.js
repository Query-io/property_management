import request from '@/utils/request'

// 查询维修维护记录列表
export function listMaintenance(query) {
  return request({
    url: '/system/maintenance/list',
    method: 'get',
    params: query
  })
}

// 查询维修维护记录详细
export function getMaintenance(recordId) {
  return request({
    url: '/system/maintenance/' + recordId,
    method: 'get'
  })
}

// 新增维修维护记录
export function addMaintenance(data) {
  return request({
    url: '/system/maintenance',
    method: 'post',
    data: data
  })
}

// 修改维修维护记录
export function updateMaintenance(data) {
  return request({
    url: '/system/maintenance',
    method: 'put',
    data: data
  })
}

// 删除维修维护记录
export function delMaintenance(recordId) {
  return request({
    url: '/system/maintenance/' + recordId,
    method: 'delete'
  })
}