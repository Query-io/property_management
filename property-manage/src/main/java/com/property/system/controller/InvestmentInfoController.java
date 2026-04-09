package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.common.utils.poi.ExcelUtil;
import com.property.system.domain.InvestmentInfo;
import com.property.system.service.IInvestmentInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/investment/info")
public class InvestmentInfoController extends BaseController {
    @Autowired
    private IInvestmentInfoService investmentInfoService;

    /**
     * 查询招商信息列表
     * 允许所有已登录用户访问（无需特定权限）
     */
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/list")
    public TableDataInfo list(InvestmentInfo investmentInfo) {
        startPage();
        List<InvestmentInfo> list = investmentInfoService.selectInvestmentInfoList(investmentInfo);
        return getDataTable(list);
    }

    /**
     * 导出招商信息列表
     */
    @PreAuthorize("@ss.hasPermi('investment:info:export')")
    @Log(title = "招商信息", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(InvestmentInfo investmentInfo) {
        List<InvestmentInfo> list = investmentInfoService.selectInvestmentInfoList(investmentInfo);
        ExcelUtil<InvestmentInfo> util = new ExcelUtil<>(InvestmentInfo.class);
        return util.exportExcel(list, "招商信息数据");
    }

    /**
     * 获取招商信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('investment:info:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(investmentInfoService.selectInvestmentInfoById(id));
    }

    /**
     * 新增招商信息
     */
    @PreAuthorize("@ss.hasPermi('investment:info:add')")
    @Log(title = "招商信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody InvestmentInfo investmentInfo) {
        investmentInfo.setCreateBy(getUsername());
        return toAjax(investmentInfoService.insertInvestmentInfo(investmentInfo));
    }

    /**
     * 修改招商信息
     */
    @PreAuthorize("@ss.hasPermi('investment:info:edit')")
    @Log(title = "招商信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody InvestmentInfo investmentInfo) {
        investmentInfo.setUpdateBy(getUsername());
        return toAjax(investmentInfoService.updateInvestmentInfo(investmentInfo));
    }

    /**
     * 删除招商信息
     */
    @PreAuthorize("@ss.hasPermi('investment:info:remove')")
    @Log(title = "招商信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(investmentInfoService.deleteInvestmentInfoByIds(ids));
    }
}