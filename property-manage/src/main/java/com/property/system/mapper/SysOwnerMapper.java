package com.property.system.mapper;

import com.property.system.domain.SysOwnerInfo;
import io.swagger.models.auth.In;

import java.util.List;

public interface SysOwnerMapper {
    // 查询全部
    List<SysOwnerInfo> selectOwnerList(SysOwnerInfo sysOwnerInfo);

    //根据id查询
    SysOwnerInfo selectOwnerById(Long id);

    // 根据 userId 查询
    SysOwnerInfo selectOwnerByUserId(Long userId);

    // 插入
    int insertOwner(SysOwnerInfo owner);

    // 更新
    int updateOwner(SysOwnerInfo owner);

    // 删除
    int deleteOwnerById(Integer ownerId);
}