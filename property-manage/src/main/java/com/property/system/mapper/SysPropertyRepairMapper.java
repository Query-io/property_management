package com.property.system.mapper;

import com.property.system.domain.SysPropertyRepair;
import java.util.List;

public interface SysPropertyRepairMapper {

    /**
     * 查询维修单列表
     */
    List<SysPropertyRepair> selectSysPropertyRepairList(SysPropertyRepair repair);

    /**
     * 查询未已审核的物业维修单，用于生成维修支付订单
     */
    List<SysPropertyRepair> selectDealSysPropertyRepairList();

    /**
     * 查询单个维修单
     */
    SysPropertyRepair selectSysPropertyRepairById(Long id);

    /**
     * 新增维修单
     */
    int insertSysPropertyRepair(SysPropertyRepair repair);

    /**
     * 更新维修单
     */
    int updateSysPropertyRepair(SysPropertyRepair repair);

    /**
     * 删除维修单（单个）
     */
    int deleteSysPropertyRepairById(Long id);

    /**
     * 删除维修单（批量）
     */
    int deleteSysPropertyRepairByIds(Long[] ids);

     /**
      * 更新维修单评分
      */
     int updateRepairRate(SysPropertyRepair repair);
}
