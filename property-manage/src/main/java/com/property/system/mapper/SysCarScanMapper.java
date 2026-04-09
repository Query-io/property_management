package com.property.system.mapper;

import com.property.system.domain.SysCarScan;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface SysCarScanMapper {

    // 查询车牌扫描记录，传入查询条件实体类
    List<SysCarScan> selectCarScanList(SysCarScan sysCarScan);

    // 根据 scan_id 查询车牌扫描记录
    SysCarScan selectCarScanById(Long scanId);

    // 根据 userId 查询车牌扫描记录
    List<SysCarScan> selectCarScanByUserId(Long userId);

    // 插入车牌扫描记录
    int insertCarScan(SysCarScan carScan);

    // 更新车牌扫描记录，只更新不为空的字段
    int updateCarScan(SysCarScan carScan);

    // 删除车牌扫描记录
    int deleteCarScanById(Long scanId);
}
