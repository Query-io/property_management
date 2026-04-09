package com.property.system.domain;

import com.property.common.annotation.Excel;
import com.property.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.math.BigDecimal;

/**
 * 违规类型对象 sys_violation_type
 */
public class SysViolationType extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 类型ID */
    private Long typeId;

    /** 类型编码 */
    @Excel(name = "类型编码")
    private String typeCode;

    /** 类型名称 */
    @Excel(name = "类型名称")
    private String typeName;

    /** 最低罚款金额 */
    @Excel(name = "最低罚款")
    private BigDecimal penaltyMin;

    /** 最高罚款金额 */
    @Excel(name = "最高罚款")
    private BigDecimal penaltyMax;

    /** 状态（0正常 1停用） */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private Integer status;

    // getter和setter方法

    public Long getTypeId() {
        return typeId;
    }

    public void setTypeId(Long typeId) {
        this.typeId = typeId;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public BigDecimal getPenaltyMin() {
        return penaltyMin;
    }

    public void setPenaltyMin(BigDecimal penaltyMin) {
        this.penaltyMin = penaltyMin;
    }

    public BigDecimal getPenaltyMax() {
        return penaltyMax;
    }

    public void setPenaltyMax(BigDecimal penaltyMax) {
        this.penaltyMax = penaltyMax;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "SysViolationType{" +
                "typeId=" + typeId +
                ", typeCode='" + typeCode + '\'' +
                ", typeName='" + typeName + '\'' +
                ", penaltyMin=" + penaltyMin +
                ", penaltyMax=" + penaltyMax +
                ", status=" + status +
                '}';
    }
}