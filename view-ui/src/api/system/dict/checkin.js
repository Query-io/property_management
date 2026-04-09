import request from '@/utils/request'

// 查询入住登记列表
export function listCheckin(query) {
  return request({
    url: '/property/checkin/list',
    method: 'get',
    params: query
  })
}

// 查询入住登记详细
export function getCheckin(checkInId) {
  return request({
    url: '/property/checkin/' + checkInId,
    method: 'get'
  })
}

// 新增入住登记
export function addCheckin(data) {
  return request({
    url: '/property/checkin',
    method: 'post',
    data: data
  })
}

// 修改入住登记
export function updateCheckin(data) {
  return request({
    url: '/property/checkin',
    method: 'put',
    data: data
  })
}

// 删除入住登记
export function delCheckin(checkInId) {
  return request({
    url: '/property/checkin/' + checkInId,
    method: 'delete'
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