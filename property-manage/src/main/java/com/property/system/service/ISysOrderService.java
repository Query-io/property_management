package com.property.system.service;
import com.property.system.domain.SysOrder;
import com.property.system.domain.SysOrderItem;

import java.util.List;

public interface ISysOrderService {

    // 查询订单
    SysOrder selectSysOrderById(Long id);

    // 查询订单列表
    List<SysOrder> selectSysOrderList(SysOrder sysOrder);

    // 新增订单
    int generatedSysOrder(SysOrder sysOrder);

    // 修改订单状态
    int updateSysOrderStatus(SysOrder sysOrder);

    // 删除订单
    int deleteSysOrderById(Long id);

    // ========== 明细 ==========

    // 查询订单明细列表
    List<SysOrderItem> selectSysOrderItemList(Long orderId);

    // 插入订单明细
    int insertOrderItem(SysOrderItem item);

    // 更新订单明细
    int updateOrderItem(SysOrderItem item);

    // 删除订单明细（按订单ID）
    int deleteOrderItemsByOrderId(Long orderId);

    //模拟停车费用支付
    boolean parkingPay(Long parkOrderId);

}
