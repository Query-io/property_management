package com.property.system.service.impl;

import com.property.common.core.text.Convert;
import com.property.system.domain.OwnerWelfare;
import com.property.system.mapper.OwnerWelfareMapper;
import com.property.system.service.IOwnerWelfareService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OwnerWelfareServiceImpl implements IOwnerWelfareService {
    @Autowired
    private OwnerWelfareMapper ownerWelfareMapper;

    /**
     * 查询业主福利申领
     */
    @Override
    public OwnerWelfare selectOwnerWelfareById(Long id) {
        return ownerWelfareMapper.selectOwnerWelfareById(id);
    }

    /**
     * 查询业主福利申领列表
     */
    @Override
    public List<OwnerWelfare> selectOwnerWelfareList(OwnerWelfare ownerWelfare) {
        return ownerWelfareMapper.selectOwnerWelfareList(ownerWelfare);
    }

    /**
     * 新增业主福利申领
     */
    @Override
    public int insertOwnerWelfare(OwnerWelfare ownerWelfare) {
        return ownerWelfareMapper.insertOwnerWelfare(ownerWelfare);
    }

    /**
     * 修改业主福利申领
     */
    @Override
    public int updateOwnerWelfare(OwnerWelfare ownerWelfare) {
        return ownerWelfareMapper.updateOwnerWelfare(ownerWelfare);
    }

    /**
     * 批量删除业主福利申领
     */
    @Override
    public int deleteOwnerWelfareByIds(Long[] ids) {
        return ownerWelfareMapper.deleteOwnerWelfareByIds(ids);
    }
}