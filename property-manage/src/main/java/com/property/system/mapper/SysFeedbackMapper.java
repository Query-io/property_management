package com.property.system.mapper;

import com.property.system.domain.SysFeedback;

import java.util.List;
public interface SysFeedbackMapper {

    SysFeedback selectSysFeedbackById(Long id);

    List<SysFeedback> selectSysFeedbackList(SysFeedback feedback);

    int insertSysFeedback(SysFeedback feedback);

    int updateSysFeedback(SysFeedback feedback);

    int deleteSysFeedbackById(Long id);

    int deleteSysFeedbackByIds(Long[] ids);
}
