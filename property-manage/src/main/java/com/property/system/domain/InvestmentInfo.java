package com.property.system.domain;

import com.property.common.annotation.Excel;
import com.property.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = true)
public class InvestmentInfo extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 招商标题 */
    @Excel(name = "招商标题")
    private String title;

    /** 招商内容 */
    @Excel(name = "招商内容")
    private String content;

    /** 招商位置 */
    @Excel(name = "招商位置")
    private String location;

    /** 面积(平方米) */
    @Excel(name = "面积(平方米)")
    private BigDecimal area;

    /** 租金单价(元/月/平方米) */
    @Excel(name = "租金单价(元/月/平方米)")
    private BigDecimal rentPrice;

    /** 联系人 */
    @Excel(name = "联系人")
    private String contactPerson;

    /** 联系电话 */
    @Excel(name = "联系电话")
    private String contactPhone;

    /** 状态(0:待招商,1:已签约,2:已关闭) */
    @Excel(name = "状态", readConverterExp = "0=待招商,1=已签约,2=已关闭")
    private Integer status;

    /** 发布时间 */
    @Excel(name = "发布时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date publishTime;
}