package com.property.system.controller;

import cn.hutool.extra.qrcode.QrCodeUtil;
import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.common.utils.sign.Base64;
import com.property.system.domain.SysOrder;
import com.property.system.domain.SysOrderItem;
import com.property.system.service.ISysOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/system/order")
public class SysOrderController extends BaseController {


    @Autowired
    private ISysOrderService orderService;

    /**
     * 支付模拟二维码生成
     */
    @GetMapping("/generateParQr/{orderId}")
    public AjaxResult generateParQr(@PathVariable("orderId") Long orderId) throws IOException {
        //模拟支付后跳转链接
       String url = "http://localhost:8080/system/order/simulatePay/" + orderId;
        BufferedImage generate = QrCodeUtil.generate(url, 200, 200);
        //转为base64
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        ImageIO.write(generate, "png", outputStream);
        String base64Img = Base64.encode(outputStream.toByteArray());
        String dataUrl = "data:image/png;base64," + base64Img;
        return AjaxResult.success("二维码成功生成！", dataUrl);
    }

    /**
     * 获取订单列表 - 当前用户
     */
    @GetMapping("/listByUser")
    //@PreAuthorize("@ss.hasPermi('system:order:list')")
    public TableDataInfo listByUser(SysOrder order) {
        startPage();
        order.setUserId(getUserId());
        List<SysOrder> list = orderService.selectSysOrderList(order);
        return getDataTable(list);
    }

    /**
     * 获取订单列表 - 管理员
     */
    @GetMapping("/listByAdmin")
    //@PreAuthorize("@ss.hasPermi('system:order:list')")
    public TableDataInfo listByAdmin(SysOrder order) {
        startPage();
        List<SysOrder> list = orderService.selectSysOrderList(order);
        return getDataTable(list);
    }

    /**
     * 获取订单详细信息
     */
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) {
        return success(orderService.selectSysOrderById(id));
    }

    /**
     * 新增订单
     */
    @Log(title = "订单", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysOrder order) {
        return toAjax(orderService.generatedSysOrder(order));
    }

    /**
     * 更新订单状态（模拟支付）
     */
    @Log(title = "订单支付", businessType = BusinessType.UPDATE)
    @PutMapping("/pay")
    public AjaxResult pay(@RequestBody SysOrder order) {
        return toAjax(orderService.updateSysOrderStatus(order));
    }

    // =================== 明细相关 ===================

    /**
     * 查询订单明细列表
     */
    @GetMapping("/item/list/{orderId}")
    public AjaxResult itemList(@PathVariable Long orderId) {
        List<SysOrderItem> items = orderService.selectSysOrderItemList(orderId);
        return success(items);
    }

    /**
     * 添加订单明细
     */
    @Log(title = "订单明细", businessType = BusinessType.INSERT)
    @PostMapping("/item")
    public AjaxResult addItem(@Validated @RequestBody SysOrderItem item) {
        return toAjax(orderService.insertOrderItem(item));
    }

    /**
     * 修改订单明细
     */
    @Log(title = "订单明细", businessType = BusinessType.UPDATE)
    @PutMapping("/item")
    public AjaxResult updateItem(@Validated @RequestBody SysOrderItem item) {
        return toAjax(orderService.updateOrderItem(item));
    }

    /**
     * 停车费用支付
     */
    @GetMapping("/parkingPay/{parkOrderId}")
    public AjaxResult parkingPay(@PathVariable Long parkOrderId) {
        return toAjax(orderService.parkingPay(parkOrderId));
    }

}
