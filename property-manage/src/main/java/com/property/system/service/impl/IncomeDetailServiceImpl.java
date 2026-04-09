package com.property.system.service.impl;

import com.property.common.core.text.Convert;
import com.property.system.domain.IncomeDetail;
import com.property.system.mapper.IncomeDetailMapper;
import com.property.system.service.IIncomeDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IncomeDetailServiceImpl implements IIncomeDetailService {
    @Autowired
    private IncomeDetailMapper incomeDetailMapper;

    /**
     * 查询收益明细
     */
    @Override
    public IncomeDetail selectIncomeDetailById(Long id) {
        return incomeDetailMapper.selectIncomeDetailById(id);
    }

    /**
     * 查询收益明细列表
     */
    @Override
    public List<IncomeDetail> selectIncomeDetailList(IncomeDetail incomeDetail) {
        return incomeDetailMapper.selectIncomeDetailList(incomeDetail);
    }

    /**
     * 新增收益明细
     */
    @Override
    public int insertIncomeDetail(IncomeDetail incomeDetail) {
        return incomeDetailMapper.insertIncomeDetail(incomeDetail);
    }

    /**
     * 修改收益明细
     */
    @Override
    public int updateIncomeDetail(IncomeDetail incomeDetail) {
        return incomeDetailMapper.updateIncomeDetail(incomeDetail);
    }

    /**
     * 批量删除收益明细
     */
    @Override
    public int deleteIncomeDetailByIds(Long[] ids) {
        return incomeDetailMapper.deleteIncomeDetailByIds(ids);
    }
}