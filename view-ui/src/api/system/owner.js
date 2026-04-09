import request from '@/utils/request'




// 查询业主列表
export function listOwner(query) {
  return request({
    url: '/system/owner/list',
    method: 'get',
    params: query
  })
}

// 根据业主ID获取详细信息
export function getOwner(ownerId) {
  return request({
    url: `/system/owner/${ownerId}`,
    method: 'get'
  })
}

// 根据当前用户获取所属业主信息
export function getOwnerByUser() {
  return request({
    url: '/system/owner/byUser',
    method: 'get'
  })
}

// 新增业主
export function addOwner(data) {
  return request({
    url: '/system/owner',
    method: 'post',
    data
  })
}

// 修改业主
export function updateOwner(data) {
  return request({
    url: '/system/owner',
    method: 'put',
    data
  })
}

// 删除业主
export function delOwner(ownerIds) {
  return request({
    url: `/system/owner/${ownerIds}`,
    method: 'delete'
  })
}
