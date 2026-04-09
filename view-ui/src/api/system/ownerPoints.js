import request from '@/utils/request'

// 查询业主积分列表
export function listPoints(query) {
  return request({
    url: '/system/ownerPoints/list',
    method: 'get',
    params: query
  })
}

// 查询业主积分详细
export function getPoints(ownerId) {
  return request({
    url: '/system/ownerPoints/' + ownerId,
    method: 'get'
  })
}

// 根据用户ID获取积分
export function getPointsByUserId(userId) {
  return request({
    url: '/system/ownerPoints/getPointsByUserId/' + userId,
    method: 'get'
  })
}

// 新增业主积分
export function addPoints(data) {
  return request({
    url: '/system/ownerPoints',
    method: 'post',
    data: data
  })
}

// 修改业主积分（修改所有字段）
export function updatePoints(data) {
  return request({
    url: '/system/ownerPoints',
    method: 'put',
    data: data
  })
}

// 更新积分（只更新积分字段，不带历史记录）
export function updatePointsOnly(data) {
  return request({
    url: '/system/ownerPoints/updatePoints',
    method: 'put',
    data: data
  })
}

// 删除业主积分
export function delPoints(ownerIds) {
  return request({
    url: '/system/ownerPoints/' + ownerIds,
    method: 'delete'
  })
}

// 导出业主积分
export function exportPoints(query) {
  return request({
    url: '/system/ownerPoints/export',
    method: 'get',
    params: query
  })
}

// 获取积分调整历史记录
export function getHistoryByOwnerId(ownerId) {
  return request({
    url: '/system/ownerPoints/history/' + ownerId,
    method: 'get'
  })
}

// 调整积分（带乐观锁和历史记录）
export function adjustPoints(data) {
  return request({
    url: '/system/ownerPoints/adjustPoints',
    method: 'post',
    data: data
  })
}