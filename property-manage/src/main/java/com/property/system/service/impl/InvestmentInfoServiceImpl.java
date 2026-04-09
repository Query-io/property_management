package com.property.system.service.impl;

import com.property.common.core.text.Convert;
import com.property.system.domain.InvestmentInfo;
import com.property.system.mapper.InvestmentInfoMapper;
import com.property.system.service.IInvestmentInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InvestmentInfoServiceImpl implements IInvestmentInfoService {
    @Autowired
    private InvestmentInfoMapper investmentInfoMapper;

    /**
     * 查询招商信息
     */
    @Override
    public InvestmentInfo selectInvestmentInfoById(Long id) {
        return investmentInfoMapper.selectInvestmentInfoById(id);
    }

    /**
     * 查询招商信息列表
     */
    @Override
    public List<InvestmentInfo> selectInvestmentInfoList(InvestmentInfo investmentInfo) {
        return investmentInfoMapper.selectInvestmentInfoList(investmentInfo);
    }

    /**
     * 新增招商信息
     */
    @Override
    public int insertInvestmentInfo(InvestmentInfo investmentInfo) {
        return investmentInfoMapper.insertInvestmentInfo(investmentInfo);
    }

    /**
     * 修改招商信息
     */
    @Override
    public int updateInvestmentInfo(InvestmentInfo investmentInfo) {
        return investmentInfoMapper.updateInvestmentInfo(investmentInfo);
    }

    /**
     * 批量删除招商信息
     */
    @Override
    public int deleteInvestmentInfoByIds(Long[] ids) {
        return investmentInfoMapper.deleteInvestmentInfoByIds(ids);
    }
}