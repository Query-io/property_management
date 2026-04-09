package com.property.system.service;
import com.property.system.domain.SysOwnerInfo;

import java.util.List;

/**
 * 业主信息 服务层接口
 */
public interface ISysOwnerService {

    /**
     * 查询所有业主信息列表
     *
     * @param owner 查询条件
     * @return 业主信息集合
     */
    List<SysOwnerInfo> selectOwnerList(SysOwnerInfo owner);

    /**
     * 根据业主ID查询业主信息
     *
     * @param ownerId 业主ID
     * @return 业主信息
     */
    SysOwnerInfo selectOwnerById(Long ownerId);

    /**
     * 根据用户ID查询业主信息
     *
     * @param userId 用户ID
     * @return 业主信息
     */
    SysOwnerInfo selectOwnerByUserId(Long userId);

    /**
     * 新增业主信息
     *
     * @param owner 业主信息
     * @return 结果
     */
    int insertOwner(SysOwnerInfo owner);

    /**
     * 修改业主信息
     *
     * @param owner 业主信息
     * @return 结果
     */
    int updateOwner(SysOwnerInfo owner);

    /**
     * 删除业主信息
     *
     * @param ownerId 业主ID
     * @return 结果
     */
    int deleteOwnerById(Integer ownerId);

    /**
     * 批量删除业主信息
     *
     * @param ownerIds 需要删除的业主ID数组
     * @return 结果
     */
    int deleteOwnerByIds(Integer[] ownerIds);
}
