import request from '@/utils/request'

// 查询停车场列表
export function listParkInfo(query) {
  return request({
    url: '/system/parkInfo/list',
    method: 'get',
    params: query
  })
}

// 查询未删除的停车场列表
export function listActiveParkInfo(query) {
  return request({
    url: '/system/parkInfo/listActive',
    method: 'get',
    params: query
  })
}

// 查询停车场详细
export function getParkInfo(parkId) {
  return request({
    url: '/system/parkInfo/' + parkId,
    method: 'get'
  })
}

// 新增停车场
export function addParkInfo(data) {
  return request({
    url: '/system/parkInfo',
    method: 'post',
    data: data
  })
}

// 修改停车场
export function updateParkInfo(data) {
  return request({
    url: '/system/parkInfo',
    method: 'put',
    data: data
  })
}

// 删除停车场
export function delParkInfo(parkId) {
  return request({
    url: '/system/parkInfo/' + parkId,
    method: 'delete'
  })
}

// 批量删除停车场
export function delParkInfos(parkIds) {
  return request({
    url: '/system/parkInfo/' + parkIds,
    method: 'delete'
  })
}
