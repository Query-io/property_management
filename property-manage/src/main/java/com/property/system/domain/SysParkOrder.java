package com.property.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.property.common.core.domain.BaseEntity;

import java.math.BigDecimal;
import java.util.Date;

public class SysParkOrder extends BaseEntity {

    private Long id;                // 主键
    private Long parkId;            // 停车场ID
    private Integer type;           // 是否固定车（0不是 1是）
    private String plateColor;      // 车牌颜色
    private String plateNum;        // 车牌号
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date entryTime;         // 进入停车场时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date exitTime;          // 离开停车场时间
    private Double parkingDuration;// 停车时长（分钟）
    private BigDecimal parkFee;     // 停车收费金额
    private String delFlag;         // 删除标识（0代表存在 1代表删除）
    private Long userId;
    private String userName;
    private String parkName;
    private String status;   // 0 表示已支付、 1表示待支付


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getParkId() {
        return parkId;
    }

    public void setParkId(Long parkId) {
        this.parkId = parkId;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getPlateColor() {
        return plateColor;
    }

    public void setPlateColor(String plateColor) {
        this.plateColor = plateColor;
    }

    public String getPlateNum() {
        return plateNum;
    }

    public void setPlateNum(String plateNum) {
        this.plateNum = plateNum;
    }

    public Date getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(Date entryTime) {
        this.entryTime = entryTime;
    }

    public Date getExitTime() {
        return exitTime;
    }

    public void setExitTime(Date exitTime) {
        this.exitTime = exitTime;
    }

    public Double getParkingDuration() {
        return parkingDuration;
    }

    public void setParkingDuration(Double parkingDuration) {
        this.parkingDuration = parkingDuration;
    }

    public BigDecimal getParkFee() {
        return parkFee;
    }

    public void setParkFee(BigDecimal parkFee) {
        this.parkFee = parkFee;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getParkName() {
        return parkName;
    }

    public void setParkName(String parkName) {
        this.parkName = parkName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
