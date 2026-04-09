package com.property.system.service.impl;

import com.property.common.constant.Constants;
import com.property.common.exception.ServiceException;
import com.property.common.utils.SecurityUtils;
import com.property.system.domain.*;
import com.property.system.mapper.*;
import com.property.system.service.ISysOrderService;
import com.property.system.utils.OrderNoUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Service
public class SysOrderServiceImpl implements ISysOrderService {

    @Autowired
    private SysOrderMapper orderMapper;
    @Autowired
    private SysParkOrderMapper orderParkMapper;

    @Autowired
    private SysPropertyRepairMapper propertyRepairMapper;

    @Autowired
    private SysPropertyMapper propertyMapper;

    @Autowired
    private SysOwnerMapper ownerMapper;

    @Override
    public SysOrder selectSysOrderById(Long id) {
        return orderMapper.selectSysOrderById(id);
    }

    @Override
    public List<SysOrder> selectSysOrderList(SysOrder sysOrder) {
        return orderMapper.selectSysOrderList(sysOrder);
    }

    @Override
    public int generatedSysOrder(SysOrder sysOrder) {
        // 1. 组装主订单
        // 根据 orderType 不同选择不同前缀，比如租金"RENT_"，维修"REP_" 等
        String prefix;
        switch (sysOrder.getOrderType()) {
            case "维修":
                prefix = "REP";
                break;
            case "房租":
                prefix = "REN";
                break;
            default:
                prefix = "ORD";
                break;
        }
        sysOrder.setOrderNo(OrderNoUtil.generateOrderNo(prefix));
        sysOrder.setUserId(SecurityUtils.getUserId());
        sysOrder.setUserName(SecurityUtils.getUsername());
        sysOrder.setStatus(String.valueOf(Constants.NO)); // '1' = 待支付
        sysOrder.setCreateTime(new Date());

        // 初始化实付金额和积分使用
        sysOrder.setActualAmount(sysOrder.getTotalAmount()); // 默认实付金额等于订单总额
        sysOrder.setPointsUsed(0); // 默认不使用积分

        //查询维修订单关联的房租id
        if (sysOrder.getOrderType().equals("维修")) {
            SysPropertyRepair sysPropertyRepair = propertyRepairMapper.selectSysPropertyRepairById(sysOrder.getAssociationId());
            if (sysPropertyRepair != null) {
                sysOrder.setPropertyId(sysPropertyRepair.getPropertyId());
            }
            //更新状态为待支付
            sysPropertyRepair.setStatus("2");
            propertyRepairMapper.updateSysPropertyRepair(sysPropertyRepair);
        }
        //根据房产查询绑定的租户
        if (sysOrder.getPropertyId() == null){
            throw new ServiceException("参数异常！");
        }
        SysPropertyInfo sysPropertyInfo = propertyMapper.selectPropertyById(sysOrder.getPropertyId());
        if (sysPropertyInfo == null) {
            throw new ServiceException("房产不存在！");
        }
        // 查询租户关联的用户id
        SysOwnerInfo sysOwnerInfo = ownerMapper.selectOwnerById(sysPropertyInfo.getOwnerId());
        sysOrder.setUserId(sysOwnerInfo.getUserId());
        sysOrder.setUserName(sysOwnerInfo.getOwnerName());
        // 主订单总额如果前端没传，可由后台累加明细
        if (sysOrder.getTotalAmount() == null) {
            BigDecimal total = BigDecimal.ZERO;
            if (sysOrder.getItems() != null) {
                for (SysOrderItem item : sysOrder.getItems()) {
                    BigDecimal amt = item.getAmount() != null
                            ? item.getAmount()
                            : BigDecimal.ZERO;
                    total = total.add(amt);
                }
            }
            sysOrder.setTotalAmount(total);
            // 如果totalAmount为空，则actualAmount也设为total
            if (sysOrder.getActualAmount() == null) {
                sysOrder.setActualAmount(total);
            }
        }
        // 插入主订单，生成自增 id
        orderMapper.insertSysOrder(sysOrder);

        // 2. 插入所有明细
        List<SysOrderItem> items = sysOrder.getItems();
        int count = 0;
        if (items != null) {
            for (SysOrderItem item : items) {
                item.setOrderId(sysOrder.getId());
                // 如果是"维修"类型，自动计算 amount = quantity * unitPrice
                if ("维修".equals(sysOrder.getOrderType())
                        && item.getQuantity() != null
                        && item.getUnitPrice() != null) {
                    BigDecimal amt = item.getUnitPrice()
                            .multiply(BigDecimal.valueOf(item.getQuantity()));
                    item.setAmount(amt);
                }
                // 描述
                if (item.getDescription() == null) {
                    item.setDescription(item.getItemName());
                }
                count += orderMapper.insertOrderItem(item);
            }
        }
        return count;

    }

    @Override
    public int updateSysOrderStatus(SysOrder sysOrder) {
        Long id = sysOrder.getId();
        SysOrder order = orderMapper.selectSysOrderById(id);
        if (order.getOrderType().equals("维修")){
            //更新维修单状态为已支付
            SysPropertyRepair sysPropertyRepair = propertyRepairMapper.selectSysPropertyRepairById(order.getAssociationId());
            sysPropertyRepair.setStatus("3");
            propertyRepairMapper.updateSysPropertyRepair(sysPropertyRepair);
        }

        // 如果前端没有传递实付金额，则使用订单总额
        if (sysOrder.getActualAmount() == null) {
            sysOrder.setActualAmount(order.getTotalAmount());
        }
        // 如果前端没有传递积分使用数量，则设为0
        if (sysOrder.getPointsUsed() == null) {
            sysOrder.setPointsUsed(0);
        }

        return orderMapper.updateSysOrderStatus(sysOrder);
    }

    @Override
    public int deleteSysOrderById(Long id) {
        // 删除明细
        orderMapper.deleteOrderItemsByOrderId(id);
        // 删除主订单
        return orderMapper.deleteSysOrderById(id);
    }

    // ========== 明细 ==========

    @Override
    public List<SysOrderItem> selectSysOrderItemList(Long orderId) {
        return orderMapper.selectSysOrderItemList(orderId);
    }

    @Override
    public int insertOrderItem(SysOrderItem item) {
        return orderMapper.insertOrderItem(item);
    }

    @Override
    public int updateOrderItem(SysOrderItem item) {
        return orderMapper.updateOrderItem(item);
    }

    @Override
    public int deleteOrderItemsByOrderId(Long orderId) {
        return orderMapper.deleteOrderItemsByOrderId(orderId);
    }

    /**
     * 停车费用支付
     * @param parkOrderId
     * @return
     */
    @Override
    public boolean parkingPay(Long parkOrderId) {
        //更新停车订单状态为已支付
        SysParkOrder sysParkOrder = orderParkMapper.selectParkOrderById(parkOrderId);
        sysParkOrder.setStatus(String.valueOf(Constants.YES));
        orderParkMapper.updateParkOrder(sysParkOrder);
        // 生成订单和订单明细
        SysOrder sysOrder = new SysOrder();
        sysOrder.setOrderNo(OrderNoUtil.generateOrderNo("TCF"));
        sysOrder.setOrderType("停车费");
        sysOrder.setUserId(SecurityUtils.getUserId());
        sysOrder.setUserName(SecurityUtils.getUsername());
        sysOrder.setTotalAmount(sysParkOrder.getParkFee());
        sysOrder.setActualAmount(sysParkOrder.getParkFee()); // 实付金额等于订单总额
        sysOrder.setPointsUsed(0); // 停车费支付默认不使用积分
        sysOrder.setStatus(String.valueOf(Constants.YES));
        sysOrder.setPayTime(new Date());
        sysOrder.setAssociationId(sysParkOrder.getId());
        orderMapper.insertSysOrder(sysOrder);
        SysOrderItem sysOrderItem = new SysOrderItem();
        sysOrderItem.setOrderId(sysOrder.getId());
        sysOrderItem.setItemName("停车费用支付");
        sysOrderItem.setAmount(sysParkOrder.getParkFee());
        StringBuilder msg = new StringBuilder();
        msg.append("车牌号为【").append(sysParkOrder.getPlateNum()).append("】的车在")
                .append(sysParkOrder.getParkName()).append("总停车费为：").append(sysParkOrder.getParkFee());
        sysOrderItem.setDescription(msg.toString());
        int i = orderMapper.insertOrderItem(sysOrderItem);
        return i > 0;
    }
}