package com.property.system.service;

import com.property.system.domain.SysViolationRecord;
import java.util.List;
import java.util.Map;

/**
 * 违规信息记录 服务层接口
 */
public interface ISysViolationRecordService {
    /**
     * 查询违规信息记录
     */
    List<SysViolationRecord> selectViolationList(SysViolationRecord violationRecord);

    /**
     * 查询违规信息记录详情
     */
    SysViolationRecord selectViolationById(Long violationId);

    /**
     * 新增违规信息记录
     */
    int insertViolation(SysViolationRecord violationRecord);

    /**
     * 修改违规信息记录
     */
    int updateViolation(SysViolationRecord violationRecord);

    /**
     * 批量删除违规信息记录
     */
    int deleteViolationByIds(Long[] violationIds);

    /**
     * 处理违规记录
     */
    int processViolation(Long violationId, Long processorId);

    /**
     * 撤销违规记录
     */
    int cancelViolation(Long violationId);

    /**
     * 导出违规记录
     */
    List<SysViolationRecord> selectViolationExport(SysViolationRecord violationRecord);

    /**
     * 获取统计数据
     */
    List<Map<String, Object>> getViolationStatistics();

    /**
     * 根据车牌号查询违规记录
     */
    List<SysViolationRecord> selectViolationByPlateNum(String plateNum);
}