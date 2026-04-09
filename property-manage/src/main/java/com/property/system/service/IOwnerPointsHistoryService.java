package com.property.system.service;

import com.property.system.domain.OwnerPointsHistory;
import java.util.List;

public interface IOwnerPointsHistoryService {
    /**
     * 查询业主积分调整历史记录
     */
    List<OwnerPointsHistory> selectOwnerPointsHistoryList(OwnerPointsHistory ownerPointsHistory);

    /**
     * 根据业主ID查询历史记录
     */
    List<OwnerPointsHistory> selectHistoryByOwnerId(Long ownerId);

    /**
     * 根据用户ID查询历史记录
     */
    List<OwnerPointsHistory> selectHistoryByUserId(Long userId);

    /**
     * 新增业主积分调整历史记录
     */
    int insertOwnerPointsHistory(OwnerPointsHistory ownerPointsHistory);
}