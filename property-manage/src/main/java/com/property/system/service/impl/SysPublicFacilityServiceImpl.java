// 位置：property-manage/src/main/java/com/property/system/service/impl/SysPublicFacilityServiceImpl.java
package com.property.system.service.impl;

import com.property.system.domain.SysPublicFacility;
import com.property.system.mapper.SysPublicFacilityMapper;
import com.property.system.service.ISysPublicFacilityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SysPublicFacilityServiceImpl implements ISysPublicFacilityService {

    @Autowired
    private SysPublicFacilityMapper facilityMapper;

    @Override
    public List<SysPublicFacility> selectFacilityList(SysPublicFacility facility) {
        return facilityMapper.selectFacilityList(facility);
    }

    @Override
    public SysPublicFacility selectFacilityById(Long facilityId) {
        return facilityMapper.selectFacilityById(facilityId);
    }

    @Override
    public int insertFacility(SysPublicFacility facility) {
        return facilityMapper.insertFacility(facility);
    }

    @Override
    public int updateFacility(SysPublicFacility facility) {
        return facilityMapper.updateFacility(facility);
    }

    @Override
    public int deleteFacilityById(Long facilityId) {
        return facilityMapper.deleteFacilityById(facilityId);
    }

    @Override
    public int deleteFacilityByIds(Long[] facilityIds) {
        return facilityMapper.deleteFacilityByIds(facilityIds);
    }
}