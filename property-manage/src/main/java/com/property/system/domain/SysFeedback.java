package com.property.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.property.common.core.domain.BaseEntity;
import lombok.Data;

import java.util.Date;

/**
 * 投诉与反馈
 */
@Data
public class SysFeedback extends BaseEntity {
    private Long id;
    private Long userId;
    private String userName;
    private String contact;
    private String content;
    private String replyContent;
    private Long replyUserId;
    private String replyUserName;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date replyTime;
    private Integer delFlag;
}