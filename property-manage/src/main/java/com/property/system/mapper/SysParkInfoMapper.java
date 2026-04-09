package com.property.system.mapper;

import java.util.List;

import com.property.system.domain.SysParkInfo;

/**
 * 停车场信息表 数据层
 * 提供对停车场信息（SysParkInfo）的增删改查操作
 */
public interface SysParkInfoMapper {

    /**
     * 根据停车场ID查询停车场信息
     *
     * @param parkId 停车场ID
     * @return 停车场信息
     */
    public SysParkInfo selectParkInfoById(Long parkId);

    /**
     * 查询停车场信息列表
     *
     * @param parkInfo 停车场信息查询条件
     * @return 停车场信息集合
     */
    public List<SysParkInfo> selectParkInfoList(SysParkInfo parkInfo);

    /**
     * 查询所有未删除的停车场信息
     *
     * @return 未删除的停车场信息集合
     */
    public List<SysParkInfo> selectActiveParkInfoList();

    /**
     * 新增停车场信息
     *
     * @param parkInfo 停车场信息
     * @return 插入结果（影响的行数）
     */
    public int insertParkInfo(SysParkInfo parkInfo);

    /**
     * 修改停车场信息
     *
     * @param parkInfo 停车场信息
     * @return 更新结果（影响的行数）
     */
    public int updateParkInfo(SysParkInfo parkInfo);

    /**
     * 删除停车场信息（通过ID）
     *
     * @param parkId 停车场ID
     * @return 删除结果（影响的行数）
     */
    public int deleteParkInfoById(Long parkId);

    /**
     * 批量删除停车场信息
     *
     * @param parkIds 需要删除的停车场ID集合
     * @return 删除结果（影响的行数）
     */
    public int deleteParkInfoByIds(Long[] parkIds);
}
