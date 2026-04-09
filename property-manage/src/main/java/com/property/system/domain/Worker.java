package com.property.system.domain;

import com.property.common.annotation.Excel;
import com.property.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

/**
 * 工人信息对象 sys_worker
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class Worker extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 工人ID */
    private Long workerId;

    public String getWorkerName() {
        return workerName;
    }

    public void setWorkerName(String workerName) {
        this.workerName = workerName;
    }

    public Long getWorkerId() {
        return workerId;
    }

    public void setWorkerId(Long workerId) {
        this.workerId = workerId;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getWorkerType() {
        return workerType;
    }

    public void setWorkerType(String workerType) {
        this.workerType = workerType;
    }

    public Date getEntryDate() {
        return entryDate;
    }

    public void setEntryDate(Date entryDate) {
        this.entryDate = entryDate;
    }

    public String getWorkStatus() {
        return workStatus;
    }

    public void setWorkStatus(String workStatus) {
        this.workStatus = workStatus;
    }

    public String getEmergencyContact() {
        return emergencyContact;
    }

    public void setEmergencyContact(String emergencyContact) {
        this.emergencyContact = emergencyContact;
    }

    public String getEmergencyPhone() {
        return emergencyPhone;
    }

    public void setEmergencyPhone(String emergencyPhone) {
        this.emergencyPhone = emergencyPhone;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    /** 用户ID（关联用户表） */
    @Excel(name = "用户ID")
    private Long userId;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    /** 工人姓名 */
    @Excel(name = "工人姓名")
    private String workerName;

    /** 性别（0男 1女 2未知） */
    @Excel(name = "性别", readConverterExp = "0=男,1=女,2=未知")
    private String gender;

    /** 年龄 */
    @Excel(name = "年龄")
    private Integer age;

    /** 联系电话 */
    @Excel(name = "联系电话")
    private String phoneNumber;

    /** 身份证号 */
    @Excel(name = "身份证号")
    private String idCard;

    /** 家庭住址 */
    @Excel(name = "家庭住址")
    private String address;

    /** 工种 */
    @Excel(name = "工种")
    private String workerType;

    /** 入职日期 */
    @Excel(name = "入职日期", dateFormat = "yyyy-MM-dd")
    private Date entryDate;

    /** 工作状态（0空闲 1忙碌 2请假 3离职） */
    @Excel(name = "工作状态", readConverterExp = "0=空闲,1=忙碌,2=请假,3=离职")
    private String workStatus;

    /** 紧急联系人 */
    @Excel(name = "紧急联系人")
    private String emergencyContact;

    /** 紧急联系电话 */
    @Excel(name = "紧急联系电话")
    private String emergencyPhone;

    /** 备注 */
    @Excel(name = "备注")
    private String remark;
}