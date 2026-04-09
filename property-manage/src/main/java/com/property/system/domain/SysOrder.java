package com.property.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.property.common.core.domain.BaseEntity;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
public class SysOrder extends BaseEntity {
    private Long id;                   // 订单ID
    private String orderNo;           // 订单编号
    private String orderType;         // 订单类型（房租/维修/停车费用等）
    private Long userId;              // 用户ID（业主）
    private Long propertyId;             // 房产ID（可为空）
    private BigDecimal totalAmount;   // 订单总金额
    private BigDecimal actualAmount;  // 实付金额
    private Integer pointsUsed;       // 积分使用数量
    private String status;            // 状态：0=已支付，1=待支付
    private String remark;            // 备注
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date payTime;             // 支付时间
    private String userName;          // 用户姓名

    private String propertyAddress;   //房产地址
    // 关联订单明细列表（非数据库字段）
    private List<SysOrderItem> items;

    private Long associationId;  //关联其它订单id（可能为停车订单id/维修订单id/其它)
}