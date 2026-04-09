package com.property.system.service.impl;

import com.property.system.domain.OwnerPointsHistory;
import com.property.system.mapper.OwnerPointsHistoryMapper;
import com.property.system.service.IOwnerPointsHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OwnerPointsHistoryServiceImpl implements IOwnerPointsHistoryService {
    @Autowired
    private OwnerPointsHistoryMapper ownerPointsHistoryMapper;

    /**
     * 查询业主积分调整历史记录
     */
    @Override
    public List<OwnerPointsHistory> selectOwnerPointsHistoryList(OwnerPointsHistory ownerPointsHistory) {
        return ownerPointsHistoryMapper.selectOwnerPointsHistoryList(ownerPointsHistory);
    }

    /**
     * 根据业主ID查询历史记录
     */
    @Override
    public List<OwnerPointsHistory> selectHistoryByOwnerId(Long ownerId) {
        return ownerPointsHistoryMapper.selectHistoryByOwnerId(ownerId);
    }

    /**
     * 根据用户ID查询历史记录
     */
    @Override
    public List<OwnerPointsHistory> selectHistoryByUserId(Long userId) {
        return ownerPointsHistoryMapper.selectHistoryByUserId(userId);
    }

    /**
     * 新增业主积分调整历史记录
     */
    @Override
    public int insertOwnerPointsHistory(OwnerPointsHistory ownerPointsHistory) {
        return ownerPointsHistoryMapper.insertOwnerPointsHistory(ownerPointsHistory);
    }
}