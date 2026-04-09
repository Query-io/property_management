package com.property.system.domain;

import com.property.common.annotation.Excel;
import com.property.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
/**
 * @Author: xiaoming
 * @Version: V1.0
 * @Package: com.property.system.domain
 * @Project: modern-property-service-new
 * @ClassName: OwnerPointsHistory
 * @Date: 2026/1/13 12:30
 * @FileEffect: 业主积分变化历史记录
 */

@Data
@EqualsAndHashCode(callSuper = true)
public class OwnerPointsHistory extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 历史记录ID */
    private Long historyId;

    /** 业主ID */
    private Long ownerId;

    /** 用户ID */
    private Long userId;

    /** 调整前积分 */
    @Excel(name = "调整前积分")
    private Integer oldPoints;

    /** 调整后积分 */
    @Excel(name = "调整后积分")
    private Integer newPoints;

    /** 调整积分值 */
    @Excel(name = "调整积分值")
    private Integer adjustPoints;

    /** 调整类型（ADD:增加, SUBTRACT:减少, SET:直接设置） */
    @Excel(name = "调整类型")
    private String adjustType;

    /** 调整原因 */
    @Excel(name = "调整原因")
    private String reason;

    /** 业主姓名（用于展示） */
    private String ownerName;
}