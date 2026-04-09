package com.property;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 启动程序
 * 
 *
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class PropertyManagementApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(PropertyManagementApplication.class, args);
        System.out.println("==============ﾞ  物业管理系统启动成功   ===============ﾞ  \n");
    }
}
