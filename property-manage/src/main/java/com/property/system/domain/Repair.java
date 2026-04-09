package com.property.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.property.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 物业报修 sys_property_repair
 */
public class Repair extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 报修单ID */
    private Long id;

    /** 房产ID */
    private Long propertyId;

    /** 房产地址 */
    private String propertyAddress;

    /** 申请人用户ID */
    private Long applicantId;

    /** 申请人姓名 */
    private String applicantName;

    /** 申请人联系电话 */
    private String applicantPhone;

    /** 维修项目 */
    private String repairItem;

    /** 维修描述 */
    private String repairDescription;

    /** 维修相关图片 URL */
    private String imageUrl;

    /** 状态（已提交、已处理、待支付、已支付） */
    private String status;

    /** 提交时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date submitTime;

    /** 维修人姓名 */
    private String assigneeName;

    /** 维修人联系方式 */
    private String assigneePhone;

    /** 删除标志（0代表存在 1代表删除） */
    private String delFlag;

    /** 处理完成时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date completedTime;

    /** 评分（1-5分） */
    private Integer score;

    /** 评语 */
    private String comment;

    /** 评分时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date rateTime;

    public String getRepairNo() {
        return repairNo;
    }

    public void setRepairNo(String repairNo) {
        this.repairNo = repairNo;
    }

    public String getWorkerName() {
        return workerName;
    }

    public void setWorkerName(String workerName) {
        this.workerName = workerName;
    }

    /** 评分人 */
    private String rateBy;

    private String repairNo;
    private String workerName;

    /** 开始时间（查询用） */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date beginTime;

    /** 结束时间（查询用） */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endTime;

    // 请求参数
    private Map<String, Object> params;

    public Repair() {
        params = new HashMap<>();
    }

    // Getter和Setter方法
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime) {
        this.submitTime = submitTime;
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

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
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

    public Map<String, Object> getParams() {
        return params;
    }

    public void setParams(Map<String, Object> params) {
        this.params = params;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("propertyId", getPropertyId())
                .append("propertyAddress", getPropertyAddress())
                .append("applicantId", getApplicantId())
                .append("applicantName", getApplicantName())
                .append("applicantPhone", getApplicantPhone())
                .append("repairItem", getRepairItem())
                .append("repairDescription", getRepairDescription())
                .append("imageUrl", getImageUrl())
                .append("status", getStatus())
                .append("submitTime", getSubmitTime())
                .append("assigneeName", getAssigneeName())
                .append("assigneePhone", getAssigneePhone())
                .append("delFlag", getDelFlag())
                .append("completedTime", getCompletedTime())
                .append("score", getScore())
                .append("comment", getComment())
                .append("rateTime", getRateTime())
                .append("rateBy", getRateBy())
                .append("beginTime", getBeginTime())
                .append("endTime", getEndTime())
                .append("params", getParams())
                .toString();
    }
}