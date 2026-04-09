package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.system.domain.SysOwnerInfo;
import com.property.system.service.ISysOwnerInfoService;
import com.property.system.service.ISysOwnerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 业主信息 控制层
 */
@RestController
@RequestMapping("/system/owner")
public class SysOwnerController extends BaseController {

    @Autowired
    private ISysOwnerService ownerService;

    /**
     * 获取业主信息列表
     */
    //@PreAuthorize("@ss.hasPermi('system:owner:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysOwnerInfo owner) {
        startPage();
        List<SysOwnerInfo> list = ownerService.selectOwnerList(owner);
        return getDataTable(list);
    }

    /**
     * 获取业主详细信息
     */
    //@PreAuthorize("@ss.hasPermi('system:owner:query')")
    @GetMapping("/{ownerId}")
    public AjaxResult getInfo(@PathVariable Long ownerId) {
        return success(ownerService.selectOwnerById(ownerId));
    }

    /**
     * 根据用户ID获取业主信息
     */
    //@PreAuthorize("@ss.hasPermi('system:owner:query')")
    @GetMapping("/byUser")
    public AjaxResult getByUser() {
        return success(ownerService.selectOwnerByUserId(getUserId()));
    }

    /**
     * 新增业主信息
     */
    //@PreAuthorize("@ss.hasPermi('system:owner:add')")
    @Log(title = "业主信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysOwnerInfo owner) {
        owner.setUserId(getUserId());
        owner.setOwnerName(getUsername());
        owner.setCreateBy(getUsername());
        return toAjax(ownerService.insertOwner(owner));
    }

    /**
     * 修改业主信息
     */
    //@PreAuthorize("@ss.hasPermi('system:owner:edit')")
    @Log(title = "业主信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysOwnerInfo owner) {
        owner.setUpdateBy(getUsername());
        return toAjax(ownerService.updateOwner(owner));
    }

    /**
     * 删除业主信息
     */
    //@PreAuthorize("@ss.hasPermi('system:owner:remove')")
    @Log(title = "业主信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ownerIds}")
    public AjaxResult remove(@PathVariable Integer[] ownerIds) {
        return toAjax(ownerService.deleteOwnerByIds(ownerIds));
    }

    /**
     * 获取所有业主信息列表（不分页）
     */
    //@PreAuthorize("@ss.hasPermi('system:owner:list')")
    @GetMapping("/listAll")
    public AjaxResult listAll() {
        List<SysOwnerInfo> list = ownerService.selectOwnerList(new SysOwnerInfo());
        return AjaxResult.success("查询成功", list);
    }
}
