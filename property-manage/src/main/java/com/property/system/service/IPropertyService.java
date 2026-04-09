package com.property.system.service;

import com.property.system.domain.SysPropertyInfo;
import java.util.List;

/**
 * 房产信息 服务层接口
 *
 */
public interface IPropertyService {

    /**
     * 查询房产信息
     *
     * @param propertyId 房产ID
     * @return 房产信息
     */
    public SysPropertyInfo selectPropertyById(Long propertyId);

    /**
     * 查询房产信息列表
     *
     * @param property 查询条件
     * @return 房产集合
     */
    public List<SysPropertyInfo> selectPropertyList(SysPropertyInfo property);


    /**
     * 查询房产信息，根据业主id
     */
    List<SysPropertyInfo> selectPropertyListByOwnerId(Long ownerId);


    /**
     * 查询房产信息，根据userId
     */
    List<SysPropertyInfo> selectPropertyListByUserId(Long userId);

    /**
     * 新增房产信息
     *
     * @param property 房产信息
     * @return 结果
     */
    public int insertProperty(SysPropertyInfo property);

    /**
     * 修改房产信息
     *
     * @param property 房产信息
     * @return 结果
     */
    public int updateProperty(SysPropertyInfo property);

    /**
     * 删除房产信息
     *
     * @param propertyId 房产ID
     * @return 结果
     */
    public int deletePropertyById(Long propertyId);

    /**
     * 批量删除房产信息
     *
     * @param propertyIds 房产ID数组
     * @return 结果
     */
    public int deletePropertyByIds(Long[] propertyIds);

    /**
     * 修改房产状态
     *
     * @param propertyId 房产ID
     * @param status 新状态
     * @return 结果
     */
    public int updatePropertyStatus(Long propertyId, String status);

    /**
     * 更换房产的业主信息
     *
     * @return 结果
     */
    public int updatePropertyOwner(SysPropertyInfo property);

    /**
     * 更新房产图片地址
     ** @return 结果
     */
    public boolean updatePropertyImageUrl(Long propertyId, String imageUrl);
}
