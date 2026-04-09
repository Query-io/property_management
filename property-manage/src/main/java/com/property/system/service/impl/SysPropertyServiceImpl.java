package com.property.system.service.impl;

import com.property.system.domain.SysPropertyInfo;
import com.property.system.mapper.SysPropertyMapper;
import com.property.system.service.IPropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

/**
 * 房产信息 服务层实现
 *
 */
@Service
public class SysPropertyServiceImpl implements IPropertyService {

    @Autowired
    private SysPropertyMapper propertyMapper;

    @Override
    public SysPropertyInfo selectPropertyById(Long propertyId) {
        return propertyMapper.selectPropertyById(propertyId);
    }

    @Override
    public List<SysPropertyInfo> selectPropertyList(SysPropertyInfo property) {
        return propertyMapper.selectPropertyList(property);
    }

    @Override
    public List<SysPropertyInfo> selectPropertyListByOwnerId(Long ownerId) {
        return propertyMapper.selectPropertyListByOwnerId(ownerId);
    }

    @Override
    public List<SysPropertyInfo> selectPropertyListByUserId(Long userId) {
        return propertyMapper.selectPropertyListByUserId(userId);
    }

    @Override
    public int insertProperty(SysPropertyInfo property) {
        return propertyMapper.insertProperty(property);
    }

    @Override
    public int updateProperty(SysPropertyInfo property) {
        return propertyMapper.updateProperty(property);
    }

    @Override
    public int deletePropertyById(Long propertyId) {
        return propertyMapper.deletePropertyById(propertyId);
    }

    @Override
    public int deletePropertyByIds(Long[] propertyIds) {
        int rows = 0;
        for (Long id : propertyIds) {
            rows += propertyMapper.deletePropertyById(id);
        }
        return rows;
    }

    @Override
    public int updatePropertyStatus(Long propertyId, String status) {
        return propertyMapper.updatePropertyStatus( status,propertyId);
    }

    @Override
    public int updatePropertyOwner(SysPropertyInfo property) {
        return propertyMapper.updatePropertyOwner(property);
    }

    @Override
    public boolean updatePropertyImageUrl(Long propertyId, String imageUrl) {
        int i = propertyMapper.updatePropertyImageUrl(propertyId, imageUrl);
        return i > 0;
    }

}
