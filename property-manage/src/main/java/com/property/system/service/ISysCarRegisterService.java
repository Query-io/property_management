package com.property.system.service;

import java.util.List;
import com.property.system.domain.SysCarRegister;

/**
 * 车辆登记Service接口
 *
 * @author property
 * @date 2026-01-20
 */
public interface ISysCarRegisterService
{
    /**
     * 查询车辆登记
     *
     * @param carId 车辆登记主键
     * @return 车辆登记
     */
    public SysCarRegister selectSysCarRegisterByCarId(Long carId);

    /**
     * 查询车辆登记列表
     *
     * @param sysCarRegister 车辆登记
     * @return 车辆登记集合
     */
    public List<SysCarRegister> selectSysCarRegisterList(SysCarRegister sysCarRegister);

    /**
     * 新增车辆登记
     *
     * @param sysCarRegister 车辆登记
     * @return 结果
     */
    public int insertSysCarRegister(SysCarRegister sysCarRegister);

    /**
     * 修改车辆登记
     *
     * @param sysCarRegister 车辆登记
     * @return 结果
     */
    public int updateSysCarRegister(SysCarRegister sysCarRegister);

    /**
     * 批量删除车辆登记
     *
     * @param carIds 需要删除的车辆登记主键集合
     * @return 结果
     */
    public int deleteSysCarRegisterByCarIds(Long[] carIds);

    /**
     * 删除车辆登记信息
     *
     * @param carId 车辆登记主键
     * @return 结果
     */
    public int deleteSysCarRegisterByCarId(Long carId);

    /**
     * 根据车牌号查询车辆登记
     *
     * @param plateNumber 车牌号码
     * @return 车辆登记
     */
    public SysCarRegister selectSysCarRegisterByPlateNumber(String plateNumber);
}