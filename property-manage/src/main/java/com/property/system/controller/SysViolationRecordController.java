package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.common.utils.SecurityUtils;
import com.property.common.utils.poi.ExcelUtil;
import com.property.system.domain.SysViolationRecord;
import com.property.system.service.ISysViolationRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 违规信息记录 控制层
 */
@RestController
@RequestMapping("/system/violation")
public class SysViolationRecordController extends BaseController {

    @Autowired
    private ISysViolationRecordService violationRecordService;

    /**
     * 查询违规信息记录列表
     */
    @PreAuthorize("@ss.hasPermi('system:violation:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysViolationRecord violationRecord) {
        startPage();
        List<SysViolationRecord> list = violationRecordService.selectViolationList(violationRecord);
        return getDataTable(list);
    }

    /**
     * 导出违规信息记录列表
     */
    @PreAuthorize("@ss.hasPermi('system:violation:export')")
    @Log(title = "违规信息记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysViolationRecord violationRecord) {
        List<SysViolationRecord> list = violationRecordService.selectViolationExport(violationRecord);
        ExcelUtil<SysViolationRecord> util = new ExcelUtil<>(SysViolationRecord.class);
        util.exportExcel(response, list, "违规信息记录数据");
    }

    /**
     * 获取违规信息记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:violation:query')")
    @GetMapping("/{violationId}")
    public AjaxResult getInfo(@PathVariable("violationId") Long violationId) {
        return AjaxResult.success(violationRecordService.selectViolationById(violationId));
    }

    /**
     * 新增违规信息记录
     */
    @PreAuthorize("@ss.hasPermi('system:violation:add')")
    @Log(title = "违规信息记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysViolationRecord violationRecord) {
        return toAjax(violationRecordService.insertViolation(violationRecord));
    }

    /**
     * 修改违规信息记录
     */
    @PreAuthorize("@ss.hasPermi('system:violation:edit')")
    @Log(title = "违规信息记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysViolationRecord violationRecord) {
        return toAjax(violationRecordService.updateViolation(violationRecord));
    }

    /**
     * 删除违规信息记录
     */
    @PreAuthorize("@ss.hasPermi('system:violation:remove')")
    @Log(title = "违规信息记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{violationIds}")
    public AjaxResult remove(@PathVariable Long[] violationIds) {
        return toAjax(violationRecordService.deleteViolationByIds(violationIds));
    }

    /**
     * 处理违规记录
     */
    @PreAuthorize("@ss.hasPermi('system:violation:process')")
    @Log(title = "处理违规记录", businessType = BusinessType.UPDATE)
    @PutMapping("/process/{violationId}")
    public AjaxResult processViolation(@PathVariable Long violationId) {
        Long processorId = SecurityUtils.getUserId();
        return toAjax(violationRecordService.processViolation(violationId, processorId));
    }

    /**
     * 撤销违规记录
     */
    @PreAuthorize("@ss.hasPermi('system:violation:cancel')")
    @Log(title = "撤销违规记录", businessType = BusinessType.UPDATE)
    @PutMapping("/cancel/{violationId}")
    public AjaxResult cancelViolation(@PathVariable Long violationId) {
        return toAjax(violationRecordService.cancelViolation(violationId));
    }

    /**
     * 获取违规统计信息
     */
    @PreAuthorize("@ss.hasPermi('system:violation:list')")
    @GetMapping("/statistics")
    public AjaxResult getStatistics() {
        List<Map<String, Object>> statistics = violationRecordService.getViolationStatistics();
        return AjaxResult.success(statistics);
    }

    /**
     * 根据车牌号查询违规记录
     */
    @PreAuthorize("@ss.hasPermi('system:violation:query')")
    @GetMapping("/byPlate/{plateNum}")
    public AjaxResult getViolationByPlate(@PathVariable String plateNum) {
        List<SysViolationRecord> list = violationRecordService.selectViolationByPlateNum(plateNum);
        return AjaxResult.success(list);
    }

    /**
     * 上传证据图片
     */
    @Log(title = "上传证据图片", businessType = BusinessType.UPDATE)
    @PostMapping("/uploadEvidence")
    public AjaxResult uploadEvidence(@RequestParam("file") MultipartFile file) {
        try {
            // 这里实现文件上传逻辑，返回文件路径
            // 实际项目中需要调用文件上传工具类
            String fileName = "evidence_" + System.currentTimeMillis() + ".jpg";
            String filePath = "/profile/upload/violation/" + fileName;

            // 模拟文件保存
            // FileUploadUtils.saveFile(file, filePath);

            return AjaxResult.success("上传成功", filePath);
        } catch (Exception e) {
            logger.error("上传文件失败", e);
            return AjaxResult.error("上传失败");
        }
    }
}