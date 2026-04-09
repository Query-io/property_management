package com.property.system.service.impl;


import com.property.common.utils.SecurityUtils;
import com.property.system.domain.SysPropertyRepair;
import com.property.system.mapper.SysPropertyRepairMapper;
import com.property.system.service.ISysPropertyRepairService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class SysPropertyRepairServiceImpl implements ISysPropertyRepairService {

    @Autowired
    private SysPropertyRepairMapper sysPropertyRepairMapper;

    @Override
    public List<SysPropertyRepair> selectSysPropertyRepairList(SysPropertyRepair repair) {
        return sysPropertyRepairMapper.selectSysPropertyRepairList(repair);
    }

    @Override
    public List<SysPropertyRepair> selectDealSysPropertyRepairList() {
        return sysPropertyRepairMapper.selectDealSysPropertyRepairList();
    }

    @Override
    public SysPropertyRepair selectSysPropertyRepairById(Long id) {
        return sysPropertyRepairMapper.selectSysPropertyRepairById(id);
    }

    @Override
    public int insertSysPropertyRepair(SysPropertyRepair repair) {
        repair.setApplicantId(SecurityUtils.getUserId());
        repair.setApplicantName(SecurityUtils.getUsername());
        return sysPropertyRepairMapper.insertSysPropertyRepair(repair);
    }

    /**
     * 更新维修单
     * 注意：这里不再自动设置completedTime，由Controller根据状态变化来设置
     * @param repair
     * @return
     */
    @Override
    public int updateSysPropertyRepair(SysPropertyRepair repair) {
        // 这里不再自动设置completedTime，由Controller根据状态变化来设置
        // 只更新时间戳
        repair.setUpdateTime(new Date());
        return sysPropertyRepairMapper.updateSysPropertyRepair(repair);
    }

    @Override
    public int deleteSysPropertyRepairById(Long id) {
        return sysPropertyRepairMapper.deleteSysPropertyRepairById(id);
    }

    @Override
    public int deleteSysPropertyRepairByIds(Long[] ids) {
        return sysPropertyRepairMapper.deleteSysPropertyRepairByIds(ids);
    }

    @Override
    public int updateRepairRate(SysPropertyRepair repair) {
        repair.setRateBy(SecurityUtils.getUsername());
        repair.setUpdateTime(new Date());
        return sysPropertyRepairMapper.updateRepairRate(repair);
    }
}