package com.property.system.domain;


import com.property.common.core.domain.BaseEntity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 停车场信息管理
 */
public class SysParkInfo extends BaseEntity {

    private Long parkId;       // 主键
    private Long parkAmount;   // 车位数
    private Long parkSpare;    // 剩余车位数
    private String parkAddress; // 停车场地址
    private String parkName;   // 停车场名字
    private BigDecimal parkRule; // 收费规则
    private String parkPic;    // 停车场照片地址
    private String delFlag;    // 删除标志（0代表存在 1代表删除）
    private String remark;     // 备注信息


    public Long getParkId() {
        return parkId;
    }

    public void setParkId(Long parkId) {
        this.parkId = parkId;
    }

    public Long getParkAmount() {
        return parkAmount;
    }

    public void setParkAmount(Long parkAmount) {
        this.parkAmount = parkAmount;
    }

    public Long getParkSpare() {
        return parkSpare;
    }

    public void setParkSpare(Long parkSpare) {
        this.parkSpare = parkSpare;
    }

    public String getParkAddress() {
        return parkAddress;
    }

    public void setParkAddress(String parkAddress) {
        this.parkAddress = parkAddress;
    }

    public String getParkName() {
        return parkName;
    }

    public void setParkName(String parkName) {
        this.parkName = parkName;
    }

    public BigDecimal getParkRule() {
        return parkRule;
    }

    public void setParkRule(BigDecimal parkRule) {
        this.parkRule = parkRule;
    }

    public String getParkPic() {
        return parkPic;
    }

    public void setParkPic(String parkPic) {
        this.parkPic = parkPic;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

    @Override
    public String getRemark() {
        return remark;
    }

    @Override
    public void setRemark(String remark) {
        this.remark = remark;
    }
}