// property-manage/src/main/java/com/property/system/domain/SysMaintenanceRecord.java
package com.property.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.property.common.annotation.Excel;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 维修维护记录 sys_maintenance_record
 */
public class SysMaintenanceRecord {
    private static final long serialVersionUID = 1L;

    /** 记录ID */
    private Long recordId;

    /** 设施ID */
    private Long facilityId;

    /** 设施编号 */
    @Excel(name = "设施编号")
    private String facilityCode;

    /** 设施名称 */
    @Excel(name = "设施名称")
    private String facilityName;

    /** 维护类型（1日常维护 2故障维修 3定期保养） */
    @Excel(name = "维护类型", readConverterExp = "1=日常维护,2=故障维修,3=定期保养")
    private String maintainType;

    /** 维护日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "维护日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date maintainDate;

    /** 维护内容 */
    @Excel(name = "维护内容")
    private String maintainContent;

    /** 维护人 */
    @Excel(name = "维护人")
    private String maintainPerson;

    /** 维护部门 */
    @Excel(name = "维护部门")
    private String maintainDept;

    /** 维护费用 */
    @Excel(name = "维护费用")
    private BigDecimal cost;

    /** 维护结果（1正常 2待观察 3未修复） */
    @Excel(name = "维护结果", readConverterExp = "1=正常,2=待观察,3=未修复")
    private String maintainResult;

    /** 下次维护日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "下次维护日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date nextMaintainDate;

    /** 附件（照片等） */
    private String attachments;

    /** 备注 */
    @Excel(name = "备注")
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

    // Getters and Setters (需要生成完整的)
    public Long getRecordId() {
        return recordId;
    }

    public void setRecordId(Long recordId) {
        this.recordId = recordId;
    }

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

    public String getMaintainType() {
        return maintainType;
    }

    public void setMaintainType(String maintainType) {
        this.maintainType = maintainType;
    }

    public Date getMaintainDate() {
        return maintainDate;
    }

    public void setMaintainDate(Date maintainDate) {
        this.maintainDate = maintainDate;
    }

    public String getMaintainContent() {
        return maintainContent;
    }

    public void setMaintainContent(String maintainContent) {
        this.maintainContent = maintainContent;
    }

    public String getMaintainPerson() {
        return maintainPerson;
    }

    public void setMaintainPerson(String maintainPerson) {
        this.maintainPerson = maintainPerson;
    }

    public String getMaintainDept() {
        return maintainDept;
    }

    public void setMaintainDept(String maintainDept) {
        this.maintainDept = maintainDept;
    }

    public BigDecimal getCost() {
        return cost;
    }

    public void setCost(BigDecimal cost) {
        this.cost = cost;
    }

    public String getMaintainResult() {
        return maintainResult;
    }

    public void setMaintainResult(String maintainResult) {
        this.maintainResult = maintainResult;
    }

    public Date getNextMaintainDate() {
        return nextMaintainDate;
    }

    public void setNextMaintainDate(Date nextMaintainDate) {
        this.nextMaintainDate = nextMaintainDate;
    }

    public String getAttachments() {
        return attachments;
    }

    public void setAttachments(String attachments) {
        this.attachments = attachments;
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

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("recordId", getRecordId())
                .append("facilityId", getFacilityId())
                .append("facilityCode", getFacilityCode())
                .append("facilityName", getFacilityName())
                .append("maintainType", getMaintainType())
                .append("maintainDate", getMaintainDate())
                .append("maintainContent", getMaintainContent())
                .append("maintainPerson", getMaintainPerson())
                .append("maintainDept", getMaintainDept())
                .append("cost", getCost())
                .append("maintainResult", getMaintainResult())
                .append("nextMaintainDate", getNextMaintainDate())
                .append("attachments", getAttachments())
                .append("remarks", getRemarks())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}