package com.property.system.controller;

import com.property.common.annotation.Log;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.page.TableDataInfo;
import com.property.common.enums.BusinessType;
import com.property.common.utils.poi.ExcelUtil;
import com.property.system.domain.Worker;
import com.property.system.service.IWorkerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/system/worker")
public class WorkerController extends BaseController {
    @Autowired
    private IWorkerService workerService;

    /**
     * 查询工人信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:worker:list')")
    @GetMapping("/list")
    public TableDataInfo list(Worker worker) {
        startPage();
        List<Worker> list = workerService.selectWorkerList(worker);
        return getDataTable(list);
    }

    /**
     * 导出工人信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:worker:export')")
    @Log(title = "工人信息", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(Worker worker) {
        List<Worker> list = workerService.selectWorkerList(worker);
        ExcelUtil<Worker> util = new ExcelUtil<>(Worker.class);
        return util.exportExcel(list, "工人信息数据");
    }

    /**
     * 获取工人信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:worker:query')")
    @GetMapping(value = "/{workerId}")
    public AjaxResult getInfo(@PathVariable("workerId") Long workerId) {
        return AjaxResult.success(workerService.selectWorkerById(workerId));
    }

    /**
     * 新增工人信息
     */
    @PreAuthorize("@ss.hasPermi('system:worker:add')")
    @Log(title = "工人信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Worker worker) {
        worker.setCreateBy(getUsername());
        return toAjax(workerService.insertWorker(worker));
    }

    /**
     * 修改工人信息
     */
    @PreAuthorize("@ss.hasPermi('system:worker:edit')")
    @Log(title = "工人信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Worker worker) {
        worker.setUpdateBy(getUsername());
        return toAjax(workerService.updateWorker(worker));
    }

    /**
     * 删除工人信息
     */
    @PreAuthorize("@ss.hasPermi('system:worker:remove')")
    @Log(title = "工人信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{workerIds}")
    public AjaxResult remove(@PathVariable Long[] workerIds) {
        return toAjax(workerService.deleteWorkerByIds(workerIds));
    }
}