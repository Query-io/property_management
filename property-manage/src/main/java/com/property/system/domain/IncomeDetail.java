package com.property.system.domain;

import com.property.common.annotation.Excel;
import com.property.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = true)
public class IncomeDetail extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 招商信息ID */
    @Excel(name = "招商信息ID")
    private Long investmentId;

    /** 收益类型(租金、押金、管理费、广告费) */
    @Excel(name = "收益类型", readConverterExp = "租=金,押=金,管=理费,广=告费")
    private String incomeType;

    /** 金额 */
    @Excel(name = "金额")
    private BigDecimal amount;

    /** 付款日期 */
    @Excel(name = "付款日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date paymentDate;

    /** 计费周期开始 */
    @Excel(name = "计费周期开始", width = 30, dateFormat = "yyyy-MM-dd")
    private Date periodStart;

    /** 计费周期结束 */
    @Excel(name = "计费周期结束", width = 30, dateFormat = "yyyy-MM-dd")
    private Date periodEnd;

    /** 付款方名称 */
    @Excel(name = "付款方名称")
    private String payerName;

    /** 付款方电话 */
    @Excel(name = "付款方电话")
    private String payerPhone;

    /** 付款方式(现金、转账、支付宝、微信) */
    @Excel(name = "付款方式", readConverterExp = "现=金,转=账,支=付宝,微=信")
    private String paymentMethod;

    /** 发票编号 */
    @Excel(name = "发票编号")
    private String invoiceNo;

    /** 备注 */
    @Excel(name = "备注")
    private String remark;

    /** 招商信息标题（关联查询） */
    private String investmentTitle;
}