package com.property.system.service;

import com.property.system.domain.SysCarScan;
import java.util.List;

/**
 * 车辆扫描信息 服务层接口
 */
public interface ISysCarScanService {

    // 查询车牌扫描记录
    List<SysCarScan> selectCarScanList(SysCarScan carScan);

    // 根据 scan_id 查询车牌扫描记录
    SysCarScan selectCarScanById(Long scanId);

    // 根据 userId 查询车牌扫描记录
    List<SysCarScan> selectCarScanByUserId(Long userId);

    // 插入车牌扫描记录
    boolean addEntryCar(SysCarScan carScan);

    // 车辆出场
    boolean exitCar(SysCarScan carScan);

    // 更新车牌扫描记录，只更新不为空的字段
    int updateCarScan(SysCarScan carScan);

    // 删除车牌扫描记录
    int deleteCarScanById(Long scanId);

    // 批量删除车牌扫描记录
    int deleteCarScanByIds(Long[] scanIds);
}
