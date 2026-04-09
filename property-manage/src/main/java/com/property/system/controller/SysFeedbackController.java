package com.property.system.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.system.domain.SysFeedback;
import com.property.system.service.ISysFeedbackService;

/**
 * 用户反馈 信息操作处理
 *
 */
@RestController
@RequestMapping("/system/feedback")
public class SysFeedbackController extends BaseController
{
    @Autowired
    private ISysFeedbackService feedbackService;

    /**
     * 获取投诉与反馈列表--- 普通用户
     */
    //@PreAuthorize("@ss.hasPermi('system:feedback:list')")
    @GetMapping("/listByUser")
    public TableDataInfo listByUser(SysFeedback feedback)
    {
        startPage();
        feedback.setUserId(getUserId());
        List<SysFeedback> list = feedbackService.selectSysFeedbackList(feedback);
        return getDataTable(list);
    }



    /**
     * 获取投诉与反馈列表--- 管理员
     */
    //@PreAuthorize("@ss.hasPermi('system:feedback:list')")
    @GetMapping("/listByAdmin")
    public TableDataInfo listByAdmin(SysFeedback feedback)
    {
        startPage();
        List<SysFeedback> list = feedbackService.selectSysFeedbackList(feedback);
        return getDataTable(list);
    }

    /**
     * 获取投诉与反馈详细信息
     */
    //@PreAuthorize("@ss.hasPermi('system:feedback:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable Long id)
    {
        return success(feedbackService.selectSysFeedbackById(id));
    }

    /**
     * 用户投诉
     */
    //@PreAuthorize("@ss.hasPermi('system:feedback:add')")
    @Log(title = "用户投诉与反馈", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysFeedback feedback)
    {
        feedback.setCreateBy(getUsername());
        feedback.setUserId(getUserId());
        feedback.setUserName(getUsername());
        return toAjax(feedbackService.insertSysFeedback(feedback));
    }

    /**
     * 修改反馈
     */
    //@PreAuthorize("@ss.hasPermi('system:feedback:edit')")
    @Log(title = "用户投诉与反馈", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysFeedback feedback)
    {
        feedback.setReplyUserId(getUserId());
        feedback.setReplyUserName(getUsername());
        feedback.setUpdateBy(getUsername());
        return toAjax(feedbackService.updateSysFeedback(feedback));
    }

    /**
     * 删除反馈
     */
    //@PreAuthorize("@ss.hasPermi('system:feedback:remove')")
    @Log(title = "用户投诉与反馈", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(feedbackService.deleteSysFeedbackByIds(ids));
    }
}
