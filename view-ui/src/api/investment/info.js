import request from '@/utils/request'

// 查询招商信息列表
export function listInfo(query) {
  return request({
    url: '/investment/info/list',
    method: 'get',
    params: query
  })
}

// 查询招商信息详细
export function getInfo(id) {
  return request({
    url: '/investment/info/' + id,
    method: 'get'
  })
}

// 新增招商信息
export function addInfo(data) {
  return request({
    url: '/investment/info',
    method: 'post',
    data: data
  })
}

// 修改招商信息
export function updateInfo(data) {
  return request({
    url: '/investment/info',
    method: 'put',
    data: data
  })
}

// 删除招商信息
export function delInfo(ids) {
  return request({
    url: '/investment/info/' + ids,
    method: 'delete'
  })
}

// 导出招商信息
export function exportInfo(query) {
  return request({
    url: '/investment/info/export',
    method: 'get',
    params: query
  })
}