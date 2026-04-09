package com.property.system.service.impl;

import com.property.system.domain.SysOwnerInfo;
import com.property.system.mapper.SysOwnerMapper;
import com.property.system.service.ISysOwnerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 业主信息 服务层实现
 */
@Service
public class SysOwnerServiceImpl implements ISysOwnerService {

    @Autowired
    private SysOwnerMapper ownerMapper;

    @Override
    public List<SysOwnerInfo> selectOwnerList(SysOwnerInfo owner) {
        return ownerMapper.selectOwnerList(owner);
    }

    @Override
    public SysOwnerInfo selectOwnerById(Long ownerId) {
        return ownerMapper.selectOwnerById(ownerId);
    }

    @Override
    public SysOwnerInfo selectOwnerByUserId(Long userId) {
        return ownerMapper.selectOwnerByUserId(userId);
    }

    @Override
    public int insertOwner(SysOwnerInfo owner) {
        return ownerMapper.insertOwner(owner);
    }

    @Override
    public int updateOwner(SysOwnerInfo owner) {
        return ownerMapper.updateOwner(owner);
    }

    @Override
    public int deleteOwnerById(Integer ownerId) {
        return ownerMapper.deleteOwnerById(ownerId);
    }

    @Override
    public int deleteOwnerByIds(Integer[] ownerIds) {
        int rows = 0;
        for (Integer id : ownerIds) {
            rows += ownerMapper.deleteOwnerById(id);
        }
        return rows;
    }
}
