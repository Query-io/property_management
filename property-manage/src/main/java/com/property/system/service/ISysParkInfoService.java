package com.property.system.service;

import com.property.system.domain.SysParkInfo;

import java.util.List;

/**
 * 停车场信息 服务层
 */
public interface ISysParkInfoService {

    /**
     * 查询停车场信息
     *
     * @param parkId 停车场ID
     * @return 停车场信息
     */
    SysParkInfo selectParkInfoById(Long parkId);

    /**
     * 查询停车场信息列表
     *
     * @param parkInfo 停车场信息查询条件
     * @return 停车场信息集合
     */
    List<SysParkInfo> selectParkInfoList(SysParkInfo parkInfo);

    /**
     * 查询所有未删除的停车场信息
     *
     * @return 未删除的停车场信息集合
     */
    List<SysParkInfo> selectActiveParkInfoList();

    /**
     * 新增停车场信息
     *
     * @param parkInfo 停车场信息
     * @return 结果
     */
    int insertParkInfo(SysParkInfo parkInfo);

    /**
     * 修改停车场信息
     *
     * @param parkInfo 停车场信息
     * @return 结果
     */
    int updateParkInfo(SysParkInfo parkInfo);

    /**
     * 删除停车场信息（通过ID）
     *
     * @param parkId 停车场ID
     * @return 结果
     */
    int deleteParkInfoById(Long parkId);

    /**
     * 批量删除停车场信息
     *
     * @param parkIds 需要删除的停车场ID
     * @return 结果
     */
    int deleteParkInfoByIds(Long[] parkIds);
}
