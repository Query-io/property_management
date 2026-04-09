// property-manage/src/main/java/com/property/system/controller/SysDamageRecordController.java
package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.system.domain.SysDamageRecord;
import com.property.system.service.ISysDamageRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 损坏报废登记Controller
 */
@RestController
@RequestMapping("/system/damage")
public class SysDamageRecordController extends BaseController {

    @Autowired
    private ISysDamageRecordService damageRecordService;

    /**
     * 查询损坏报废登记列表
     */
    @PreAuthorize("@ss.hasPermi('system:damage:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysDamageRecord damageRecord) {
        startPage();
        List<SysDamageRecord> list = damageRecordService.selectDamageRecordList(damageRecord);
        return getDataTable(list);
    }

    /**
     * 获取损坏报废登记详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:damage:query')")
    @GetMapping("/{damageId}")
    public AjaxResult getInfo(@PathVariable Long damageId) {
        return success(damageRecordService.selectDamageRecordById(damageId));
    }

    /**
     * 新增损坏报废登记
     */
    @PreAuthorize("@ss.hasPermi('system:damage:add')")
    @Log(title = "损坏报废登记", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysDamageRecord damageRecord) {
        damageRecord.setCreateBy(getUsername());
        return toAjax(damageRecordService.insertDamageRecord(damageRecord));
    }

    /**
     * 修改损坏报废登记
     */
    @PreAuthorize("@ss.hasPermi('system:damage:edit')")
    @Log(title = "损坏报废登记", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysDamageRecord damageRecord) {
        damageRecord.setUpdateBy(getUsername());
        return toAjax(damageRecordService.updateDamageRecord(damageRecord));
    }

    /**
     * 删除损坏报废登记
     */
    @PreAuthorize("@ss.hasPermi('system:damage:remove')")
    @Log(title = "损坏报废登记", businessType = BusinessType.DELETE)
    @DeleteMapping("/{damageIds}")
    public AjaxResult remove(@PathVariable Long[] damageIds) {
        return toAjax(damageRecordService.deleteDamageRecordByIds(damageIds));
    }
}