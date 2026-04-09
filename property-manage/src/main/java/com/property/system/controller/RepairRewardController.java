package com.property.system.controller;

import com.property.system.domain.Repair;
import com.property.system.dto.RepairRewardDTO;
import com.property.system.service.IRepairRewardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/system/repair/reward")
public class RepairRewardController {

    @Autowired
    private IRepairRewardService repairRewardService;

    /**
     * 导出报修奖惩信息
     * POST /system/repair/reward/export
     */
    @PostMapping("/export")
    public void export(@RequestBody Map<String, Object> params, HttpServletResponse response) {
        // 将Map参数转换为Repair对象
        Repair repair = convertMapToRepair(params);
        repairRewardService.exportRepairReward(repair, response);
    }

    /**
     * 导出工人奖惩统计
     * POST /system/repair/reward/exportStat
     */
    @PostMapping("/exportStat")
    public void exportStat(@RequestBody Map<String, Object> params, HttpServletResponse response) {
        // 提取参数
        String workerName = (String) params.get("workerName");
        String workerType = (String) params.get("workerType");
        String startTime = (String) params.get("beginTime");
        String endTime = (String) params.get("endTime");

        repairRewardService.exportWorkerRewardStat(workerName, workerType, startTime, endTime, response);
    }

    /**
     * 将Map转换为Repair对象
     */
    private Repair convertMapToRepair(Map<String, Object> params) {
        Repair repair = new Repair();

        if (params == null) {
            return repair;
        }

        // 设置工人姓名
        if (params.containsKey("workerName")) {
            repair.setWorkerName((String) params.get("workerName"));
        }

        // 设置报修单编号
        if (params.containsKey("repairNo")) {
            repair.setRepairNo((String) params.get("repairNo"));
        }

        // 设置开始时间
        if (params.containsKey("beginTime")) {
            String beginTimeStr = (String) params.get("beginTime");
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date beginTime = sdf.parse(beginTimeStr);
                repair.setBeginTime(beginTime);
            } catch (ParseException e) {
                // 解析失败，不设置时间
                e.printStackTrace();
            }
        }

        // 设置结束时间
        if (params.containsKey("endTime")) {
            String endTimeStr = (String) params.get("endTime");
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date endTime = sdf.parse(endTimeStr);
                repair.setEndTime(endTime);
            } catch (ParseException e) {
                // 解析失败，不设置时间
                e.printStackTrace();
            }
        }

        // 设置评分
        if (params.containsKey("score")) {
            repair.setScore(Integer.parseInt(params.get("score").toString()));
        }

        return repair;
    }
}