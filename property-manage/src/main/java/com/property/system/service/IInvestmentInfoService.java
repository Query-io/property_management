package com.property.system.service;

import com.property.system.domain.InvestmentInfo;
import java.util.List;

public interface IInvestmentInfoService {
    /**
     * 查询招商信息
     */
    InvestmentInfo selectInvestmentInfoById(Long id);

    /**
     * 查询招商信息列表
     */
    List<InvestmentInfo> selectInvestmentInfoList(InvestmentInfo investmentInfo);

    /**
     * 新增招商信息
     */
    int insertInvestmentInfo(InvestmentInfo investmentInfo);

    /**
     * 修改招商信息
     */
    int updateInvestmentInfo(InvestmentInfo investmentInfo);

    /**
     * 批量删除招商信息
     */
    int deleteInvestmentInfoByIds(Long[] ids);
}