package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.config.PropertyConfig;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.common.utils.file.FileUploadUtils;
import com.property.common.utils.file.FileUtils;
import com.property.system.domain.SysCarScan;
import com.property.system.domain.SysOwnerInfo;
import com.property.system.service.ISysCarScanService;
import com.property.system.service.ISysOwnerInfoService;
import com.property.system.utils.OcrUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * 车辆扫描信息 控制层
 */
@RestController
@RequestMapping("/system/carScan")
public class SysCarScanController extends BaseController {

    @Autowired
    private ISysCarScanService carScanService;

    @Autowired
    private ISysOwnerInfoService ownerInfoService; // 新增：注入业主信息服务

    /**
     * 获取车牌扫描记录列表
     */
    //@PreAuthorize("@ss.hasPermi('system:carScan:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysCarScan carScan) {
        startPage();
        List<SysCarScan> list = carScanService.selectCarScanList(carScan);
        return getDataTable(list);
    }

    @GetMapping("/listByUser")
    public TableDataInfo listByUser(SysCarScan carScan) {
        carScan.setUserId(getUserId());
        startPage();
        List<SysCarScan> list = carScanService.selectCarScanList(carScan);
        return getDataTable(list);
    }


    /**
     * 获取车牌扫描记录详细信息
     */
    //@PreAuthorize("@ss.hasPermi('system:carScan:query')")
    @GetMapping("/{scanId}")
    public AjaxResult getInfo(@PathVariable Long scanId) {
        return success(carScanService.selectCarScanById(scanId));
    }

    /**
     * 根据用户ID获取车牌扫描记录
     */
    //@PreAuthorize("@ss.hasPermi('system:carScan:query')")
    @GetMapping("/byUser")
    public AjaxResult getByUser() {
        return success(carScanService.selectCarScanByUserId(getUserId()));
    }

    /**
     * 根据车牌号查询车主信息
     */
    @GetMapping("/getOwnerByPlate")
    public AjaxResult getOwnerByPlate(@RequestParam String plateNum) {
        // 根据车牌号查询业主信息
        SysOwnerInfo ownerInfo = ownerInfoService.selectOwnerByPlateNum(plateNum);
        if (ownerInfo != null) {
            return success(ownerInfo);
        } else {
            return success(); // 返回空数据，前端判断为陌生车辆
        }
    }

    /**
     * 车辆入场接口
     */
    //@PreAuthorize("@ss.hasPermi('system:carScan:add')")
    @Log(title = "车辆扫描信息", businessType = BusinessType.INSERT)
    @PostMapping("/addEntryCar")
    public AjaxResult add(@Validated @RequestBody SysCarScan carScan) {
        carScan.setUserId(getUserId());
        return toAjax(carScanService.addEntryCar(carScan));
    }

    /**
     * 车辆出场接口
     */
    @Log(title = "车辆扫描信息", businessType = BusinessType.INSERT)
    @PostMapping("/exitCar")
    public AjaxResult exitCar(@Validated @RequestBody SysCarScan carScan) {
        carScan.setUserId(getUserId());
        return toAjax(carScanService.exitCar(carScan));
    }

    /**
     * 车牌识别接口 - 修改：添加车辆类型判断
     */
    @PostMapping("/carScan")
    public AjaxResult carScan(MultipartFile file) {
        if (file !=null && !file.isEmpty()) {
            try {
                //上传图片路径
                String filePath = PropertyConfig.getUploadPlatePath();
                String fileName = FileUploadUtils.upload(filePath, file);
                String newFileName = FileUtils.getName(fileName);
                Map<String, Object> plate = OcrUtil.plateLicense(PropertyConfig.getProfile() + fileName.replace("/profile", ""));
                if (plate.isEmpty()) {
                    return error("车牌识别失败，请联系管理员！");
                }

                SysCarScan sysCarScan = new SysCarScan();
                sysCarScan.setPicture(fileName);
                String plateNum = plate.get("number").toString();
                sysCarScan.setPlateNum(plateNum);
                sysCarScan.setPlateColor(plate.get("color").toString());

                // 新增：判断是否为已注册车辆
                SysOwnerInfo ownerInfo = ownerInfoService.selectOwnerByPlateNum(plateNum);
                if (ownerInfo != null) {
                    // 已注册车辆，type=1
                    sysCarScan.setType(1);
                } else {
                    // 未注册车辆，type=0
                    sysCarScan.setType(0);
                }

                return AjaxResult.success(sysCarScan);
            } catch (Exception e) {
                return AjaxResult.error(e.getMessage());
            }

        }
        return error("车牌识别失败，请联系管理员！");
    }


    /**
     * 修改车牌扫描记录
     */
    //@PreAuthorize("@ss.hasPermi('system:carScan:edit')")
    @Log(title = "车辆扫描信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysCarScan carScan) {
        carScan.setUserId(getUserId());
        return toAjax(carScanService.updateCarScan(carScan));
    }

    /**
     * 删除车牌扫描记录
     */
    //@PreAuthorize("@ss.hasPermi('system:carScan:remove')")
    @Log(title = "车辆扫描信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{scanIds}")
    public AjaxResult remove(@PathVariable Long[] scanIds) {
        return toAjax(carScanService.deleteCarScanByIds(scanIds));
    }
}