package com.property.system.service;

import com.property.system.domain.OwnerPoints;
import java.util.List;

public interface IOwnerPointsService {
    /**
     * 查询业主积分
     */
    OwnerPoints selectOwnerPointsById(Long ownerId);

    /**
     * 根据用户ID查询业主积分
     */
    OwnerPoints selectOwnerPointsByUserId(Long userId);

    /**
     * 查询业主积分列表
     */
    List<OwnerPoints> selectOwnerPointsList(OwnerPoints ownerPoints);

    /**
     * 新增业主积分
     */
    int insertOwnerPoints(OwnerPoints ownerPoints);

    /**
     * 修改业主积分
     */
    int updateOwnerPoints(OwnerPoints ownerPoints);

    /**
     * 更新积分（只更新积分字段）
     */
    int updatePoints(OwnerPoints ownerPoints);

    /**
     * 调整积分（带乐观锁和历史记录）
     */
    int adjustPoints(OwnerPoints ownerPoints, String adjustType, String reason);

    /**
     * 批量删除业主积分
     */
    int deleteOwnerPointsByIds(Long[] ownerIds);

    /**
     * 更新积分（带乐观锁）
     */
    int updatePointsWithLock(OwnerPoints ownerPoints);
}