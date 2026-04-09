package com.property.system.mapper;

import com.property.system.domain.Repair;
import com.property.system.dto.RepairRewardDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 报修奖惩信息Mapper
 */
public interface RepairRewardMapper {

    /**
     * 查询报修奖惩信息列表
     */
    List<RepairRewardDTO> selectRepairRewardList(Repair repair);

    /**
     * 查询工人奖惩统计
     */
    List<Map<String, Object>> selectWorkerRewardStat(@Param("params") Map<String, Object> params);
}