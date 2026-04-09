package com.property.system.service;

import java.util.List;
import com.property.system.domain.SysCheckIn;

/**
 * 入住登记Service接口
 *
 * @author property
 * @date 2026-01-20
 */
public interface ISysCheckInService
{
    /**
     * 查询入住登记
     *
     * @param checkInId 入住登记主键
     * @return 入住登记
     */
    public SysCheckIn selectSysCheckInByCheckInId(Long checkInId);

    /**
     * 查询入住登记列表
     *
     * @param sysCheckIn 入住登记
     * @return 入住登记集合
     */
    public List<SysCheckIn> selectSysCheckInList(SysCheckIn sysCheckIn);

    /**
     * 新增入住登记
     *
     * @param sysCheckIn 入住登记
     * @return 结果
     */
    public int insertSysCheckIn(SysCheckIn sysCheckIn);

    /**
     * 修改入住登记
     *
     * @param sysCheckIn 入住登记
     * @return 结果
     */
    public int updateSysCheckIn(SysCheckIn sysCheckIn);

    /**
     * 批量删除入住登记
     *
     * @param checkInIds 需要删除的入住登记主键集合
     * @return 结果
     */
    public int deleteSysCheckInByCheckInIds(Long[] checkInIds);

    /**
     * 删除入住登记信息
     *
     * @param checkInId 入住登记主键
     * @return 结果
     */
    public int deleteSysCheckInByCheckInId(Long checkInId);
}