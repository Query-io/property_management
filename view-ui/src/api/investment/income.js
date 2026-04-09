import request from '@/utils/request'

// 查询收益明细列表
export function listIncome(query) {
  return request({
    url: '/investment/income/list',
    method: 'get',
    params: query
  })
}

// 查询收益明细详细
export function getIncome(id) {
  return request({
    url: '/investment/income/' + id,
    method: 'get'
  })
}

// 新增收益明细
export function addIncome(data) {
  return request({
    url: '/investment/income',
    method: 'post',
    data: data
  })
}

// 修改收益明细
export function updateIncome(data) {
  return request({
    url: '/investment/income',
    method: 'put',
    data: data
  })
}

// 删除收益明细
export function delIncome(ids) {
  return request({
    url: '/investment/income/' + ids,
    method: 'delete'
  })
}

// 导出收益明细
export function exportIncome(query) {
  return request({
    url: '/investment/income/export',
    method: 'get',
    params: query
  })
}