import request from '@/utils/request'

// 查询工人信息列表
export function listWorker(query) {
  return request({
    url: '/system/worker/list',
    method: 'get',
    params: query
  })
}

// 查询工人信息详细
export function getWorker(workerId) {
  return request({
    url: '/system/worker/' + workerId,
    method: 'get'
  })
}

// 新增工人信息
export function addWorker(data) {
  return request({
    url: '/system/worker',
    method: 'post',
    data: data
  })
}

// 修改工人信息
export function updateWorker(data) {
  return request({
    url: '/system/worker',
    method: 'put',
    data: data
  })
}

// 删除工人信息
export function delWorker(workerIds) {
  return request({
    url: '/system/worker/' + workerIds,
    method: 'delete'
  })
}

// 导出工人信息
export function exportWorker(query) {
  return request({
    url: '/system/worker/export',
    method: 'get',
    params: query
  })
}