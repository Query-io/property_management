// 位置：property-manage/src/main/java/com/property/system/domain/SysPublicFacility.java
package com.property.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 公共设施信息档案 sys_public_facility
 */
public class SysPublicFacility {
    private static final long serialVersionUID = 1L;

    /** 设施ID */
    private Long facilityId;

    /** 设施编号 */
    private String facilityCode;

    public Long getFacilityId() {
        return facilityId;
    }

    public void setFacilityId(Long facilityId) {
        this.facilityId = facilityId;
    }

    public String getFacilityCode() {
        return facilityCode;
    }

    public void setFacilityCode(String facilityCode) {
        this.facilityCode = facilityCode;
    }

    public String getFacilityName() {
        return facilityName;
    }

    public void setFacilityName(String facilityName) {
        this.facilityName = facilityName;
    }

    public String getFacilityType() {
        return facilityType;
    }

    public void setFacilityType(String facilityType) {
        this.facilityType = facilityType;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getInstallDate() {
        return installDate;
    }

    public void setInstallDate(Date installDate) {
        this.installDate = installDate;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getSpecifications() {
        return specifications;
    }

    public void setSpecifications(String specifications) {
        this.specifications = specifications;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getMaintainCycle() {
        return maintainCycle;
    }

    public void setMaintainCycle(Integer maintainCycle) {
        this.maintainCycle = maintainCycle;
    }

    public Date getLastMaintainDate() {
        return lastMaintainDate;
    }

    public void setLastMaintainDate(Date lastMaintainDate) {
        this.lastMaintainDate = lastMaintainDate;
    }

    public Date getNextMaintainDate() {
        return nextMaintainDate;
    }

    public void setNextMaintainDate(Date nextMaintainDate) {
        this.nextMaintainDate = nextMaintainDate;
    }

    public String getResponsibilityDept() {
        return responsibilityDept;
    }

    public void setResponsibilityDept(String responsibilityDept) {
        this.responsibilityDept = responsibilityDept;
    }

    public String getResponsibilityPerson() {
        return responsibilityPerson;
    }

    public void setResponsibilityPerson(String responsibilityPerson) {
        this.responsibilityPerson = responsibilityPerson;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public BigDecimal getPurchasePrice() {
        return purchasePrice;
    }

    public void setPurchasePrice(BigDecimal purchasePrice) {
        this.purchasePrice = purchasePrice;
    }

    public Integer getWarrantyPeriod() {
        return warrantyPeriod;
    }

    public void setWarrantyPeriod(Integer warrantyPeriod) {
        this.warrantyPeriod = warrantyPeriod;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
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

    /** 设施名称 */
    private String facilityName;

    /** 设施类型 */
    private String facilityType;

    /** 所在位置 */
    private String location;

    /** 安装日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date installDate;

    /** 生产厂家 */
    private String manufacturer;

    /** 规格型号 */
    private String specifications;

    /** 设施状态（0正常 1维修中 2已报废） */
    private String status;

    /** 维护周期（天） */
    private Integer maintainCycle;

    /** 上次维护日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date lastMaintainDate;

    /** 下次维护日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date nextMaintainDate;

    /** 责任部门 */
    private String responsibilityDept;

    /** 责任人 */
    private String responsibilityPerson;

    /** 联系电话 */
    private String contactPhone;

    /** 采购价格 */
    private BigDecimal purchasePrice;

    /** 保修期（月） */
    private Integer warrantyPeriod;

    /** 备注 */
    private String remarks;

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

    // 省略 getter/setter 方法（实际需要全部生成）
}