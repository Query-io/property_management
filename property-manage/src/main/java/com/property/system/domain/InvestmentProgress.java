package com.property.system.domain;

import com.property.common.annotation.Excel;
import com.property.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = true)
public class InvestmentProgress extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 招商信息ID */
    @Excel(name = "招商信息ID")
    private Long investmentId;

    /** 进度类型(咨询、考察、洽谈、签约) */
    @Excel(name = "进度类型", readConverterExp = "咨=询,考=察,洽=谈,签=约")
    private String progressType;

    /** 进度描述 */
    @Excel(name = "进度描述")
    private String progressDesc;

    /** 进度日期 */
    @Excel(name = "进度日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date progressDate;

    /** 下一步计划 */
    @Excel(name = "下一步计划")
    private String nextPlan;

    /** 跟进人 */
    @Excel(name = "跟进人")
    private String trackPerson;

    /** 招商信息标题（关联查询） */
    private String investmentTitle;
}