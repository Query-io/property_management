package com.property.system.service.impl;

import com.property.common.core.text.Convert;
import com.property.common.utils.DateUtils;
import com.property.common.utils.SecurityUtils;
import com.property.system.domain.SysViolationRecord;
import com.property.system.mapper.SysViolationRecordMapper;
import com.property.system.service.ISysViolationRecordService;
import com.property.system.utils.ViolationDateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 违规信息记录 服务层实现
 */
@Service
public class SysViolationRecordServiceImpl implements ISysViolationRecordService {

    @Autowired
    private SysViolationRecordMapper violationRecordMapper;

    @Override
    public List<SysViolationRecord> selectViolationList(SysViolationRecord violationRecord) {
        return violationRecordMapper.selectViolationList(violationRecord);
    }

    @Override
    public SysViolationRecord selectViolationById(Long violationId) {
        return violationRecordMapper.selectViolationById(violationId);
    }

    @Override
    public int insertViolation(SysViolationRecord violationRecord) {
        violationRecord.setCreateTime(DateUtils.getNowDate());
        violationRecord.setCreateBy(SecurityUtils.getUsername());
        return violationRecordMapper.insertViolation(violationRecord);
    }

    @Override
    public int updateViolation(SysViolationRecord violationRecord) {
        violationRecord.setUpdateTime(DateUtils.getNowDate());
        violationRecord.setUpdateBy(SecurityUtils.getUsername());
        return violationRecordMapper.updateViolation(violationRecord);
    }

    @Override
    public int deleteViolationByIds(Long[] violationIds) {
        return violationRecordMapper.deleteViolationByIds(violationIds);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int processViolation(Long violationId, Long processorId) {
        // 检查记录是否存在且未处理
        SysViolationRecord record = violationRecordMapper.selectViolationById(violationId);
        if (record == null) {
            throw new RuntimeException("违规记录不存在");
        }
        if (record.getStatus() != 0) {
            throw new RuntimeException("该记录已处理或已撤销");
        }

        // 获取当前登录用户名
        String updateBy = SecurityUtils.getUsername();

        // 更新状态为已处理
        return violationRecordMapper.updateViolationStatus(violationId, 1, processorId, updateBy);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int cancelViolation(Long violationId) {
        // 检查记录是否存在
        SysViolationRecord record = violationRecordMapper.selectViolationById(violationId);
        if (record == null) {
            throw new RuntimeException("违规记录不存在");
        }

        // 获取当前登录用户ID和用户名
        Long processorId = SecurityUtils.getUserId();
        String updateBy = SecurityUtils.getUsername();

        // 更新状态为已撤销
        return violationRecordMapper.updateViolationStatus(violationId, 2, processorId, updateBy);
    }

    @Override
    public List<SysViolationRecord> selectViolationExport(SysViolationRecord violationRecord) {
        return violationRecordMapper.selectViolationList(violationRecord);
    }

    @Override
    public List<Map<String, Object>> getViolationStatistics() {
        List<Map<String, Object>> statistics = new ArrayList<>();

        // 获取当月统计数据
        Date now = new Date();
        Date startOfMonth = ViolationDateUtils.getMonthStart(now);
        Date endOfMonth = ViolationDateUtils.getMonthEnd(now);

        // 统计各类违规数量
        List<Map<String, Object>> typeStats = violationRecordMapper.countViolationByType(startOfMonth, endOfMonth);

        // 统计处理状态
        Map<String, Object> statusStats = new HashMap<>();

        // 统计未处理数量
        int pendingCount = violationRecordMapper.countPendingViolations();

        // 统计已处理数量
        SysViolationRecord query = new SysViolationRecord();
        query.setBeginTime(startOfMonth);
        query.setEndTime(endOfMonth);
        query.setStatus(1);
        int processedCount = violationRecordMapper.countViolationRecords(query);

        // 统计已撤销数量
        query.setStatus(2);
        int cancelledCount = violationRecordMapper.countViolationRecords(query);

        statusStats.put("pending", pendingCount);
        statusStats.put("processed", processedCount);
        statusStats.put("cancelled", cancelledCount);

        // 构建返回数据
        Map<String, Object> typeMap = new HashMap<>();
        typeMap.put("type", "violationTypeStats");
        typeMap.put("data", typeStats);
        statistics.add(typeMap);

        Map<String, Object> statusMap = new HashMap<>();
        statusMap.put("type", "statusStats");
        statusMap.put("data", statusStats);
        statistics.add(statusMap);

        return statistics;
    }

    @Override
    public List<SysViolationRecord> selectViolationByPlateNum(String plateNum) {
        return violationRecordMapper.selectViolationByPlateNum(plateNum);
    }
}