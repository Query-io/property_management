package com.property.system.mapper;

import com.property.system.domain.SysPropertyInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysPropertyMapper {

    /**
     * 查询房产列表（包含业主名称与负责人名称）
     * @param property 查询条件
     * @return 房产信息列表
     */
    List<SysPropertyInfo> selectPropertyList(SysPropertyInfo property);


    List<SysPropertyInfo> selectPropertyListByOwnerId(@Param("ownerId") Long ownerId);

    List<SysPropertyInfo> selectPropertyListByUserId(@Param("userId") Long userId);

    /**
     * 根据ID查询房产信息
     */
    SysPropertyInfo selectPropertyById(@Param("propertyId") Long propertyId);

    /**
     * 新增房产
     */
    int insertProperty(SysPropertyInfo property);

    /**
     * 修改房产
     */
    int updateProperty(SysPropertyInfo property);

    /**
     * 修改房产状态
     */
    int updatePropertyStatus(@Param("status") String status,@Param("propertyId")Long propertyId);

    /**
     * 修改绑定的业主
     */
    int updatePropertyOwner(SysPropertyInfo propertyInfo);

    /**
     * 删除房产信息
     */
    int deletePropertyById(@Param("propertyId")Long propertyId);


    /**
     * 更新房产图片地址
     ** @return 结果
     */
    int updatePropertyImageUrl(@Param("propertyId")Long propertyId, @Param("imageUrl")String imageUrl);
}
