package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.common.utils.poi.ExcelUtil;
import com.property.system.domain.OwnerPoints;
import com.property.system.domain.OwnerPointsHistory;
import com.property.system.service.IOwnerPointsHistoryService;
import com.property.system.service.IOwnerPointsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/system/ownerPoints")
public class OwnerPointsController extends BaseController {
    @Autowired
    private IOwnerPointsService ownerPointsService;

    @Autowired
    private IOwnerPointsHistoryService ownerPointsHistoryService;

    /**
     * 查询业主积分列表
     */
    @PreAuthorize("@ss.hasPermi('system:ownerPoints:list')")
    @GetMapping("/list")
    public TableDataInfo list(OwnerPoints ownerPoints) {
        startPage();
        List<OwnerPoints> list = ownerPointsService.selectOwnerPointsList(ownerPoints);
        return getDataTable(list);
    }

    /**
     * 导出业主积分列表
     */
    @PreAuthorize("@ss.hasPermi('system:ownerPoints:export')")
    @Log(title = "业主积分", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(OwnerPoints ownerPoints) {
        List<OwnerPoints> list = ownerPointsService.selectOwnerPointsList(ownerPoints);
        ExcelUtil<OwnerPoints> util = new ExcelUtil<>(OwnerPoints.class);
        return util.exportExcel(list, "业主积分数据");
    }

    /**
     * 获取业主积分详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:ownerPoints:query')")
    @GetMapping(value = "/{ownerId}")
    public AjaxResult getInfo(@PathVariable("ownerId") Long ownerId) {
        return AjaxResult.success(ownerPointsService.selectOwnerPointsById(ownerId));
    }

    /**
     * 根据用户ID获取积分（包含版本号用于并发控制）
     */
    @GetMapping("/getPointsByUserId/{userId}")
    public AjaxResult getPointsByUserId(@PathVariable("userId") Long userId) {
        OwnerPoints ownerPoints = ownerPointsService.selectOwnerPointsByUserId(userId);
        if (ownerPoints != null) {
            return AjaxResult.success(ownerPoints); // 返回完整对象包含updateTime
        }
        return AjaxResult.success(new OwnerPoints());
    }

    /**
     * 新增业主积分
     */
    @PreAuthorize("@ss.hasPermi('system:ownerPoints:add')")
    @Log(title = "业主积分", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody OwnerPoints ownerPoints) {
        ownerPoints.setCreateBy(getUsername());
        return toAjax(ownerPointsService.insertOwnerPoints(ownerPoints));
    }

    /**
     * 修改业主积分
     */
    @Log(title = "业主积分", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody OwnerPoints ownerPoints) {
        ownerPoints.setUpdateBy(getUsername());
        return toAjax(ownerPointsService.updateOwnerPoints(ownerPoints));
    }

    /**
     * 更新积分（简单更新）
     */
    @PreAuthorize("@ss.hasPermi('system:ownerPoints:updatePoints')")
    @Log(title = "更新积分", businessType = BusinessType.UPDATE)
    @PutMapping("/updatePoints")
    public AjaxResult updatePoints(@RequestBody OwnerPoints ownerPoints) {
        ownerPoints
                .setUpdateBy(getUsername());
        int rows = ownerPointsService.updatePoints(ownerPoints);
        if (rows == 0) {
            return AjaxResult.error("更新失败，请检查数据");
        }
        return toAjax(rows);
    }

    /**
     * 删除业主积分
     */
    @PreAuthorize("@ss.hasPermi('system:ownerPoints:remove')")
    @Log(title = "业主积分", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ownerIds}")
    public AjaxResult remove(@PathVariable Long[] ownerIds) {
        return toAjax(ownerPointsService.deleteOwnerPointsByIds(ownerIds));
    }

    /**
     * 更新积分（带乐观锁控制和历史记录）
     */
//    @PreAuthorize("@ss.hasPermi('system:ownerPoints:updatePoints')")
    @Log(title = "调整积分", businessType = BusinessType.UPDATE)
    @PostMapping("/adjustPoints")
    public AjaxResult adjustPoints(@RequestBody PointsAdjustRequest request) {
        OwnerPoints ownerPoints = request.getOwnerPoints();
        ownerPoints.setUpdateBy(getUsername());

        try {
            int rows = ownerPointsService.adjustPoints(
                    ownerPoints,
                    request.getAdjustType(),
                    request.getReason()
            );

            if (rows == 0) {
                return AjaxResult.error("积分已被其他操作修改，请刷新后重试");
            }
            return AjaxResult.success("积分调整成功");
        } catch (Exception e) {
            return AjaxResult.error("调整积分失败: " + e.getMessage());
        }
    }

    /**
     * 查询业主积分调整历史记录
     */
    @PreAuthorize("@ss.hasPermi('system:ownerPoints:history')")
    @GetMapping("/history/list")
    public TableDataInfo historyList(OwnerPointsHistory ownerPointsHistory) {
        startPage();
        List<OwnerPointsHistory> list = ownerPointsHistoryService.selectOwnerPointsHistoryList(ownerPointsHistory);
        return getDataTable(list);
    }

    /**
     * 根据业主ID查询积分调整历史
     */
    @GetMapping("/history/{ownerId}")
    public AjaxResult getHistoryByOwnerId(@PathVariable("ownerId") Long ownerId) {
        List<OwnerPointsHistory> list = ownerPointsHistoryService.selectHistoryByOwnerId(ownerId);
        return AjaxResult.success(list);
    }

    /**
     * 根据用户ID查询积分调整历史
     */
    @GetMapping("/history/user/{userId}")
    public AjaxResult getHistoryByUserId(@PathVariable("userId") Long userId) {
        List<OwnerPointsHistory> list = ownerPointsHistoryService.selectHistoryByUserId(userId);
        return AjaxResult.success(list);
    }
}

/**
 * 积分调整请求对象
 */
class PointsAdjustRequest {
    private OwnerPoints ownerPoints;
    private String adjustType;
    private String reason;

    public OwnerPoints getOwnerPoints() {
        return ownerPoints;
    }

    public void setOwnerPoints(OwnerPoints ownerPoints) {
        this.ownerPoints = ownerPoints;
    }

    public String getAdjustType() {
        return adjustType;
    }

    public void setAdjustType(String adjustType) {
        this.adjustType = adjustType;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }


}