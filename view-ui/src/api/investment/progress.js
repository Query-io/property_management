import request from '@/utils/request'

// 查询招商进度列表
export function listProgress(query) {
  return request({
    url: '/investment/progress/list',
    method: 'get',
    params: query
  })
}

// 查询招商进度详细
export function getProgress(id) {
  return request({
    url: '/investment/progress/' + id,
    method: 'get'
  })
}

// 新增招商进度
export function addProgress(data) {
  return request({
    url: '/investment/progress',
    method: 'post',
    data: data
  })
}

// 修改招商进度
export function updateProgress(data) {
  return request({
    url: '/investment/progress',
    method: 'put',
    data: data
  })
}

// 删除招商进度
export function delProgress(ids) {
  return request({
    url: '/investment/progress/' + ids,
    method: 'delete'
  })
}

// 导出招商进度
export function exportProgress(query) {
  return request({
    url: '/investment/progress/export',
    method: 'get',
    params: query
  })
}