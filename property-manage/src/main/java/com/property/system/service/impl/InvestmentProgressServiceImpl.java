package com.property.system.service.impl;

import com.property.common.core.text.Convert;
import com.property.system.domain.InvestmentProgress;
import com.property.system.mapper.InvestmentProgressMapper;
import com.property.system.service.IInvestmentProgressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InvestmentProgressServiceImpl implements IInvestmentProgressService {
    @Autowired
    private InvestmentProgressMapper investmentProgressMapper;

    /**
     * 查询招商进度
     */
    @Override
    public InvestmentProgress selectInvestmentProgressById(Long id) {
        return investmentProgressMapper.selectInvestmentProgressById(id);
    }

    /**
     * 查询招商进度列表
     */
    @Override
    public List<InvestmentProgress> selectInvestmentProgressList(InvestmentProgress investmentProgress) {
        return investmentProgressMapper.selectInvestmentProgressList(investmentProgress);
    }

    /**
     * 新增招商进度
     */
    @Override
    public int insertInvestmentProgress(InvestmentProgress investmentProgress) {
        return investmentProgressMapper.insertInvestmentProgress(investmentProgress);
    }

    /**
     * 修改招商进度
     */
    @Override
    public int updateInvestmentProgress(InvestmentProgress investmentProgress) {
        return investmentProgressMapper.updateInvestmentProgress(investmentProgress);
    }

    /**
     * 批量删除招商进度
     */
    @Override
    public int deleteInvestmentProgressByIds(Long[] ids) {
        return investmentProgressMapper.deleteInvestmentProgressByIds(ids);
    }
}