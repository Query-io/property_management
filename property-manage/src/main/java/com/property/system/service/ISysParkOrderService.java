package com.property.system.service;

import com.property.system.domain.SysParkOrder;

import java.util.List;

public interface ISysParkOrderService {

    // 查询全部停车订单（可根据条件查询）
    List<SysParkOrder> selectParkOrderList(SysParkOrder parkOrder);

    int deleteParkOrderById(Long id);
}
