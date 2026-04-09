import request from '@/utils/request'

// 查询房产列表
export function listProperty(query) {
  return request({
    url: '/system/property/list',
    method: 'get',
    params: query
  })
}

// 查询房产列表-不分页
export function rentedList(query) {
  return request({
    url: '/system/property/rentedList',
    method: 'get',
    params: query
  })
}

//查询房产信息根据ownerId
export function listByOwnerId(ownerId) {
  return request({
    url: 'system/property/listByOwnerId',
    method:'get',
    params: {ownerId : ownerId}
  })
}


//查询房产信息根据userId
export function listByUserId(userId) {
  return request({
    url: 'system/property/listByUserId',
    method:'get',
    params: {userId : userId}
  })
}
// 获取房产详细信息
export function getProperty(propertyId) {
  return request({
    url: '/system/property/' + propertyId,
    method: 'get'
  })
}

// 新增房产信息
export function addProperty(data) {
  return request({
    url: '/system/property',
    method: 'post',
    data: data
  })
}

// 修改房产信息
export function updateProperty(data) {
  return request({
    url: '/system/property',
    method: 'put',
    data: data
  })
}

// 删除房产信息（支持批量删除，propertyIds 为数组）
export function deleteProperty(propertyIds) {
  // 拼接成逗号分隔的字符串
  return request({
    url: '/system/property/' + propertyIds.join(','),
    method: 'delete'
  })
}

// 修改房产状态
export function changePropertyStatus(propertyId, status) {
  return request({
    url: '/system/property/changeStatus',
    method: 'put',
    params: { propertyId: propertyId, status: status }
  })
}

// 绑定业主（更新房产绑定的业主信息）
// 这里传参方式参考控制器路径变量，传入 propertyId、ownerId（以及在 requestBody 中携带 ownerName）
export function bindOwner(payload) {
  return request({
    url: `/system/property/bindOwner`,
    method: 'put',
    data: payload
  })
}

// 上传房产图片，同时会更新数据库中的 image_url 字段
export function uploadPropertyImage(propertyId, file) {
  const formData = new FormData()
  formData.append('propertyImage', file)
  formData.append('propertyId', propertyId)
  return request({
    url: '/system/property/uploadImage',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })


}
