package com.property.system.mapper;

import com.property.system.domain.OwnerPoints;

import java.util.Date;
import java.util.List;

public interface OwnerPointsMapper {
    /**
     * 查询业主积分信息
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
     * 删除业主积分
     */
    int deleteOwnerPointsById(Long ownerId);

    /**
     * 批量删除业主积分
     */
    int deleteOwnerPointsByIds(Long[] ownerIds);

    /**
     * 查询业主积分的更新时间（用于乐观锁）
     */
    Date selectUpdateTimeById(Long ownerId);

    /**
     * 更新积分（带乐观锁）
     */
    int updatePointsWithLock(OwnerPoints ownerPoints);
}