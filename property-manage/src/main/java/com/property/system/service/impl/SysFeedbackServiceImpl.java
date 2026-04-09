package com.property.system.service.impl;

import java.util.Date;
import java.util.List;

import com.property.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.property.system.domain.SysFeedback;
import com.property.system.mapper.SysFeedbackMapper;
import com.property.system.service.ISysFeedbackService;

/**
 * 用户投诉与反馈 服务层实现
 *
 */
@Service
public class SysFeedbackServiceImpl implements ISysFeedbackService
{
    @Autowired
    private SysFeedbackMapper feedbackMapper;

    /**
     * 查询反馈信息
     *
     * @param id 反馈ID
     * @return 反馈信息
     */
    @Override
    public SysFeedback selectSysFeedbackById(Long id)
    {
        return feedbackMapper.selectSysFeedbackById(id);
    }

    /**
     * 查询反馈列表
     *
     * @param feedback 查询条件
     * @return 反馈列表
     */
    @Override
    public List<SysFeedback> selectSysFeedbackList(SysFeedback feedback)
    {
        return feedbackMapper.selectSysFeedbackList(feedback);
    }

    /**
     * 新增反馈
     *
     * @param feedback 反馈信息
     * @return 结果
     */
    @Override
    public int insertSysFeedback(SysFeedback feedback)
    {
        return feedbackMapper.insertSysFeedback(feedback);
    }

    /**
     * 修改反馈
     *
     * @param feedback 反馈信息
     * @return 结果
     */
    @Override
    public int updateSysFeedback(SysFeedback feedback)
    {
        feedback.setReplyTime(new Date());
        return feedbackMapper.updateSysFeedback(feedback);
    }

    /**
     * 删除反馈
     *
     * @param id 反馈ID
     * @return 结果
     */
    @Override
    public int deleteSysFeedbackById(Long id)
    {
        return feedbackMapper.deleteSysFeedbackById(id);
    }

    /**
     * 批量删除反馈
     *
     * @param ids 反馈ID数组
     * @return 结果
     */
    @Override
    public int deleteSysFeedbackByIds(Long[] ids)
    {
        return feedbackMapper.deleteSysFeedbackByIds(ids);
    }
}
