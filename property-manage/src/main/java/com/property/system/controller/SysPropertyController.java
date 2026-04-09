package com.property.system.controller;

import java.util.List;

import com.property.common.annotation.Log;
import com.property.common.config.PropertyConfig;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.common.utils.file.FileUploadUtils;
import com.property.common.utils.file.MimeTypeUtils;
import com.property.system.domain.SysPropertyInfo;
import com.property.system.service.IPropertyService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * 房产信息 控制层
 */
@RestController
@RequestMapping("/system/property")
public class SysPropertyController extends BaseController {

    @Autowired
    private IPropertyService propertyService;

    /**
     * 获取房产信息列表
     */
    //@PreAuthorize("@ss.hasPermi('system:property:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysPropertyInfo property) {
        startPage();
        List<SysPropertyInfo> list = propertyService.selectPropertyList(property);
        return getDataTable(list);
    }

    /**
     * 获取房产信息列表(已出租)，不分页
     */
    @GetMapping("/rentedList")
    public AjaxResult rentedList() {
        SysPropertyInfo sysPropertyInfo = new SysPropertyInfo();
        sysPropertyInfo.setStatus("0");
        List<SysPropertyInfo> sysPropertyInfos = propertyService.selectPropertyList(sysPropertyInfo);
        return AjaxResult.success(sysPropertyInfos);
    }

    /**
     * 获取房产信息列表，根据业主id
     */
    //@PreAuthorize("@ss.hasPermi('system:property:list')")
    @GetMapping("/listByOwnerId")
    public AjaxResult listByOwnerId(@RequestParam Long ownerId) {
        List<SysPropertyInfo> list = propertyService.selectPropertyListByOwnerId(ownerId);
        return AjaxResult.success("查询成功", list);
    }

    /**
     * 获取房产信息列表，根据userID查询
     */
    //@PreAuthorize("@ss.hasPermi('system:property:list')")
    @GetMapping("/listByUserId")
    public AjaxResult listByUserId(@RequestParam Long userId) {
        List<SysPropertyInfo> list = propertyService.selectPropertyListByUserId(userId);
        return AjaxResult.success("查询成功", list);
    }

    /**
     * 获取房产详细信息
     */
    //@PreAuthorize("@ss.hasPermi('system:property:query')")
    @GetMapping("/{propertyId}")
    public AjaxResult getInfo(@PathVariable Long propertyId) {
        return success(propertyService.selectPropertyById(propertyId));
    }

    /**
     * 新增房产信息
     */
    //@PreAuthorize("@ss.hasPermi('system:property:add')")
    @Log(title = "房产信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysPropertyInfo property) {
        property.setCreateBy(getUsername());
        return toAjax(propertyService.insertProperty(property));
    }

    /**
     * 修改房产信息
     */
    //@PreAuthorize("@ss.hasPermi('system:property:edit')")
    @Log(title = "房产信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysPropertyInfo property) {
        property.setUpdateBy(getUsername());
        return toAjax(propertyService.updateProperty(property));
    }

    /**
     * 删除房产信息
     */
    //@PreAuthorize("@ss.hasPermi('system:property:remove')")
    @Log(title = "房产信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{propertyIds}")
    public AjaxResult remove(@PathVariable Long[] propertyIds) {
        return toAjax(propertyService.deletePropertyByIds(propertyIds));
    }

    /**
     * 绑定业主
     */
    //@PreAuthorize("@ss.hasPermi('system:property:edit')")
    @Log(title = "房产信息", businessType = BusinessType.UPDATE)
    @PutMapping("/bindOwner")
    public AjaxResult bindOwner(@RequestBody SysPropertyInfo property) {
        //设置负责人
        property.setManager(getUsername());
        property.setManagerId(getUserId());
        return toAjax(propertyService.updatePropertyOwner(property));
    }

    /**
     * 修改房产状态
     */
    //@PreAuthorize("@ss.hasPermi('system:property:edit')")
    @Log(title = "房产信息", businessType = BusinessType.UPDATE)
    @PutMapping("/changeStatus")
    public AjaxResult changeStatus(@RequestParam("propertyId") Long propertyId, @RequestParam("status") String status) {
        return toAjax(propertyService.updatePropertyStatus(propertyId, status));
    }


    @PostMapping("/uploadImage")
    public AjaxResult uploadImage(@RequestParam("propertyImage") MultipartFile file,@RequestParam("propertyId") Long propertyId) throws Exception {
        if (!file.isEmpty()) {
            String imageUrl = FileUploadUtils.upload(PropertyConfig.getUploadPath(), file, MimeTypeUtils.IMAGE_EXTENSION);
            propertyService.updatePropertyImageUrl(propertyId,imageUrl);
            AjaxResult ajax = AjaxResult.success();
            ajax.put("imgUrl", imageUrl);
            return ajax;
        }
        return error("上传房产图片失败，请联系管理员");
    }


}