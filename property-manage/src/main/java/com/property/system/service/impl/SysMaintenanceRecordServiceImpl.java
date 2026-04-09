// property-manage/src/main/java/com/property/system/service/impl/SysMaintenanceRecordServiceImpl.java
package com.property.system.service.impl;

import com.property.system.domain.SysMaintenanceRecord;
import com.property.system.mapper.SysMaintenanceRecordMapper;
import com.property.system.service.ISysMaintenanceRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SysMaintenanceRecordServiceImpl implements ISysMaintenanceRecordService {

    @Autowired
    private SysMaintenanceRecordMapper maintenanceRecordMapper;

    @Override
    public List<SysMaintenanceRecord> selectMaintenanceRecordList(SysMaintenanceRecord record) {
        return maintenanceRecordMapper.selectMaintenanceRecordList(record);
    }

    @Override
    public SysMaintenanceRecord selectMaintenanceRecordById(Long recordId) {
        return maintenanceRecordMapper.selectMaintenanceRecordById(recordId);
    }

    @Override
    public int insertMaintenanceRecord(SysMaintenanceRecord record) {
        return maintenanceRecordMapper.insertMaintenanceRecord(record);
    }

    @Override
    public int updateMaintenanceRecord(SysMaintenanceRecord record) {
        return maintenanceRecordMapper.updateMaintenanceRecord(record);
    }

    @Override
    public int deleteMaintenanceRecordById(Long recordId) {
        return maintenanceRecordMapper.deleteMaintenanceRecordById(recordId);
    }

    @Override
    public int deleteMaintenanceRecordByIds(Long[] recordIds) {
        return maintenanceRecordMapper.deleteMaintenanceRecordByIds(recordIds);
    }
}