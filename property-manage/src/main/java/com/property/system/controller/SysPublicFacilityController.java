package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.system.domain.SysPublicFacility;
import com.property.system.service.ISysPublicFacilityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 公共设施信息Controller
 */
@RestController
@RequestMapping("/system/facility")
public class SysPublicFacilityController extends BaseController {

    @Autowired
    private ISysPublicFacilityService facilityService;

    /**
     * 查询公共设施信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:facility:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysPublicFacility facility) {
        startPage();
        List<SysPublicFacility> list = facilityService.selectFacilityList(facility);
        return getDataTable(list);
    }

    /**
     * 获取公共设施信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:facility:query')")
    @GetMapping("/{facilityId}")
    public AjaxResult getInfo(@PathVariable Long facilityId) {
        return success(facilityService.selectFacilityById(facilityId));
    }

    /**
     * 新增公共设施信息
     */
    @PreAuthorize("@ss.hasPermi('system:facility:add')")
    @Log(title = "公共设施信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysPublicFacility facility) {
        facility.setCreateBy(getUsername());
        return toAjax(facilityService.insertFacility(facility));
    }

    /**
     * 修改公共设施信息
     */
    @PreAuthorize("@ss.hasPermi('system:facility:edit')")
    @Log(title = "公共设施信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysPublicFacility facility) {
        facility.setUpdateBy(getUsername());
        return toAjax(facilityService.updateFacility(facility));
    }

    /**
     * 删除公共设施信息
     */
    @PreAuthorize("@ss.hasPermi('system:facility:remove')")
    @Log(title = "公共设施信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{facilityIds}")
    public AjaxResult remove(@PathVariable Long[] facilityIds) {
        return toAjax(facilityService.deleteFacilityByIds(facilityIds));
    }
}