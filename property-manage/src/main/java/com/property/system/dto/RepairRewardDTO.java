package com.property.system.dto;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 报修奖惩信息DTO
 */
public class RepairRewardDTO {

    /** 工人姓名 */
    private String workerName;

    /** 报修单编号 */
    private String repairNo;

    /** 打分（1-5分） */
    private Integer score;

    /** 评价内容 */
    private String evaluation;

    /** 完成时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date completionTime;

    /** 报修标题 */
    private String repairTitle;

    /** 奖惩类型（1:奖励，2:惩罚，0:无） */
    private String rewardType;

    /** 奖惩金额 */
    private BigDecimal rewardAmount;

    /** 备注 */
    private String remark;

    // Getter和Setter方法
    public String getWorkerName() {
        return workerName;
    }

    public void setWorkerName(String workerName) {
        this.workerName = workerName;
    }

    public String getRepairNo() {
        return repairNo;
    }

    public void setRepairNo(String repairNo) {
        this.repairNo = repairNo;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getEvaluation() {
        return evaluation;
    }

    public void setEvaluation(String evaluation) {
        this.evaluation = evaluation;
    }

    public Date getCompletionTime() {
        return completionTime;
    }

    public void setCompletionTime(Date completionTime) {
        this.completionTime = completionTime;
    }

    public String getRepairTitle() {
        return repairTitle;
    }

    public void setRepairTitle(String repairTitle) {
        this.repairTitle = repairTitle;
    }

    public String getRewardType() {
        return rewardType;
    }

    public void setRewardType(String rewardType) {
        this.rewardType = rewardType;
    }

    public BigDecimal getRewardAmount() {
        return rewardAmount;
    }

    public void setRewardAmount(BigDecimal rewardAmount) {
        this.rewardAmount = rewardAmount;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}