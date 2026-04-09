import request from '@/utils/request';

/**
 * 获取停车订单列表
 * @param query 查询条件
 * @returns {AxiosPromise<AxiosResponse<any>>}
 */
export function listParkOrder(query) {
  return request({
    url: '/system/parkOrder/list',
    method: 'get',
    params: query
  });
}

  /**
   * 删除停车订单
   * @param id
   * @returns {AxiosPromise<AxiosResponse<any>>}
   */
  export function deleteParkOrder(id) {
    return request({
      url: '/system/parkOrder/' + id,
      method: 'delete'
    });
  }
