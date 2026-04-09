package com.property.system.domain;

import com.property.common.annotation.Excel;
import com.property.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = true)
public class OwnerWelfare extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 业主ID */
    @Excel(name = "业主ID")
    private Long ownerId;

    /** 业主姓名 */
    @Excel(name = "业主姓名")
    private String ownerName;

    /** 房间号 */
    @Excel(name = "房间号")
    private String roomNo;

    /** 福利类型(节日礼品、生日礼券、积分兑换) */
    @Excel(name = "福利类型", readConverterExp = "节=日礼品,生=日礼券,积=分兑换")
    private String welfareType;

    /** 福利名称 */
    @Excel(name = "福利名称")
    private String welfareName;

    /** 福利描述 */
    @Excel(name = "福利描述")
    private String welfareDesc;

    /** 申领时间 */
    @Excel(name = "申领时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date applyTime;

    /** 领取时间 */
    @Excel(name = "领取时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date receiveTime;

    /** 领取方式(自提、配送) */
    @Excel(name = "领取方式", readConverterExp = "自=提,配=送")
    private String receiveMethod;

    /** 状态(0:待领取,1:已领取,2:已过期) */
    @Excel(name = "状态", readConverterExp = "0=待领取,1=已领取,2=已过期")
    private Integer status;

    /** 备注 */
    @Excel(name = "备注")
    private String remark;
}