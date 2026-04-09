package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.common.utils.poi.ExcelUtil;
import com.property.system.domain.OwnerWelfare;
import com.property.system.service.IOwnerWelfareService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/investment/welfare")
public class OwnerWelfareController extends BaseController {
    @Autowired
    private IOwnerWelfareService ownerWelfareService;

    /**
     * 查询业主福利申领列表
     */
    @PreAuthorize("@ss.hasPermi('investment:welfare:list')")
    @GetMapping("/list")
    public TableDataInfo list(OwnerWelfare ownerWelfare) {
        startPage();
        List<OwnerWelfare> list = ownerWelfareService.selectOwnerWelfareList(ownerWelfare);
        return getDataTable(list);
    }

    /**
     * 导出业主福利申领列表
     */
    @PreAuthorize("@ss.hasPermi('investment:welfare:export')")
    @Log(title = "业主福利申领", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(OwnerWelfare ownerWelfare) {
        List<OwnerWelfare> list = ownerWelfareService.selectOwnerWelfareList(ownerWelfare);
        ExcelUtil<OwnerWelfare> util = new ExcelUtil<>(OwnerWelfare.class);
        return util.exportExcel(list, "业主福利申领数据");
    }

    /**
     * 获取业主福利申领详细信息
     */
    @PreAuthorize("@ss.hasPermi('investment:welfare:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(ownerWelfareService.selectOwnerWelfareById(id));
    }

    /**
     * 新增业主福利申领
     */
    @PreAuthorize("@ss.hasPermi('investment:welfare:add')")
    @Log(title = "业主福利申领", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody OwnerWelfare ownerWelfare) {
        ownerWelfare.setCreateBy(getUsername());
        return toAjax(ownerWelfareService.insertOwnerWelfare(ownerWelfare));
    }

    /**
     * 修改业主福利申领
     */
    @PreAuthorize("@ss.hasPermi('investment:welfare:edit')")
    @Log(title = "业主福利申领", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody OwnerWelfare ownerWelfare) {
        ownerWelfare.setUpdateBy(getUsername());
        return toAjax(ownerWelfareService.updateOwnerWelfare(ownerWelfare));
    }

    /**
     * 删除业主福利申领
     */
    @PreAuthorize("@ss.hasPermi('investment:welfare:remove')")
    @Log(title = "业主福利申领", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(ownerWelfareService.deleteOwnerWelfareByIds(ids));
    }
}