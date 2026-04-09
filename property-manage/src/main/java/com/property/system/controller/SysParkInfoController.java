package com.property.system.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.system.domain.SysParkInfo;
import com.property.system.service.ISysParkInfoService;

/**
 * 停车场信息操作处理
 */
@RestController
@RequestMapping("/system/parkInfo")
public class SysParkInfoController extends BaseController {

    @Autowired
    private ISysParkInfoService parkInfoService;

    /**
     * 获取停车场信息列表
     */
    //@PreAuthorize("@ss.hasPermi('system:parkInfo:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysParkInfo parkInfo) {
        startPage();
        List<SysParkInfo> list = parkInfoService.selectParkInfoList(parkInfo);
        return getDataTable(list);
    }

    /**
     * 获取所有未删除的停车场信息
     */
    //@PreAuthorize("@ss.hasPermi('system:parkInfo:list')")
    @GetMapping("/listActive")
    public AjaxResult listActiveParkInfo() {
        List<SysParkInfo> list = parkInfoService.selectActiveParkInfoList();
        return success(list);
    }

    /**
     * 根据停车场ID获取停车场信息
     */
    //@PreAuthorize("@ss.hasPermi('system:parkInfo:query')")
    @GetMapping("/{parkId}")
    public AjaxResult getInfo(@PathVariable Long parkId) {
        return success(parkInfoService.selectParkInfoById(parkId));
    }

    /**
     * 新增停车场信息
     */
   // @PreAuthorize("@ss.hasPermi('system:parkInfo:add')")
    @Log(title = "停车场信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysParkInfo parkInfo) {
        parkInfo.setCreateBy(getUsername());
        return toAjax(parkInfoService.insertParkInfo(parkInfo));
    }

    /**
     * 修改停车场信息
     */
    //@PreAuthorize("@ss.hasPermi('system:parkInfo:edit')")
    @Log(title = "停车场信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysParkInfo parkInfo) {
        parkInfo.setUpdateBy(getUsername());
        return toAjax(parkInfoService.updateParkInfo(parkInfo));
    }

    /**
     * 删除停车场信息
     */
    //@PreAuthorize("@ss.hasPermi('system:parkInfo:remove')")
    @Log(title = "停车场信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{parkIds}")
    public AjaxResult remove(@PathVariable Long[] parkIds) {
        return toAjax(parkInfoService.deleteParkInfoByIds(parkIds));
    }
}
