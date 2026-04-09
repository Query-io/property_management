package com.property.system.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.property.system.domain.SysParkInfo;
import com.property.system.mapper.SysParkInfoMapper;
import com.property.system.service.ISysParkInfoService;

import java.util.List;

/**
 * 停车场信息 服务层实现
 */
@Service
public class SysParkInfoServiceImpl implements ISysParkInfoService {

    @Autowired
    private SysParkInfoMapper parkInfoMapper;

    /**
     * 查询停车场信息
     *
     * @param parkId 停车场ID
     * @return 停车场信息
     */
    @Override
    public SysParkInfo selectParkInfoById(Long parkId) {
        return parkInfoMapper.selectParkInfoById(parkId);
    }

    /**
     * 查询停车场信息列表
     *
     * @param parkInfo 停车场信息查询条件
     * @return 停车场信息集合
     */
    @Override
    public List<SysParkInfo> selectParkInfoList(SysParkInfo parkInfo) {
        return parkInfoMapper.selectParkInfoList(parkInfo);
    }

    /**
     * 查询所有未删除的停车场信息
     *
     * @return 未删除的停车场信息集合
     */
    @Override
    public List<SysParkInfo> selectActiveParkInfoList() {
        return parkInfoMapper.selectActiveParkInfoList();
    }

    /**
     * 新增停车场信息
     *
     * @param parkInfo 停车场信息
     * @return 结果
     */
    @Override
    public int insertParkInfo(SysParkInfo parkInfo) {
        return parkInfoMapper.insertParkInfo(parkInfo);
    }

    /**
     * 修改停车场信息
     *
     * @param parkInfo 停车场信息
     * @return 结果
     */
    @Override
    public int updateParkInfo(SysParkInfo parkInfo) {
        return parkInfoMapper.updateParkInfo(parkInfo);
    }

    /**
     * 删除停车场信息（通过ID）
     *
     * @param parkId 停车场ID
     * @return 结果
     */
    @Override
    public int deleteParkInfoById(Long parkId) {
        return parkInfoMapper.deleteParkInfoById(parkId);
    }

    /**
     * 批量删除停车场信息
     *
     * @param parkIds 需要删除的停车场ID集合
     * @return 结果
     */
    @Override
    public int deleteParkInfoByIds(Long[] parkIds) {
        return parkInfoMapper.deleteParkInfoByIds(parkIds);
    }
}
