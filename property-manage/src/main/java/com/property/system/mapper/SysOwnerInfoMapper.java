package com.property.system.mapper;

import com.property.system.domain.SysOwnerInfo;
import io.lettuce.core.dynamic.annotation.Param;

public interface SysOwnerInfoMapper {
    SysOwnerInfo selectOwnerByPlateNum(@Param("plateNum") String plateNum);

}

