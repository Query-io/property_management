package com.property.system.service;

import com.property.system.domain.InvestmentProgress;
import java.util.List;

public interface IInvestmentProgressService {
    /**
     * 查询招商进度
     */
    InvestmentProgress selectInvestmentProgressById(Long id);

    /**
     * 查询招商进度列表
     */
    List<InvestmentProgress> selectInvestmentProgressList(InvestmentProgress investmentProgress);

    /**
     * 新增招商进度
     */
    int insertInvestmentProgress(InvestmentProgress investmentProgress);

    /**
     * 修改招商进度
     */
    int updateInvestmentProgress(InvestmentProgress investmentProgress);

    /**
     * 批量删除招商进度
     */
    int deleteInvestmentProgressByIds(Long[] ids);
}