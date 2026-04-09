package com.property.system.service;

import com.property.system.domain.OwnerWelfare;
import java.util.List;

public interface IOwnerWelfareService {
    /**
     * 查询业主福利申领
     */
    OwnerWelfare selectOwnerWelfareById(Long id);

    /**
     * 查询业主福利申领列表
     */
    List<OwnerWelfare> selectOwnerWelfareList(OwnerWelfare ownerWelfare);

    /**
     * 新增业主福利申领
     */
    int insertOwnerWelfare(OwnerWelfare ownerWelfare);

    /**
     * 修改业主福利申领
     */
    int updateOwnerWelfare(OwnerWelfare ownerWelfare);

    /**
     * 批量删除业主福利申领
     */
    int deleteOwnerWelfareByIds(Long[] ids);
}