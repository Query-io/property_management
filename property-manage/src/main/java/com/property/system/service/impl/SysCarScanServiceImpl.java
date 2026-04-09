package com.property.system.service.impl;

import com.property.common.constant.Constants;
import com.property.common.exception.ServiceException;
import com.property.system.domain.SysCarScan;
import com.property.system.domain.SysParkInfo;
import com.property.system.domain.SysParkOrder;
import com.property.system.domain.SysOwnerInfo; // 新增导入
import com.property.system.mapper.SysCarScanMapper;
import com.property.system.mapper.SysParkInfoMapper;
import com.property.system.mapper.SysParkOrderMapper;
import com.property.system.mapper.SysOwnerInfoMapper; // 新增导入
import com.property.system.service.ISysCarScanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 车辆扫描信息 服务层实现
 */
@Service
public class SysCarScanServiceImpl implements ISysCarScanService {

    @Autowired
    private SysCarScanMapper carScanMapper;

    @Autowired
    private SysParkOrderMapper parkOrderMapper;

    @Autowired
    private SysParkInfoMapper parkInfoMapper;

    @Autowired
    private SysOwnerInfoMapper ownerInfoMapper; // 新增：业主信息Mapper

    @Override
    public List<SysCarScan> selectCarScanList(SysCarScan carScan) {
        return carScanMapper.selectCarScanList(carScan);
    }

    @Override
    public SysCarScan selectCarScanById(Long scanId) {
        return carScanMapper.selectCarScanById(scanId);
    }

    @Override
    public List<SysCarScan> selectCarScanByUserId(Long userId) {
        return carScanMapper.selectCarScanByUserId(userId);
    }

    /**
     * 车辆入场
     * @param carScan
     * @return
     */
    @Override
    public boolean addEntryCar(SysCarScan carScan) {
        // 检查该车辆是否存在入场记录订单,如果有则提示车辆已入库，请勿重复扫描。
        String plateNum = carScan.getPlateNum();
        SysParkOrder sysParkOrder = parkOrderMapper.selectLatestOrderByUserIdAndPlateNum(carScan.getUserId(), plateNum);
        //未出库
        if (sysParkOrder != null && sysParkOrder.getExitTime() == null) {
            throw new ServiceException("该车辆已入库，请勿重复扫描！");
        }
        SysParkInfo sysParkInfo = parkInfoMapper.selectParkInfoById(carScan.getParkId());
        //该停车场空闲数为0
        if (sysParkInfo.getParkSpare() == null || sysParkInfo.getParkSpare() == 0) {
            throw new ServiceException("该停车场已无空闲停车位，请重新选择！");
        }

        // 新增：判断是否为已注册车辆，如果carScan中已经有type字段，直接使用
        Integer type = carScan.getType();
        if (type == null) {
            // 如果没有传递type，则根据车牌号查询是否已注册
            SysOwnerInfo ownerInfo = ownerInfoMapper.selectOwnerByPlateNum(plateNum);
            type = (ownerInfo != null) ? 1 : 0; // 1:已注册，0:未注册
        }

        SysParkOrder addParkOrder = new SysParkOrder();
        addParkOrder.setPlateNum(carScan.getPlateNum());
        addParkOrder.setPlateColor(carScan.getPlateColor());
        addParkOrder.setParkId(carScan.getParkId());
        addParkOrder.setDelFlag(Constants.SUCCESS);
        addParkOrder.setEntryTime(new Date());
        addParkOrder.setUserId(carScan.getUserId());
        // 设置车辆类型（是否固定车）
        addParkOrder.setType(type);
        parkOrderMapper.insertParkOrder(addParkOrder);

        // 停车场剩余车位数-1
        sysParkInfo.setParkSpare(sysParkInfo.getParkSpare() -1);
        parkInfoMapper.updateParkInfo(sysParkInfo);

        //插入扫描记录
        //驶入
        carScan.setDirection(Constants.YES); // 0驶入
        carScan.setType(type); // 使用判断后的type值
        carScan.setCreateTime(new Date());
        carScanMapper.insertCarScan(carScan);
        return true;
    }

    @Override
    public boolean exitCar(SysCarScan carScan) {
        String plateNum = carScan.getPlateNum();
        SysParkOrder sysParkOrder = parkOrderMapper.selectLatestOrderByUserIdAndPlateNum(carScan.getUserId(), plateNum);
        if (sysParkOrder == null || sysParkOrder.getExitTime() != null) {
            throw new ServiceException("该车辆未入库或已出库！");
        }
        Date now = new Date();
        sysParkOrder.setExitTime(now);
        // 查询停车场信息
        SysParkInfo sysParkInfo = parkInfoMapper.selectParkInfoById(sysParkOrder.getParkId());

        // 记录车辆识别记录
        carScan.setDirection(Constants.NO); // 1驶出
        // 使用订单中的type值（已注册/未注册）
        carScan.setType(sysParkOrder.getType());
        carScan.setCreateTime(now);
        carScan.setParkId(sysParkOrder.getParkId());
        // 每小时多少元
        BigDecimal parkRule = sysParkInfo.getParkRule();
        //获取入场时间
        Date entryTime = sysParkOrder.getEntryTime();
        // 计算规则，不足一小时，按照一小时算，
        // 入库与出场的间隔分钟数
        // 计算停车时长（以分钟为单位）
        long durationInMillis = now.getTime() - entryTime.getTime(); // 计算两个时间的间隔（毫秒）
        long durationInMinutes = TimeUnit.MILLISECONDS.toMinutes(durationInMillis);
        sysParkOrder.setParkingDuration((double) durationInMinutes);

        // 如果停车时长小于1小时，则按1小时算
        if (durationInMinutes < 60) {
            durationInMinutes = 60; // 按1小时算
        }
        //费用
        BigDecimal hours = BigDecimal.valueOf(durationInMinutes).divide(BigDecimal.valueOf(60), 2, BigDecimal.ROUND_UP);
        BigDecimal parkFee = hours.multiply(parkRule);
        sysParkOrder.setParkFee(parkFee);
        // 新增出场识别记录
        carScanMapper.insertCarScan(carScan);
        //更新订单记录
        parkOrderMapper.updateParkOrder(sysParkOrder);
        //该停车场空闲数+1
        sysParkInfo.setParkSpare(sysParkInfo.getParkSpare() + 1);
        parkInfoMapper.updateParkInfo(sysParkInfo);
        return true;
    }

    @Override
    public int updateCarScan(SysCarScan carScan) {
        return carScanMapper.updateCarScan(carScan);
    }

    @Override
    public int deleteCarScanById(Long scanId) {
        return carScanMapper.deleteCarScanById(scanId);
    }

    @Override
    public int deleteCarScanByIds(Long[] scanIds) {
        int rows = 0;
        for (Long id : scanIds) {
            rows += carScanMapper.deleteCarScanById(id);
        }
        return rows;
    }
}