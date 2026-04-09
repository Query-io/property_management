// 位置：view-ui/src/api/system/facility.js
import request from '@/utils/request'

// 查询公共设施信息列表
export function listFacility(query) {
  return request({
    url: '/system/facility/list',
    method: 'get',
    params: query
  })
}

// 查询公共设施信息详细
export function getFacility(facilityId) {
  return request({
    url: '/system/facility/' + facilityId,
    method: 'get'
  })
}

// 新增公共设施信息
export function addFacility(data) {
  return request({
    url: '/system/facility',
    method: 'post',
    data: data
  })
}

// 修改公共设施信息
export function updateFacility(data) {
  return request({
    url: '/system/facility',
    method: 'put',
    data: data
  })
}

// 删除公共设施信息
export function delFacility(facilityId) {
  return request({
    url: '/system/facility/' + facilityId,
    method: 'delete'
  })
}