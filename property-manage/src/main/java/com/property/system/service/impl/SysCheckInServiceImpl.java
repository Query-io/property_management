package com.property.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.property.system.mapper.SysCheckInMapper;
import com.property.system.domain.SysCheckIn;
import com.property.system.service.ISysCheckInService;
import com.property.common.utils.DateUtils;
import com.property.common.utils.SecurityUtils;
import com.property.common.utils.StringUtils;

/**
 * 入住登记Service业务层处理
 *
 * @author property
 * @date 2026-01-20
 */
@Service
public class SysCheckInServiceImpl implements ISysCheckInService
{
    @Autowired
    private SysCheckInMapper sysCheckInMapper;

    /**
     * 查询入住登记
     *
     * @param checkInId 入住登记主键
     * @return 入住登记
     */
    @Override
    public SysCheckIn selectSysCheckInByCheckInId(Long checkInId)
    {
        return sysCheckInMapper.selectSysCheckInByCheckInId(checkInId);
    }

    /**
     * 查询入住登记列表
     *
     * @param sysCheckIn 入住登记
     * @return 入住登记
     */
    @Override
    public List<SysCheckIn> selectSysCheckInList(SysCheckIn sysCheckIn)
    {
        return sysCheckInMapper.selectSysCheckInList(sysCheckIn);
    }

    /**
     * 新增入住登记
     *
     * @param sysCheckIn 入住登记
     * @return 结果
     */
    @Override
    public int insertSysCheckIn(SysCheckIn sysCheckIn)
    {
        sysCheckIn.setCreateTime(DateUtils.getNowDate());
        sysCheckIn.setCreateBy(SecurityUtils.getUsername());
        return sysCheckInMapper.insertSysCheckIn(sysCheckIn);
    }

    /**
     * 修改入住登记
     *
     * @param sysCheckIn 入住登记
     * @return 结果
     */
    @Override
    public int updateSysCheckIn(SysCheckIn sysCheckIn)
    {
        sysCheckIn.setUpdateTime(DateUtils.getNowDate());
        sysCheckIn.setUpdateBy(SecurityUtils.getUsername());
        return sysCheckInMapper.updateSysCheckIn(sysCheckIn);
    }

    /**
     * 批量删除入住登记
     *
     * @param checkInIds 需要删除的入住登记主键集合
     * @return 结果
     */
    @Override
    public int deleteSysCheckInByCheckInIds(Long[] checkInIds)
    {
        return sysCheckInMapper.deleteSysCheckInByCheckInIds(checkInIds);
    }

    /**
     * 删除入住登记信息
     *
     * @param checkInId 入住登记主键
     * @return 结果
     */
    @Override
    public int deleteSysCheckInByCheckInId(Long checkInId)
    {
        return sysCheckInMapper.deleteSysCheckInByCheckInId(checkInId);
    }
}