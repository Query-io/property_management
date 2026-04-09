package com.property.system.domain;

import com.property.common.annotation.Excel;
import com.property.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = true)
public class OwnerPoints extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 业主ID */
    private Long ownerId;

    /** 业主姓名 */
    @Excel(name = "业主姓名")
    private String ownerName;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 积分（对应数据库occupation字段） */
    @Excel(name = "积分")
    private Integer points;

    /** 出生日期 */
    @Excel(name = "出生日期", dateFormat = "yyyy-MM-dd")
    private Date dateOfBirth;

    public String getIdentityNo() {
        return identityNo;
    }

    public void setIdentityNo(String identityNo) {
        this.identityNo = identityNo;
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

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Integer getPoints() {
        return points;
    }

    public void setPoints(Integer points) {
        this.points = points;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    /** 身份证号 */
    @Excel(name = "身份证号")
    private String identityNo;

    /** 联系地址 */
    @Excel(name = "联系地址")
    private String address;

    /** 联系电话 */
    @Excel(name = "联系电话")
    private String phoneNumber;
}