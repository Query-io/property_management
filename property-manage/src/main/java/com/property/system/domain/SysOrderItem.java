package com.property.system.domain;
import com.property.common.core.domain.BaseEntity;
import lombok.Data;
import java.math.BigDecimal;

@Data
public class SysOrderItem extends BaseEntity {
    private Long id;                 // 明细ID
    private Long orderId;           // 所属订单ID
    private String itemName;        // 明细名称（水费、电费等）
    private Integer quantity;       // 数量
    private BigDecimal unitPrice;   // 单价
    private BigDecimal amount;      // 金额
    private String description;     // 详细描述
}
