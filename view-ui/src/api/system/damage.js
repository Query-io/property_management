// view-ui/src/api/system/damage.js
import request from '@/utils/request'

// 查询损坏报废登记列表
export function listDamage(query) {
  return request({
    url: '/system/damage/list',
    method: 'get',
    params: query
  })
}

// 查询损坏报废登记详细
export function getDamage(damageId) {
  return request({
    url: '/system/damage/' + damageId,
    method: 'get'
  })
}

// 新增损坏报废登记
export function addDamage(data) {
  return request({
    url: '/system/damage',
    method: 'post',
    data: data
  })
}

// 修改损坏报废登记
export function updateDamage(data) {
  return request({
    url: '/system/damage',
    method: 'put',
    data: data
  })
}

// 删除损坏报废登记
export function delDamage(damageId) {
  return request({
    url: '/system/damage/' + damageId,
    method: 'delete'
  })
}