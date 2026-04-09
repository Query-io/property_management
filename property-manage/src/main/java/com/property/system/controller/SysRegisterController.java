package com.property.system.controller;

import com.property.common.core.domain.entity.SysUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.property.common.core.controller.BaseController;
import com.property.common.core.domain.AjaxResult;
import com.property.common.core.domain.model.RegisterBody;
import com.property.common.utils.StringUtils;
import com.property.framework.web.service.SysRegisterService;
import com.property.system.service.ISysConfigService;
import com.property.system.service.ISysUserService;
import com.property.system.service.IWorkerService;
import com.property.system.domain.Worker;
import java.util.Date;

/**
 * 注册验证
 *
 */
@RestController
public class SysRegisterController extends BaseController
{
    @Autowired
    private SysRegisterService registerService;

    @Autowired
    private ISysConfigService configService;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private IWorkerService workerService;

    @PostMapping("/register")
    public AjaxResult register(@RequestBody RegisterBody user)
    {
        if (!("true".equals(configService.selectConfigByKey("sys.account.registerUser"))))
        {
            return error("当前系统没有开启注册功能！");
        }

        String msg = registerService.register(user);

        // 如果注册成功且roleId为2，则插入工人信息
        if (StringUtils.isEmpty(msg) && user.getRoleId() != null && user.getRoleId() == 2) {
            try {
                // 获取刚注册的用户信息
                SysUser sysUser = userService.selectUserByUserName(user.getUsername());
                if (sysUser != null) {
                    // 创建工人信息记录
                    Worker worker = new Worker();
                    worker.setUserId(sysUser.getUserId());
                    // 使用用户名作为工人姓名，确保不为空
                    worker.setWorkerName(StringUtils.isNotEmpty(user.getNickName()) ?
                            user.getNickName() : user.getUsername());
                    worker.setPhoneNumber(user.getPhonenumber());
                    worker.setCreateBy(user.getUsername()); // 创建者为当前注册用户
                    worker.setCreateTime(new Date());

                    // 插入工人信息
                    int result = workerService.insertWorker(worker);
                    if (result <= 0) {
                        // 可以记录日志，但不影响用户注册成功
                        logger.warn("工人信息插入失败，用户ID：" + sysUser.getUserId());
                    }
                }
            } catch (Exception e) {
                // 捕获异常，避免影响用户注册流程
                logger.error("插入工人信息时发生异常：", e);
            }
        }

        return StringUtils.isEmpty(msg) ? success() : error(msg);
    }
}