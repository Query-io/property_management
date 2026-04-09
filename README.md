# 智慧物业管理系统 (Smart Property Management System)

![logo](D:\work\modern-property-service-new\assets\logo-1775741580174-4.png)

## 项目简介

本项目是一套功能完善的智慧物业管理系统，旨在通过信息化手段，提升物业管理效率，优化业主服务体验。系统覆盖了从房产资源管理、业主服务、财务收费到公共设施维护、招商运营等全方位的物业管理工作流。系统基于主流Java技术栈开发，具备权限管理、数据字典、日志监控等基础功能，并针对物业场景深度定制了丰富的业务模块。

![image-20260409215126823](D:\work\modern-property-service-new\assets\image-20260409215126823.png)

## 核心功能模块

系统功能围绕“人、房、钱、事”四个核心要素构建，主要包含以下模块：

### 1. 基础数据管理
- **房产信息管理**：对小区内楼栋、单元、房间进行管理，支持房屋类型、面积、状态（正常/空置）等信息的维护，并可绑定业主与负责人。
- **业主信息管理**：维护业主档案，包括基本信息、联系方式、身份证件等。
- **业主积分系统**：支持对业主进行积分加减操作，积分可用于抵扣物业费、兑换福利，并提供完整的积分变更历史记录。
- **员工（工人）管理**：管理物业维修工人的信息、工种（电工、水工等）、工作状态（空闲/忙碌）及紧急联系人。

### 2. 物业财务管理
- **物业账单缴费**：支持生成各类费用账单（房租、物业费、停车费等），业主可在线支付。
- **订单管理**：统一管理所有支付订单，支持多种订单类型，记录支付状态、实付金额及积分抵扣详情。
- **招商与收益管理**：
    - **招商信息发布**：管理商铺、广告位等招商资源的发布、状态（待招商/已签约/已关闭）。
    - **招商进度跟踪**：记录客户从咨询、考察、洽谈到签约的全过程。
    - **收益明细管理**：记录租金、押金、管理费等各项收入，支持按合同周期和付款方查询。

### 3. 服务与报修管理
- **维修报障管理**：业主可在线提交维修申请（图文描述），管理员分配工人。支持维修状态跟踪（待处理/维修中/已完成）、完工评价与评分。
- **投诉与反馈**：业主可提交投诉建议，物业人员进行回复处理，形成闭环。

### 4. 车辆与停车场管理
- **车辆登记管理**：业主车辆信息登记，关联业主与停车位，管理车牌有效期。
- **智能入场/出库**：模拟车牌识别（LPR）的入场、出场扫描，记录车辆出入场时间、图片等。
- **停车订单管理**：根据入场出场时间自动计算停车时长与费用，生成停车订单。
- **违规信息管理**：记录车辆违章（违停、超速等）信息，支持罚款与处理状态流转。

### 5. 公共设施管理
- **设施信息档案**：建立公共设施（儿童滑梯、健身器材等）的完整档案，包括位置、厂商、保修期、维护周期等。
- **维修维护记录**：记录对设施的日常维护、故障维修和定期保养，追踪维护费用与结果。
- **损坏报废登记**：记录设施损坏情况（人为/自然/老化），并跟踪维修或报废处理流程。

### 6. 业主增值服务
- **业主福利申领**：发布节日礼品、生日礼券等福利，业主可申领并选择自提或配送，支持状态流转（待领取/已领取/已过期）。

### 7. 系统管理
- **用户管理**：管理系统用户、角色（超级管理员、业主、工人等）及权限。
- **菜单与字典管理**：动态配置系统菜单和常用数据字典（如维修状态、收益类型）。
- **日志监控**：记录用户登录日志、操作日志，便于安全审计与问题追踪。
- **通知公告**：发布小区通知、公告信息。

## 技术栈

- **后端框架**：Spring Boot、Spring Security、MyBatis
- **数据库**：MySQL 8.4.7
- **前端框架**：基于RuoYi框架的前端UI
- **工具与插件**：Navicat Premium（数据库管理）、Lombok、PageHelper（分页）

## 快速开始

### 环境要求
- JDK 1.8 或更高版本
- Maven 3.6+
- MySQL 8.0+
- Git

### 安装步骤

1. **克隆项目代码**
   ```bash
   git clone https://github.com/your-repo/property-management-system.git
   ```

2. **导入数据库**
   - 创建MySQL数据库：`CREATE DATABASE property-service-system CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;`
   - 使用Navicat或命令行执行项目根目录下的 `property-service-system.sql` 文件，初始化表结构和示例数据。

3. **修改配置文件**
   - 打开 `application-druid.yml` 或 `application.yml`，修改数据库连接配置（URL、用户名、密码）。

4. **启动后端服务**

   ```bash
   1、IDEA直接启动
   2、Java -jar property-manage.jar
   ```

5. **启动前端服务**

   ```bash
   npm install
   若上面报错则执行下面的命令
   npm install --registry=https://registry.npmmirror.com
   启动命令：
   npm run dev
   ```

6. - 默认访问地址：`http://localhost:80`

### 项目结构

```
property-manage
├── src
│   └── main
│       ├── java
│       │   └── com
│       │       └── property
│       │           ├── framework
│       │           │   ├── aspectj
│       │           │   ├── config
│       │           │   ├── datasource
│       │           │   ├── interceptor
│       │           │   ├── manager
│       │           │   ├── security
│       │           │   └── web
│       │           ├── system
│       │           │   ├── controller
│       │           │   ├── domain
│       │           │   ├── dto
│       │           │   ├── mapper
│       │           │   ├── service
│       │           │   └── utils
│       │           └── web
│       │               ├── controller
│       │               └── core
│       ├── resources
│       │   ├── i18n
│       │   ├── mapper
│       │   ├── META-INF
│       │   ├── mybatis
│       │   │   ├── application.yml
│       │   │   ├── application-druid.yml
│       │   │   └── banner.txt
│       │   └── logback.xml
│       └── PropertyManagementApplication.java
```

## 主要功能展示

<!-- 以下为预留图片位置，请替换为实际功能截图 -->

- **业主信息管理界面**
  ![image-20260409215312182](D:\work\modern-property-service-new\assets\image-20260409215312182.png)
- **报修单**
  ![image-20260409215527730](D:\work\modern-property-service-new\assets\image-20260409215527730.png)
- **车辆入场识别记录**
  ![image-20260409215556769](D:\work\modern-property-service-new\assets\image-20260409215556769.png)
- **订单支付与积分抵扣**
  ![image-20260409215804944](D:\work\modern-property-service-new\assets\image-20260409215804944.png)

## 数据库设计概览

核心数据表结构如下（仅列出主要表）：

| 表名                                | 说明                 |
| :---------------------------------- | :------------------- |
| `sys_property_info`                 | 房产信息表           |
| `sys_owner_info`                    | 业主信息表           |
| `sys_order` / `sys_order_item`      | 订单及明细表         |
| `sys_property_repair`               | 维修报修表           |
| `sys_car_register` / `sys_car_scan` | 车辆登记与出入记录表 |
| `investment_info` / `income_detail` | 招商信息与收益明细表 |
| `sys_public_facility`               | 公共设施档案表       |
| `sys_worker`                        | 工人信息表           |
| `sys_feedback`                      | 投诉反馈表           |

详细的数据库ER图及字段说明请参考
![property-service-system.drawio](D:\work\modern-property-service-new\assets\property-service-system.drawio.png)

## 贡献指南

欢迎通过Issue或Pull Request贡献代码。请确保代码符合项目编码规范，并添加必要的单元测试。

## 许可证

本项目基于 MIT 许可证开源，详情请见 [LICENSE](LICENSE) 文件。

---

**项目团队**：Blake  
**联系方式**：3340136981@qq.com  
**项目地址**：[https://github.com/your-repo/property-management-system](https://github.com/your-repo/property-management-system)