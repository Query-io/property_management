package com.property.system.mapper;

import com.property.system.domain.InvestmentInfo;
import java.util.List;

public interface InvestmentInfoMapper {
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
     * 删除招商信息
     */
    int deleteInvestmentInfoById(Long id);

    /**
     * 批量删除招商信息
     */
    int deleteInvestmentInfoByIds(Long[] ids);
}