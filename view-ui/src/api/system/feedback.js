import request from '@/utils/request'

// 查询当前用户的反馈列表
export function listFeedbackByUser(query) {
  return request({
    url: '/system/feedback/listByUser',
    method: 'get',
    params: query
  })
}

// 查询管理员查看的全部反馈列表
export function listFeedbackByAdmin(query) {
  return request({
    url: '/system/feedback/listByAdmin',
    method: 'get',
    params: query
  })
}

// 查询反馈详细
export function getFeedback(id) {
  return request({
    url: '/system/feedback/' + id,
    method: 'get'
  })
}

// 新增反馈（普通用户提交）
export function addFeedback(data) {
  return request({
    url: '/system/feedback',
    method: 'post',
    data: data
  })
}

// 回复或修改反馈（管理人员操作）
export function updateFeedback(data) {
  return request({
    url: '/system/feedback',
    method: 'put',
    data: data
  })
}

// 删除反馈
export function delFeedback(ids) {
  return request({
    url: '/system/feedback/' + ids,
    method: 'delete'
  })
}
