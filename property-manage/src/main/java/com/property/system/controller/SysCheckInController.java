package com.property.system.controller;

import java.util.List;

import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.property.system.domain.SysCheckIn;
import com.property.system.service.ISysCheckInService;

/**
 * 入住登记Controller
 *
 * @author property
 * @date 2026-01-20
 */
@RestController
@RequestMapping("/property/checkin")
public class SysCheckInController extends BaseController
{
    @Autowired
    private ISysCheckInService sysCheckInService;

    /**
     * 查询入住登记列表
     */
    @GetMapping("/list")
    public TableDataInfo list(SysCheckIn sysCheckIn)
    {
        startPage();
        List<SysCheckIn> list = sysCheckInService.selectSysCheckInList(sysCheckIn);
        return getDataTable(list);
    }

    /**
     * 获取入住登记详细信息
     */
    @GetMapping(value = "/{checkInId}")
    public AjaxResult getInfo(@PathVariable("checkInId") Long checkInId)
    {
        return success(sysCheckInService.selectSysCheckInByCheckInId(checkInId));
    }

    /**
     * 新增入住登记
     */
    @PostMapping
    public AjaxResult add(@RequestBody SysCheckIn sysCheckIn)
    {
        return toAjax(sysCheckInService.insertSysCheckIn(sysCheckIn));
    }

    /**
     * 修改入住登记
     */
    @PutMapping
    public AjaxResult edit(@RequestBody SysCheckIn sysCheckIn)
    {
        return toAjax(sysCheckInService.updateSysCheckIn(sysCheckIn));
    }

    /**
     * 删除入住登记
     */
    @DeleteMapping("/{checkInIds}")
    public AjaxResult remove(@PathVariable Long[] checkInIds)
    {
        return toAjax(sysCheckInService.deleteSysCheckInByCheckInIds(checkInIds));
    }

    /**
     * 获取所有入住登记列表（不分页）
     */
    @GetMapping("/listAll")
    public AjaxResult listAll(SysCheckIn sysCheckIn)
    {
        List<SysCheckIn> list = sysCheckInService.selectSysCheckInList(sysCheckIn);
        return success(list);
    }
}