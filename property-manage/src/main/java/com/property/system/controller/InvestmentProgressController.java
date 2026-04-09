package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.common.utils.poi.ExcelUtil;
import com.property.system.domain.InvestmentProgress;
import com.property.system.service.IInvestmentProgressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/investment/progress")
public class InvestmentProgressController extends BaseController {
    @Autowired
    private IInvestmentProgressService investmentProgressService;

    /**
     * 查询招商进度列表
     */
    @PreAuthorize("@ss.hasPermi('investment:progress:list')")
    @GetMapping("/list")
    public TableDataInfo list(InvestmentProgress investmentProgress) {
        startPage();
        List<InvestmentProgress> list = investmentProgressService.selectInvestmentProgressList(investmentProgress);
        return getDataTable(list);
    }

    /**
     * 导出招商进度列表
     */
    @PreAuthorize("@ss.hasPermi('investment:progress:export')")
    @Log(title = "招商进度", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(InvestmentProgress investmentProgress) {
        List<InvestmentProgress> list = investmentProgressService.selectInvestmentProgressList(investmentProgress);
        ExcelUtil<InvestmentProgress> util = new ExcelUtil<>(InvestmentProgress.class);
        return util.exportExcel(list, "招商进度数据");
    }

    /**
     * 获取招商进度详细信息
     */
    @PreAuthorize("@ss.hasPermi('investment:progress:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(investmentProgressService.selectInvestmentProgressById(id));
    }

    /**
     * 新增招商进度
     */
    @PreAuthorize("@ss.hasPermi('investment:progress:add')")
    @Log(title = "招商进度", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody InvestmentProgress investmentProgress) {
        investmentProgress.setCreateBy(getUsername());
        return toAjax(investmentProgressService.insertInvestmentProgress(investmentProgress));
    }

    /**
     * 修改招商进度
     */
    @PreAuthorize("@ss.hasPermi('investment:progress:edit')")
    @Log(title = "招商进度", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody InvestmentProgress investmentProgress) {
        investmentProgress.setUpdateBy(getUsername());
        return toAjax(investmentProgressService.updateInvestmentProgress(investmentProgress));
    }

    /**
     * 删除招商进度
     */
    @PreAuthorize("@ss.hasPermi('investment:progress:remove')")
    @Log(title = "招商进度", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(investmentProgressService.deleteInvestmentProgressByIds(ids));
    }
}