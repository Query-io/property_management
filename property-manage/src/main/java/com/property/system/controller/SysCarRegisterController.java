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
import com.property.system.domain.SysCarRegister;
import com.property.system.service.ISysCarRegisterService;

/**
 * 车辆登记Controller
 *
 * @author property
 * @date 2026-01-20
 */
@RestController
@RequestMapping("/car/register")
public class SysCarRegisterController extends BaseController
{
    @Autowired
    private ISysCarRegisterService sysCarRegisterService;

    /**
     * 查询车辆登记列表
     */
    @GetMapping("/list")
    public TableDataInfo list(SysCarRegister sysCarRegister)
    {
        startPage();
        List<SysCarRegister> list = sysCarRegisterService.selectSysCarRegisterList(sysCarRegister);
        return getDataTable(list);
    }

    /**
     * 获取车辆登记详细信息
     */
    @GetMapping(value = "/{carId}")
    public AjaxResult getInfo(@PathVariable("carId") Long carId)
    {
        return success(sysCarRegisterService.selectSysCarRegisterByCarId(carId));
    }

    /**
     * 新增车辆登记
     */
    @PostMapping
    public AjaxResult add(@RequestBody SysCarRegister sysCarRegister)
    {
        // 检查车牌号是否已存在
        SysCarRegister existCar = sysCarRegisterService.selectSysCarRegisterByPlateNumber(sysCarRegister.getPlateNumber());
        if (existCar != null) {
            return error("车牌号 " + sysCarRegister.getPlateNumber() + " 已存在");
        }
        return toAjax(sysCarRegisterService.insertSysCarRegister(sysCarRegister));
    }

    /**
     * 修改车辆登记
     */
    @PutMapping
    public AjaxResult edit(@RequestBody SysCarRegister sysCarRegister)
    {
        return toAjax(sysCarRegisterService.updateSysCarRegister(sysCarRegister));
    }

    /**
     * 删除车辆登记
     */
    @DeleteMapping("/{carIds}")
    public AjaxResult remove(@PathVariable Long[] carIds)
    {
        return toAjax(sysCarRegisterService.deleteSysCarRegisterByCarIds(carIds));
    }

    /**
     * 根据车牌号查询车辆信息
     */
    @GetMapping("/plate/{plateNumber}")
    public AjaxResult getByPlateNumber(@PathVariable String plateNumber)
    {
        SysCarRegister car = sysCarRegisterService.selectSysCarRegisterByPlateNumber(plateNumber);
        return success(car);
    }
}