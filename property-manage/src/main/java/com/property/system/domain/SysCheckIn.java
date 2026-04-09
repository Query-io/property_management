package com.property.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 入住登记对象 sys_check_in
 *
 * @author property
 * @date 2026-01-20
 */
public class SysCheckIn
{
    private static final long serialVersionUID = 1L;

    /** 入住ID */
    private Long checkInId;

    /** 房产ID */
    private Long propertyId;

    /** 业主ID */
    private Long ownerId;

    /** 业主姓名 */
    private String ownerName;

    /** 入住日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date checkInDate;

    /** 预计居住时长(月) */
    private Integer expectedDuration;

    /** 合同编号 */
    private String contractNumber;

    /** 租金金额 */
    private BigDecimal rentalAmount;

    /** 押金金额 */
    private BigDecimal depositAmount;

    /** 状态（0正常 1已退房） */
    private String status;

    /** 房产地址（关联查询） */
    private String propertyAddress;

    /** 房产区域（关联查询） */
    private String region;

    /** 楼栋号（关联查询） */
    private String buildingNo;

    /** 房间号（关联查询） */
    private String roomNo;

    /** 创建者 */
    private String createBy;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    /** 更新者 */
    private String updateBy;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    /** 备注 */
    private String remark;

    public Long getCheckInId() {
        return checkInId;
    }

    public void setCheckInId(Long checkInId) {
        this.checkInId = checkInId;
    }

    public Long getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(Long propertyId) {
        this.propertyId = propertyId;
    }

    public Long getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(Long ownerId) {
        this.ownerId = ownerId;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public Date getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate;
    }

    public Integer getExpectedDuration() {
        return expectedDuration;
    }

    public void setExpectedDuration(Integer expectedDuration) {
        this.expectedDuration = expectedDuration;
    }

    public String getContractNumber() {
        return contractNumber;
    }

    public void setContractNumber(String contractNumber) {
        this.contractNumber = contractNumber;
    }

    public BigDecimal getRentalAmount() {
        return rentalAmount;
    }

    public void setRentalAmount(BigDecimal rentalAmount) {
        this.rentalAmount = rentalAmount;
    }

    public BigDecimal getDepositAmount() {
        return depositAmount;
    }

    public void setDepositAmount(BigDecimal depositAmount) {
        this.depositAmount = depositAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPropertyAddress() {
        return propertyAddress;
    }

    public void setPropertyAddress(String propertyAddress) {
        this.propertyAddress = propertyAddress;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getBuildingNo() {
        return buildingNo;
    }

    public void setBuildingNo(String buildingNo) {
        this.buildingNo = buildingNo;
    }

    public String getRoomNo() {
        return roomNo;
    }

    public void setRoomNo(String roomNo) {
        this.roomNo = roomNo;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}