package com.property.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.property.common.annotation.Excel;
import com.property.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = true)
public class SysPropertyRepair extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 维修单ID */
    private Long id;

    /** 房产ID */
    @Excel(name = "房产ID")
    private Long propertyId;

    /** 房产地址 */
    @Excel(name = "房产地址")
    private String propertyAddress;

    /** 申请人ID */
    @Excel(name = "申请人ID")
    private Long applicantId;

    /** 申请人姓名 */
    @Excel(name = "申请人姓名")
    private String applicantName;

    /** 申请人电话 */
    @Excel(name = "申请人电话")
    private String applicantPhone;

    /** 维修项目 */
    @Excel(name = "维修项目")
    private String repairItem;

    /** 维修描述 */
    @Excel(name = "维修描述")
    private String repairDescription;

    /** 图片URL */
    @Excel(name = "图片URL")
    private String imageUrl;

    /** 提交时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "提交时间", dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date submitTime;

    /** 状态（0待处理，1已处理，2已完成） */
    @Excel(name = "状态", readConverterExp = "0=待处理,1=已处理,2=已完成")
    private String status;

    /** 维修人姓名 */
    @Excel(name = "维修人姓名")
    private String assigneeName;

    /** 维修人电话 */
    @Excel(name = "维修人电话")
    private String assigneePhone;

    /** 完成时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "完成时间", dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date completedTime;

    /** 评分（1-5分） */
    @Excel(name = "评分")
    private Integer score;

    /** 评语 */
    @Excel(name = "评语")
    private String comment;

    /** 评分时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "评分时间", dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date rateTime;

    /** 评分人 */
    @Excel(name = "评分人")
    private String rateBy;

    /** 维修开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date assignTime;

    /** 查询条件：开始时间（用于提交时间范围查询） */
    private Date beginSubmitTime;

    /** 查询条件：结束时间（用于提交时间范围查询） */
    private Date endSubmitTime;

    // getter和setter方法
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(Long propertyId) {
        this.propertyId = propertyId;
    }

    public String getPropertyAddress() {
        return propertyAddress;
    }

    public void setPropertyAddress(String propertyAddress) {
        this.propertyAddress = propertyAddress;
    }

    public Long getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(Long applicantId) {
        this.applicantId = applicantId;
    }

    public String getApplicantName() {
        return applicantName;
    }

    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }

    public String getApplicantPhone() {
        return applicantPhone;
    }

    public void setApplicantPhone(String applicantPhone) {
        this.applicantPhone = applicantPhone;
    }

    public String getRepairItem() {
        return repairItem;
    }

    public void setRepairItem(String repairItem) {
        this.repairItem = repairItem;
    }

    public String getRepairDescription() {
        return repairDescription;
    }

    public void setRepairDescription(String repairDescription) {
        this.repairDescription = repairDescription;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Date getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime) {
        this.submitTime = submitTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAssigneeName() {
        return assigneeName;
    }

    public void setAssigneeName(String assigneeName) {
        this.assigneeName = assigneeName;
    }

    public String getAssigneePhone() {
        return assigneePhone;
    }

    public void setAssigneePhone(String assigneePhone) {
        this.assigneePhone = assigneePhone;
    }

    public Date getCompletedTime() {
        return completedTime;
    }

    public void setCompletedTime(Date completedTime) {
        this.completedTime = completedTime;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getRateTime() {
        return rateTime;
    }

    public void setRateTime(Date rateTime) {
        this.rateTime = rateTime;
    }

    public String getRateBy() {
        return rateBy;
    }

    public void setRateBy(String rateBy) {
        this.rateBy = rateBy;
    }

    public Date getAssignTime() {
        return assignTime;
    }

    public void setAssignTime(Date assignTime) {
        this.assignTime = assignTime;
    }

    public Date getBeginSubmitTime() {
        return beginSubmitTime;
    }

    public void setBeginSubmitTime(Date beginSubmitTime) {
        this.beginSubmitTime = beginSubmitTime;
    }

    public Date getEndSubmitTime() {
        return endSubmitTime;
    }

    public void setEndSubmitTime(Date endSubmitTime) {
        this.endSubmitTime = endSubmitTime;
    }
}