package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.system.domain.SysParkOrder;
import com.property.system.service.ISysParkOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 停车订单 控制层
 */
@RestController
@RequestMapping("/system/parkOrder")
public class SysParkOrderController extends BaseController {

    @Autowired
    private ISysParkOrderService parkOrderService;

    /**
     * 获取停车订单列表
     */
    //@PreAuthorize("@ss.hasPermi('system:parkOrder:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysParkOrder parkOrder) {
        startPage();
        List<SysParkOrder> list = parkOrderService.selectParkOrderList(parkOrder);
        return getDataTable(list);
    }

    /**
     * 删除停车订单
     */
    //@PreAuthorize("@ss.hasPermi('system:parkOrder:remove')")
    //@Log(title = "停车订单", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id) {
        return toAjax(parkOrderService.deleteParkOrderById(id));
    }

}
