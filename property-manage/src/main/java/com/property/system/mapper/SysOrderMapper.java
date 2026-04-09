package com.property.system.mapper;

import com.property.system.domain.SysOrder;
import com.property.system.domain.SysOrderItem;

import java.util.List;

public interface  SysOrderMapper {

    // 主表操作
    SysOrder selectSysOrderById(Long id);

    List<SysOrder> selectSysOrderList(SysOrder sysOrder);

    int insertSysOrder(SysOrder sysOrder);

    int updateSysOrderStatus(SysOrder sysOrder);

    int deleteSysOrderById(Long id);

    // 明细操作
    List<SysOrderItem> selectSysOrderItemList(Long orderId);

    int insertOrderItem(SysOrderItem item);

    int updateOrderItem(SysOrderItem item);

    int deleteOrderItemsByOrderId(Long orderId);
}
