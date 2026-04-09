// property-manage/src/main/java/com/property/system/controller/SysMaintenanceRecordController.java
package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.system.domain.SysMaintenanceRecord;
import com.property.system.service.ISysMaintenanceRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 维修维护记录Controller
 */
@RestController
@RequestMapping("/system/maintenance")
public class SysMaintenanceRecordController extends BaseController {

    @Autowired
    private ISysMaintenanceRecordService maintenanceRecordService;

    /**
     * 查询维修维护记录列表
     */
    @PreAuthorize("@ss.hasPermi('system:maintenance:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysMaintenanceRecord maintenanceRecord) {
        startPage();
        List<SysMaintenanceRecord> list = maintenanceRecordService.selectMaintenanceRecordList(maintenanceRecord);
        return getDataTable(list);
    }

    /**
     * 获取维修维护记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:maintenance:query')")
    @GetMapping("/{recordId}")
    public AjaxResult getInfo(@PathVariable Long recordId) {
        return success(maintenanceRecordService.selectMaintenanceRecordById(recordId));
    }

    /**
     * 新增维修维护记录
     */
    @PreAuthorize("@ss.hasPermi('system:maintenance:add')")
    @Log(title = "维修维护记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysMaintenanceRecord maintenanceRecord) {
        maintenanceRecord.setCreateBy(getUsername());
        return toAjax(maintenanceRecordService.insertMaintenanceRecord(maintenanceRecord));
    }

    /**
     * 修改维修维护记录
     */
    @PreAuthorize("@ss.hasPermi('system:maintenance:edit')")
    @Log(title = "维修维护记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysMaintenanceRecord maintenanceRecord) {
        maintenanceRecord.setUpdateBy(getUsername());
        return toAjax(maintenanceRecordService.updateMaintenanceRecord(maintenanceRecord));
    }

    /**
     * 删除维修维护记录
     */
    @PreAuthorize("@ss.hasPermi('system:maintenance:remove')")
    @Log(title = "维修维护记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{recordIds}")
    public AjaxResult remove(@PathVariable Long[] recordIds) {
        return toAjax(maintenanceRecordService.deleteMaintenanceRecordByIds(recordIds));
    }
}