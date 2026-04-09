package com.property.system.mapper;

import com.property.system.domain.IncomeDetail;
import java.util.List;

public interface IncomeDetailMapper {
    /**
     * 查询收益明细
     */
    IncomeDetail selectIncomeDetailById(Long id);

    /**
     * 查询收益明细列表
     */
    List<IncomeDetail> selectIncomeDetailList(IncomeDetail incomeDetail);

    /**
     * 新增收益明细
     */
    int insertIncomeDetail(IncomeDetail incomeDetail);

    /**
     * 修改收益明细
     */
    int updateIncomeDetail(IncomeDetail incomeDetail);

    /**
     * 删除收益明细
     */
    int deleteIncomeDetailById(Long id);

    /**
     * 批量删除收益明细
     */
    int deleteIncomeDetailByIds(Long[] ids);
}