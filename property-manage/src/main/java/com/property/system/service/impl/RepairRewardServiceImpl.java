package com.property.system.service.impl;

import com.property.system.domain.Repair;
import com.property.system.dto.RepairRewardDTO;
import com.property.system.mapper.RepairRewardMapper;
import com.property.system.service.IRepairRewardService;
import com.property.system.utils.ExcelUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RepairRewardServiceImpl implements IRepairRewardService {

    @Autowired
    private RepairRewardMapper repairRewardMapper;

    @Override
    public List<RepairRewardDTO> selectRepairRewardList(Repair repair) {
        return repairRewardMapper.selectRepairRewardList(repair);
    }

    @Override
    public void exportRepairReward(Repair repair, HttpServletResponse response) {
        List<RepairRewardDTO> list = this.selectRepairRewardList(repair);

        if (list == null || list.isEmpty()) {
            throw new RuntimeException("没有可导出的数据");
        }

        // 准备导出数据
        String sheetName = "报修奖惩明细";
        String fileName = "报修奖惩明细.xlsx";
        String[] headers = {"工人姓名", "报修单编号", "打分", "评价", "完成时间", "报修项目", "奖惩类型", "奖惩金额", "备注"};
        String[] fields = {"workerName", "repairNo", "score", "evaluation", "completionTime", "repairTitle", "rewardType", "rewardAmount", "remark"};

        // 使用ExcelUtil导出
        try {
            ExcelUtil.exportExcel(response, list, fileName, sheetName, headers, fields);
        } catch (Exception e) {
            throw new RuntimeException("导出Excel失败: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Map<String, Object>> selectWorkerRewardStat(String workerName, String workerType,
                                                            String startTime, String endTime) {
        Map<String, Object> params = new HashMap<>();
        params.put("workerName", workerName);
        params.put("startTime", startTime);
        params.put("endTime", endTime);

        return repairRewardMapper.selectWorkerRewardStat(params);
    }

    @Override
    public void exportWorkerRewardStat(String workerName, String workerType,
                                       String startTime, String endTime, HttpServletResponse response) {
        List<Map<String, Object>> list = this.selectWorkerRewardStat(workerName, workerType, startTime, endTime);

        if (list == null || list.isEmpty()) {
            throw new RuntimeException("没有可导出的数据");
        }

        // 准备导出数据 - 注意：这里没有"工种"字段，数据库中没有工种信息
        String sheetName = "工人奖惩统计";
        String fileName = "工人奖惩统计.xlsx";
        String[] headers = {"工人姓名", "联系电话", "完成工单数", "平均评分", "奖励次数", "惩罚次数", "总奖励金额", "总惩罚金额", "奖惩合计"};

        // 使用ExcelUtil导出
        try {
            ExcelUtil.exportExcel(response, list, fileName, sheetName, headers);
        } catch (Exception e) {
            throw new RuntimeException("导出Excel失败: " + e.getMessage(), e);
        }
    }
}