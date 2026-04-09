package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.common.utils.poi.ExcelUtil;
import com.property.system.domain.IncomeDetail;
import com.property.system.service.IIncomeDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/investment/income")
public class IncomeDetailController extends BaseController {
    @Autowired
    private IIncomeDetailService incomeDetailService;

    /**
     * 查询收益明细列表
     */
    @PreAuthorize("@ss.hasPermi('investment:income:list')")
    @GetMapping("/list")
    public TableDataInfo list(IncomeDetail incomeDetail) {
        startPage();
        List<IncomeDetail> list = incomeDetailService.selectIncomeDetailList(incomeDetail);
        return getDataTable(list);
    }

    /**
     * 导出收益明细列表
     */
    @PreAuthorize("@ss.hasPermi('investment:income:export')")
    @Log(title = "收益明细", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(IncomeDetail incomeDetail) {
        List<IncomeDetail> list = incomeDetailService.selectIncomeDetailList(incomeDetail);
        ExcelUtil<IncomeDetail> util = new ExcelUtil<>(IncomeDetail.class);
        return util.exportExcel(list, "收益明细数据");
    }

    /**
     * 获取收益明细详细信息
     */
    @PreAuthorize("@ss.hasPermi('investment:income:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(incomeDetailService.selectIncomeDetailById(id));
    }

    /**
     * 新增收益明细
     */
    @PreAuthorize("@ss.hasPermi('investment:income:add')")
    @Log(title = "收益明细", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody IncomeDetail incomeDetail) {
        incomeDetail.setCreateBy(getUsername());
        return toAjax(incomeDetailService.insertIncomeDetail(incomeDetail));
    }

    /**
     * 修改收益明细
     */
    @PreAuthorize("@ss.hasPermi('investment:income:edit')")
    @Log(title = "收益明细", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody IncomeDetail incomeDetail) {
        incomeDetail.setUpdateBy(getUsername());
        return toAjax(incomeDetailService.updateIncomeDetail(incomeDetail));
    }

    /**
     * 删除收益明细
     */
    @PreAuthorize("@ss.hasPermi('investment:income:remove')")
    @Log(title = "收益明细", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(incomeDetailService.deleteIncomeDetailByIds(ids));
    }
}