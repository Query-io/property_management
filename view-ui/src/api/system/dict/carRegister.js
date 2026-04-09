import request from '@/utils/request'

// 查询车辆登记列表
export function listCarRegister(query) {
  return request({
    url: '/car/register/list',
    method: 'get',
    params: query
  })
}

// 查询车辆登记详细
export function getCarRegister(carId) {
  return request({
    url: '/car/register/' + carId,
    method: 'get'
  })
}

// 新增车辆登记
export function addCarRegister(data) {
  return request({
    url: '/car/register',
    method: 'post',
    data: data
  })
}

// 修改车辆登记
export function updateCarRegister(data) {
  return request({
    url: '/car/register',
    method: 'put',
    data: data
  })
}

// 删除车辆登记
export function delCarRegister(carId) {
  return request({
    url: '/car/register/' + carId,
    method: 'delete'
  })
}

// 查询业主列表（用于下拉框）
export function listOwners() {
  return request({
    url: '/system/owner/listAll',
    method: 'get'
  })
}