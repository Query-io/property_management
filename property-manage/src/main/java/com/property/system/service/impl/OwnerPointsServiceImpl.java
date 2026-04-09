package com.property.system.service.impl;

import com.property.common.core.text.Convert;
import com.property.system.domain.OwnerPoints;
import com.property.system.domain.OwnerPointsHistory;
import com.property.system.mapper.OwnerPointsHistoryMapper;
import com.property.system.mapper.OwnerPointsMapper;
import com.property.system.service.IOwnerPointsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OwnerPointsServiceImpl implements IOwnerPointsService {
    @Autowired
    private OwnerPointsMapper ownerPointsMapper;

    @Autowired
    private OwnerPointsHistoryMapper ownerPointsHistoryMapper;

    /**
     * 查询业主积分
     */
    @Override
    public OwnerPoints selectOwnerPointsById(Long ownerId) {
        return ownerPointsMapper.selectOwnerPointsById(ownerId);
    }

    /**
     * 根据用户ID查询业主积分
     */
    @Override
    public OwnerPoints selectOwnerPointsByUserId(Long userId) {
        return ownerPointsMapper.selectOwnerPointsByUserId(userId);
    }

    /**
     * 查询业主积分列表
     */
    @Override
    public List<OwnerPoints> selectOwnerPointsList(OwnerPoints ownerPoints) {
        return ownerPointsMapper.selectOwnerPointsList(ownerPoints);
    }

    /**
     * 新增业主积分
     */
    @Override
    public int insertOwnerPoints(OwnerPoints ownerPoints) {
        return ownerPointsMapper.insertOwnerPoints(ownerPoints);
    }

    /**
     * 修改业主积分
     */
    @Override
    public int updateOwnerPoints(OwnerPoints ownerPoints) {
        return ownerPointsMapper.updateOwnerPoints(ownerPoints);
    }

    /**
     * 更新积分（只更新积分字段）
     */
    @Override
    public int updatePoints(OwnerPoints ownerPoints) {
        return ownerPointsMapper.updatePoints(ownerPoints);
    }

    /**
     * 批量删除业主积分
     */
    @Override
    public int deleteOwnerPointsByIds(Long[] ownerIds) {
        return ownerPointsMapper.deleteOwnerPointsByIds(ownerIds);
    }

    /**
     * 调整积分（带乐观锁和历史记录）
     */
    @Override
    @Transactional
    public int adjustPoints(OwnerPoints ownerPoints, String adjustType, String reason) {
        // 1. 查询当前积分信息
        OwnerPoints current = ownerPointsMapper.selectOwnerPointsById(ownerPoints.getOwnerId());
        if (current == null) {
            return 0;
        }

        Integer oldPoints = current.getPoints() != null ? current.getPoints() : 0;
        Integer newPoints = ownerPoints.getPoints() != null ? ownerPoints.getPoints() : 0;
        Integer adjustPoints = newPoints - oldPoints;

        // 2. 更新积分，使用乐观锁
        ownerPoints.setUpdateTime(current.getUpdateTime()); // 设置当前更新时间作为版本号
        int rows = ownerPointsMapper.updatePoints(ownerPoints);

        if (rows > 0) {
            // 3. 记录积分调整历史
            OwnerPointsHistory history = new OwnerPointsHistory();
            history.setOwnerId(ownerPoints.getOwnerId());
            history.setUserId(current.getUserId());
            history.setOldPoints(oldPoints);
            history.setNewPoints(newPoints);
            history.setAdjustPoints(adjustPoints);
            history.setAdjustType(adjustType);
            history.setReason(reason);
            history.setCreateBy(ownerPoints.getUpdateBy());

            ownerPointsHistoryMapper.insertOwnerPointsHistory(history);
        }

        return rows;
    }

    /**
     * 更新积分（带乐观锁）
     */
    @Override
    public int updatePointsWithLock(OwnerPoints ownerPoints) {
        return ownerPointsMapper.updatePointsWithLock(ownerPoints);
    }
}