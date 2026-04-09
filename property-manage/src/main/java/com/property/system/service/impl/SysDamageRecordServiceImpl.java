// property-manage/src/main/java/com/property/system/service/impl/SysDamageRecordServiceImpl.java
package com.property.system.service.impl;

import com.property.system.domain.SysDamageRecord;
import com.property.system.mapper.SysDamageRecordMapper;
import com.property.system.service.ISysDamageRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SysDamageRecordServiceImpl implements ISysDamageRecordService {

    @Autowired
    private SysDamageRecordMapper damageRecordMapper;

    @Override
    public List<SysDamageRecord> selectDamageRecordList(SysDamageRecord record) {
        return damageRecordMapper.selectDamageRecordList(record);
    }

    @Override
    public SysDamageRecord selectDamageRecordById(Long damageId) {
        return damageRecordMapper.selectDamageRecordById(damageId);
    }

    @Override
    public int insertDamageRecord(SysDamageRecord record) {
        return damageRecordMapper.insertDamageRecord(record);
    }

    @Override
    public int updateDamageRecord(SysDamageRecord record) {
        return damageRecordMapper.updateDamageRecord(record);
    }

    @Override
    public int deleteDamageRecordById(Long damageId) {
        return damageRecordMapper.deleteDamageRecordById(damageId);
    }

    @Override
    public int deleteDamageRecordByIds(Long[] damageIds) {
        return damageRecordMapper.deleteDamageRecordByIds(damageIds);
    }
}