package com.property.system.service;

import com.property.system.domain.SysOwnerInfo;

public interface ISysOwnerInfoService {
    /**
     * 根据车牌号查询业主信息
     */
    SysOwnerInfo selectOwnerByPlateNum(String plateNum);
}
