package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.config.PropertyConfig;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.common.exception.file.InvalidExtensionException;
import com.property.common.utils.file.FileUploadUtils;
import com.property.common.utils.file.MimeTypeUtils;
import com.property.system.domain.SysPropertyRepair;
import com.property.system.dto.RepairRateDTO;
import com.property.system.service.ISysPropertyRepairService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * 物业维修单控制器
 */
@RestController
@RequestMapping("/system/repair")
public class SysPropertyRepairController extends BaseController {

    @Autowired
    private ISysPropertyRepairService repairService;

    /**
     * 查询物业维修单列表
     */
    //@PreAuthorize("@ss.hasPermi('system:repair:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysPropertyRepair repair) {
        startPage();
        List<SysPropertyRepair> list = repairService.selectSysPropertyRepairList(repair);
        return getDataTable(list);
    }

    /**
     * 查询处理完成的维修单（用于生成账单）
     */
    //@PreAuthorize("@ss.hasPermi('system:repair:list')")
    @GetMapping("/listDeal")
    public AjaxResult listDealRepairs() {
        List<SysPropertyRepair> list = repairService.selectDealSysPropertyRepairList();
        return success(list);
    }

    /**
     * 获取单个维修单详情
     */
    //@PreAuthorize("@ss.hasPermi('system:repair:query')")
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) {
        return success(repairService.selectSysPropertyRepairById(id));
    }

    /**
     * 新增维修单
     */
    //@PreAuthorize("@ss.hasPermi('system:repair:add')")
    @Log(title = "物业维修", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysPropertyRepair repair) {
        repair.setCreateBy(getUsername());
        return toAjax(repairService.insertSysPropertyRepair(repair));
    }

    /**
     * 维修单变更已处理
     */
    // @PreAuthorize("@ss.hasPermi('system:repair:edit')")
    @Log(title = "物业维修", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysPropertyRepair repair) {
        // 设置更新者
        repair.setUpdateBy(getUsername());

        // 获取当前维修单信息，用于比较状态变化
        SysPropertyRepair existingRepair = repairService.selectSysPropertyRepairById(repair.getId());
        if (existingRepair != null) {
            String existingStatus = existingRepair.getStatus();
            String newStatus = repair.getStatus();

            // 状态变化逻辑
            if (!newStatus.equals(existingStatus)) {
                // 变为维修中状态（2）
                if ("2".equals(newStatus) && !"2".equals(existingStatus)) {
                    // 设置维修开始时间（如果前端未传入，则自动设置）
                    if (repair.getAssignTime() == null) {
                        repair.setAssignTime(new Date());
                    }
                }
                // 变为已完成状态（1）
                else if ("1".equals(newStatus) && !"1".equals(existingStatus)) {
                    // 设置维修完成时间（如果前端未传入，则自动设置）
                    if (repair.getCompletedTime() == null) {
                        repair.setCompletedTime(new Date());
                    }
                }
            }

            // 如果assigneeName被设置（分配了维修工），且状态不是维修中，则自动设置为维修中
            if (repair.getAssigneeName() != null && !repair.getAssigneeName().isEmpty()
                    && !"2".equals(repair.getStatus()) && (existingRepair.getAssigneeName() == null || existingRepair.getAssigneeName().isEmpty())) {
                repair.setStatus("2");
                // 设置维修开始时间
                if (repair.getAssignTime() == null) {
                    repair.setAssignTime(new Date());
                }
            }
        }

        return toAjax(repairService.updateSysPropertyRepair(repair));
    }

    /**
     * 删除维修单（支持批量）
     */
    //@PreAuthorize("@ss.hasPermi('system:repair:remove')")
    @Log(title = "物业维修", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(repairService.deleteSysPropertyRepairByIds(ids));
    }

    /**
     * 上传维修图片
     */
    @PostMapping("/uploadRepairImage")
    public AjaxResult uploadRepairImage(@RequestParam("file") MultipartFile file) throws IOException, InvalidExtensionException {
        if (!file.isEmpty()) {
            String imageUrl = FileUploadUtils.upload(PropertyConfig.getUploadPath(), file, MimeTypeUtils.IMAGE_EXTENSION);
            AjaxResult ajax = AjaxResult.success();
            ajax.put("imgUrl", imageUrl);
            return ajax;
        }
        return error("上传图片失败，请联系管理员");
    }

    /**
     * 提交维修评分
     */
    @PostMapping("/rate")
    public AjaxResult rate(@RequestBody RepairRateDTO rateDTO) {
        try {
            // 获取当前登录用户
            String currentUser = getUsername();

            // 获取维修单信息
            SysPropertyRepair repair = repairService.selectSysPropertyRepairById(rateDTO.getId());
            if (repair == null) {
                return AjaxResult.error("维修单不存在");
            }

            // 检查维修是否已完成
            if (!"1".equals(repair.getStatus())) {
                return AjaxResult.error("只有已完成的维修单才能评分");
            }

            // 检查是否已评分
            if (repair.getScore() != null) {
                return AjaxResult.error("该维修单已评分");
            }

            // 更新评分
            repair.setScore(rateDTO.getScore());
            repair.setComment(rateDTO.getComment());
            repair.setRateBy(currentUser);
            repair.setRateTime(new Date());
            repair.setUpdateBy(currentUser);

            int result = repairService.updateRepairRate(repair);

            if (result > 0) {
                return AjaxResult.success("评分提交成功");
            } else {
                return AjaxResult.error("评分提交失败");
            }
        } catch (Exception e) {
            logger.error("评分提交失败", e);
            return AjaxResult.error("系统错误：" + e.getMessage());
        }
    }

    /**
     * 获取维修单评分
     */
    @GetMapping("/rate/{id}")
    public AjaxResult getRate(@PathVariable Long id) {
        SysPropertyRepair repair = repairService.selectSysPropertyRepairById(id);
        if (repair == null) {
            return AjaxResult.error("维修单不存在");
        }

        // 构建返回结果
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        result.put("score", repair.getScore());
        result.put("comment", repair.getComment());
        result.put("rateTime", repair.getRateTime());
        result.put("rateBy", repair.getRateBy());

        return AjaxResult.success(result);
    }
}