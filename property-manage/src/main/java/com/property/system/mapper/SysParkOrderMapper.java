package com.property.system.mapper;

import com.property.system.domain.SysParkOrder;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface SysParkOrderMapper {

    // 查询全部停车订单（可根据条件查询）
    List<SysParkOrder> selectParkOrderList(SysParkOrder sysParkOrder);

    // 根据 userId 和车牌号查询用户最新的停车订单
    SysParkOrder selectLatestOrderByUserIdAndPlateNum(@Param("userId") Long userId, @Param("plateNum") String plateNum);

    // 根据订单id查询订单
    SysParkOrder selectParkOrderById(@Param("id") Long id);

    // 插入停车订单
    int insertParkOrder(SysParkOrder parkOrder);

    // 更新停车订单（只更新不为空的字段）
    int updateParkOrder(SysParkOrder parkOrder);

    // 删除停车订单
    int deleteParkOrderById(Long id);
}
