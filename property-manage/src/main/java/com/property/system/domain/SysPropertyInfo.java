package com.property.system.domain;
import com.property.common.core.domain.BaseEntity;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 房产信息实体类
 */
@Data
public class SysPropertyInfo extends BaseEntity {

    /** 房产ID */
    private Long propertyId;

    /** 房产地址 */
    private String propertyAddress;

    /** 所属区域 */
    private String region;

    /** 所属楼栋 */
    private String buildingNo;

    /** 单元号 */
    private String unitNo;

    /** 所在楼层 */
    private Integer floor;

    /** 房间号 */
    private String roomNo;

    /** 建筑面积（平方米） */
    private BigDecimal buildingArea;

    /** 使用面积（平方米） */
    private BigDecimal usableArea;

    /** 主业主ID */
    private Long ownerId;

    /** 主业主名称 */
    private String owner;

    /** 负责人ID */
    private Long managerId;

    /** 负责人名称 */
    private String manager;

    /** 房屋类型（住宅/商用/办公等） */
    private String propertyType;

    /** 房屋状态（0正常 1空置 2出租 3出售） */
    private String status;

    /** 房产图片地址 */
    private String imageUrl;

    /** 创建时间 */
    private Date createTime;

    /** 更新时间 */
    private Date updateTime;

    /** 备注 */
    private String remark;
}
