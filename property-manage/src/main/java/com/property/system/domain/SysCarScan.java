package com.property.system.domain;

import com.property.common.core.domain.BaseEntity;

import java.util.Date;


/**
 * 车辆识别
 */
public class SysCarScan extends BaseEntity {


    private Long scanId;             // 主键
    private Long userId;      // 用户ID
    private Long parkId;         // 停车场ID
    private String plateColor;   // 车牌颜色
    private String plateNum;     // 车牌号
    private Integer type;        // 是否固定车（0不是 1是）
    private Integer direction;   // 方向（0驶入 1驶出）
    private String picture;      // 扫描图片地址


    private String userName; // 用户名称

    private String parkName;  //停车场名称

    public Long getScanId() {
        return scanId;
    }

    public void setScanId(Long scanId) {
        this.scanId = scanId;
    }

    public Long getUserId() {
        return userId;
    }

    public String getParkName() {
        return parkName;
    }

    public void setParkName(String parkName) {
        this.parkName = parkName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getParkId() {
        return parkId;
    }

    public void setParkId(Long parkId) {
        this.parkId = parkId;
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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getDirection() {
        return direction;
    }

    public void setDirection(Integer direction) {
        this.direction = direction;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }
}
