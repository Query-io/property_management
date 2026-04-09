package com.property.system.service;

import java.util.List;
import com.property.system.domain.SysFeedback;

/**
 * 用户投诉与反馈 服务层
 *
 */
public interface ISysFeedbackService {
    /**
     * 查询反馈信息
     *
     * @param id ID
     * @return 反馈信息
     */
    public SysFeedback selectSysFeedbackById(Long id);

    /**
     * 查询反馈列表
     *
     * @param feedback 反馈信息查询条件
     * @return 反馈集合
     */
    public List<SysFeedback> selectSysFeedbackList(SysFeedback feedback);

    /**
     * 新增反馈
     *
     * @param feedback 反馈信息
     * @return 结果
     */
    public int insertSysFeedback(SysFeedback feedback);

    /**
     * 修改反馈
     *
     * @param feedback 反馈信息
     * @return 结果
     */
    public int updateSysFeedback(SysFeedback feedback);

    /**
     * 删除反馈信息
     *
     * @param id 反馈ID
     * @return 结果
     */
    public int deleteSysFeedbackById(Long id);

    /**
     * 批量删除反馈信息
     *
     * @param ids 需要删除的反馈ID数组
     * @return 结果
     */
    public int deleteSysFeedbackByIds(Long[] ids);
}
