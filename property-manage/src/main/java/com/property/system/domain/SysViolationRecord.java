package com.property.system.domain;

import com.property.common.annotation.Excel;
import com.property.common.annotation.Excel.ColumnType;
import com.property.common.core.domain.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 违规信息记录对象 sys_violation_record
 */
public class SysViolationRecord extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 违规ID */
    @Excel(name = "违规编号", cellType = ColumnType.NUMERIC)
    private Long violationId;

    /** 车牌号码 */
    @NotBlank(message = "车牌号码不能为空")
    @Excel(name = "车牌号码")
    private String plateNum;

    /** 违规类型 */
    @NotBlank(message = "违规类型不能为空")
    @Excel(name = "违规类型")
    private String violationType;

    /** 违规时间 */
    @NotNull(message = "违规时间不能为空")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "违规时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date violationTime;

    /** 违规地点 */
    @Excel(name = "违规地点")
    private String location;

    /** 违规描述 */
    @Excel(name = "违规描述")
    private String description;

    /** 证据图片 */
    @Excel(name = "证据图片")
    private String evidenceImg;

    /** 处理状态（0未处理 1已处理 2已撤销） */
    @Excel(name = "处理状态", readConverterExp = "0=未处理,1=已处理,2=已撤销")
    private Integer status;

    /** 罚款金额 */
    @Excel(name = "罚款金额")
    private BigDecimal penaltyAmount;

    /** 处罚日期 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "处罚日期", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date penaltyDate;

    /** 处理人员ID */
    private Long processorId;

    /** 处理人员姓名 */
    @Excel(name = "处理人员")
    private String processorName;

    // 查询条件字段（Date类型）
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date beginTime;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endTime;

    // getter和setter方法...
    public Long getViolationId() {
        return violationId;
    }

    public void setViolationId(Long violationId) {
        this.violationId = violationId;
    }

    public String getPlateNum() {
        return plateNum;
    }

    public void setPlateNum(String plateNum) {
        this.plateNum = plateNum;
    }

    public String getViolationType() {
        return violationType;
    }

    public void setViolationType(String violationType) {
        this.violationType = violationType;
    }

    public Date getViolationTime() {
        return violationTime;
    }

    public void setViolationTime(Date violationTime) {
        this.violationTime = violationTime;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEvidenceImg() {
        return evidenceImg;
    }

    public void setEvidenceImg(String evidenceImg) {
        this.evidenceImg = evidenceImg;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public BigDecimal getPenaltyAmount() {
        return penaltyAmount;
    }

    public void setPenaltyAmount(BigDecimal penaltyAmount) {
        this.penaltyAmount = penaltyAmount;
    }

    public Date getPenaltyDate() {
        return penaltyDate;
    }

    public void setPenaltyDate(Date penaltyDate) {
        this.penaltyDate = penaltyDate;
    }

    public Long getProcessorId() {
        return processorId;
    }

    public void setProcessorId(Long processorId) {
        this.processorId = processorId;
    }

    public String getProcessorName() {
        return processorName;
    }

    public void setProcessorName(String processorName) {
        this.processorName = processorName;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("violationId", getViolationId())
                .append("plateNum", getPlateNum())
                .append("violationType", getViolationType())
                .append("violationTime", getViolationTime())
                .append("location", getLocation())
                .append("description", getDescription())
                .append("evidenceImg", getEvidenceImg())
                .append("status", getStatus())
                .append("penaltyAmount", getPenaltyAmount())
                .append("penaltyDate", getPenaltyDate())
                .append("processorId", getProcessorId())
                .append("remark", getRemark())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}