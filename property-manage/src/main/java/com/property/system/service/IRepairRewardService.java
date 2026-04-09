package com.property.system.service;

import com.property.system.domain.Repair;
import com.property.system.dto.RepairRewardDTO;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 报修奖惩信息服务接口
 */
public interface IRepairRewardService {

    /**
     * 查询报修奖惩信息列表
     */
    List<RepairRewardDTO> selectRepairRewardList(Repair repair);

    /**
     * 导出报修奖惩信息
     */
    void exportRepairReward(Repair repair, HttpServletResponse response);

    /**
     * 查询工人奖惩统计
     */
    List<Map<String, Object>> selectWorkerRewardStat(String workerName, String workerType,
                                                     String startTime, String endTime);

    /**
     * 导出工人奖惩统计
     */
    void exportWorkerRewardStat(String workerName, String workerType,
                                String startTime, String endTime,
                                HttpServletResponse response);
}