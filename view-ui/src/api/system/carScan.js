import request from '@/utils/request';

/**
 * 获取车辆识别记录
 * @param query
 * @returns {AxiosPromise<AxiosResponse<any>>}
 */
export function listByUser(query) {
  return request({
    url: '/system/carScan/listByUser',
    method: 'get',
    params: query
  })
}

/**
 * 车牌识别接口
 */
export function carScan(file) {
  const formData = new FormData();
  formData.append('file', file);

  return request({
    url: '/system/carScan/carScan',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  });
}

/**
 * 入场车辆新增接口
 */
export function addEntryCar(carScan) {
  return request({
    url: '/system/carScan/addEntryCar',
    method: 'post',
    data: carScan
  });
}

/**
 * 车辆出库接口
 */
export function exitCar(carScan) {
  return request({
    url: '/system/carScan/exitCar',
    method: 'post',
    data: carScan
  });
}

// 根据车牌号查询车辆信息
export function getCarByPlateNumber(plateNumber) {
  return request({
    url: `/car/register/plate/${plateNumber}`,
    method: 'get'
  });
}

// 获取所有已登记车辆列表
export function listAllCars() {
  return request({
    url: '/car/register/list',
    method: 'get',
    params: {
      pageNum: 1,
      pageSize: 1000 // 设置较大的值获取所有车辆
    }
  });
}

// 新增：根据车牌号查询车主信息
export function getOwnerByPlate(plateNum) {
  return request({
    url: '/system/carScan/getOwnerByPlate',
    method: 'get',
    params: { plateNum }
  });
}