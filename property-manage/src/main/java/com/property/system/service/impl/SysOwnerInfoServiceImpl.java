package com.property.system.service.impl;

import com.property.system.domain.SysOwnerInfo;
import com.property.system.mapper.SysOwnerInfoMapper;
import com.property.system.service.ISysOwnerInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SysOwnerInfoServiceImpl implements ISysOwnerInfoService {
    @Autowired
    private SysOwnerInfoMapper ownerInfoMapper;

    @Override
    public SysOwnerInfo selectOwnerByPlateNum(String plateNum) {
        return ownerInfoMapper.selectOwnerByPlateNum(plateNum);
    }
}
