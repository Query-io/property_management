package com.property.system.dto;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

public class RepairRateDTO {

    @NotNull(message = "维修单ID不能为空")
    private Long id;

    @NotNull(message = "评分不能为空")
    @Min(value = 1, message = "评分不能小于1分")
    @Max(value = 5, message = "评分不能大于5分")
    private Integer score;

    private String comment;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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
}