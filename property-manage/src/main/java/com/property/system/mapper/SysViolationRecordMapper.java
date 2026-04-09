package com.property.system.mapper;

import com.property.system.domain.SysViolationRecord;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 违规信息记录Mapper接口
 */
public interface SysViolationRecordMapper {

    /**
     * 按违规类型分组统计
     */
    List<Map<String, Object>> countViolationByType(@Param("beginTime") Date beginTime,
                                                   @Param("endTime") Date endTime);

    /**
     * 查询违规信息记录
     */
    List<SysViolationRecord> selectViolationList(SysViolationRecord violationRecord);

    /**
     * 查询所有违规信息记录
     */
    List<SysViolationRecord> selectViolationAll();

    /**
     * 通过违规ID查询违规信息记录
     */
    SysViolationRecord selectViolationById(Long violationId);

    /**
     * 通过车牌号查询违规信息记录
     */
    List<SysViolationRecord> selectViolationByPlateNum(String plateNum);

    /**
     * 新增违规信息记录
     */
    int insertViolation(SysViolationRecord violationRecord);

    /**
     * 修改违规信息记录
     */
    int updateViolation(SysViolationRecord violationRecord);

    /**
     * 删除违规信息记录
     */
    int deleteViolationById(Long violationId);

    /**
     * 批量删除违规信息记录
     */
    int deleteViolationByIds(Long[] violationIds);

    /**
     * 统计违规记录数量
     */
    int countViolationRecords(SysViolationRecord violationRecord);

    /**
     * 更新违规记录状态
     */
    int updateViolationStatus(@Param("violationId") Long violationId,
                              @Param("status") Integer status,
                              @Param("processorId") Long processorId,
                              @Param("updateBy") String updateBy);

    /**
     * 获取待处理违规数量
     */
    int countPendingViolations();
}