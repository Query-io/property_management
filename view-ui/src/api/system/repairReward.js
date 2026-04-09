import request from '@/utils/request'

// 查询报修奖惩信息列表
export function listRepairReward(query) {
  return request({
    url: '/system/repair/reward/list',
    method: 'get',
    params: query
  })
}

// 导出报修奖惩信息
export function exportRepairReward(data) {
  return request({
    url: '/system/repair/reward/export',
    method: 'post',
    data: data,
    responseType: 'blob'
  })
}

// 查询工人奖惩统计
export function listWorkerRewardStat(params) {
  return request({
    url: '/system/repair/reward/stat',
    method: 'get',
    params: params
  })
}

// 导出工人奖惩统计
export function exportWorkerRewardStat(params) {
  return request({
    url: '/system/repair/reward/exportStat',
    method: 'post',
    params: params,
    responseType: 'blob'
  })
}