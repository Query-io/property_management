package com.property.system.service.impl;

import com.property.system.domain.SysParkOrder;
import com.property.system.mapper.SysParkOrderMapper;
import com.property.system.service.ISysParkOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

/**
 * 订单服务
 */
@Service
public class SysParkOrderServiceImpl implements ISysParkOrderService {

    @Autowired
    private SysParkOrderMapper parkOrderMapper;

    @Override
    public List<SysParkOrder> selectParkOrderList(SysParkOrder parkOrder) {
        return parkOrderMapper.selectParkOrderList(parkOrder);
    }

    @Override
    public int deleteParkOrderById(Long id) {
        return parkOrderMapper.deleteParkOrderById(id);
    }
}
