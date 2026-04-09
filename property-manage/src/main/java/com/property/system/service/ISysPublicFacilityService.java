package com.property.system.service;

import com.property.system.domain.SysPublicFacility;
import java.util.List;

public interface ISysPublicFacilityService {
    /**
     * 查询公共设施信息列表
     */
    List<SysPublicFacility> selectFacilityList(SysPublicFacility facility);

    /**
     * 查询公共设施信息
     */
    SysPublicFacility selectFacilityById(Long facilityId);

    /**
     * 新增公共设施信息
     */
    int insertFacility(SysPublicFacility facility);

    /**
     * 修改公共设施信息
     */
    int updateFacility(SysPublicFacility facility);

    /**
     * 删除公共设施信息
     */
    int deleteFacilityById(Long facilityId);

    /**
     * 批量删除公共设施信息
     */
    int deleteFacilityByIds(Long[] facilityIds);
}