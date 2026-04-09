// property-manage/src/main/java/com/property/system/domain/SysDamageRecord.java
package com.property.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.property.common.annotation.Excel;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 损坏报废登记 sys_damage_record
 */
public class SysDamageRecord {
    private static final long serialVersionUID = 1L;

    /** 损坏ID */
    private Long damageId;

    /** 设施ID */
    private Long facilityId;

    /** 设施编号 */
    @Excel(name = "设施编号")
    private String facilityCode;

    /** 设施名称 */
    @Excel(name = "设施名称")
    private String facilityName;

    /** 损坏日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "损坏日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date damageDate;

    /** 损坏类型（1人为损坏 2自然损坏 3老化损坏） */
    @Excel(name = "损坏类型", readConverterExp = "1=人为损坏,2=自然损坏,3=老化损坏")
    private String damageType;

    /** 损坏描述 */
    @Excel(name = "损坏描述")
    private String damageDescription;

    public Long getDamageId() {
        return damageId;
    }

    public void setDamageId(Long damageId) {
        this.damageId = damageId;
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

    public Date getDamageDate() {
        return damageDate;
    }

    public void setDamageDate(Date damageDate) {
        this.damageDate = damageDate;
    }

    public String getDamageType() {
        return damageType;
    }

    public void setDamageType(String damageType) {
        this.damageType = damageType;
    }

    public String getDamageDescription() {
        return damageDescription;
    }

    public void setDamageDescription(String damageDescription) {
        this.damageDescription = damageDescription;
    }

    public String getReporter() {
        return reporter;
    }

    public void setReporter(String reporter) {
        this.reporter = reporter;
    }

    public String getReporterPhone() {
        return reporterPhone;
    }

    public void setReporterPhone(String reporterPhone) {
        this.reporterPhone = reporterPhone;
    }

    public String getHandleStatus() {
        return handleStatus;
    }

    public void setHandleStatus(String handleStatus) {
        this.handleStatus = handleStatus;
    }

    public String getHandleMethod() {
        return handleMethod;
    }

    public void setHandleMethod(String handleMethod) {
        this.handleMethod = handleMethod;
    }

    public String getHandlePerson() {
        return handlePerson;
    }

    public void setHandlePerson(String handlePerson) {
        this.handlePerson = handlePerson;
    }

    public Date getHandleDate() {
        return handleDate;
    }

    public void setHandleDate(Date handleDate) {
        this.handleDate = handleDate;
    }

    public String getHandleResult() {
        return handleResult;
    }

    public void setHandleResult(String handleResult) {
        this.handleResult = handleResult;
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

    /** 上报人 */
    @Excel(name = "上报人")
    private String reporter;

    /** 上报人电话 */
    @Excel(name = "上报人电话")
    private String reporterPhone;

    /** 处理状态（0未处理 1处理中 2已处理） */
    @Excel(name = "处理状态", readConverterExp = "0=未处理,1=处理中,2=已处理")
    private String handleStatus;

    /** 处理方式（1维修 2更换 3报废） */
    @Excel(name = "处理方式", readConverterExp = "1=维修,2=更换,3=报废")
    private String handleMethod;

    /** 处理人 */
    @Excel(name = "处理人")
    private String handlePerson;

    /** 处理日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "处理日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date handleDate;

    /** 处理结果 */
    @Excel(name = "处理结果")
    private String handleResult;

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

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("damageId", getDamageId())
                .append("facilityId", getFacilityId())
                .append("facilityCode", getFacilityCode())
                .append("facilityName", getFacilityName())
                .append("damageDate", getDamageDate())
                .append("damageType", getDamageType())
                .append("damageDescription", getDamageDescription())
                .append("reporter", getReporter())
                .append("reporterPhone", getReporterPhone())
                .append("handleStatus", getHandleStatus())
                .append("handleMethod", getHandleMethod())
                .append("handlePerson", getHandlePerson())
                .append("handleDate", getHandleDate())
                .append("handleResult", getHandleResult())
                .append("attachments", getAttachments())
                .append("remarks", getRemarks())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}