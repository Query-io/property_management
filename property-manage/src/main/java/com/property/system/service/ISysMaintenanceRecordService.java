// property-manage/src/main/java/com/property/system/service/ISysMaintenanceRecordService.java
package com.property.system.service;

import com.property.system.domain.SysMaintenanceRecord;
import java.util.List;

public interface ISysMaintenanceRecordService {
    /**
     * 查询维修维护记录列表
     */
    List<SysMaintenanceRecord> selectMaintenanceRecordList(SysMaintenanceRecord record);

    /**
     * 查询维修维护记录
     */
    SysMaintenanceRecord selectMaintenanceRecordById(Long recordId);

    /**
     * 新增维修维护记录
     */
    int insertMaintenanceRecord(SysMaintenanceRecord record);

    /**
     * 修改维修维护记录
     */
    int updateMaintenanceRecord(SysMaintenanceRecord record);

    /**
     * 删除维修维护记录
     */
    int deleteMaintenanceRecordById(Long recordId);

    /**
     * 批量删除维修维护记录
     */
    int deleteMaintenanceRecordByIds(Long[] recordIds);
}