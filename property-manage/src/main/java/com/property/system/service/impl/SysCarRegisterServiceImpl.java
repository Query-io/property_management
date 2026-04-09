package com.property.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.property.system.mapper.SysCarRegisterMapper;
import com.property.system.domain.SysCarRegister;
import com.property.system.service.ISysCarRegisterService;
import com.property.common.utils.DateUtils;
import com.property.common.utils.SecurityUtils;
import com.property.common.utils.StringUtils;

/**
 * 车辆登记Service业务层处理
 *
 * @author property
 * @date 2026-01-20
 */
@Service
public class SysCarRegisterServiceImpl implements ISysCarRegisterService
{
    @Autowired
    private SysCarRegisterMapper sysCarRegisterMapper;

    /**
     * 查询车辆登记
     *
     * @param carId 车辆登记主键
     * @return 车辆登记
     */
    @Override
    public SysCarRegister selectSysCarRegisterByCarId(Long carId)
    {
        return sysCarRegisterMapper.selectSysCarRegisterByCarId(carId);
    }

    /**
     * 查询车辆登记列表
     *
     * @param sysCarRegister 车辆登记
     * @return 车辆登记
     */
    @Override
    public List<SysCarRegister> selectSysCarRegisterList(SysCarRegister sysCarRegister)
    {
        return sysCarRegisterMapper.selectSysCarRegisterList(sysCarRegister);
    }

    /**
     * 新增车辆登记
     *
     * @param sysCarRegister 车辆登记
     * @return 结果
     */
    @Override
    public int insertSysCarRegister(SysCarRegister sysCarRegister)
    {
        sysCarRegister.setCreateTime(DateUtils.getNowDate());
        sysCarRegister.setCreateBy(SecurityUtils.getUsername());
        return sysCarRegisterMapper.insertSysCarRegister(sysCarRegister);
    }

    /**
     * 修改车辆登记
     *
     * @param sysCarRegister 车辆登记
     * @return 结果
     */
    @Override
    public int updateSysCarRegister(SysCarRegister sysCarRegister)
    {
        sysCarRegister.setUpdateTime(DateUtils.getNowDate());
        sysCarRegister.setUpdateBy(SecurityUtils.getUsername());
        return sysCarRegisterMapper.updateSysCarRegister(sysCarRegister);
    }

    /**
     * 批量删除车辆登记
     *
     * @param carIds 需要删除的车辆登记主键集合
     * @return 结果
     */
    @Override
    public int deleteSysCarRegisterByCarIds(Long[] carIds)
    {
        return sysCarRegisterMapper.deleteSysCarRegisterByCarIds(carIds);
    }

    /**
     * 删除车辆登记信息
     *
     * @param carId 车辆登记主键
     * @return 结果
     */
    @Override
    public int deleteSysCarRegisterByCarId(Long carId)
    {
        return sysCarRegisterMapper.deleteSysCarRegisterByCarId(carId);
    }

    /**
     * 根据车牌号查询车辆登记
     *
     * @param plateNumber 车牌号码
     * @return 车辆登记
     */
    @Override
    public SysCarRegister selectSysCarRegisterByPlateNumber(String plateNumber)
    {
        return sysCarRegisterMapper.selectSysCarRegisterByPlateNumber(plateNumber);
    }
}