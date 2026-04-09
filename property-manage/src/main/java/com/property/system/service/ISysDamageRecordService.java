package com.property.system.service;

import com.property.system.domain.SysDamageRecord;
import java.util.List;

public interface ISysDamageRecordService {
    /**
     * 查询损坏报废登记列表
     */
    List<SysDamageRecord> selectDamageRecordList(SysDamageRecord record);

    /**
     * 查询损坏报废登记
     */
    SysDamageRecord selectDamageRecordById(Long damageId);

    /**
     * 新增损坏报废登记
     */
    int insertDamageRecord(SysDamageRecord record);

    /**
     * 修改损坏报废登记
     */
    int updateDamageRecord(SysDamageRecord record);

    /**
     * 删除损坏报废登记
     */
    int deleteDamageRecordById(Long damageId);

    /**
     * 批量删除损坏报废登记
     */
    int deleteDamageRecordByIds(Long[] damageIds);
}