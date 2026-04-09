package com.property.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.property.common.core.domain.BaseEntity;
import lombok.Data;

import java.util.Date;

/**
 * 业主信息
 */
@Data
public class SysOwnerInfo extends BaseEntity {
    /**
     * 业主ID（主键，自增）
     */
    private Integer ownerId;

    /**
     * 业主姓名
     */
    private String ownerName;

    public String getIdentityNo() {
        return identityNo;
    }

    public void setIdentityNo(String identityNo) {
        this.identityNo = identityNo;
    }

    public Integer getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(Integer ownerId) {
        this.ownerId = ownerId;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
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

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    /**
     * 出生日期
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date dateOfBirth;

    /**
     * 身份证号
     */
    private String identityNo;

    /**
     * 联系地址
     */
    private String address;

    /**
     * 积分
     */
    private String occupation;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 车牌号码
     */
    private String signature;

    /**
     * 联系电话
     */
    private String phoneNumber;

    /**
     * 关联用户ID（对应 sys_user 表的主键）
     */
    private Long userId;
}
