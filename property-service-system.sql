/*
 Navicat Premium Dump SQL

 Source Server         : 8.4.7
 Source Server Type    : MySQL
 Source Server Version : 80407 (8.4.7)
 Source Host           : localhost:3309
 Source Schema         : property-service-system

 Target Server Type    : MySQL
 Target Server Version : 80407 (8.4.7)
 File Encoding         : 65001

 Date: 03/03/2026 15:57:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for income_detail
-- ----------------------------
DROP TABLE IF EXISTS `income_detail`;
CREATE TABLE `income_detail`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `investment_id` int NOT NULL COMMENT '招商信息ID',
  `income_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收益类型(租金、押金、管理费、广告费)',
  `amount` decimal(15, 2) NOT NULL COMMENT '金额',
  `payment_date` date NULL DEFAULT NULL COMMENT '付款日期',
  `period_start` date NULL DEFAULT NULL COMMENT '计费周期开始',
  `period_end` date NULL DEFAULT NULL COMMENT '计费周期结束',
  `payer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '付款方名称',
  `payer_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '付款方电话',
  `payment_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '付款方式(现金、转账、支付宝、微信)',
  `invoice_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发票编号',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_investment_id`(`investment_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '收益明细管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of income_detail
-- ----------------------------
INSERT INTO `income_detail` VALUES (1, 2, '租金', 20000.00, '2026-01-12', '2026-02-01', '2026-02-28', 'ABC科技有限公司', '13900139001', '银行转账', 'INV20260112001', 'admin', '2025-12-30 20:46:34', NULL, NULL, '首月租金');
INSERT INTO `income_detail` VALUES (2, 2, '押金', 40000.00, '2026-01-12', '2026-02-01', '2026-01-31', 'ABC科技有限公司', '13900139001', '银行转账', 'INV20260112002', 'admin', '2025-12-30 20:46:34', NULL, NULL, '合同押金(两个月租金)');
INSERT INTO `income_detail` VALUES (3, 5, '租金', 7200.00, '2026-01-20', '2026-02-01', '2026-02-28', '创意儿童绘画中心', '13900139002', '微信支付', 'INV20260120001', 'admin', '2025-12-30 20:46:34', NULL, NULL, '首月租金');
INSERT INTO `income_detail` VALUES (4, 5, '管理费', 600.00, '2026-01-20', '2026-02-01', '2026-02-28', '创意儿童绘画中心', '13900139002', '微信支付', 'INV20260120002', 'admin', '2025-12-30 20:46:34', NULL, NULL, '物业管理费');
INSERT INTO `income_detail` VALUES (5, 5, '押金', 14400.00, '2026-01-20', '2026-02-01', '2026-01-31', '创意儿童绘画中心', '13900139002', '银行转账', 'INV20260120003', 'admin', '2025-12-30 20:46:34', NULL, NULL, '合同押金(两个月租金)');

-- ----------------------------
-- Table structure for investment_info
-- ----------------------------
DROP TABLE IF EXISTS `investment_info`;
CREATE TABLE `investment_info`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '招商标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '招商内容',
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '招商位置',
  `area` decimal(10, 2) NULL DEFAULT NULL COMMENT '面积(平方米)',
  `rent_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '租金单价(元/月/平方米)',
  `contact_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '状态(0:待招商,1:已签约,2:已关闭)',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '招商信息发布表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of investment_info
-- ----------------------------
INSERT INTO `investment_info` VALUES (1, 'A栋一楼商铺招商', '位于小区主入口，人流量大，适合便利店、药店等', 'A栋一楼101', 80.00, 150.00, '张经理', '13800138001', 0, '2026-01-15 09:00:00', 'admin', '2025-12-30 20:46:34', NULL, NULL, '招租中，欢迎咨询');
INSERT INTO `investment_info` VALUES (2, 'B栋二楼办公空间招租', '精装修办公空间，配备独立空调，拎包入住', 'B栋二楼201-203', 200.00, 100.00, '李主任', '13800138002', 1, '2026-01-10 10:00:00', 'admin', '2025-12-30 20:46:34', 'super', '2026-02-04 21:54:34', '已签约，合同期3年');
INSERT INTO `investment_info` VALUES (3, '小区会所健身房招租', '会所内300平米空间，适合健身品牌入驻', '会所一楼东侧', 300.00, 80.00, '王总', '13800138003', 0, '2026-01-20 14:30:00', 'admin', '2025-12-30 20:46:34', NULL, NULL, '有多个品牌在洽谈中');
INSERT INTO `investment_info` VALUES (4, '地下停车场广告位招商', '地下停车场入口及通道广告位招商', '地下停车场', 15.00, 500.00, '赵主管', '13800138004', 0, '2026-01-05 11:00:00', 'admin', '2025-12-30 20:46:34', NULL, NULL, '广告位招租，位置优越');
INSERT INTO `investment_info` VALUES (5, '儿童游乐区配套招商', '儿童游乐区旁配套服务招商，适合儿童摄影、培训等', '儿童游乐区旁', 60.00, 120.00, '孙经理', '13800138005', 1, '2026-01-18 15:20:00', 'admin', '2025-12-30 20:46:34', NULL, NULL, '已签约儿童绘画培训中心');

-- ----------------------------
-- Table structure for investment_progress
-- ----------------------------
DROP TABLE IF EXISTS `investment_progress`;
CREATE TABLE `investment_progress`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `investment_id` int NOT NULL COMMENT '招商信息ID',
  `progress_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '进度类型(咨询、考察、洽谈、签约)',
  `progress_desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '进度描述',
  `progress_date` date NULL DEFAULT NULL COMMENT '进度日期',
  `next_plan` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '下一步计划',
  `track_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跟进人',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_investment_id`(`investment_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '招商进度跟踪表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of investment_progress
-- ----------------------------
INSERT INTO `investment_progress` VALUES (1, 1, '咨询', '3名客户电话咨询，其中1名表示有意向实地考察', '2026-01-16', '安排有意向客户实地考察', '张经理', 'admin', '2025-12-30 20:46:34', NULL, NULL, '需跟进客户A');
INSERT INTO `investment_progress` VALUES (2, 2, '签约', '与ABC公司签订3年租赁合同，已支付首期租金', '2026-01-12', '协助客户办理入驻手续', '李主任', 'admin', '2025-12-30 20:46:34', NULL, NULL, '合同已归档');
INSERT INTO `investment_progress` VALUES (3, 2, '考察', '客户实地考察办公空间，对装修和位置表示满意', '2026-01-11', '准备合同细节洽谈', '李主任', 'admin', '2025-12-30 20:46:34', NULL, NULL, '客户对价格无异议');
INSERT INTO `investment_progress` VALUES (4, 3, '咨询', '收到2家健身品牌咨询', '2026-01-22', '发送详细资料给咨询客户', '王总', 'admin', '2025-12-30 20:46:34', NULL, NULL, '等待客户回复');
INSERT INTO `investment_progress` VALUES (5, 4, '洽谈', '与广告公司洽谈价格和合作细节', '2026-01-08', '准备合同草案', '赵主管', 'admin', '2025-12-30 20:46:34', NULL, NULL, '价格已初步达成一致');
INSERT INTO `investment_progress` VALUES (6, 5, '签约', '与儿童绘画培训中心签订2年合同', '2026-01-20', '协助布置场地', '孙经理', 'admin', '2025-12-30 20:46:34', NULL, NULL, '已收到押金和首月租金');

-- ----------------------------
-- Table structure for owner_points_history
-- ----------------------------
DROP TABLE IF EXISTS `owner_points_history`;
CREATE TABLE `owner_points_history`  (
  `history_id` bigint NOT NULL AUTO_INCREMENT COMMENT '历史记录ID',
  `owner_id` bigint NOT NULL COMMENT '业主ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `old_points` int NULL DEFAULT NULL COMMENT '调整前积分',
  `new_points` int NULL DEFAULT NULL COMMENT '调整后积分',
  `adjust_points` int NULL DEFAULT NULL COMMENT '调整积分值（正数为增加，负数为减少）',
  `adjust_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '调整类型（ADD:增加, SUBTRACT:减少, SET:直接设置）',
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '调整原因',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`history_id`) USING BTREE,
  INDEX `idx_owner_id`(`owner_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '业主积分调整历史记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of owner_points_history
-- ----------------------------
INSERT INTO `owner_points_history` VALUES (1, 6, 103, 0, 20, 20, 'ADD', '新用户注册奖励', 'admin', '2024-01-01 10:00:00');
INSERT INTO `owner_points_history` VALUES (2, 7, 1, 0, 12, 12, 'ADD', '系统管理员初始积分', 'admin', '2024-01-02 14:30:00');
INSERT INTO `owner_points_history` VALUES (3, 8, 105, 0, 4, 4, 'ADD', '新业主注册', 'admin', '2024-01-03 16:45:00');
INSERT INTO `owner_points_history` VALUES (4, 8, 105, 4, 24, 20, 'ADD', '2025年1月10日在小区门口见义勇为，赠予20积分', 'super', '2026-01-13 13:45:52');
INSERT INTO `owner_points_history` VALUES (6, 8, 105, 24, 20, -4, 'SUBTRACT', '减积分功能测试', 'super', '2026-01-13 13:52:25');
INSERT INTO `owner_points_history` VALUES (10, 8, 105, 50, 70, 20, 'ADD', '测试', 'super', '2026-01-13 14:07:00');
INSERT INTO `owner_points_history` VALUES (11, 8, 105, 70, 40, -30, 'SUBTRACT', '系统缴费扣减积分，订单号：ORD20260113145834507，抵扣金额：¥3', '李春伟', '2026-01-13 14:59:21');
INSERT INTO `owner_points_history` VALUES (12, 8, 105, 40, 30, -10, 'SUBTRACT', '系统缴费扣减积分，订单号：REN20260118101419827，抵扣金额：¥1', '李春伟', '2026-01-18 10:15:29');
INSERT INTO `owner_points_history` VALUES (13, 8, 105, 30, 20, -10, 'SUBTRACT', '系统缴费扣减积分，订单号：ORD20260118103026238，抵扣金额：¥1', '李春伟', '2026-01-18 10:31:15');
INSERT INTO `owner_points_history` VALUES (14, 8, 105, 20, 10, -10, 'SUBTRACT', '系统缴费扣减积分，订单号：ORD20260118104810743，抵扣金额：¥1', '李春伟', '2026-01-18 10:49:12');
INSERT INTO `owner_points_history` VALUES (15, 8, 105, 10, 60, 50, 'ADD', '系统调整', 'super', '2026-01-18 10:53:54');
INSERT INTO `owner_points_history` VALUES (16, 8, 105, 60, 70, 10, 'ADD', '测试', 'super', '2026-01-18 10:54:19');
INSERT INTO `owner_points_history` VALUES (17, 8, 105, 70, 30, -40, 'SUBTRACT', '系统缴费扣减积分，订单号：ORD20260118105443962，抵扣金额：¥4', '李春伟', '2026-01-18 10:56:13');
INSERT INTO `owner_points_history` VALUES (18, 8, 105, 30, 50, 20, 'ADD', '测试', 'super', '2026-01-18 10:59:44');
INSERT INTO `owner_points_history` VALUES (19, 8, 105, 50, 80, 30, 'ADD', '测试', 'super', '2026-01-18 11:07:35');
INSERT INTO `owner_points_history` VALUES (20, 7, 1, 12, 42, 30, 'ADD', '测试', 'super', '2026-01-18 13:47:12');
INSERT INTO `owner_points_history` VALUES (21, 7, 1, 42, 132, 90, 'ADD', '测试', 'super', '2026-01-18 13:47:23');
INSERT INTO `owner_points_history` VALUES (22, 8, 105, 80, 79, -1, 'SUBTRACT', '测试', 'super', '2026-01-18 13:47:41');
INSERT INTO `owner_points_history` VALUES (23, 8, 105, 79, 80, 1, 'ADD', '测试', 'super', '2026-01-18 13:47:49');
INSERT INTO `owner_points_history` VALUES (24, 8, 105, 80, 40, -40, 'SUBTRACT', '系统缴费扣减积分，订单号：REN20260202124317589，抵扣金额：¥4', '李春伟', '2026-02-03 14:54:05');
INSERT INTO `owner_points_history` VALUES (25, 8, 105, 40, 30, -10, 'SUBTRACT', '系统缴费扣减积分，订单号：ORD20260303145714967，抵扣金额：¥1', '李春伟', '2026-03-03 14:58:16');

-- ----------------------------
-- Table structure for owner_welfare
-- ----------------------------
DROP TABLE IF EXISTS `owner_welfare`;
CREATE TABLE `owner_welfare`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `owner_id` int NOT NULL COMMENT '业主ID',
  `owner_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '业主姓名',
  `room_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房间号',
  `welfare_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '福利类型(节日礼品、生日礼券、积分兑换)',
  `welfare_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '福利名称',
  `welfare_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '福利描述',
  `apply_time` datetime NULL DEFAULT NULL COMMENT '申领时间',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '领取时间',
  `receive_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '领取方式(自提、配送)',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '状态(0:待领取,1:已领取,2:已过期)',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_owner_id`(`owner_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '业主福利申领表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of owner_welfare
-- ----------------------------
INSERT INTO `owner_welfare` VALUES (1, 6, '王佳怡', '521', '节日礼品', '2026年春节礼盒', '包含坚果、糖果、春联等', '2026-01-25 10:30:00', '2026-01-26 15:20:00', '自提', 1, 'admin', '2025-12-30 20:46:34', 'super', '2026-02-10 19:15:31', '业主自行到物业中心领取');
INSERT INTO `owner_welfare` VALUES (2, 8, '赵文浩', '202', '生日礼券', '1月份生日礼券', '价值100元的超市购物券', '2026-01-10 09:15:00', NULL, '配送', 0, 'admin', '2025-12-30 20:46:34', 'super', '2026-02-10 19:15:47', '等待配送');
INSERT INTO `owner_welfare` VALUES (7, 8, '李春伟', '521', '节日礼品', '测试数据', '121212121212', '2026-01-21 00:00:00', '2026-01-23 00:00:00', '自提', 0, 'super', '2026-01-21 13:50:54', 'super', '2026-01-21 14:35:24', '测试');

-- ----------------------------
-- Table structure for sys_car_register
-- ----------------------------
DROP TABLE IF EXISTS `sys_car_register`;
CREATE TABLE `sys_car_register`  (
  `car_id` int NOT NULL AUTO_INCREMENT COMMENT '车辆ID',
  `owner_id` int NOT NULL COMMENT '业主ID',
  `owner_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '业主姓名',
  `plate_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '车牌号码',
  `car_brand` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '车辆品牌',
  `car_model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '车辆型号',
  `car_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '车辆颜色',
  `parking_space` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '停车位号',
  `register_date` date NOT NULL COMMENT '登记日期',
  `expire_date` date NULL DEFAULT NULL COMMENT '有效期至',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1过期）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  PRIMARY KEY (`car_id`) USING BTREE,
  UNIQUE INDEX `uniq_plate_number`(`plate_number` ASC) USING BTREE,
  INDEX `idx_owner_id`(`owner_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '车辆登记表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_car_register
-- ----------------------------
INSERT INTO `sys_car_register` VALUES (1, 8, '李春伟', '粤S6A86G', '广汽传祺', 'SUV', '白', 'A区33号', '2026-01-20', '2028-06-06', '0', '测试数据', '2026-01-20 13:21:16', NULL, 'super', '');

-- ----------------------------
-- Table structure for sys_car_scan
-- ----------------------------
DROP TABLE IF EXISTS `sys_car_scan`;
CREATE TABLE `sys_car_scan`  (
  `scan_id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_Id` int NOT NULL COMMENT '用户id',
  `park_id` bigint NULL DEFAULT NULL COMMENT '停车场ID',
  `plate_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车牌颜色',
  `plate_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车牌号',
  `type` int NULL DEFAULT NULL COMMENT '是否固定车（0不是 1是）',
  `direction` int NULL DEFAULT NULL COMMENT '方向（0驶入 1驶出）',
  `picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '扫面图片地址',
  `create_time` datetime NULL DEFAULT NULL COMMENT '扫描时间',
  PRIMARY KEY (`scan_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '车辆出入信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_car_scan
-- ----------------------------
INSERT INTO `sys_car_scan` VALUES (105, 103, 2, 'blue', '沪KR9888', 0, 0, '/profile/plate/2025/05/10/111_20250510020831A001.jpg', '2025-05-10 02:08:36');
INSERT INTO `sys_car_scan` VALUES (106, 103, 2, 'blue', '沪KR9888', 0, 1, '/profile/plate/2025/05/10/111_20250510020902A002.jpg', '2025-05-10 02:09:04');
INSERT INTO `sys_car_scan` VALUES (107, 1, 2, 'blue', '粤S6A86G', 0, 0, '/profile/plate/2025/12/30/a14f-kquziii5699814_20251230143943A001.jpg', '2025-12-30 14:39:57');
INSERT INTO `sys_car_scan` VALUES (108, 1, 2, 'blue', '粤S6A86G', 0, 1, '/profile/plate/2025/12/30/a14f-kquziii5699814_20251230144029A002.jpg', '2025-12-30 14:40:32');
INSERT INTO `sys_car_scan` VALUES (109, 1, 2, 'blue', '粤S6A86G', 0, 0, '/profile/plate/2026/01/18/车牌1_20260118105853A001.jpg', '2026-01-18 10:59:00');
INSERT INTO `sys_car_scan` VALUES (110, 1, 2, 'blue', '粤S6A86G', 0, 1, '/profile/plate/2026/01/18/车牌1_20260118111909A002.jpg', '2026-01-18 11:19:21');
INSERT INTO `sys_car_scan` VALUES (111, 1, 2, 'blue', '粤S6A86G', 1, 0, '/profile/plate/2026/01/22/车牌1_20260122124115A001.jpg', '2026-01-22 12:41:22');
INSERT INTO `sys_car_scan` VALUES (112, 1, 2, 'blue', '苏EG08P9', 0, 0, '/profile/plate/2026/01/22/车牌2_20260122124236A002.jpg', '2026-01-22 12:42:40');
INSERT INTO `sys_car_scan` VALUES (113, 1, 2, 'blue', '苏EG08P9', 0, 1, '/profile/plate/2026/01/22/车牌2_20260122130002A001.jpg', '2026-01-22 13:00:03');
INSERT INTO `sys_car_scan` VALUES (114, 1, 2, 'blue', '粤S6A86G', 1, 1, '/profile/plate/2026/01/22/车牌1_20260122130013A002.jpg', '2026-01-22 13:00:15');
INSERT INTO `sys_car_scan` VALUES (115, 1, 2, 'blue', '粤S6A86G', 1, 0, '/profile/plate/2026/02/10/车牌1_20260210083640A001.jpg', '2026-02-10 08:36:49');
INSERT INTO `sys_car_scan` VALUES (116, 1, 2, 'blue', '粤S6A86G', 1, 1, '/profile/plate/2026/02/10/车牌1_20260210083718A002.jpg', '2026-02-10 08:37:20');

-- ----------------------------
-- Table structure for sys_check_in
-- ----------------------------
DROP TABLE IF EXISTS `sys_check_in`;
CREATE TABLE `sys_check_in`  (
  `check_in_id` int NOT NULL AUTO_INCREMENT COMMENT '入住ID',
  `property_id` int NOT NULL COMMENT '房产ID',
  `owner_id` int NOT NULL COMMENT '业主ID',
  `owner_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '业主姓名',
  `check_in_date` date NOT NULL COMMENT '入住日期',
  `expected_duration` int NULL DEFAULT NULL COMMENT '预计居住时长(月)',
  `contract_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '合同编号',
  `rental_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '租金金额',
  `deposit_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '押金金额',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1已退房）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  PRIMARY KEY (`check_in_id`) USING BTREE,
  INDEX `idx_property_id`(`property_id` ASC) USING BTREE,
  INDEX `idx_owner_id`(`owner_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '入住登记表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_check_in
-- ----------------------------
INSERT INTO `sys_check_in` VALUES (1, 4, 8, '李春伟', '2026-01-20', 12, 'ASD1233432', 5000.00, 1200.00, '0', '入住登记功能测试', '2026-01-20 13:19:24', NULL, 'super', '');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-04-07 21:33:13', 'super', '2026-01-18 14:02:02', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-04-07 21:33:13', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-light', 'Y', 'admin', '2025-04-07 21:33:13', 'super', '2025-05-09 23:41:52', '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-04-07 21:33:13', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2025-04-07 21:33:13', 'super', '2025-05-09 23:41:35', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-04-07 21:33:13', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_damage_record
-- ----------------------------
DROP TABLE IF EXISTS `sys_damage_record`;
CREATE TABLE `sys_damage_record`  (
  `damage_id` bigint NOT NULL AUTO_INCREMENT COMMENT '损坏ID',
  `facility_id` bigint NULL DEFAULT NULL COMMENT '设施ID',
  `facility_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设施编号',
  `facility_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设施名称',
  `damage_date` date NULL DEFAULT NULL COMMENT '损坏日期',
  `damage_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '损坏类型（1人为损坏 2自然损坏 3老化损坏）',
  `damage_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '损坏描述',
  `reporter` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上报人',
  `reporter_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上报人电话',
  `handle_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '处理状态（0未处理 1处理中 2已处理）',
  `handle_method` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理方式（1维修 2更换 3报废）',
  `handle_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理人',
  `handle_date` date NULL DEFAULT NULL COMMENT '处理日期',
  `handle_result` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理结果',
  `attachments` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件（照片等）',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`damage_id`) USING BTREE,
  INDEX `idx_facility_id`(`facility_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '损坏报废登记表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_damage_record
-- ----------------------------
INSERT INTO `sys_damage_record` VALUES (1, 3, 'FS-2023-003', '休闲长椅', '2026-02-19', '1', '椅面木板断裂，螺丝松动', '赵六', '13800138004', '1', '1', '维修员B', '2026-03-03', NULL, '', '等待配件到货', 'admin', '2025-12-30 18:03:04', 'super', '2026-03-03 15:46:52');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 144 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 0, '维修', '维修', 'sys_order_type', NULL, 'default', 'N', '0', 'admin', '2025-05-05 21:46:08', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (101, 0, '房租', '房租', 'sys_order_type', NULL, 'default', 'N', '0', 'admin', '2025-05-05 21:46:28', 'admin', '2025-05-05 21:47:11', '日常费用等。');
INSERT INTO `sys_dict_data` VALUES (102, 4, '其它', '其它', 'sys_order_type', NULL, 'default', 'N', '0', 'admin', '2025-05-05 21:46:54', 'admin', '2025-05-06 23:29:56', NULL);
INSERT INTO `sys_dict_data` VALUES (103, 3, '停车费', '停车费', 'sys_order_type', NULL, 'default', 'N', '0', 'admin', '2025-05-06 23:29:46', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (104, 0, '待处理', '0', 'sys_repair_status', NULL, 'info', 'N', '0', 'admin', '2025-05-07 23:33:55', 'super', '2026-01-19 11:14:41', '初始状态');
INSERT INTO `sys_dict_data` VALUES (105, 1, '已完成', '1', 'sys_repair_status', NULL, 'primary', 'N', '0', 'admin', '2025-05-07 23:34:09', 'super', '2026-01-19 11:15:37', '维修完成后状态');
INSERT INTO `sys_dict_data` VALUES (106, 2, '维修中', '2', 'sys_repair_status', NULL, 'primary', 'N', '0', 'admin', '2025-05-07 23:34:23', 'super', '2026-01-19 11:14:33', '分配工人后的状态');
INSERT INTO `sys_dict_data` VALUES (107, 3, '已评价', '3', 'sys_repair_status', NULL, 'success', 'N', '0', 'admin', '2025-05-07 23:34:36', 'super', '2026-01-19 11:15:12', '评分后的状态');
INSERT INTO `sys_dict_data` VALUES (108, 1, '待招商', '0', 'investment_status', '', 'primary', 'Y', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (109, 2, '已签约', '1', 'investment_status', '', 'success', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (110, 3, '已关闭', '2', 'investment_status', '', 'danger', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (111, 1, '咨询', '咨询', 'progress_type', '', 'primary', 'Y', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (112, 2, '考察', '考察', 'progress_type', '', 'info', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (113, 3, '洽谈', '洽谈', 'progress_type', '', 'warning', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (114, 4, '签约', '签约', 'progress_type', '', 'success', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (115, 1, '租金', '租金', 'income_type', '', 'primary', 'Y', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (116, 2, '押金', '押金', 'income_type', '', 'success', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (117, 3, '管理费', '管理费', 'income_type', '', 'info', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (118, 4, '广告费', '广告费', 'income_type', '', 'warning', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (119, 1, '现金', '现金', 'payment_method', '', 'primary', 'Y', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (120, 2, '转账', '转账', 'payment_method', '', 'success', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (121, 3, '支付宝', '支付宝', 'payment_method', '', 'info', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (122, 4, '微信', '微信', 'payment_method', '', 'warning', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (123, 1, '节日礼品', '节日礼品', 'welfare_type', '', 'primary', 'Y', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (124, 2, '生日礼券', '生日礼券', 'welfare_type', '', 'success', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (125, 3, '积分兑换', '积分兑换', 'welfare_type', '', 'info', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (126, 1, '待领取', '0', 'welfare_status', '', 'primary', 'Y', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (127, 2, '已领取', '1', 'welfare_status', '', 'success', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (128, 3, '已过期', '2', 'welfare_status', '', 'danger', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (129, 1, '自提', '自提', 'receive_method', '', 'primary', 'Y', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (130, 2, '配送', '配送', 'receive_method', '', 'success', 'N', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '');
INSERT INTO `sys_dict_data` VALUES (131, 1, '男', '0', 'sys_gender', '', '', 'Y', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (132, 2, '女', '1', 'sys_gender', '', '', 'N', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (133, 3, '未知', '2', 'sys_gender', '', '', 'N', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (134, 1, '电工', 'electrician', 'sys_worker_type', '', '', 'Y', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (135, 2, '水工', 'plumber', 'sys_worker_type', '', '', 'N', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (136, 3, '木工', 'carpenter', 'sys_worker_type', '', '', 'N', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (137, 4, '瓦工', 'bricklayer', 'sys_worker_type', '', '', 'N', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (138, 5, '油漆工', 'painter', 'sys_worker_type', '', '', 'N', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (139, 6, '清洁工', 'cleaner', 'sys_worker_type', '', '', 'N', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (140, 1, '空闲', '0', 'sys_work_status', '', '', 'Y', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (141, 2, '忙碌', '1', 'sys_work_status', '', '', 'N', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (142, 3, '请假', '2', 'sys_work_status', '', '', 'N', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (143, 4, '离职', '3', 'sys_work_status', '', '', 'N', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 119 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '订单类型', 'sys_order_type', '0', 'admin', '2025-05-05 21:43:24', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (101, '维修状态', 'sys_repair_status', '0', 'admin', '2025-05-07 23:32:21', 'admin', '2025-05-08 01:21:38', NULL);
INSERT INTO `sys_dict_type` VALUES (102, '招商状态', 'investment_status', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '招商信息状态列表');
INSERT INTO `sys_dict_type` VALUES (103, '进度类型', 'progress_type', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '招商进度类型列表');
INSERT INTO `sys_dict_type` VALUES (104, '收益类型', 'income_type', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '收益明细类型列表');
INSERT INTO `sys_dict_type` VALUES (105, '付款方式', 'payment_method', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '付款方式列表');
INSERT INTO `sys_dict_type` VALUES (106, '福利类型', 'welfare_type', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '业主福利类型列表');
INSERT INTO `sys_dict_type` VALUES (107, '福利状态', 'welfare_status', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '福利申领状态列表');
INSERT INTO `sys_dict_type` VALUES (108, '领取方式', 'receive_method', '0', 'admin', '2025-12-30 20:31:43', 'admin', '2025-12-30 20:31:43', '福利领取方式列表');
INSERT INTO `sys_dict_type` VALUES (116, '性别', 'sys_gender', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '性别字典');
INSERT INTO `sys_dict_type` VALUES (117, '工种', 'sys_worker_type', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '工人工种字典');
INSERT INTO `sys_dict_type` VALUES (118, '工作状态', 'sys_work_status', '0', 'admin', '2025-12-31 10:30:36', '', NULL, '工人工作状态字典');

-- ----------------------------
-- Table structure for sys_feedback
-- ----------------------------
DROP TABLE IF EXISTS `sys_feedback`;
CREATE TABLE `sys_feedback`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '投诉人id',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '投诉人名称',
  `contact` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系方式',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '投诉内容',
  `reply_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '反馈内容',
  `reply_user_id` bigint NULL DEFAULT NULL COMMENT '回复人ID',
  `reply_user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '回复人名称',
  `reply_time` datetime NULL DEFAULT NULL COMMENT '回复时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` int NULL DEFAULT 0 COMMENT '删除标志（0代表存在，1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '投诉与反馈表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_feedback
-- ----------------------------
INSERT INTO `sys_feedback` VALUES (3, 103, '张敏', '125205632', '隔壁吵死了', '已跟对方商量', 2, 'manager', '2025-05-10 03:00:12', '2025-05-10 02:59:28', '2026-02-02 17:54:22', 1);
INSERT INTO `sys_feedback` VALUES (4, 105, '李春伟', '18846571726', '楼上小孩一直跑', '已处理', 1, 'super', '2025-12-31 14:23:57', '2025-12-31 14:23:27', '2025-12-31 14:23:56', 0);
INSERT INTO `sys_feedback` VALUES (5, 105, '李春伟', '18846571726', '邻居太吵了', '已处理', 1, 'super', '2026-03-03 15:56:18', '2026-02-02 18:28:25', '2026-03-03 15:56:18', 0);

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 198 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (1, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 07:57:30');
INSERT INTO `sys_logininfor` VALUES (2, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 07:58:09');
INSERT INTO `sys_logininfor` VALUES (3, 'manager', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 07:58:17');
INSERT INTO `sys_logininfor` VALUES (4, 'manager', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 07:59:50');
INSERT INTO `sys_logininfor` VALUES (5, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 07:59:57');
INSERT INTO `sys_logininfor` VALUES (6, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 08:01:58');
INSERT INTO `sys_logininfor` VALUES (7, 'manager', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 08:02:08');
INSERT INTO `sys_logininfor` VALUES (8, 'manager', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 08:02:26');
INSERT INTO `sys_logininfor` VALUES (9, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-01-19 08:02:35');
INSERT INTO `sys_logininfor` VALUES (10, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 08:02:39');
INSERT INTO `sys_logininfor` VALUES (11, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 08:10:40');
INSERT INTO `sys_logininfor` VALUES (12, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 08:10:57');
INSERT INTO `sys_logininfor` VALUES (13, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 08:12:15');
INSERT INTO `sys_logininfor` VALUES (14, 'xiaoming', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-19 08:13:11');
INSERT INTO `sys_logininfor` VALUES (15, 'xiaoming', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 08:13:21');
INSERT INTO `sys_logininfor` VALUES (16, 'xiaoming', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 08:13:30');
INSERT INTO `sys_logininfor` VALUES (17, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 08:13:36');
INSERT INTO `sys_logininfor` VALUES (18, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 08:16:32');
INSERT INTO `sys_logininfor` VALUES (19, 'demo', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-19 08:18:02');
INSERT INTO `sys_logininfor` VALUES (20, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-19 08:58:40');
INSERT INTO `sys_logininfor` VALUES (21, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 08:58:49');
INSERT INTO `sys_logininfor` VALUES (22, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 09:00:10');
INSERT INTO `sys_logininfor` VALUES (23, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 09:00:21');
INSERT INTO `sys_logininfor` VALUES (24, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 09:01:13');
INSERT INTO `sys_logininfor` VALUES (25, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 09:01:24');
INSERT INTO `sys_logininfor` VALUES (26, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 10:11:48');
INSERT INTO `sys_logininfor` VALUES (27, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 10:11:54');
INSERT INTO `sys_logininfor` VALUES (28, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 10:12:22');
INSERT INTO `sys_logininfor` VALUES (29, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 10:12:28');
INSERT INTO `sys_logininfor` VALUES (30, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 11:04:26');
INSERT INTO `sys_logininfor` VALUES (31, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 11:05:04');
INSERT INTO `sys_logininfor` VALUES (32, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 11:05:10');
INSERT INTO `sys_logininfor` VALUES (33, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 11:15:55');
INSERT INTO `sys_logininfor` VALUES (34, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 11:16:06');
INSERT INTO `sys_logininfor` VALUES (35, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 11:16:29');
INSERT INTO `sys_logininfor` VALUES (36, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 11:16:36');
INSERT INTO `sys_logininfor` VALUES (37, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 11:20:25');
INSERT INTO `sys_logininfor` VALUES (38, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 11:20:35');
INSERT INTO `sys_logininfor` VALUES (39, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 11:21:00');
INSERT INTO `sys_logininfor` VALUES (40, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 11:21:10');
INSERT INTO `sys_logininfor` VALUES (41, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 11:25:06');
INSERT INTO `sys_logininfor` VALUES (42, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-01-19 11:25:16');
INSERT INTO `sys_logininfor` VALUES (43, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 11:25:20');
INSERT INTO `sys_logininfor` VALUES (44, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-19 11:25:56');
INSERT INTO `sys_logininfor` VALUES (45, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 11:26:02');
INSERT INTO `sys_logininfor` VALUES (46, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-20 11:54:08');
INSERT INTO `sys_logininfor` VALUES (47, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-20 12:34:08');
INSERT INTO `sys_logininfor` VALUES (48, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-20 14:15:34');
INSERT INTO `sys_logininfor` VALUES (49, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-20 14:26:43');
INSERT INTO `sys_logininfor` VALUES (50, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-01-20 14:26:50');
INSERT INTO `sys_logininfor` VALUES (51, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-20 14:26:54');
INSERT INTO `sys_logininfor` VALUES (52, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-20 14:27:18');
INSERT INTO `sys_logininfor` VALUES (53, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-20 14:27:27');
INSERT INTO `sys_logininfor` VALUES (54, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-20 16:13:13');
INSERT INTO `sys_logininfor` VALUES (55, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-20 17:48:14');
INSERT INTO `sys_logininfor` VALUES (56, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-01-20 19:00:55');
INSERT INTO `sys_logininfor` VALUES (57, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-01-20 19:00:59');
INSERT INTO `sys_logininfor` VALUES (58, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-20 19:01:03');
INSERT INTO `sys_logininfor` VALUES (59, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-21 11:13:48');
INSERT INTO `sys_logininfor` VALUES (60, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-21 11:13:53');
INSERT INTO `sys_logininfor` VALUES (61, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-21 11:20:00');
INSERT INTO `sys_logininfor` VALUES (62, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-21 11:23:23');
INSERT INTO `sys_logininfor` VALUES (63, 'aaa', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-21 11:24:09');
INSERT INTO `sys_logininfor` VALUES (64, 'aaa', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-21 11:24:17');
INSERT INTO `sys_logininfor` VALUES (65, 'aaa', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-21 11:36:51');
INSERT INTO `sys_logininfor` VALUES (66, 'aaa', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-21 11:44:27');
INSERT INTO `sys_logininfor` VALUES (67, 'aaa', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-21 11:44:34');
INSERT INTO `sys_logininfor` VALUES (68, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-21 11:44:43');
INSERT INTO `sys_logininfor` VALUES (69, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-21 13:40:14');
INSERT INTO `sys_logininfor` VALUES (70, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-22 12:21:35');
INSERT INTO `sys_logininfor` VALUES (71, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-22 12:59:42');
INSERT INTO `sys_logininfor` VALUES (72, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-22 21:25:12');
INSERT INTO `sys_logininfor` VALUES (73, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-24 16:15:00');
INSERT INTO `sys_logininfor` VALUES (74, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-24 16:35:18');
INSERT INTO `sys_logininfor` VALUES (75, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-24 16:35:27');
INSERT INTO `sys_logininfor` VALUES (76, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-24 16:35:32');
INSERT INTO `sys_logininfor` VALUES (77, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-24 16:36:10');
INSERT INTO `sys_logininfor` VALUES (78, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-24 16:36:13');
INSERT INTO `sys_logininfor` VALUES (79, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-24 16:36:21');
INSERT INTO `sys_logininfor` VALUES (80, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-24 16:36:27');
INSERT INTO `sys_logininfor` VALUES (81, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-24 16:36:31');
INSERT INTO `sys_logininfor` VALUES (82, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-25 21:35:49');
INSERT INTO `sys_logininfor` VALUES (83, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-29 19:55:20');
INSERT INTO `sys_logininfor` VALUES (84, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-29 19:55:29');
INSERT INTO `sys_logininfor` VALUES (85, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-29 19:55:35');
INSERT INTO `sys_logininfor` VALUES (86, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-29 20:29:56');
INSERT INTO `sys_logininfor` VALUES (87, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-29 20:30:02');
INSERT INTO `sys_logininfor` VALUES (88, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 09:39:54');
INSERT INTO `sys_logininfor` VALUES (89, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 09:58:56');
INSERT INTO `sys_logininfor` VALUES (90, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-02-02 11:52:47');
INSERT INTO `sys_logininfor` VALUES (91, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-02-02 11:52:50');
INSERT INTO `sys_logininfor` VALUES (92, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 11:52:54');
INSERT INTO `sys_logininfor` VALUES (93, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 12:43:20');
INSERT INTO `sys_logininfor` VALUES (94, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 12:43:32');
INSERT INTO `sys_logininfor` VALUES (95, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 12:55:54');
INSERT INTO `sys_logininfor` VALUES (96, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 12:56:03');
INSERT INTO `sys_logininfor` VALUES (97, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 14:05:39');
INSERT INTO `sys_logininfor` VALUES (98, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 14:05:56');
INSERT INTO `sys_logininfor` VALUES (99, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 14:06:37');
INSERT INTO `sys_logininfor` VALUES (100, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 14:06:47');
INSERT INTO `sys_logininfor` VALUES (101, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 14:07:16');
INSERT INTO `sys_logininfor` VALUES (102, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 14:07:24');
INSERT INTO `sys_logininfor` VALUES (103, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 14:07:35');
INSERT INTO `sys_logininfor` VALUES (104, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-02-02 14:32:17');
INSERT INTO `sys_logininfor` VALUES (105, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 14:32:24');
INSERT INTO `sys_logininfor` VALUES (106, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 15:14:24');
INSERT INTO `sys_logininfor` VALUES (107, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 15:20:17');
INSERT INTO `sys_logininfor` VALUES (108, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 15:20:29');
INSERT INTO `sys_logininfor` VALUES (109, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 15:35:38');
INSERT INTO `sys_logininfor` VALUES (110, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 15:36:05');
INSERT INTO `sys_logininfor` VALUES (111, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 15:44:50');
INSERT INTO `sys_logininfor` VALUES (112, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 15:45:09');
INSERT INTO `sys_logininfor` VALUES (113, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 16:00:56');
INSERT INTO `sys_logininfor` VALUES (114, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 16:01:14');
INSERT INTO `sys_logininfor` VALUES (115, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-02-02 17:39:21');
INSERT INTO `sys_logininfor` VALUES (116, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 17:39:26');
INSERT INTO `sys_logininfor` VALUES (117, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 17:47:18');
INSERT INTO `sys_logininfor` VALUES (118, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 17:47:26');
INSERT INTO `sys_logininfor` VALUES (119, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 17:54:50');
INSERT INTO `sys_logininfor` VALUES (120, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 17:55:03');
INSERT INTO `sys_logininfor` VALUES (121, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-02 18:28:29');
INSERT INTO `sys_logininfor` VALUES (122, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 18:28:39');
INSERT INTO `sys_logininfor` VALUES (123, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 19:49:42');
INSERT INTO `sys_logininfor` VALUES (124, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-03 14:40:37');
INSERT INTO `sys_logininfor` VALUES (125, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-03 14:43:30');
INSERT INTO `sys_logininfor` VALUES (126, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-03 14:43:40');
INSERT INTO `sys_logininfor` VALUES (127, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-03 15:00:15');
INSERT INTO `sys_logininfor` VALUES (128, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-03 15:43:28');
INSERT INTO `sys_logininfor` VALUES (129, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-02-03 16:45:33');
INSERT INTO `sys_logininfor` VALUES (130, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-03 16:45:38');
INSERT INTO `sys_logininfor` VALUES (131, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-03 16:48:40');
INSERT INTO `sys_logininfor` VALUES (132, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-03 16:48:47');
INSERT INTO `sys_logininfor` VALUES (133, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-03 16:52:54');
INSERT INTO `sys_logininfor` VALUES (134, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-03 16:53:02');
INSERT INTO `sys_logininfor` VALUES (135, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-03 16:59:00');
INSERT INTO `sys_logininfor` VALUES (136, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-03 16:59:11');
INSERT INTO `sys_logininfor` VALUES (137, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-03 17:01:32');
INSERT INTO `sys_logininfor` VALUES (138, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-03 17:01:39');
INSERT INTO `sys_logininfor` VALUES (139, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 21:24:07');
INSERT INTO `sys_logininfor` VALUES (140, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-05 08:28:12');
INSERT INTO `sys_logininfor` VALUES (141, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-05 08:31:12');
INSERT INTO `sys_logininfor` VALUES (142, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-07 11:46:56');
INSERT INTO `sys_logininfor` VALUES (143, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-07 12:19:54');
INSERT INTO `sys_logininfor` VALUES (144, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-07 12:20:02');
INSERT INTO `sys_logininfor` VALUES (145, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-07 12:20:46');
INSERT INTO `sys_logininfor` VALUES (146, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-07 12:20:53');
INSERT INTO `sys_logininfor` VALUES (147, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-07 12:22:30');
INSERT INTO `sys_logininfor` VALUES (148, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-07 12:22:39');
INSERT INTO `sys_logininfor` VALUES (149, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-07 12:22:47');
INSERT INTO `sys_logininfor` VALUES (150, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-07 12:23:01');
INSERT INTO `sys_logininfor` VALUES (151, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-07 12:27:38');
INSERT INTO `sys_logininfor` VALUES (152, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-07 12:27:44');
INSERT INTO `sys_logininfor` VALUES (153, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-02-10 08:36:03');
INSERT INTO `sys_logininfor` VALUES (154, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-10 08:36:07');
INSERT INTO `sys_logininfor` VALUES (155, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-10 19:15:14');
INSERT INTO `sys_logininfor` VALUES (156, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-11 21:21:20');
INSERT INTO `sys_logininfor` VALUES (157, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 10:47:42');
INSERT INTO `sys_logininfor` VALUES (158, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:09:30');
INSERT INTO `sys_logininfor` VALUES (159, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-27 11:09:34');
INSERT INTO `sys_logininfor` VALUES (160, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:09:41');
INSERT INTO `sys_logininfor` VALUES (161, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-27 11:10:55');
INSERT INTO `sys_logininfor` VALUES (162, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:11:04');
INSERT INTO `sys_logininfor` VALUES (163, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-27 11:11:20');
INSERT INTO `sys_logininfor` VALUES (164, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:11:29');
INSERT INTO `sys_logininfor` VALUES (165, 'demo1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-27 11:11:42');
INSERT INTO `sys_logininfor` VALUES (166, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:11:54');
INSERT INTO `sys_logininfor` VALUES (167, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-27 11:12:17');
INSERT INTO `sys_logininfor` VALUES (168, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:12:24');
INSERT INTO `sys_logininfor` VALUES (169, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-27 11:14:07');
INSERT INTO `sys_logininfor` VALUES (170, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:14:18');
INSERT INTO `sys_logininfor` VALUES (171, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-27 11:14:59');
INSERT INTO `sys_logininfor` VALUES (172, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:15:06');
INSERT INTO `sys_logininfor` VALUES (173, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-27 11:15:21');
INSERT INTO `sys_logininfor` VALUES (174, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:15:34');
INSERT INTO `sys_logininfor` VALUES (175, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-27 11:16:28');
INSERT INTO `sys_logininfor` VALUES (176, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:16:34');
INSERT INTO `sys_logininfor` VALUES (177, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-27 11:17:18');
INSERT INTO `sys_logininfor` VALUES (178, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:17:31');
INSERT INTO `sys_logininfor` VALUES (179, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-27 11:18:25');
INSERT INTO `sys_logininfor` VALUES (180, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:18:33');
INSERT INTO `sys_logininfor` VALUES (181, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-27 11:18:46');
INSERT INTO `sys_logininfor` VALUES (182, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:18:58');
INSERT INTO `sys_logininfor` VALUES (183, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-27 11:19:16');
INSERT INTO `sys_logininfor` VALUES (184, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 11:19:22');
INSERT INTO `sys_logininfor` VALUES (185, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-03 14:40:44');
INSERT INTO `sys_logininfor` VALUES (186, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-03 14:45:29');
INSERT INTO `sys_logininfor` VALUES (187, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-03 14:45:38');
INSERT INTO `sys_logininfor` VALUES (188, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-03 14:46:02');
INSERT INTO `sys_logininfor` VALUES (189, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-03 14:46:16');
INSERT INTO `sys_logininfor` VALUES (190, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-03 14:57:20');
INSERT INTO `sys_logininfor` VALUES (191, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-03 14:57:32');
INSERT INTO `sys_logininfor` VALUES (192, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-03 15:28:02');
INSERT INTO `sys_logininfor` VALUES (193, '李春伟', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-03 15:32:28');
INSERT INTO `sys_logininfor` VALUES (194, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-03 15:32:35');
INSERT INTO `sys_logininfor` VALUES (195, 'super', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-03 15:56:21');
INSERT INTO `sys_logininfor` VALUES (196, 'supergergggggggggggggggggggggggggggggggggggg', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-03-03 15:56:31');
INSERT INTO `sys_logininfor` VALUES (197, 'supergergggggggggggggggggggggggggggggggggggg', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-03 15:56:35');

-- ----------------------------
-- Table structure for sys_maintenance_record
-- ----------------------------
DROP TABLE IF EXISTS `sys_maintenance_record`;
CREATE TABLE `sys_maintenance_record`  (
  `record_id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `facility_id` bigint NULL DEFAULT NULL COMMENT '设施ID',
  `facility_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设施编号',
  `facility_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设施名称',
  `maintain_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '维护类型（1日常维护 2故障维修 3定期保养）',
  `maintain_date` date NULL DEFAULT NULL COMMENT '维护日期',
  `maintain_content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '维护内容',
  `maintain_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '维护人',
  `maintain_dept` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '维护部门',
  `cost` decimal(10, 2) NULL DEFAULT NULL COMMENT '维护费用',
  `maintain_result` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '维护结果（1正常 2待观察 3未修复）',
  `next_maintain_date` date NULL DEFAULT NULL COMMENT '下次维护日期',
  `attachments` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件（照片等）',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`record_id`) USING BTREE,
  INDEX `idx_facility_id`(`facility_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '维修维护记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_maintenance_record
-- ----------------------------
INSERT INTO `sys_maintenance_record` VALUES (1, 1, 'FS-2023-001', '儿童滑梯', '2', '2026-03-03', '更换磨损的滑梯垫，加固支架螺丝', '维修员A', '工程部', 300.00, '1', '2026-10-01', '', '定期维护', 'admin', '2025-12-30 18:03:04', 'super', '2026-03-03 15:54:26');
INSERT INTO `sys_maintenance_record` VALUES (2, 3, 'FS-2023-003', '休闲长椅', '2', '2026-03-03', '修复松动螺丝，补漆防腐', '维修员B', '工程部', 150.00, '1', '2026-10-01', '', '居民报修处理', 'admin', '2025-12-30 18:03:04', 'super', '2026-03-03 15:54:32');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3107 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 12, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-04-07 21:33:13', 'super', '2026-01-21 11:50:52', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '房产信息管理', 0, 2, 'property', '', '', '', 1, 1, 'M', '0', '0', '', 'component', 'admin', '2025-04-07 21:33:13', 'super', '2026-01-21 11:49:34', '系统监控目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-04-07 21:33:13', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-04-07 21:33:13', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-04-07 21:33:13', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-04-07 21:33:13', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-04-07 21:33:13', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-04-07 21:33:13', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-04-07 21:33:13', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-04-07 21:33:13', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-04-07 21:33:13', 'super', '2026-01-21 11:45:47', '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 2003, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 2003, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 2003, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-04-07 21:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '房产信息管理', 2, 1, 'property', 'property/index', NULL, '', 1, 1, 'C', '0', '0', 'system:property:list', 'clipboard', 'admin', '2025-04-12 14:17:31', 'admin', '2025-04-12 16:35:54', '');
INSERT INTO `sys_menu` VALUES (2001, '房产信息录入', 2, 2, 'property/add', 'property/add/index', NULL, '', 1, 1, 'C', '0', '0', 'system:property:add', 'input', 'admin', '2025-04-12 14:18:33', 'admin', '2025-04-12 16:36:06', '');
INSERT INTO `sys_menu` VALUES (2002, '通知公告', 0, 11, 'notice', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'message', 'admin', '2025-04-12 14:31:59', 'super', '2026-01-21 11:51:04', '');
INSERT INTO `sys_menu` VALUES (2003, '公告查询', 2002, 1, 'notice', 'notice/index', NULL, '', 1, 0, 'C', '0', '0', 'system:notice:list', 'date-range', 'admin', '2025-04-12 14:33:36', 'admin', '2025-04-12 16:35:04', '');
INSERT INTO `sys_menu` VALUES (2004, '发布公告', 2002, 2, 'notice/add', 'notice/add/index', NULL, '', 1, 0, 'C', '0', '0', 'system:notice:add', 'clipboard', 'admin', '2025-04-12 14:40:41', 'admin', '2025-04-12 16:35:12', '');
INSERT INTO `sys_menu` VALUES (2005, '信息管理', 0, 1, 'owner', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'people', 'admin', '2025-04-12 17:31:28', 'super', '2025-12-31 10:19:58', '');
INSERT INTO `sys_menu` VALUES (2006, '业主信息维护', 2005, 1, 'owner', 'owner/index', NULL, '', 1, 0, 'C', '0', '0', 'system:owner:list', 'form', 'admin', '2025-04-12 17:32:11', 'admin', '2025-04-12 17:33:38', '');
INSERT INTO `sys_menu` VALUES (2007, '业主基本信息维护', 0, 3, 'owner/maintain', 'owner/maintain/index', NULL, '', 1, 0, 'C', '0', '0', NULL, 'user', 'admin', '2025-04-12 17:35:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '停车场信息管理', 0, 7, 'parkInfo', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'component', 'admin', '2025-04-13 00:36:27', 'super', '2026-01-21 11:52:23', '');
INSERT INTO `sys_menu` VALUES (2009, '车位管理', 2008, 1, 'parkInfo/parkingInfo', 'parkInfo/parkingInfo/index', NULL, '', 1, 0, 'C', '0', '0', 'sysetm:parkInfo:list', 'cascader', 'admin', '2025-04-13 00:38:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '车辆管理', 0, 6, 'carScan', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-04-13 15:40:11', 'super', '2026-01-21 11:52:15', '');
INSERT INTO `sys_menu` VALUES (2011, '智能入场识别', 2010, 2, 'carScan/carIn', 'carScan/carIn/index', NULL, '', 1, 0, 'C', '0', '0', 'system:carScan:add', 'cascader', 'admin', '2025-04-13 15:42:18', 'super', '2026-01-20 13:46:35', '');
INSERT INTO `sys_menu` VALUES (2012, '智能出库', 2010, 3, 'carScan/carOut', 'carScan/carOut/index', NULL, '', 1, 0, 'C', '0', '0', 'system:carScan:add', 'component', 'admin', '2025-04-13 17:33:12', 'super', '2026-01-20 13:46:47', '');
INSERT INTO `sys_menu` VALUES (2013, '停车订单一览', 2010, 5, 'parkOrder', 'parkOrder/index', NULL, '', 1, 0, 'C', '0', '0', 'system:parkOrder:list', 'log', 'admin', '2025-04-13 21:07:09', 'super', '2026-01-20 13:47:34', '');
INSERT INTO `sys_menu` VALUES (2014, '出入场记录', 2010, 6, 'carScan', 'carScan/list', NULL, '', 1, 0, 'C', '0', '0', 'system:carScan:list', 'clipboard', 'admin', '2025-04-13 21:43:29', 'super', '2026-01-20 13:47:41', '');
INSERT INTO `sys_menu` VALUES (2015, '投诉与反馈管理', 0, 8, 'feedback', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'edit', 'admin', '2025-04-29 21:32:13', 'super', '2026-01-21 11:52:46', '');
INSERT INTO `sys_menu` VALUES (2016, '投诉与反馈', 2015, 1, 'feedback', 'feedback/index', NULL, '', 1, 1, 'C', '0', '0', 'system:feedback:list', 'redis-list', 'admin', '2025-04-29 21:34:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '用户投诉', 2015, 2, 'feedback/add', 'feedback/add/index', NULL, '', 1, 1, 'C', '0', '0', NULL, 'tool', 'admin', '2025-04-29 22:05:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '投诉信息查询', 2015, 3, 'feedback/user', 'feedback/user/index', NULL, '', 1, 1, 'C', '0', '0', 'system:feedback:list', 'list', 'admin', '2025-04-29 22:13:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '物业账单缴费管理', 0, 4, 'order', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'component', 'admin', '2025-05-05 22:54:32', 'super', '2026-01-21 11:50:08', '');
INSERT INTO `sys_menu` VALUES (2024, '账单缴费', 2023, 2, 'order/user', 'order/user/index', NULL, '', 1, 1, 'C', '0', '0', '', 'list', 'admin', '2025-05-05 22:55:29', 'admin', '2025-05-05 23:11:09', '');
INSERT INTO `sys_menu` VALUES (2025, '账单统计明细', 2023, 1, 'order', 'order/index', NULL, '', 1, 1, 'C', '0', '0', '', 'list', 'admin', '2025-05-05 23:04:44', 'admin', '2025-05-05 23:33:19', '');
INSERT INTO `sys_menu` VALUES (2027, '物业账单生成', 2023, 3, 'order/add', 'order/add/index', NULL, '', 1, 1, 'C', '0', '0', NULL, 'edit', 'admin', '2025-05-06 23:32:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2028, '维修报障管理', 0, 5, 'repair', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-05-07 23:55:00', 'super', '2026-01-21 11:50:15', '');
INSERT INTO `sys_menu` VALUES (2029, '维修报障管理', 2028, 1, 'repair', 'repair/index', NULL, '', 1, 1, 'C', '0', '0', 'system:repair:list', 'skill', 'admin', '2025-05-07 23:56:23', 'admin', '2025-05-07 23:58:02', '');
INSERT INTO `sys_menu` VALUES (2030, '维修单查询', 2028, 2, 'repair/user', 'repair/user/index', NULL, '', 1, 1, 'C', '0', '0', NULL, 'edit', 'admin', '2025-05-07 23:57:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2031, '维修报障申请', 2028, 3, 'repair/add', 'repair/add/index', NULL, '', 1, 1, 'C', '0', '0', NULL, 'component', 'admin', '2025-05-07 23:57:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2040, '公共设施管理', 0, 9, 'facility', '', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-12-30 19:14:27', 'super', '2026-01-21 11:52:56', '公共设施管理目录');
INSERT INTO `sys_menu` VALUES (2041, '设施信息档案', 2040, 1, 'facility', 'facility/facility/index', NULL, '', 1, 0, 'C', '0', '0', 'system:facility:view', 'component', 'admin', '2025-12-30 19:14:27', '', NULL, '公共设施信息档案');
INSERT INTO `sys_menu` VALUES (2042, '维修维护记录', 2040, 2, 'maintenance', 'facility/maintenance/index', NULL, '', 1, 0, 'C', '0', '0', 'system:maintenance:view', 'edit', 'admin', '2025-12-30 19:14:27', '', NULL, '维修维护记录');
INSERT INTO `sys_menu` VALUES (2043, '损坏报废登记', 2040, 3, 'damage', 'facility/damage/index', NULL, '', 1, 0, 'C', '0', '0', 'system:damage:view', 'form', 'admin', '2025-12-30 19:14:27', '', NULL, '损坏报废登记');
INSERT INTO `sys_menu` VALUES (2063, '设施查询', 2041, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:facility:list', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2064, '设施新增', 2041, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:facility:add', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2065, '设施修改', 2041, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:facility:edit', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2066, '设施删除', 2041, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:facility:remove', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2067, '设施导出', 2041, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:facility:export', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2068, '维修查询', 2042, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:maintenance:list', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2069, '维修新增', 2042, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:maintenance:add', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2070, '维修修改', 2042, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:maintenance:edit', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2071, '维修删除', 2042, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:maintenance:remove', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2072, '维修导出', 2042, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:maintenance:export', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2073, '损坏查询', 2043, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:damage:list', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2074, '损坏新增', 2043, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:damage:add', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2075, '损坏修改', 2043, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:damage:edit', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2076, '损坏删除', 2043, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:damage:remove', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2077, '损坏导出', 2043, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:damage:export', '#', 'admin', '2025-12-30 19:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2100, '工人管理', 2005, 3, 'worker', 'system/worker/index', NULL, '', 1, 0, 'C', '0', '0', 'system:worker:list', 'user', 'admin', '2025-12-31 10:30:49', 'super', '2026-01-21 11:45:06', '工人管理菜单');
INSERT INTO `sys_menu` VALUES (2101, '工人查询', 2100, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:worker:query', '#', 'admin', '2025-12-31 10:30:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2102, '工人新增', 2100, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:worker:add', '#', 'admin', '2025-12-31 10:30:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2103, '工人修改', 2100, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:worker:edit', '#', 'admin', '2025-12-31 10:30:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2104, '工人删除', 2100, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:worker:remove', '#', 'admin', '2025-12-31 10:30:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2105, '工人导出', 2100, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:worker:export', '#', 'admin', '2025-12-31 10:30:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2118, '招商管理', 0, 10, 'investment', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'guide', 'admin', '2025-12-30 20:38:03', 'super', '2026-01-21 11:53:11', '');
INSERT INTO `sys_menu` VALUES (2119, '招商信息发布', 2118, 1, 'info', 'investment/info/index', NULL, '', 1, 0, 'C', '0', '0', 'investment:info:list', 'list', 'admin', '2025-12-30 20:38:03', 'admin', '2025-12-30 20:38:03', '');
INSERT INTO `sys_menu` VALUES (2120, '招商进度跟踪', 2118, 2, 'progress', 'investment/progress/index', NULL, '', 1, 0, 'C', '0', '0', 'investment:progress:list', 'edit', 'admin', '2025-12-30 20:38:03', 'admin', '2025-12-30 20:38:03', '');
INSERT INTO `sys_menu` VALUES (2121, '收益明细管理', 2118, 3, 'income', 'investment/income/index', NULL, '', 1, 0, 'C', '0', '0', 'investment:income:list', 'money', 'admin', '2025-12-30 20:38:03', 'admin', '2025-12-30 20:38:03', '');
INSERT INTO `sys_menu` VALUES (2122, '业主福利申领', 2118, 4, 'welfare', 'investment/welfare/index', NULL, '', 1, 0, 'C', '0', '0', 'investment:welfare:list', 'star', 'admin', '2025-12-30 20:38:03', 'admin', '2025-12-30 20:38:03', '');
INSERT INTO `sys_menu` VALUES (2130, '业主档案积分', 2005, 2, 'points', 'system/points/index', NULL, '', 1, 0, 'C', '0', '0', 'system:ownerPoints:list', 'star', 'admin', '2025-12-30 22:27:19', 'super', '2026-01-20 18:25:29', '业主档案积分管理');
INSERT INTO `sys_menu` VALUES (2131, '业主积分查询', 2130, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:ownerPoints:query', '#', 'admin', '2025-12-30 22:27:19', 'admin', '2025-12-30 22:27:19', '');
INSERT INTO `sys_menu` VALUES (2132, '业主积分新增', 2130, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:ownerPoints:add', '#', 'admin', '2025-12-30 22:27:19', 'admin', '2025-12-30 22:27:19', '');
INSERT INTO `sys_menu` VALUES (2133, '业主积分修改', 2130, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:ownerPoints:edit', '#', 'admin', '2025-12-30 22:27:19', 'admin', '2025-12-30 22:27:19', '');
INSERT INTO `sys_menu` VALUES (2134, '业主积分删除', 2130, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:ownerPoints:remove', '#', 'admin', '2025-12-30 22:27:19', 'admin', '2025-12-30 22:27:19', '');
INSERT INTO `sys_menu` VALUES (2135, '业主积分导出', 2130, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:ownerPoints:export', '#', 'admin', '2025-12-30 22:27:19', 'admin', '2025-12-30 22:27:19', '');
INSERT INTO `sys_menu` VALUES (2136, '积分调整', 2130, 6, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:ownerPoints:updatePoints', '#', 'admin', '2025-12-30 22:27:19', 'admin', '2025-12-30 22:27:19', '');
INSERT INTO `sys_menu` VALUES (2138, '违规信息管理', 2010, 4, 'violation', 'system/violation/index', NULL, '', 1, 0, 'C', '0', '0', 'system:violation:list', 'chart', 'admin', '2025-12-31 17:16:00', 'super', '2026-01-20 13:47:14', '违规信息管理菜单');
INSERT INTO `sys_menu` VALUES (2139, '违规信息查询', 2138, 1, '', '', NULL, '', 1, 0, 'F', '0', '0', 'system:violation:query', '#', 'admin', '2025-12-31 17:16:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2140, '违规信息新增', 2138, 2, '', '', NULL, '', 1, 0, 'F', '0', '0', 'system:violation:add', '#', 'admin', '2025-12-31 17:16:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2141, '违规信息修改', 2138, 3, '', '', NULL, '', 1, 0, 'F', '0', '0', 'system:violation:edit', '#', 'admin', '2025-12-31 17:16:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2142, '违规信息删除', 2138, 4, '', '', NULL, '', 1, 0, 'F', '0', '0', 'system:violation:remove', '#', 'admin', '2025-12-31 17:16:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2143, '处理违规记录', 2138, 5, '', '', NULL, '', 1, 0, 'F', '0', '0', 'system:violation:process', '#', 'admin', '2025-12-31 17:16:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2144, '撤销违规记录', 2138, 6, '', '', NULL, '', 1, 0, 'F', '0', '0', 'system:violation:cancel', '#', 'admin', '2025-12-31 17:16:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2145, '违规信息导出', 2138, 7, '', '', NULL, '', 1, 0, 'F', '0', '0', 'system:violation:export', '#', 'admin', '2025-12-31 17:16:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2146, '入住登记', 2005, 4, 'checkin', 'property/checkin/index', NULL, '', 1, 0, 'C', '0', '0', 'property:checkin:list', 'form', 'admin', '2026-01-20 11:49:50', 'super', '2026-01-21 11:45:15', '');
INSERT INTO `sys_menu` VALUES (2147, '入住查询', 2101, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'property:checkin:query', '#', 'admin', '2026-01-20 11:49:50', 'admin', '2026-01-20 11:49:50', '');
INSERT INTO `sys_menu` VALUES (2148, '入住新增', 2101, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'property:checkin:add', '#', 'admin', '2026-01-20 11:49:50', 'admin', '2026-01-20 11:49:50', '');
INSERT INTO `sys_menu` VALUES (2149, '入住修改', 2101, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'property:checkin:edit', '#', 'admin', '2026-01-20 11:49:50', 'admin', '2026-01-20 11:49:50', '');
INSERT INTO `sys_menu` VALUES (2150, '入住删除', 2101, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'property:checkin:remove', '#', 'admin', '2026-01-20 11:49:50', 'admin', '2026-01-20 11:49:50', '');
INSERT INTO `sys_menu` VALUES (2151, '入住导出', 2101, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'property:checkin:export', '#', 'admin', '2026-01-20 11:49:50', 'admin', '2026-01-20 11:49:50', '');
INSERT INTO `sys_menu` VALUES (3101, '车辆登记', 2010, 1, 'carregister', 'carScan/carregister/index', NULL, '', 1, 0, 'C', '0', '0', 'car:register:list', 'form', 'admin', '2026-01-20 11:49:50', 'super', '2026-01-20 11:55:19', '');
INSERT INTO `sys_menu` VALUES (3102, '车辆查询', 3101, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'car:register:query', '#', 'admin', '2026-01-20 11:49:50', 'admin', '2026-01-20 11:49:50', '');
INSERT INTO `sys_menu` VALUES (3103, '车辆新增', 3101, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'car:register:add', '#', 'admin', '2026-01-20 11:49:50', 'admin', '2026-01-20 11:49:50', '');
INSERT INTO `sys_menu` VALUES (3104, '车辆修改', 3101, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'car:register:edit', '#', 'admin', '2026-01-20 11:49:50', 'admin', '2026-01-20 11:49:50', '');
INSERT INTO `sys_menu` VALUES (3105, '车辆删除', 3101, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'car:register:remove', '#', 'admin', '2026-01-20 11:49:50', 'admin', '2026-01-20 11:49:50', '');
INSERT INTO `sys_menu` VALUES (3106, '车辆导出', 3101, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'car:register:export', '#', 'admin', '2026-01-20 11:49:50', 'admin', '2026-01-20 11:49:50', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (10, '温馨提示：小区部分区域停电', '1', 0x3C703EE69CAAE69DA53438E5B08FE697B6E69CACE5B08FE58CBA312D35E6A08BE4BC9AE5819CE794B5EFBC8CE5819CE794B5E58E9FE59BA0EFBC9AE794B5E8B7AFE6A380E4BFAEEFBC8CE681A2E5A48DE697B6E997B4EFBC9AE7AD89E5BE85E9809AE79FA53C2F703E, '0', 'super', '2026-01-13 11:35:02', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 215 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1, '操作日志', 9, 'com.property.web.controller.monitor.SysOperlogController.clean()', 'DELETE', 1, 'super', NULL, '/monitor/operlog/clean', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-18 14:00:22', 39);
INSERT INTO `sys_oper_log` VALUES (2, '登录日志', 9, 'com.property.web.controller.monitor.SysLogininforController.clean()', 'DELETE', 1, 'super', NULL, '/monitor/logininfor/clean', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-18 14:00:28', 35);
INSERT INTO `sys_oper_log` VALUES (3, '参数管理', 2, 'com.property.system.controller.SysConfigController.edit()', 'PUT', 1, 'super', NULL, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":1,\"configKey\":\"sys.index.skinName\",\"configName\":\"主框架页-默认皮肤样式名称\",\"configType\":\"Y\",\"configValue\":\"skin-purple\",\"createBy\":\"admin\",\"createTime\":\"2025-04-07 21:33:13\",\"params\":{},\"remark\":\"蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-18 14:01:33', 11);
INSERT INTO `sys_oper_log` VALUES (4, '参数管理', 2, 'com.property.system.controller.SysConfigController.edit()', 'PUT', 1, 'super', NULL, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":1,\"configKey\":\"sys.index.skinName\",\"configName\":\"主框架页-默认皮肤样式名称\",\"configType\":\"Y\",\"configValue\":\"skin-blue\",\"createBy\":\"admin\",\"createTime\":\"2025-04-07 21:33:13\",\"params\":{},\"remark\":\"蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-18 14:01:33\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-18 14:02:03', 9);
INSERT INTO `sys_oper_log` VALUES (5, '参数管理', 9, 'com.property.system.controller.SysConfigController.refreshCache()', 'DELETE', 1, 'super', NULL, '/system/config/refreshCache', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-18 14:02:14', 14);
INSERT INTO `sys_oper_log` VALUES (6, '角色管理', 2, 'com.property.system.controller.SysRoleController.edit()', 'PUT', 1, 'super', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-04-07 21:33:13\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2023,2028,2025,2027,2029,2030],\"params\":{},\"remark\":\"工人\",\"roleId\":2,\"roleKey\":\"manager\",\"roleName\":\"工人\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 08:01:17', 39);
INSERT INTO `sys_oper_log` VALUES (7, '角色管理', 2, 'com.property.system.controller.SysRoleController.edit()', 'PUT', 1, 'super', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-04-07 21:33:13\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2023,2028,2025,2027,2029],\"params\":{},\"remark\":\"工人\",\"roleId\":2,\"roleKey\":\"manager\",\"roleName\":\"工人\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 08:01:49', 16);
INSERT INTO `sys_oper_log` VALUES (8, '用户管理', 2, 'com.property.system.controller.SysUserController.edit()', 'PUT', 1, 'super', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/12/30/1mSjxwzqiQZwqJO_20251230144706A004.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-04-07 21:33:13\",\"delFlag\":\"0\",\"email\":\"1122@qq.com\",\"loginDate\":\"2026-01-19 08:02:08\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"工人\",\"params\":{},\"phonenumber\":\"15666666666\",\"remark\":\"工人\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"manager\",\"roleName\":\"工人\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"super\",\"userId\":2,\"userName\":\"manager\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 08:05:41', 17);
INSERT INTO `sys_oper_log` VALUES (9, '物业维修', 1, 'com.property.system.controller.SysPropertyRepairController.add()', 'POST', 1, '李春伟', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"applicantId\":105,\"applicantName\":\"李春伟\",\"applicantPhone\":\"15644445555\",\"createBy\":\"李春伟\",\"id\":8,\"imageUrl\":\"/profile/upload/2026/01/19/R-C_20260119090106A001.png\",\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨市\",\"propertyId\":4,\"repairDescription\":\"水管漏水了\",\"repairItem\":\"漏水\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 09:01:09', 15);
INSERT INTO `sys_oper_log` VALUES (10, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"assigneeName\":\"demo1\",\"assigneePhone\":\"18833334444\",\"completedTime\":\"2026-01-19 09:37:44\",\"id\":8,\"params\":{},\"remark\":\"测试\",\"status\":\"2\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 09:37:44', 33);
INSERT INTO `sys_oper_log` VALUES (11, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"completedTime\":\"2026-01-19 09:37:55\",\"id\":8,\"params\":{},\"status\":\"1\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 09:37:55', 4);
INSERT INTO `sys_oper_log` VALUES (12, '物业维修', 1, 'com.property.system.controller.SysPropertyRepairController.add()', 'POST', 1, '李春伟', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"applicantId\":105,\"applicantName\":\"李春伟\",\"applicantPhone\":\"21212121\",\"createBy\":\"李春伟\",\"id\":9,\"imageUrl\":\"/profile/upload/2026/01/19/R-C_20260119101216A001.png\",\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨市\",\"propertyId\":4,\"repairDescription\":\"1212121\",\"repairItem\":\"1212\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 10:12:18', 24);
INSERT INTO `sys_oper_log` VALUES (13, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"assignTime\":\"2026-01-19 10:12:41\",\"assigneeName\":\"demo1\",\"assigneePhone\":\"18833334444\",\"id\":9,\"params\":{},\"remark\":\"\",\"status\":\"2\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 10:12:41\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 10:12:41', 12);
INSERT INTO `sys_oper_log` VALUES (14, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"completedTime\":\"2026-01-19 10:12:52\",\"id\":9,\"params\":{},\"status\":\"1\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 10:12:52\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 10:12:52', 1);
INSERT INTO `sys_oper_log` VALUES (15, '物业维修', 1, 'com.property.system.controller.SysPropertyRepairController.add()', 'POST', 1, '李春伟', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"applicantId\":105,\"applicantName\":\"李春伟\",\"applicantPhone\":\"12344445555\",\"createBy\":\"李春伟\",\"id\":10,\"imageUrl\":\"/profile/upload/2026/01/19/R-C_20260119110455A001.png\",\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨市\",\"propertyId\":4,\"repairDescription\":\"测试\",\"repairItem\":\"测试数据\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:04:57', 16);
INSERT INTO `sys_oper_log` VALUES (16, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"assignTime\":\"2026-01-19 11:05:33\",\"assigneeName\":\"demo1\",\"assigneePhone\":\"18833334444\",\"id\":10,\"params\":{},\"remark\":\"\",\"status\":\"2\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:05:33\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:05:33', 12);
INSERT INTO `sys_oper_log` VALUES (17, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"completedTime\":\"2026-01-19 11:05:51\",\"id\":10,\"params\":{},\"status\":\"1\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:05:51\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:05:51', 10);
INSERT INTO `sys_oper_log` VALUES (18, '字典数据', 2, 'com.property.system.controller.SysDictDataController.edit()', 'PUT', 1, 'super', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-05-07 23:33:55\",\"default\":false,\"dictCode\":104,\"dictLabel\":\"待处理\",\"dictSort\":0,\"dictType\":\"sys_repair_status\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"remark\":\"初始状态\",\"status\":\"0\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:13:13', 20);
INSERT INTO `sys_oper_log` VALUES (19, '字典数据', 2, 'com.property.system.controller.SysDictDataController.edit()', 'PUT', 1, 'super', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-05-07 23:33:55\",\"default\":false,\"dictCode\":104,\"dictLabel\":\"待处理\",\"dictSort\":0,\"dictType\":\"sys_repair_status\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"info\",\"params\":{},\"remark\":\"初始状态\",\"status\":\"0\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:13:28', 15);
INSERT INTO `sys_oper_log` VALUES (20, '字典数据', 2, 'com.property.system.controller.SysDictDataController.edit()', 'PUT', 1, 'super', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-05-07 23:33:55\",\"default\":false,\"dictCode\":104,\"dictLabel\":\"待处理\",\"dictSort\":0,\"dictType\":\"sys_repair_status\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"primary\",\"params\":{},\"remark\":\"初始状态\",\"status\":\"0\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:13:39', 14);
INSERT INTO `sys_oper_log` VALUES (21, '字典数据', 2, 'com.property.system.controller.SysDictDataController.edit()', 'PUT', 1, 'super', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-05-07 23:34:09\",\"default\":false,\"dictCode\":105,\"dictLabel\":\"已完成\",\"dictSort\":1,\"dictType\":\"sys_repair_status\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"success\",\"params\":{},\"remark\":\"维修完成后状态\",\"status\":\"0\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:14:05', 14);
INSERT INTO `sys_oper_log` VALUES (22, '字典数据', 2, 'com.property.system.controller.SysDictDataController.edit()', 'PUT', 1, 'super', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-05-07 23:34:23\",\"default\":false,\"dictCode\":106,\"dictLabel\":\"维修中\",\"dictSort\":2,\"dictType\":\"sys_repair_status\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"primary\",\"params\":{},\"remark\":\"分配工人后的状态\",\"status\":\"0\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:14:33', 10);
INSERT INTO `sys_oper_log` VALUES (23, '字典数据', 2, 'com.property.system.controller.SysDictDataController.edit()', 'PUT', 1, 'super', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-05-07 23:33:55\",\"default\":false,\"dictCode\":104,\"dictLabel\":\"待处理\",\"dictSort\":0,\"dictType\":\"sys_repair_status\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"info\",\"params\":{},\"remark\":\"初始状态\",\"status\":\"0\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:14:41', 11);
INSERT INTO `sys_oper_log` VALUES (24, '字典数据', 2, 'com.property.system.controller.SysDictDataController.edit()', 'PUT', 1, 'super', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-05-07 23:34:36\",\"default\":false,\"dictCode\":107,\"dictLabel\":\"已评价\",\"dictSort\":3,\"dictType\":\"sys_repair_status\",\"dictValue\":\"3\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"remark\":\"评分后的状态\",\"status\":\"0\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:15:05', 14);
INSERT INTO `sys_oper_log` VALUES (25, '字典数据', 2, 'com.property.system.controller.SysDictDataController.edit()', 'PUT', 1, 'super', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-05-07 23:34:36\",\"default\":false,\"dictCode\":107,\"dictLabel\":\"已评价\",\"dictSort\":3,\"dictType\":\"sys_repair_status\",\"dictValue\":\"3\",\"isDefault\":\"N\",\"listClass\":\"success\",\"params\":{},\"remark\":\"评分后的状态\",\"status\":\"0\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:15:12', 9);
INSERT INTO `sys_oper_log` VALUES (26, '字典数据', 2, 'com.property.system.controller.SysDictDataController.edit()', 'PUT', 1, 'super', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-05-07 23:34:09\",\"default\":false,\"dictCode\":105,\"dictLabel\":\"已完成\",\"dictSort\":1,\"dictType\":\"sys_repair_status\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"info\",\"params\":{},\"remark\":\"维修完成后状态\",\"status\":\"0\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:15:29', 10);
INSERT INTO `sys_oper_log` VALUES (27, '字典数据', 2, 'com.property.system.controller.SysDictDataController.edit()', 'PUT', 1, 'super', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-05-07 23:34:09\",\"default\":false,\"dictCode\":105,\"dictLabel\":\"已完成\",\"dictSort\":1,\"dictType\":\"sys_repair_status\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"primary\",\"params\":{},\"remark\":\"维修完成后状态\",\"status\":\"0\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:15:37', 10);
INSERT INTO `sys_oper_log` VALUES (28, '物业维修', 1, 'com.property.system.controller.SysPropertyRepairController.add()', 'POST', 1, '李春伟', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"applicantId\":105,\"applicantName\":\"李春伟\",\"applicantPhone\":\"12355556666\",\"createBy\":\"李春伟\",\"id\":11,\"imageUrl\":\"/profile/upload/2026/01/19/R-C_20260119111624A002.png\",\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨市\",\"propertyId\":4,\"repairDescription\":\"测试数据\",\"repairItem\":\"测试\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:16:25', 7);
INSERT INTO `sys_oper_log` VALUES (29, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"age\":18,\"createBy\":\"demo1\",\"createTime\":\"2026-01-19 08:58:40\",\"gender\":\"0\",\"params\":{},\"phoneNumber\":\"18833334444\",\"updateBy\":\"super\",\"userId\":108,\"workStatus\":\"0\",\"workerId\":4,\"workerName\":\"demo1\",\"workerType\":\"plumber\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:17:40', 9);
INSERT INTO `sys_oper_log` VALUES (30, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"age\":18,\"createBy\":\"demo1\",\"createTime\":\"2026-01-19 08:58:40\",\"gender\":\"0\",\"params\":{},\"phoneNumber\":\"18833334444\",\"updateBy\":\"super\",\"userId\":108,\"workStatus\":\"0\",\"workerId\":4,\"workerName\":\"demo1\",\"workerType\":\"plumber\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:17:42', 12);
INSERT INTO `sys_oper_log` VALUES (31, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"age\":18,\"createBy\":\"demo1\",\"createTime\":\"2026-01-19 08:58:40\",\"gender\":\"0\",\"params\":{},\"phoneNumber\":\"18833334444\",\"updateBy\":\"super\",\"userId\":108,\"workStatus\":\"0\",\"workerId\":4,\"workerName\":\"demo1\",\"workerType\":\"plumber\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:17:53', 6);
INSERT INTO `sys_oper_log` VALUES (32, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"age\":18,\"createBy\":\"demo1\",\"createTime\":\"2026-01-19 08:58:40\",\"gender\":\"0\",\"params\":{},\"phoneNumber\":\"18833334444\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:17:53\",\"userId\":108,\"workStatus\":\"0\",\"workerId\":4,\"workerName\":\"demo1\",\"workerType\":\"carpenter\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:18:10', 8);
INSERT INTO `sys_oper_log` VALUES (33, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"assignTime\":\"2026-01-19 11:19:03\",\"assigneeName\":\"demo1\",\"assigneePhone\":\"18833334444\",\"id\":11,\"params\":{},\"remark\":\"\",\"status\":\"2\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:19:03\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:19:03', 4);
INSERT INTO `sys_oper_log` VALUES (34, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"completedTime\":\"2026-01-19 11:19:16\",\"id\":11,\"params\":{},\"status\":\"1\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:19:16\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:19:16', 8);
INSERT INTO `sys_oper_log` VALUES (35, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"age\":18,\"createBy\":\"demo1\",\"createTime\":\"2026-01-19 08:58:40\",\"gender\":\"男\",\"params\":{},\"phoneNumber\":\"18833334444\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:18:09\",\"userId\":108,\"workStatus\":\"空闲\",\"workerId\":4,\"workerName\":\"demo1\",\"workerType\":\"水工\"}', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'work_status\' at row 1\r\n### The error may exist in file [E:\\modern-property-service-new\\property-manage\\target\\classes\\mapper\\system\\WorkerMapper.xml]\r\n### The error may involve com.property.system.mapper.WorkerMapper.updateWorker-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_worker          SET user_id = ?,             worker_name = ?,             gender = ?,             age = ?,             phone_number = ?,                                       worker_type = ?,                          work_status = ?,                                                    update_by = ?,             update_time = sysdate()          where worker_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'work_status\' at row 1\n; Data truncation: Data too long for column \'work_status\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'work_status\' at row 1', '2026-01-19 11:30:56', 37);
INSERT INTO `sys_oper_log` VALUES (36, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"age\":18,\"createBy\":\"demo1\",\"createTime\":\"2026-01-19 08:58:40\",\"gender\":\"0\",\"params\":{},\"phoneNumber\":\"18833334444\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:18:09\",\"userId\":108,\"workStatus\":\"0\",\"workerId\":4,\"workerName\":\"demo1\",\"workerType\":\"plumber\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:34:56', 14);
INSERT INTO `sys_oper_log` VALUES (37, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"age\":18,\"createBy\":\"demo1\",\"createTime\":\"2026-01-19 08:58:40\",\"gender\":\"男\",\"params\":{},\"phoneNumber\":\"18833334444\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:34:56\",\"userId\":108,\"workStatus\":\"空闲\",\"workerId\":4,\"workerName\":\"demo1\",\"workerType\":\"木工\"}', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'work_status\' at row 1\r\n### The error may exist in file [E:\\modern-property-service-new\\property-manage\\target\\classes\\mapper\\system\\WorkerMapper.xml]\r\n### The error may involve com.property.system.mapper.WorkerMapper.updateWorker-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_worker          SET user_id = ?,             worker_name = ?,             gender = ?,             age = ?,             phone_number = ?,                                       worker_type = ?,                          work_status = ?,                                                    update_by = ?,             update_time = sysdate()          where worker_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'work_status\' at row 1\n; Data truncation: Data too long for column \'work_status\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'work_status\' at row 1', '2026-01-19 11:35:55', 2);
INSERT INTO `sys_oper_log` VALUES (38, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"age\":18,\"createBy\":\"demo1\",\"createTime\":\"2026-01-19 08:58:40\",\"gender\":\"男\",\"params\":{},\"phoneNumber\":\"18833334444\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:34:56\",\"userId\":108,\"workStatus\":\"空闲\",\"workerId\":4,\"workerName\":\"demo1\",\"workerType\":\"木工\"}', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'work_status\' at row 1\r\n### The error may exist in file [E:\\modern-property-service-new\\property-manage\\target\\classes\\mapper\\system\\WorkerMapper.xml]\r\n### The error may involve com.property.system.mapper.WorkerMapper.updateWorker-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_worker          SET user_id = ?,             worker_name = ?,             gender = ?,             age = ?,             phone_number = ?,                                       worker_type = ?,                          work_status = ?,                                                    update_by = ?,             update_time = sysdate()          where worker_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'work_status\' at row 1\n; Data truncation: Data too long for column \'work_status\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'work_status\' at row 1', '2026-01-19 11:40:08', 7);
INSERT INTO `sys_oper_log` VALUES (39, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"age\":18,\"createBy\":\"demo1\",\"createTime\":\"2026-01-19 08:58:40\",\"gender\":\"男\",\"params\":{},\"phoneNumber\":\"18833334444\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:34:56\",\"userId\":108,\"workStatus\":\"忙碌\",\"workerId\":4,\"workerName\":\"demo1\",\"workerType\":\"木工\"}', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'work_status\' at row 1\r\n### The error may exist in file [E:\\modern-property-service-new\\property-manage\\target\\classes\\mapper\\system\\WorkerMapper.xml]\r\n### The error may involve com.property.system.mapper.WorkerMapper.updateWorker-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_worker          SET user_id = ?,             worker_name = ?,             gender = ?,             age = ?,             phone_number = ?,                                       worker_type = ?,                          work_status = ?,                                                    update_by = ?,             update_time = sysdate()          where worker_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'work_status\' at row 1\n; Data truncation: Data too long for column \'work_status\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'work_status\' at row 1', '2026-01-19 11:40:14', 3);
INSERT INTO `sys_oper_log` VALUES (40, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"address\":\"北京市朝阳区\",\"age\":35,\"createBy\":\"admin\",\"createTime\":\"2025-12-31 10:24:50\",\"emergencyContact\":\"李四\",\"emergencyPhone\":\"13800138002\",\"entryDate\":\"2025-12-17 00:00:00\",\"gender\":\"0\",\"idCard\":\"110101198801011234\",\"params\":{},\"phoneNumber\":\"13800138001\",\"remark\":\"经验丰富，技术娴熟\",\"updateBy\":\"super\",\"workStatus\":\"1\",\"workerId\":1,\"workerName\":\"张三\",\"workerType\":\"电工\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:40:46', 8);
INSERT INTO `sys_oper_log` VALUES (41, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"address\":\"北京市朝阳区\",\"age\":35,\"createBy\":\"admin\",\"createTime\":\"2025-12-31 10:24:50\",\"emergencyContact\":\"李四\",\"emergencyPhone\":\"13800138002\",\"entryDate\":\"2025-12-17 00:00:00\",\"gender\":\"0\",\"idCard\":\"110101198801011234\",\"params\":{},\"phoneNumber\":\"13800138001\",\"remark\":\"经验丰富，技术娴熟\",\"updateBy\":\"super\",\"workStatus\":\"1\",\"workerId\":1,\"workerName\":\"张三\",\"workerType\":\"电工\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:40:47', 5);
INSERT INTO `sys_oper_log` VALUES (42, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"address\":\"北京市朝阳区\",\"age\":35,\"createBy\":\"admin\",\"createTime\":\"2025-12-31 10:24:50\",\"emergencyContact\":\"李四\",\"emergencyPhone\":\"13800138002\",\"entryDate\":\"2025-12-17 00:00:00\",\"gender\":\"0\",\"idCard\":\"110101198801011234\",\"params\":{},\"phoneNumber\":\"13800138001\",\"remark\":\"经验丰富，技术娴熟\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:40:47\",\"workStatus\":\"0\",\"workerId\":1,\"workerName\":\"张三\",\"workerType\":\"电工\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:40:57', 0);
INSERT INTO `sys_oper_log` VALUES (43, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"age\":18,\"createBy\":\"demo1\",\"createTime\":\"2026-01-19 08:58:40\",\"gender\":\"0\",\"params\":{},\"phoneNumber\":\"18833334444\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:34:56\",\"userId\":108,\"workStatus\":\"0\",\"workerId\":4,\"workerName\":\"demo1\",\"workerType\":\"木工\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:46:43', 10);
INSERT INTO `sys_oper_log` VALUES (44, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"age\":18,\"createBy\":\"demo1\",\"createTime\":\"2026-01-19 08:58:40\",\"gender\":\"0\",\"params\":{},\"phoneNumber\":\"18833334444\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:46:43\",\"userId\":108,\"workStatus\":\"0\",\"workerId\":4,\"workerName\":\"demo1\",\"workerType\":\"电工\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:48:08', 6);
INSERT INTO `sys_oper_log` VALUES (45, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"age\":18,\"createBy\":\"demo1\",\"createTime\":\"2026-01-19 08:58:40\",\"gender\":\"0\",\"params\":{},\"phoneNumber\":\"18833334444\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:48:08\",\"userId\":108,\"workStatus\":\"0\",\"workerId\":4,\"workerName\":\"demo1\",\"workerType\":\"水工\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-19 11:51:51', 10);
INSERT INTO `sys_oper_log` VALUES (46, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"carScan/carregister/index\",\"createTime\":\"2026-01-20 11:49:50\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3101,\"menuName\":\"车辆登记\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2010,\"path\":\"carregister\",\"perms\":\"car:register:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 11:55:19', 16);
INSERT INTO `sys_oper_log` VALUES (47, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"XXXXXXXX\",\"dateOfBirth\":\"2009-11-04\",\"identityNo\":\"5454545454\",\"occupation\":\"80\",\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"phoneNumber\":\"12344444444\",\"signature\":\"努力为计算机事业添砖Java\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-18 13:47:49\",\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 13:32:53', 12);
INSERT INTO `sys_oper_log` VALUES (48, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-04-13 15:40:11\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"车辆管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"carScan\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 13:45:42', 14);
INSERT INTO `sys_oper_log` VALUES (49, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"carScan/carIn/index\",\"createTime\":\"2025-04-13 15:42:18\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2011,\"menuName\":\"智能入场识别\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2010,\"path\":\"carScan/carIn\",\"perms\":\"system:carScan:add\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 13:46:35', 11);
INSERT INTO `sys_oper_log` VALUES (50, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"carScan/carOut/index\",\"createTime\":\"2025-04-13 17:33:12\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"智能出库\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2010,\"path\":\"carScan/carOut\",\"perms\":\"system:carScan:add\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 13:46:47', 9);
INSERT INTO `sys_oper_log` VALUES (51, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/violation/index\",\"createTime\":\"2025-12-31 17:16:00\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2138,\"menuName\":\"违规信息管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2010,\"path\":\"violation\",\"perms\":\"system:violation:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 13:47:14', 8);
INSERT INTO `sys_oper_log` VALUES (52, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"parkOrder/index\",\"createTime\":\"2025-04-13 21:07:09\",\"icon\":\"log\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"停车订单一览\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2010,\"path\":\"parkOrder\",\"perms\":\"system:parkOrder:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 13:47:34', 9);
INSERT INTO `sys_oper_log` VALUES (53, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"carScan/list\",\"createTime\":\"2025-04-13 21:43:29\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2014,\"menuName\":\"车辆出入场一览\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2010,\"path\":\"carScan\",\"perms\":\"system:carScan:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 13:47:41', 9);
INSERT INTO `sys_oper_log` VALUES (54, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"owner/points/index\",\"createTime\":\"2025-12-30 22:27:19\",\"icon\":\"star\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2130,\"menuName\":\"业主档案积分\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2005,\"path\":\"owner/points\",\"perms\":\"system:ownerPoints:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 14:30:35', 9);
INSERT INTO `sys_oper_log` VALUES (55, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-04-07 21:33:13\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1006,\"menuName\":\"重置密码\",\"menuType\":\"F\",\"orderNum\":5,\"params\":{},\"parentId\":100,\"path\":\"\",\"perms\":\"system:user:resetPwd\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 15:05:18', 8);
INSERT INTO `sys_oper_log` VALUES (56, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/points/index\",\"createTime\":\"2025-12-30 22:27:19\",\"icon\":\"star\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2130,\"menuName\":\"业主档案积分\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2005,\"path\":\"owner/points\",\"perms\":\"system:ownerPoints:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 18:07:05', 20);
INSERT INTO `sys_oper_log` VALUES (57, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/points/index\",\"createTime\":\"2025-12-30 22:27:19\",\"icon\":\"star\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2130,\"menuName\":\"业主档案积分\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2005,\"path\":\"points\",\"perms\":\"system:ownerPoints:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 18:09:39', 16);
INSERT INTO `sys_oper_log` VALUES (58, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"owner/points/index\",\"createTime\":\"2025-12-30 22:27:19\",\"icon\":\"star\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2130,\"menuName\":\"业主档案积分\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2005,\"path\":\"owner/points\",\"perms\":\"system:ownerPoints:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 18:11:35', 0);
INSERT INTO `sys_oper_log` VALUES (59, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/points/index\",\"createTime\":\"2025-12-30 22:27:19\",\"icon\":\"star\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2130,\"menuName\":\"业主档案积分\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2005,\"path\":\"points\",\"perms\":\"system:points:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 18:23:08', 0);
INSERT INTO `sys_oper_log` VALUES (60, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/points/index\",\"createTime\":\"2025-12-30 22:27:19\",\"icon\":\"star\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2130,\"menuName\":\"业主档案积分\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2005,\"path\":\"points\",\"perms\":\"system:ownerPoints:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-20 18:25:29', 5);
INSERT INTO `sys_oper_log` VALUES (61, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/worker/index\",\"createTime\":\"2025-12-31 10:30:49\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2100,\"menuName\":\"工人管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2005,\"path\":\"worker\",\"perms\":\"system:worker:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:45:06', 14);
INSERT INTO `sys_oper_log` VALUES (62, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"property/checkin/index\",\"createTime\":\"2026-01-20 11:49:50\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2146,\"menuName\":\"入住登记\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2005,\"path\":\"checkin\",\"perms\":\"property:checkin:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:45:15', 11);
INSERT INTO `sys_oper_log` VALUES (63, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-04-07 21:33:13\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1006,\"menuName\":\"重置密码\",\"menuType\":\"F\",\"orderNum\":6,\"params\":{},\"parentId\":100,\"path\":\"\",\"perms\":\"system:user:resetPwd\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:45:47', 16);
INSERT INTO `sys_oper_log` VALUES (64, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-05-05 22:54:32\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2023,\"menuName\":\"物业账单缴费管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"order\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:48:52', 16);
INSERT INTO `sys_oper_log` VALUES (65, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-05-07 23:55:00\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2028,\"menuName\":\"维修报障管理\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"repair\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:49:01', 19);
INSERT INTO `sys_oper_log` VALUES (66, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-04-07 21:33:13\",\"icon\":\"component\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"房产信息管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"property\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:49:34', 11);
INSERT INTO `sys_oper_log` VALUES (67, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-05-05 22:54:32\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2023,\"menuName\":\"物业账单缴费管理\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"order\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:49:43', 11);
INSERT INTO `sys_oper_log` VALUES (68, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-05-05 22:54:32\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2023,\"menuName\":\"物业账单缴费管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"order\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:50:08', 9);
INSERT INTO `sys_oper_log` VALUES (69, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-05-07 23:55:00\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2028,\"menuName\":\"维修报障管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"repair\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:50:15', 18);
INSERT INTO `sys_oper_log` VALUES (70, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-04-07 21:33:13\",\"icon\":\"system\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":12,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:50:52', 13);
INSERT INTO `sys_oper_log` VALUES (71, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-04-12 14:31:59\",\"icon\":\"message\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"通知公告\",\"menuType\":\"M\",\"orderNum\":11,\"params\":{},\"parentId\":0,\"path\":\"notice\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:51:04', 15);
INSERT INTO `sys_oper_log` VALUES (72, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-04-13 00:36:27\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"停车场信息管理\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"parkInfo\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:51:23', 18);
INSERT INTO `sys_oper_log` VALUES (73, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-04-13 15:40:11\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"车辆管理\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"carScan\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:51:39', 12);
INSERT INTO `sys_oper_log` VALUES (74, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-04-13 15:40:11\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"车辆管理\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"carScan\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:51:45', 16);
INSERT INTO `sys_oper_log` VALUES (75, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-04-13 15:40:11\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"车辆管理\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"carScan\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:52:15', 9);
INSERT INTO `sys_oper_log` VALUES (76, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-04-13 00:36:27\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"停车场信息管理\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"parkInfo\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:52:23', 8);
INSERT INTO `sys_oper_log` VALUES (77, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-04-29 21:32:13\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2015,\"menuName\":\"投诉与反馈管理\",\"menuType\":\"M\",\"orderNum\":8,\"params\":{},\"parentId\":0,\"path\":\"feedback\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:52:46', 15);
INSERT INTO `sys_oper_log` VALUES (78, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-12-30 19:14:27\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2040,\"menuName\":\"公共设施管理\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":0,\"path\":\"facility\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:52:56', 12);
INSERT INTO `sys_oper_log` VALUES (79, '菜单管理', 2, 'com.property.system.controller.SysMenuController.edit()', 'PUT', 1, 'super', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-30 20:38:03\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2118,\"menuName\":\"招商管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"investment\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"super\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 11:53:11', 0);
INSERT INTO `sys_oper_log` VALUES (80, '业主福利申领', 1, 'com.property.system.controller.OwnerWelfareController.add()', 'POST', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-21 00:00:00\",\"createBy\":\"super\",\"id\":6,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-23 00:00:00\",\"remark\":\"测试\",\"roomNo\":\"521\",\"status\":0,\"welfareDesc\":\"121212121212\",\"welfareName\":\"测试数据\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 13:50:46', 15);
INSERT INTO `sys_oper_log` VALUES (81, '业主福利申领', 1, 'com.property.system.controller.OwnerWelfareController.add()', 'POST', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-21 00:00:00\",\"createBy\":\"super\",\"id\":7,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-23 00:00:00\",\"remark\":\"测试\",\"roomNo\":\"521\",\"status\":0,\"welfareDesc\":\"121212121212\",\"welfareName\":\"测试数据\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 13:50:54', 9);
INSERT INTO `sys_oper_log` VALUES (82, '业主福利申领', 3, 'com.property.system.controller.OwnerWelfareController.remove()', 'DELETE', 1, 'super', NULL, '/investment/welfare/6', '127.0.0.1', '内网IP', '[6]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 13:51:08', 26);
INSERT INTO `sys_oper_log` VALUES (83, '业主福利申领', 2, 'com.property.system.controller.OwnerWelfareController.edit()', 'PUT', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-21 00:00:00\",\"createBy\":\"super\",\"createTime\":\"2026-01-21 13:50:54\",\"id\":7,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-23 00:00:00\",\"remark\":\"测试\",\"roomNo\":\"521\",\"status\":1,\"updateBy\":\"super\",\"welfareDesc\":\"121212121212\",\"welfareName\":\"测试数据\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 13:58:30', 14);
INSERT INTO `sys_oper_log` VALUES (84, '业主福利申领', 2, 'com.property.system.controller.OwnerWelfareController.edit()', 'PUT', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-21 00:00:00\",\"createBy\":\"super\",\"createTime\":\"2026-01-21 13:50:54\",\"id\":7,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-23 00:00:00\",\"remark\":\"测试\",\"roomNo\":\"521\",\"status\":1,\"updateBy\":\"super\",\"welfareDesc\":\"121212121212\",\"welfareName\":\"测试数据\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 13:58:38', 13);
INSERT INTO `sys_oper_log` VALUES (85, '业主福利申领', 2, 'com.property.system.controller.OwnerWelfareController.edit()', 'PUT', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-21 00:00:00\",\"createBy\":\"super\",\"createTime\":\"2026-01-21 13:50:54\",\"id\":7,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-23 00:00:00\",\"remark\":\"测试\",\"roomNo\":\"521\",\"status\":2,\"updateBy\":\"super\",\"updateTime\":\"2026-01-21 13:58:38\",\"welfareDesc\":\"121212121212\",\"welfareName\":\"测试数据\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 13:58:54', 2);
INSERT INTO `sys_oper_log` VALUES (86, '业主福利申领', 2, 'com.property.system.controller.OwnerWelfareController.edit()', 'PUT', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-21 00:00:00\",\"createBy\":\"super\",\"createTime\":\"2026-01-21 13:50:54\",\"id\":7,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-23 00:00:00\",\"remark\":\"测试\",\"roomNo\":\"521\",\"status\":1,\"updateBy\":\"super\",\"updateTime\":\"2026-01-21 13:58:54\",\"welfareDesc\":\"121212121212\",\"welfareName\":\"测试数据\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 14:04:49', 16);
INSERT INTO `sys_oper_log` VALUES (87, '业主福利申领', 2, 'com.property.system.controller.OwnerWelfareController.edit()', 'PUT', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-21 00:00:00\",\"createBy\":\"super\",\"createTime\":\"2026-01-21 13:50:54\",\"id\":7,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-23 00:00:00\",\"remark\":\"测试\",\"roomNo\":\"521\",\"status\":2,\"updateBy\":\"super\",\"updateTime\":\"2026-01-21 14:04:49\",\"welfareDesc\":\"121212121212\",\"welfareName\":\"测试数据\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 14:07:48', 0);
INSERT INTO `sys_oper_log` VALUES (88, '业主福利申领', 2, 'com.property.system.controller.OwnerWelfareController.edit()', 'PUT', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-21 00:00:00\",\"createBy\":\"super\",\"createTime\":\"2026-01-21 13:50:54\",\"id\":7,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-23 00:00:00\",\"remark\":\"测试\",\"roomNo\":\"521\",\"status\":2,\"updateBy\":\"super\",\"updateTime\":\"2026-01-21 14:07:48\",\"welfareDesc\":\"121212121212\",\"welfareName\":\"测试数据\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 14:21:25', 0);
INSERT INTO `sys_oper_log` VALUES (89, '业主福利申领', 2, 'com.property.system.controller.OwnerWelfareController.edit()', 'PUT', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-21 00:00:00\",\"id\":7,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-23 00:00:00\",\"remark\":\"测试\",\"roomNo\":\"521\",\"status\":1,\"updateBy\":\"super\",\"welfareDesc\":\"121212121212\",\"welfareName\":\"测试数据\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 14:31:02', 6);
INSERT INTO `sys_oper_log` VALUES (90, '业主福利申领', 2, 'com.property.system.controller.OwnerWelfareController.edit()', 'PUT', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-21 00:00:00\",\"id\":7,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-23 00:00:00\",\"remark\":\"测试\",\"roomNo\":\"521\",\"status\":1,\"updateBy\":\"super\",\"welfareDesc\":\"121212121212\",\"welfareName\":\"测试数据\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 14:31:18', 20);
INSERT INTO `sys_oper_log` VALUES (91, '业主福利申领', 2, 'com.property.system.controller.OwnerWelfareController.edit()', 'PUT', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-21 00:00:00\",\"id\":7,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-23 00:00:00\",\"remark\":\"测试\",\"roomNo\":\"521\",\"status\":1,\"updateBy\":\"super\",\"welfareDesc\":\"121212121212\",\"welfareName\":\"测试数据\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 14:31:48', 11);
INSERT INTO `sys_oper_log` VALUES (92, '业主福利申领', 2, 'com.property.system.controller.OwnerWelfareController.edit()', 'PUT', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-21 00:00:00\",\"id\":7,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-23 00:00:00\",\"remark\":\"测试\",\"roomNo\":\"521\",\"status\":2,\"updateBy\":\"super\",\"welfareDesc\":\"121212121212\",\"welfareName\":\"测试数据\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 14:35:17', 21);
INSERT INTO `sys_oper_log` VALUES (93, '业主福利申领', 2, 'com.property.system.controller.OwnerWelfareController.edit()', 'PUT', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-21 00:00:00\",\"id\":7,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-23 00:00:00\",\"remark\":\"测试\",\"roomNo\":\"521\",\"status\":0,\"updateBy\":\"super\",\"welfareDesc\":\"121212121212\",\"welfareName\":\"测试数据\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-21 14:35:25', 2);
INSERT INTO `sys_oper_log` VALUES (94, '车辆扫描信息', 1, 'com.property.system.controller.SysCarScanController.add()', 'POST', 1, 'super', NULL, '/system/carScan/addEntryCar', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-22 12:41:22\",\"direction\":0,\"params\":{},\"parkId\":2,\"picture\":\"/profile/plate/2026/01/22/车牌1_20260122124115A001.jpg\",\"plateColor\":\"blue\",\"plateNum\":\"粤S6A86G\",\"type\":1,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-22 12:41:22', 49);
INSERT INTO `sys_oper_log` VALUES (95, '车辆扫描信息', 1, 'com.property.system.controller.SysCarScanController.add()', 'POST', 1, 'super', NULL, '/system/carScan/addEntryCar', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-22 12:42:40\",\"direction\":0,\"params\":{},\"parkId\":2,\"picture\":\"/profile/plate/2026/01/22/车牌2_20260122124236A002.jpg\",\"plateColor\":\"blue\",\"plateNum\":\"苏EG08P9\",\"type\":0,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-22 12:42:40', 17);
INSERT INTO `sys_oper_log` VALUES (96, '车辆扫描信息', 1, 'com.property.system.controller.SysCarScanController.exitCar()', 'POST', 1, 'super', NULL, '/system/carScan/exitCar', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-22 13:00:03\",\"direction\":1,\"params\":{},\"parkId\":2,\"picture\":\"/profile/plate/2026/01/22/车牌2_20260122130002A001.jpg\",\"plateColor\":\"blue\",\"plateNum\":\"苏EG08P9\",\"type\":0,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-22 13:00:03', 41);
INSERT INTO `sys_oper_log` VALUES (97, '车辆扫描信息', 1, 'com.property.system.controller.SysCarScanController.exitCar()', 'POST', 1, 'super', NULL, '/system/carScan/exitCar', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-22 13:00:14\",\"direction\":1,\"params\":{},\"parkId\":2,\"picture\":\"/profile/plate/2026/01/22/车牌1_20260122130013A002.jpg\",\"plateColor\":\"blue\",\"plateNum\":\"粤S6A86G\",\"type\":1,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-22 13:00:14', 16);
INSERT INTO `sys_oper_log` VALUES (98, '用户头像', 2, 'com.property.system.controller.SysProfileController.avatar()', 'POST', 1, 'super', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2026/01/24/头像_20260124161538A001.jpg\",\"code\":200}', 0, NULL, '2026-01-24 16:15:38', 50);
INSERT INTO `sys_oper_log` VALUES (99, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"黑龙江省绥化市海伦市\",\"dateOfBirth\":\"2011-05-02\",\"identityNo\":\"45222\",\"occupation\":\"20\",\"ownerId\":6,\"ownerName\":\"demo\",\"params\":{},\"phoneNumber\":\"1205200325\",\"signature\":\"一切皆有可能\",\"updateBy\":\"super\",\"userId\":103}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 11:53:57', 15);
INSERT INTO `sys_oper_log` VALUES (100, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"黑龙江省绥化市海伦市\",\"dateOfBirth\":\"2011-05-02\",\"identityNo\":\"45222\",\"occupation\":\"20\",\"ownerId\":6,\"ownerName\":\"张敏\",\"params\":{},\"phoneNumber\":\"1205200325\",\"signature\":\"一切皆有可能\",\"updateBy\":\"super\",\"userId\":103}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 12:12:03', 7);
INSERT INTO `sys_oper_log` VALUES (101, '订单', 1, 'com.property.system.controller.SysOrderController.add()', 'POST', 1, 'super', NULL, '/system/order', '127.0.0.1', '内网IP', '{\"actualAmount\":2100.00,\"createTime\":\"2026-02-02 12:43:17\",\"id\":37,\"items\":[{\"amount\":2100,\"description\":\"房租2026年2月\",\"id\":38,\"itemName\":\"房租2026年2月\",\"orderId\":37,\"params\":{},\"quantity\":1,\"unitPrice\":0}],\"orderNo\":\"REN20260202124317589\",\"orderType\":\"房租\",\"params\":{},\"pointsUsed\":0,\"propertyId\":4,\"remark\":\"\",\"status\":\"1\",\"totalAmount\":2100.00,\"userId\":105,\"userName\":\"李春伟\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 12:43:17', 31);
INSERT INTO `sys_oper_log` VALUES (102, '物业维修', 1, 'com.property.system.controller.SysPropertyRepairController.add()', 'POST', 1, '李春伟', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"applicantId\":105,\"applicantName\":\"李春伟\",\"applicantPhone\":\"18846571726\",\"createBy\":\"李春伟\",\"id\":12,\"imageUrl\":\"/profile/upload/2026/02/02/R-C_20260202140631A001.png\",\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨市\",\"propertyId\":4,\"repairDescription\":\"楼上漏水\",\"repairItem\":\"漏水\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 14:06:33', 10);
INSERT INTO `sys_oper_log` VALUES (103, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"assignTime\":\"2026-02-02 14:07:09\",\"assigneeName\":\"demo1\",\"assigneePhone\":\"18833334444\",\"id\":12,\"params\":{},\"remark\":\"\",\"status\":\"2\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-02 14:07:09\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 14:07:09', 8);
INSERT INTO `sys_oper_log` VALUES (104, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'demo1', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"completedTime\":\"2026-02-02 14:07:32\",\"id\":12,\"params\":{},\"status\":\"1\",\"updateBy\":\"demo1\",\"updateTime\":\"2026-02-02 14:07:32\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 14:07:32', 9);
INSERT INTO `sys_oper_log` VALUES (105, '物业维修', 1, 'com.property.system.controller.SysPropertyRepairController.add()', 'POST', 1, '李春伟', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"applicantId\":105,\"applicantName\":\"李春伟\",\"applicantPhone\":\"12344445555\",\"createBy\":\"李春伟\",\"id\":13,\"imageUrl\":\"/profile/upload/2026/02/02/R-C_20260202151501A002.png\",\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨市\",\"propertyId\":4,\"repairDescription\":\"楼上漏水了\",\"repairItem\":\"漏水\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 15:15:24', 10);
INSERT INTO `sys_oper_log` VALUES (106, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"assignTime\":\"2026-02-02 15:35:34\",\"assigneeName\":\"demo1\",\"assigneePhone\":\"18833334444\",\"id\":13,\"params\":{},\"remark\":\"\",\"status\":\"2\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-02 15:35:34\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 15:35:34', 16);
INSERT INTO `sys_oper_log` VALUES (107, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'demo1', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"completedTime\":\"2026-02-02 15:44:46\",\"id\":13,\"params\":{},\"status\":\"1\",\"updateBy\":\"demo1\",\"updateTime\":\"2026-02-02 15:44:46\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 15:44:46', 11);
INSERT INTO `sys_oper_log` VALUES (108, '用户投诉与反馈', 3, 'com.property.system.controller.SysFeedbackController.remove()', 'DELETE', 1, 'super', NULL, '/system/feedback/3', '127.0.0.1', '内网IP', '[3]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 17:54:22', 10);
INSERT INTO `sys_oper_log` VALUES (109, '用户投诉与反馈', 1, 'com.property.system.controller.SysFeedbackController.add()', 'POST', 1, '李春伟', NULL, '/system/feedback', '127.0.0.1', '内网IP', '{\"contact\":\"18846571726\",\"content\":\"邻居太吵了\",\"createBy\":\"李春伟\",\"id\":5,\"params\":{},\"userId\":105,\"userName\":\"李春伟\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 18:28:25', 24);
INSERT INTO `sys_oper_log` VALUES (110, '订单', 1, 'com.property.system.controller.SysOrderController.add()', 'POST', 1, 'super', NULL, '/system/order', '127.0.0.1', '内网IP', '{\"actualAmount\":30.00,\"associationId\":13,\"createTime\":\"2026-02-03 14:41:06\",\"id\":38,\"items\":[{\"amount\":30,\"description\":\"\",\"id\":39,\"itemName\":\"人工费\",\"orderId\":38,\"params\":{},\"quantity\":1,\"unitPrice\":30}],\"orderNo\":\"REP20260203144106524\",\"orderType\":\"维修\",\"params\":{},\"pointsUsed\":0,\"propertyId\":4,\"remark\":\"\",\"status\":\"1\",\"totalAmount\":30.00,\"userId\":105,\"userName\":\"李春伟\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 14:41:06', 43);
INSERT INTO `sys_oper_log` VALUES (111, '订单支付', 2, 'com.property.system.controller.SysOrderController.pay()', 'PUT', 1, '李春伟', NULL, '/system/order/pay', '127.0.0.1', '内网IP', '{\"actualAmount\":30,\"id\":38,\"params\":{},\"pointsUsed\":0,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 14:53:00', 15);
INSERT INTO `sys_oper_log` VALUES (112, '订单支付', 2, 'com.property.system.controller.SysOrderController.pay()', 'PUT', 1, '李春伟', NULL, '/system/order/pay', '127.0.0.1', '内网IP', '{\"actualAmount\":2096,\"id\":37,\"params\":{},\"pointsUsed\":40,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 14:54:05', 8);
INSERT INTO `sys_oper_log` VALUES (113, '调整积分', 2, 'com.property.system.controller.OwnerPointsController.adjustPoints()', 'POST', 1, '李春伟', NULL, '/system/ownerPoints/adjustPoints', '127.0.0.1', '内网IP', '{\"adjustType\":\"SUBTRACT\",\"ownerPoints\":{\"ownerId\":8,\"params\":{},\"points\":40,\"updateBy\":\"李春伟\",\"updateTime\":\"2026-01-18 13:47:49\"},\"reason\":\"系统缴费扣减积分，订单号：REN20260202124317589，抵扣金额：¥4\"}', '{\"msg\":\"积分调整成功\",\"code\":200}', 0, NULL, '2026-02-03 14:54:05', 39);
INSERT INTO `sys_oper_log` VALUES (114, '物业维修', 1, 'com.property.system.controller.SysPropertyRepairController.add()', 'POST', 1, '李春伟', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"applicantId\":105,\"applicantName\":\"李春伟\",\"applicantPhone\":\"18846571726\",\"createBy\":\"李春伟\",\"id\":14,\"imageUrl\":\"/profile/upload/2026/02/03/R-C_20260203164617A001.png\",\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨市\",\"propertyId\":4,\"repairDescription\":\"测试数据\",\"repairItem\":\"测试\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 16:46:51', 16);
INSERT INTO `sys_oper_log` VALUES (115, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"assignTime\":\"2026-02-03 16:52:49\",\"assigneeName\":\"demo1\",\"assigneePhone\":\"18833334444\",\"id\":14,\"params\":{},\"remark\":\"\",\"status\":\"2\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-03 16:52:49\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 16:52:49', 9);
INSERT INTO `sys_oper_log` VALUES (116, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'demo1', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"completedTime\":\"2026-02-03 16:54:45\",\"id\":14,\"params\":{},\"status\":\"1\",\"updateBy\":\"demo1\",\"updateTime\":\"2026-02-03 16:54:45\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 16:54:45', 10);
INSERT INTO `sys_oper_log` VALUES (117, '物业维修', 3, 'com.property.system.controller.SysPropertyRepairController.remove()', 'DELETE', 1, 'super', NULL, '/system/repair/10', '127.0.0.1', '内网IP', '[10]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 17:02:06', 10);
INSERT INTO `sys_oper_log` VALUES (118, '物业维修', 3, 'com.property.system.controller.SysPropertyRepairController.remove()', 'DELETE', 1, 'super', NULL, '/system/repair/8', '127.0.0.1', '内网IP', '[8]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 17:03:08', 6);
INSERT INTO `sys_oper_log` VALUES (119, '招商信息', 1, 'com.property.system.controller.InvestmentInfoController.add()', 'POST', 1, 'super', NULL, '/investment/info', '127.0.0.1', '内网IP', '{\"area\":122,\"contactPerson\":\"fefe\",\"contactPhone\":\"fefef\",\"content\":\"1221212121\",\"createBy\":\"super\",\"id\":6,\"location\":\"A\",\"params\":{},\"publishTime\":\"2026-02-03 00:00:00\",\"rentPrice\":1212,\"status\":0,\"title\":\"测试数据\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 17:27:08', 11);
INSERT INTO `sys_oper_log` VALUES (120, '招商进度', 1, 'com.property.system.controller.InvestmentProgressController.add()', 'POST', 1, 'super', NULL, '/investment/progress', '127.0.0.1', '内网IP', '{\"createBy\":\"super\",\"id\":7,\"investmentId\":6,\"nextPlan\":\"34343\",\"params\":{},\"progressDate\":\"2026-02-03 00:00:00\",\"progressDesc\":\"343434343\",\"progressType\":\"咨询\",\"trackPerson\":\"43434\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 17:34:53', 7);
INSERT INTO `sys_oper_log` VALUES (121, '收益明细', 1, 'com.property.system.controller.IncomeDetailController.add()', 'POST', 1, 'super', NULL, '/investment/income', '127.0.0.1', '内网IP', '{\"amount\":343434343,\"createBy\":\"super\",\"id\":6,\"incomeType\":\"租金\",\"investmentId\":6,\"invoiceNo\":\"43434343\",\"params\":{},\"payerName\":\"34343\",\"payerPhone\":\"43434\",\"paymentDate\":\"2026-02-03 00:00:00\",\"paymentMethod\":\"转账\",\"periodEnd\":\"2027-07-08 00:00:00\",\"periodStart\":\"2026-02-04 00:00:00\",\"remark\":\"43434\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-03 17:35:23', 10);
INSERT INTO `sys_oper_log` VALUES (122, '公共设施信息', 1, 'com.property.system.controller.SysPublicFacilityController.add()', 'POST', 1, 'super', NULL, '/system/facility', '127.0.0.1', '内网IP', '{\"createBy\":\"super\",\"facilityCode\":\"23232\",\"facilityName\":\"3232\",\"facilityType\":\"健身器材\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:24:24', 16);
INSERT INTO `sys_oper_log` VALUES (123, '公共设施信息', 3, 'com.property.system.controller.SysPublicFacilityController.remove()', 'DELETE', 1, 'super', NULL, '/system/facility/4', '127.0.0.1', '内网IP', '[4]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:24:28', 33);
INSERT INTO `sys_oper_log` VALUES (124, '维修维护记录', 1, 'com.property.system.controller.SysMaintenanceRecordController.add()', 'POST', 1, 'super', NULL, '/system/maintenance', '127.0.0.1', '内网IP', '{\"createBy\":\"super\",\"facilityCode\":\"12121\",\"facilityName\":\"2121\",\"maintainContent\":\"21212\",\"maintainDate\":\"2026-02-04\",\"maintainPerson\":\"21212\",\"maintainType\":\"1\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\modern-property-service-new\\property-manage\\target\\classes\\mapper\\system\\SysMaintenanceRecordMapper.xml]\r\n### The error may involve com.property.system.mapper.SysMaintenanceRecordMapper.insertMaintenanceRecord-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_maintenance_record (                    facility_code,           facility_name,           maintain_type,           maintain_date,           maintain_content,           maintain_person,                                                                       create_by,          create_time         ) values (                    ?,           ?,           ?,           ?,           ?,           ?,                                                                       ?,          sysdate()         )\r\n### Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\n; Field \'facility_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value', '2026-02-04 21:24:39', 65);
INSERT INTO `sys_oper_log` VALUES (125, '维修维护记录', 1, 'com.property.system.controller.SysMaintenanceRecordController.add()', 'POST', 1, 'super', NULL, '/system/maintenance', '127.0.0.1', '内网IP', '{\"createBy\":\"super\",\"facilityCode\":\"12121\",\"facilityName\":\"2121\",\"maintainContent\":\"21212\",\"maintainDate\":\"2026-02-04\",\"maintainPerson\":\"小明\",\"maintainType\":\"1\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\modern-property-service-new\\property-manage\\target\\classes\\mapper\\system\\SysMaintenanceRecordMapper.xml]\r\n### The error may involve com.property.system.mapper.SysMaintenanceRecordMapper.insertMaintenanceRecord-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_maintenance_record (                    facility_code,           facility_name,           maintain_type,           maintain_date,           maintain_content,           maintain_person,                                                                       create_by,          create_time         ) values (                    ?,           ?,           ?,           ?,           ?,           ?,                                                                       ?,          sysdate()         )\r\n### Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\n; Field \'facility_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value', '2026-02-04 21:24:49', 0);
INSERT INTO `sys_oper_log` VALUES (126, '维修维护记录', 1, 'com.property.system.controller.SysMaintenanceRecordController.add()', 'POST', 1, 'super', NULL, '/system/maintenance', '127.0.0.1', '内网IP', '{\"cost\":3232,\"createBy\":\"super\",\"facilityCode\":\"12121\",\"facilityName\":\"2121\",\"maintainContent\":\"21212\",\"maintainDate\":\"2026-02-04\",\"maintainDept\":\"23232\",\"maintainPerson\":\"小明\",\"maintainResult\":\"1\",\"maintainType\":\"1\",\"nextMaintainDate\":\"2026-02-25\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\modern-property-service-new\\property-manage\\target\\classes\\mapper\\system\\SysMaintenanceRecordMapper.xml]\r\n### The error may involve com.property.system.mapper.SysMaintenanceRecordMapper.insertMaintenanceRecord-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_maintenance_record (                    facility_code,           facility_name,           maintain_type,           maintain_date,           maintain_content,           maintain_person,           maintain_dept,           cost,           maintain_result,           next_maintain_date,                               create_by,          create_time         ) values (                    ?,           ?,           ?,           ?,           ?,           ?,           ?,           ?,           ?,           ?,                               ?,          sysdate()         )\r\n### Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\n; Field \'facility_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value', '2026-02-04 21:24:59', 7);
INSERT INTO `sys_oper_log` VALUES (127, '维修维护记录', 1, 'com.property.system.controller.SysMaintenanceRecordController.add()', 'POST', 1, 'super', NULL, '/system/maintenance', '127.0.0.1', '内网IP', '{\"cost\":3232,\"createBy\":\"super\",\"facilityCode\":\"12121\",\"facilityName\":\"2121\",\"maintainContent\":\"21212\",\"maintainDate\":\"2026-02-04\",\"maintainDept\":\"23232\",\"maintainPerson\":\"小明\",\"maintainResult\":\"1\",\"maintainType\":\"1\",\"nextMaintainDate\":\"2026-02-25\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\modern-property-service-new\\property-manage\\target\\classes\\mapper\\system\\SysMaintenanceRecordMapper.xml]\r\n### The error may involve com.property.system.mapper.SysMaintenanceRecordMapper.insertMaintenanceRecord-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_maintenance_record (                    facility_code,           facility_name,           maintain_type,           maintain_date,           maintain_content,           maintain_person,           maintain_dept,           cost,           maintain_result,           next_maintain_date,                               create_by,          create_time         ) values (                    ?,           ?,           ?,           ?,           ?,           ?,           ?,           ?,           ?,           ?,                               ?,          sysdate()         )\r\n### Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\n; Field \'facility_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value', '2026-02-04 21:25:04', 8);
INSERT INTO `sys_oper_log` VALUES (128, '维修维护记录', 1, 'com.property.system.controller.SysMaintenanceRecordController.add()', 'POST', 1, 'super', NULL, '/system/maintenance', '127.0.0.1', '内网IP', '{\"createBy\":\"super\",\"facilityCode\":\"FS-2023-001\",\"facilityName\":\"34234324\",\"maintainContent\":\"4324234\",\"maintainDate\":\"2026-02-04\",\"maintainPerson\":\"2344324\",\"maintainType\":\"1\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\modern-property-service-new\\property-manage\\target\\classes\\mapper\\system\\SysMaintenanceRecordMapper.xml]\r\n### The error may involve com.property.system.mapper.SysMaintenanceRecordMapper.insertMaintenanceRecord-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_maintenance_record (                    facility_code,           facility_name,           maintain_type,           maintain_date,           maintain_content,           maintain_person,                                                                       create_by,          create_time         ) values (                    ?,           ?,           ?,           ?,           ?,           ?,                                                                       ?,          sysdate()         )\r\n### Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\n; Field \'facility_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value', '2026-02-04 21:25:33', 0);
INSERT INTO `sys_oper_log` VALUES (129, '维修维护记录', 1, 'com.property.system.controller.SysMaintenanceRecordController.add()', 'POST', 1, 'super', NULL, '/system/maintenance', '127.0.0.1', '内网IP', '{\"createBy\":\"super\",\"facilityCode\":\"FS-2023-001\",\"facilityName\":\"儿童滑梯\",\"maintainContent\":\"测试\",\"maintainDate\":\"2026-02-04\",\"maintainPerson\":\"1212121\",\"maintainType\":\"2\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\modern-property-service-new\\property-manage\\target\\classes\\mapper\\system\\SysMaintenanceRecordMapper.xml]\r\n### The error may involve com.property.system.mapper.SysMaintenanceRecordMapper.insertMaintenanceRecord-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_maintenance_record (                    facility_code,           facility_name,           maintain_type,           maintain_date,           maintain_content,           maintain_person,                                                                       create_by,          create_time         ) values (                    ?,           ?,           ?,           ?,           ?,           ?,                                                                       ?,          sysdate()         )\r\n### Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\n; Field \'facility_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value', '2026-02-04 21:26:28', 13);
INSERT INTO `sys_oper_log` VALUES (130, '维修维护记录', 1, 'com.property.system.controller.SysMaintenanceRecordController.add()', 'POST', 1, 'super', NULL, '/system/maintenance', '127.0.0.1', '内网IP', '{\"createBy\":\"super\",\"facilityCode\":\"FS-2023-001\",\"facilityName\":\"儿童滑梯\",\"maintainContent\":\"测试\",\"maintainDate\":\"2026-02-04\",\"maintainPerson\":\"121212\",\"maintainType\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:30:51', 13);
INSERT INTO `sys_oper_log` VALUES (131, '维修维护记录', 3, 'com.property.system.controller.SysMaintenanceRecordController.remove()', 'DELETE', 1, 'super', NULL, '/system/maintenance/3', '127.0.0.1', '内网IP', '[3]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:31:38', 0);
INSERT INTO `sys_oper_log` VALUES (132, '损坏报废登记', 1, 'com.property.system.controller.SysDamageRecordController.add()', 'POST', 1, 'super', NULL, '/system/damage', '127.0.0.1', '内网IP', '{\"createBy\":\"super\",\"damageDate\":\"2026-02-04\",\"damageDescription\":\"1212121\",\"damageType\":\"1\",\"facilityCode\":\"FS-2023-001\",\"facilityName\":\"儿童滑梯\",\"handleStatus\":\"1\",\"reporter\":\"21212\",\"reporterPhone\":\"21212121\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\modern-property-service-new\\property-manage\\target\\classes\\mapper\\system\\SysDamageRecordMapper.xml]\r\n### The error may involve com.property.system.mapper.SysDamageRecordMapper.insertDamageRecord-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_damage_record (                    facility_code,           facility_name,           damage_date,           damage_type,           damage_description,           reporter,           reporter_phone,           handle_status,                                                                       create_by,          create_time         ) values (                    ?,           ?,           ?,           ?,           ?,           ?,           ?,           ?,                                                                       ?,          sysdate()         )\r\n### Cause: java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value\n; Field \'facility_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'facility_id\' doesn\'t have a default value', '2026-02-04 21:31:59', 7);
INSERT INTO `sys_oper_log` VALUES (133, '损坏报废登记', 1, 'com.property.system.controller.SysDamageRecordController.add()', 'POST', 1, 'super', NULL, '/system/damage', '127.0.0.1', '内网IP', '{\"createBy\":\"super\",\"damageDate\":\"2026-02-04\",\"damageDescription\":\"1212121\",\"damageType\":\"1\",\"facilityCode\":\"FS-2023-001\",\"facilityName\":\"儿童滑梯\",\"handleStatus\":\"1\",\"reporter\":\"21212\",\"reporterPhone\":\"21212121\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:32:29', 10);
INSERT INTO `sys_oper_log` VALUES (134, '损坏报废登记', 3, 'com.property.system.controller.SysDamageRecordController.remove()', 'DELETE', 1, 'super', NULL, '/system/damage/2', '127.0.0.1', '内网IP', '[2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:32:37', 12);
INSERT INTO `sys_oper_log` VALUES (135, '招商信息', 3, 'com.property.system.controller.InvestmentInfoController.remove()', 'DELETE', 1, 'super', NULL, '/investment/info/6', '127.0.0.1', '内网IP', '[6]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:32:44', 8);
INSERT INTO `sys_oper_log` VALUES (136, '招商进度', 3, 'com.property.system.controller.InvestmentProgressController.remove()', 'DELETE', 1, 'super', NULL, '/investment/progress/7', '127.0.0.1', '内网IP', '[7]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:32:53', 0);
INSERT INTO `sys_oper_log` VALUES (137, '收益明细', 3, 'com.property.system.controller.IncomeDetailController.remove()', 'DELETE', 1, 'super', NULL, '/investment/income/6', '127.0.0.1', '内网IP', '[6]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:32:57', 7);
INSERT INTO `sys_oper_log` VALUES (138, '招商信息', 1, 'com.property.system.controller.InvestmentInfoController.add()', 'POST', 1, 'super', NULL, '/investment/info', '127.0.0.1', '内网IP', '{\"area\":21321,\"content\":\"321313\",\"createBy\":\"super\",\"id\":7,\"location\":\"213213\",\"params\":{},\"status\":0,\"title\":\"321321\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:33:07', 17);
INSERT INTO `sys_oper_log` VALUES (139, '招商信息', 3, 'com.property.system.controller.InvestmentInfoController.remove()', 'DELETE', 1, 'super', NULL, '/investment/info/7', '127.0.0.1', '内网IP', '[7]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:33:15', 0);
INSERT INTO `sys_oper_log` VALUES (140, '招商信息', 1, 'com.property.system.controller.InvestmentInfoController.add()', 'POST', 1, 'super', NULL, '/investment/info', '127.0.0.1', '内网IP', '{\"content\":\"213213\",\"createBy\":\"super\",\"id\":8,\"location\":\"213213\",\"params\":{},\"status\":0,\"title\":\"213123\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:38:54', 0);
INSERT INTO `sys_oper_log` VALUES (141, '招商信息', 3, 'com.property.system.controller.InvestmentInfoController.remove()', 'DELETE', 1, 'super', NULL, '/investment/info/8', '127.0.0.1', '内网IP', '[8]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:38:59', 0);
INSERT INTO `sys_oper_log` VALUES (142, '招商信息', 1, 'com.property.system.controller.InvestmentInfoController.add()', 'POST', 1, 'super', NULL, '/investment/info', '127.0.0.1', '内网IP', '{\"content\":\"3213\",\"createBy\":\"super\",\"id\":9,\"location\":\"2131232\",\"params\":{},\"status\":0,\"title\":\"2321321\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:39:55', 8);
INSERT INTO `sys_oper_log` VALUES (143, '招商信息', 3, 'com.property.system.controller.InvestmentInfoController.remove()', 'DELETE', 1, 'super', NULL, '/investment/info/9', '127.0.0.1', '内网IP', '[9]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:40:02', 0);
INSERT INTO `sys_oper_log` VALUES (144, '招商信息', 1, 'com.property.system.controller.InvestmentInfoController.add()', 'POST', 1, 'super', NULL, '/investment/info', '127.0.0.1', '内网IP', '{\"content\":\"32131\",\"createBy\":\"super\",\"id\":10,\"location\":\"312321\",\"params\":{},\"status\":0,\"title\":\"231312\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:42:29', 0);
INSERT INTO `sys_oper_log` VALUES (145, '招商信息', 3, 'com.property.system.controller.InvestmentInfoController.remove()', 'DELETE', 1, 'super', NULL, '/investment/info/10', '127.0.0.1', '内网IP', '[10]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:42:36', 5);
INSERT INTO `sys_oper_log` VALUES (146, '招商信息', 1, 'com.property.system.controller.InvestmentInfoController.add()', 'POST', 1, 'super', NULL, '/investment/info', '127.0.0.1', '内网IP', '{\"content\":\"21212\",\"createBy\":\"super\",\"id\":11,\"location\":\"212121\",\"params\":{},\"status\":0,\"title\":\"121212\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:47:53', 8);
INSERT INTO `sys_oper_log` VALUES (147, '招商信息', 3, 'com.property.system.controller.InvestmentInfoController.remove()', 'DELETE', 1, 'super', NULL, '/investment/info/11', '127.0.0.1', '内网IP', '[11]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:47:56', 6);
INSERT INTO `sys_oper_log` VALUES (148, '业主福利申领', 1, 'com.property.system.controller.OwnerWelfareController.add()', 'POST', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-02-04 00:00:00\",\"createBy\":\"super\",\"id\":8,\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"roomNo\":\"521\",\"status\":0,\"welfareName\":\"324324324\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:48:17', 10);
INSERT INTO `sys_oper_log` VALUES (149, '业主福利申领', 3, 'com.property.system.controller.OwnerWelfareController.remove()', 'DELETE', 1, 'super', NULL, '/investment/welfare/8', '127.0.0.1', '内网IP', '[8]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:48:24', 18);
INSERT INTO `sys_oper_log` VALUES (150, '招商进度', 1, 'com.property.system.controller.InvestmentProgressController.add()', 'POST', 1, 'super', NULL, '/investment/progress', '127.0.0.1', '内网IP', '{\"createBy\":\"super\",\"id\":8,\"investmentId\":2,\"params\":{},\"progressDesc\":\"24532423432\",\"progressType\":\"咨询\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:52:14', 9);
INSERT INTO `sys_oper_log` VALUES (151, '招商进度', 3, 'com.property.system.controller.InvestmentProgressController.remove()', 'DELETE', 1, 'super', NULL, '/investment/progress/8', '127.0.0.1', '内网IP', '[8]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:52:17', 16);
INSERT INTO `sys_oper_log` VALUES (152, '招商信息', 2, 'com.property.system.controller.InvestmentInfoController.edit()', 'PUT', 1, 'super', NULL, '/investment/info', '127.0.0.1', '内网IP', '{\"area\":200,\"contactPerson\":\"李主任\",\"contactPhone\":\"13800138002\",\"content\":\"精装修办公空间，配备独立空调，拎包入住\",\"createBy\":\"admin\",\"createTime\":\"2025-12-30 20:46:34\",\"id\":2,\"location\":\"B栋二楼201-203\",\"params\":{},\"publishTime\":\"2026-01-10 10:00:00\",\"remark\":\"已签约，合同期3年\",\"rentPrice\":100,\"status\":2,\"title\":\"B栋二楼办公空间招租\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:54:29', 10);
INSERT INTO `sys_oper_log` VALUES (153, '招商信息', 2, 'com.property.system.controller.InvestmentInfoController.edit()', 'PUT', 1, 'super', NULL, '/investment/info', '127.0.0.1', '内网IP', '{\"area\":200,\"contactPerson\":\"李主任\",\"contactPhone\":\"13800138002\",\"content\":\"精装修办公空间，配备独立空调，拎包入住\",\"createBy\":\"admin\",\"createTime\":\"2025-12-30 20:46:34\",\"id\":2,\"location\":\"B栋二楼201-203\",\"params\":{},\"publishTime\":\"2026-01-10 10:00:00\",\"remark\":\"已签约，合同期3年\",\"rentPrice\":100,\"status\":1,\"title\":\"B栋二楼办公空间招租\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-04 21:54:29\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:54:34', 5);
INSERT INTO `sys_oper_log` VALUES (154, '招商信息', 1, 'com.property.system.controller.InvestmentInfoController.add()', 'POST', 1, 'super', NULL, '/investment/info', '127.0.0.1', '内网IP', '{\"content\":\"423423\",\"createBy\":\"super\",\"id\":12,\"location\":\"4324234\",\"params\":{},\"status\":0,\"title\":\"312312\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:55:49', 0);
INSERT INTO `sys_oper_log` VALUES (155, '招商信息', 3, 'com.property.system.controller.InvestmentInfoController.remove()', 'DELETE', 1, 'super', NULL, '/investment/info/12', '127.0.0.1', '内网IP', '[12]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:55:52', 6);
INSERT INTO `sys_oper_log` VALUES (156, '收益明细', 1, 'com.property.system.controller.IncomeDetailController.add()', 'POST', 1, 'super', NULL, '/investment/income', '127.0.0.1', '内网IP', '{\"amount\":3423423423,\"createBy\":\"super\",\"id\":7,\"incomeType\":\"租金\",\"investmentId\":2,\"params\":{},\"paymentDate\":\"2026-02-04 00:00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:56:24', 15);
INSERT INTO `sys_oper_log` VALUES (157, '收益明细', 3, 'com.property.system.controller.IncomeDetailController.remove()', 'DELETE', 1, 'super', NULL, '/investment/income/7', '127.0.0.1', '内网IP', '[7]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 21:56:28', 5);
INSERT INTO `sys_oper_log` VALUES (158, '用户管理', 2, 'com.property.system.controller.SysUserController.edit()', 'PUT', 1, 'super', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-05-10 01:20:47\",\"delFlag\":\"0\",\"email\":\"222360@qq.com\",\"loginDate\":\"2025-12-30 21:06:25\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"asd\",\"params\":{},\"phonenumber\":\"13025265222\",\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"owner\",\"roleName\":\"业主\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"super\",\"userId\":103,\"userName\":\"张敏\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-05 08:32:06', 38);
INSERT INTO `sys_oper_log` VALUES (159, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"黑龙江省绥化市海伦市\",\"dateOfBirth\":\"2011-05-02\",\"identityNo\":\"45222\",\"occupation\":\"20\",\"ownerId\":6,\"ownerName\":\"asd\",\"params\":{},\"phoneNumber\":\"1205200325\",\"signature\":\"一切皆有可能\",\"updateBy\":\"super\",\"userId\":103}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-05 08:32:27', 9);
INSERT INTO `sys_oper_log` VALUES (160, '用户管理', 2, 'com.property.system.controller.SysUserController.edit()', 'PUT', 1, 'super', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-05-10 01:20:47\",\"delFlag\":\"0\",\"email\":\"2220@qq.com\",\"loginDate\":\"2025-12-30 21:06:25\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"asd\",\"params\":{},\"phonenumber\":\"13025262222\",\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"owner\",\"roleName\":\"业主\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"super\",\"userId\":103,\"userName\":\"asd\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-05 08:34:04', 20);
INSERT INTO `sys_oper_log` VALUES (161, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"黑龙江省绥化市海伦市伦河镇\",\"dateOfBirth\":\"2003-04-10\",\"identityNo\":\"232321200304101716\",\"occupation\":\"40\",\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"phoneNumber\":\"18846571726\",\"signature\":\"努力为计算机事业添砖Java\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-03 14:54:05\",\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 11:48:09', 16);
INSERT INTO `sys_oper_log` VALUES (162, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"广州市天河区珠江新城 5 号\",\"dateOfBirth\":\"1985-11-05\",\"identityNo\":\"440106198511037890\",\"occupation\":\"132\",\"ownerId\":7,\"ownerName\":\"张伟\",\"params\":{},\"phoneNumber\":\"13987654321\",\"signature\":\"热爱生活，保持热忱\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-18 13:47:23\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 11:49:37', 7);
INSERT INTO `sys_oper_log` VALUES (163, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"上海市徐汇区虹桥路 355 号\",\"dateOfBirth\":\"1992-06-18\",\"identityNo\":\"310104199206182458\",\"occupation\":\"20\",\"ownerId\":6,\"ownerName\":\"王佳怡\",\"params\":{},\"phoneNumber\":\"13812345678\",\"signature\":\"一切皆有可能\",\"updateBy\":\"super\",\"userId\":103}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 11:51:07', 25);
INSERT INTO `sys_oper_log` VALUES (164, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"黑龙江省绥化市海伦市伦河镇\",\"dateOfBirth\":\"2003-04-10\",\"identityNo\":\"232303199005154217\",\"occupation\":\"40\",\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"phoneNumber\":\"18846571726\",\"signature\":\"努力为计算机事业添砖Java\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-03 14:54:05\",\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 11:52:26', 8);
INSERT INTO `sys_oper_log` VALUES (165, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"黑龙江省绥化市海伦市伦河镇\",\"dateOfBirth\":\"1990-05-15\",\"identityNo\":\"232303199005154217\",\"occupation\":\"40\",\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"phoneNumber\":\"18846571726\",\"signature\":\"努力为计算机事业添砖Java\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-03 14:54:05\",\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 11:53:01', 6);
INSERT INTO `sys_oper_log` VALUES (166, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"黑龙江省绥化市海伦市伦河镇\",\"dateOfBirth\":\"1990-05-15\",\"identityNo\":\"232303199005154217\",\"occupation\":\"40\",\"ownerId\":8,\"ownerName\":\"李春伟\",\"params\":{},\"phoneNumber\":\"18846571726\",\"signature\":\"努力为计算机事业添砖Java\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-03 14:54:05\",\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 11:53:09', 7);
INSERT INTO `sys_oper_log` VALUES (167, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"广州市天河区珠江新城 5 号\",\"dateOfBirth\":\"1985-11-03\",\"identityNo\":\"440106198511037890\",\"occupation\":\"132\",\"ownerId\":7,\"ownerName\":\"张伟\",\"params\":{},\"phoneNumber\":\"13987654321\",\"signature\":\"热爱生活，保持热忱\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-18 13:47:23\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 11:53:20', 6);
INSERT INTO `sys_oper_log` VALUES (168, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"黑龙江省绥化市海伦市伦河镇\",\"dateOfBirth\":\"1990-05-14\",\"identityNo\":\"232303199005154217\",\"occupation\":\"40\",\"ownerId\":8,\"ownerName\":\"王美华\",\"params\":{},\"phoneNumber\":\"18846571726\",\"signature\":\"努力为计算机事业添砖Java\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-03 14:54:05\",\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 11:53:52', 6);
INSERT INTO `sys_oper_log` VALUES (169, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"黑龙江省绥化市海伦市伦河镇\",\"dateOfBirth\":\"1990-05-13\",\"identityNo\":\"232303199005154217\",\"occupation\":\"40\",\"ownerId\":8,\"ownerName\":\"赵文浩\",\"params\":{},\"phoneNumber\":\"18846571726\",\"signature\":\"努力为计算机事业添砖Java\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-03 14:54:05\",\"userId\":105}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 11:54:33', 8);
INSERT INTO `sys_oper_log` VALUES (170, '房产信息', 2, 'com.property.system.controller.SysPropertyController.bindOwner()', 'PUT', 1, 'super', NULL, '/system/property/bindOwner', '127.0.0.1', '内网IP', '{\"manager\":\"super\",\"managerId\":1,\"owner\":\"赵文浩\",\"ownerId\":8,\"params\":{},\"propertyId\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 11:56:04', 10);
INSERT INTO `sys_oper_log` VALUES (171, '房产信息', 2, 'com.property.system.controller.SysPropertyController.bindOwner()', 'PUT', 1, 'super', NULL, '/system/property/bindOwner', '127.0.0.1', '内网IP', '{\"manager\":\"super\",\"managerId\":1,\"owner\":\"王佳怡\",\"ownerId\":6,\"params\":{},\"propertyId\":4}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 11:56:17', 5);
INSERT INTO `sys_oper_log` VALUES (172, '房产信息', 2, 'com.property.system.controller.SysPropertyController.edit()', 'PUT', 1, 'super', NULL, '/system/property', '127.0.0.1', '内网IP', '{\"buildingArea\":100,\"buildingNo\":\"A\",\"createTime\":\"2025-04-12 13:22:03\",\"floor\":2,\"imageUrl\":\"/profile/upload/2026/02/07/0227.jpg_wh860_20260207115639A001.jpg\",\"manager\":\"super\",\"managerId\":1,\"owner\":\"赵文浩\",\"ownerId\":8,\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨南岗区\",\"propertyId\":3,\"propertyType\":\"住宅\",\"region\":\"12号楼\",\"roomNo\":\"202\",\"status\":\"0\",\"unitNo\":\"B\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-07 11:56:39\",\"usableArea\":90}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 11:57:07', 8);
INSERT INTO `sys_oper_log` VALUES (173, '房产信息', 2, 'com.property.system.controller.SysPropertyController.edit()', 'PUT', 1, 'super', NULL, '/system/property', '127.0.0.1', '内网IP', '{\"buildingArea\":100,\"buildingNo\":\"12\",\"createTime\":\"2025-04-12 13:22:03\",\"floor\":2,\"imageUrl\":\"/profile/upload/2026/02/07/0227.jpg_wh860_20260207115639A001.jpg\",\"manager\":\"super\",\"managerId\":1,\"owner\":\"赵文浩\",\"ownerId\":8,\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨南岗区\",\"propertyId\":3,\"propertyType\":\"住宅\",\"region\":\"12号楼\",\"roomNo\":\"202\",\"status\":\"0\",\"unitNo\":\"1\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-07 11:57:07\",\"usableArea\":90}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 11:57:22', 8);
INSERT INTO `sys_oper_log` VALUES (174, '工人信息', 2, 'com.property.system.controller.WorkerController.edit()', 'PUT', 1, 'super', NULL, '/system/worker', '127.0.0.1', '内网IP', '{\"age\":18,\"createBy\":\"demo1\",\"createTime\":\"2026-01-19 08:58:40\",\"entryDate\":\"2026-02-07 00:00:00\",\"gender\":\"0\",\"params\":{},\"phoneNumber\":\"18833334444\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-19 11:51:51\",\"userId\":108,\"workStatus\":\"0\",\"workerId\":4,\"workerName\":\"张磊\",\"workerType\":\"水工\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 12:19:46', 9);
INSERT INTO `sys_oper_log` VALUES (175, '物业维修', 1, 'com.property.system.controller.SysPropertyRepairController.add()', 'POST', 1, '李春伟', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"applicantId\":105,\"applicantName\":\"李春伟\",\"applicantPhone\":\"18846571726\",\"createBy\":\"李春伟\",\"id\":15,\"imageUrl\":\"/profile/upload/2026/02/07/R-C_20260207122041A003.png\",\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨南岗区\",\"propertyId\":3,\"repairDescription\":\"楼上漏水了\",\"repairItem\":\"漏水\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 12:20:43', 16);
INSERT INTO `sys_oper_log` VALUES (176, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"assignTime\":\"2026-02-07 12:22:26\",\"assigneeName\":\"张磊\",\"assigneePhone\":\"18833334444\",\"id\":15,\"params\":{},\"remark\":\"急单，请尽快前往\",\"status\":\"2\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-07 12:22:26\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 12:22:26', 9);
INSERT INTO `sys_oper_log` VALUES (177, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'demo1', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"completedTime\":\"2026-02-07 12:22:44\",\"id\":15,\"params\":{},\"status\":\"1\",\"updateBy\":\"demo1\",\"updateTime\":\"2026-02-07 12:22:44\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-07 12:22:44', 6);
INSERT INTO `sys_oper_log` VALUES (178, '车辆扫描信息', 1, 'com.property.system.controller.SysCarScanController.add()', 'POST', 1, 'super', NULL, '/system/carScan/addEntryCar', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-02-10 08:36:49\",\"direction\":0,\"params\":{},\"parkId\":2,\"picture\":\"/profile/plate/2026/02/10/车牌1_20260210083640A001.jpg\",\"plateColor\":\"blue\",\"plateNum\":\"粤S6A86G\",\"type\":1,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-10 08:36:49', 33);
INSERT INTO `sys_oper_log` VALUES (179, '车辆扫描信息', 1, 'com.property.system.controller.SysCarScanController.exitCar()', 'POST', 1, 'super', NULL, '/system/carScan/exitCar', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-02-10 08:37:20\",\"direction\":1,\"params\":{},\"parkId\":2,\"picture\":\"/profile/plate/2026/02/10/车牌1_20260210083718A002.jpg\",\"plateColor\":\"blue\",\"plateNum\":\"粤S6A86G\",\"type\":1,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-10 08:37:20', 20);
INSERT INTO `sys_oper_log` VALUES (180, '业主福利申领', 2, 'com.property.system.controller.OwnerWelfareController.edit()', 'PUT', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-25 10:30:00\",\"id\":1,\"ownerId\":6,\"ownerName\":\"王佳怡\",\"params\":{},\"receiveMethod\":\"自提\",\"receiveTime\":\"2026-01-26 15:20:00\",\"remark\":\"业主自行到物业中心领取\",\"roomNo\":\"521\",\"status\":1,\"updateBy\":\"super\",\"welfareDesc\":\"包含坚果、糖果、春联等\",\"welfareName\":\"2026年春节礼盒\",\"welfareType\":\"节日礼品\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-10 19:15:31', 15);
INSERT INTO `sys_oper_log` VALUES (181, '业主福利申领', 2, 'com.property.system.controller.OwnerWelfareController.edit()', 'PUT', 1, 'super', NULL, '/investment/welfare', '127.0.0.1', '内网IP', '{\"applyTime\":\"2026-01-10 09:15:00\",\"id\":2,\"ownerId\":8,\"ownerName\":\"赵文浩\",\"params\":{},\"receiveMethod\":\"配送\",\"remark\":\"等待配送\",\"roomNo\":\"202\",\"status\":0,\"updateBy\":\"super\",\"welfareDesc\":\"价值100元的超市购物券\",\"welfareName\":\"1月份生日礼券\",\"welfareType\":\"生日礼券\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-10 19:15:47', 9);
INSERT INTO `sys_oper_log` VALUES (182, '业主福利申领', 3, 'com.property.system.controller.OwnerWelfareController.remove()', 'DELETE', 1, 'super', NULL, '/investment/welfare/3', '127.0.0.1', '内网IP', '[3]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-10 19:15:56', 14);
INSERT INTO `sys_oper_log` VALUES (183, '业主福利申领', 3, 'com.property.system.controller.OwnerWelfareController.remove()', 'DELETE', 1, 'super', NULL, '/investment/welfare/4', '127.0.0.1', '内网IP', '[4]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-10 19:15:58', 8);
INSERT INTO `sys_oper_log` VALUES (184, '业主福利申领', 3, 'com.property.system.controller.OwnerWelfareController.remove()', 'DELETE', 1, 'super', NULL, '/investment/welfare/5', '127.0.0.1', '内网IP', '[5]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-10 19:16:00', 6);
INSERT INTO `sys_oper_log` VALUES (185, '业主信息', 2, 'com.property.system.controller.SysOwnerController.edit()', 'PUT', 1, 'super', NULL, '/system/owner', '127.0.0.1', '内网IP', '{\"address\":\"黑龙江省哈尔滨市南岗区复旦街\",\"dateOfBirth\":\"1985-11-03\",\"identityNo\":\"440106198511037890\",\"occupation\":\"132\",\"ownerId\":7,\"ownerName\":\"张伟\",\"params\":{},\"phoneNumber\":\"13987654321\",\"signature\":\"热爱生活，保持热忱\",\"updateBy\":\"super\",\"updateTime\":\"2026-01-18 13:47:23\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 10:48:49', 15);
INSERT INTO `sys_oper_log` VALUES (186, '物业维修', 1, 'com.property.system.controller.SysPropertyRepairController.add()', 'POST', 1, '李春伟', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"applicantId\":105,\"applicantName\":\"李春伟\",\"applicantPhone\":\"18846571726\",\"createBy\":\"李春伟\",\"id\":16,\"imageUrl\":\"/profile/upload/2026/02/27/R-C_20260227111049A001.png\",\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨南岗区\",\"propertyId\":3,\"repairDescription\":\"房屋漏水了\",\"repairItem\":\"漏水\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 11:10:51', 31);
INSERT INTO `sys_oper_log` VALUES (187, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"assignTime\":\"2026-02-27 11:11:16\",\"assigneeName\":\"张磊\",\"assigneePhone\":\"18833334444\",\"id\":16,\"params\":{},\"remark\":\"\",\"status\":\"2\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-27 11:11:16\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 11:11:16', 49);
INSERT INTO `sys_oper_log` VALUES (188, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'demo1', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"completedTime\":\"2026-02-27 11:11:38\",\"id\":16,\"params\":{},\"status\":\"1\",\"updateBy\":\"demo1\",\"updateTime\":\"2026-02-27 11:11:39\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 11:11:39', 11);
INSERT INTO `sys_oper_log` VALUES (189, '物业维修', 1, 'com.property.system.controller.SysPropertyRepairController.add()', 'POST', 1, '李春伟', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"applicantId\":105,\"applicantName\":\"李春伟\",\"applicantPhone\":\"18846571726\",\"createBy\":\"李春伟\",\"id\":17,\"imageUrl\":\"/profile/upload/2026/02/27/R-C_20260227111451A002.png\",\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨南岗区\",\"propertyId\":3,\"repairDescription\":\"房屋漏水\",\"repairItem\":\"漏水\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 11:14:56', 8);
INSERT INTO `sys_oper_log` VALUES (190, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"assignTime\":\"2026-02-27 11:15:13\",\"assigneeName\":\"张磊\",\"assigneePhone\":\"18833334444\",\"id\":17,\"params\":{},\"remark\":\"\",\"status\":\"2\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-27 11:15:13\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 11:15:13', 10);
INSERT INTO `sys_oper_log` VALUES (191, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"completedTime\":\"2026-02-27 11:15:15\",\"id\":17,\"params\":{},\"status\":\"1\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-27 11:15:15\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 11:15:15', 7);
INSERT INTO `sys_oper_log` VALUES (192, '物业维修', 1, 'com.property.system.controller.SysPropertyRepairController.add()', 'POST', 1, '李春伟', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"applicantId\":105,\"applicantName\":\"李春伟\",\"applicantPhone\":\"18846571726\",\"createBy\":\"李春伟\",\"id\":18,\"imageUrl\":\"/profile/upload/2026/02/27/R-C_20260227111621A003.png\",\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨南岗区\",\"propertyId\":3,\"repairDescription\":\"房屋漏水\",\"repairItem\":\"漏水\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 11:16:24', 5);
INSERT INTO `sys_oper_log` VALUES (193, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"assignTime\":\"2026-02-27 11:17:10\",\"assigneeName\":\"张磊\",\"assigneePhone\":\"18833334444\",\"id\":18,\"params\":{},\"remark\":\"\",\"status\":\"2\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-27 11:17:10\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 11:17:10', 10);
INSERT INTO `sys_oper_log` VALUES (194, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"completedTime\":\"2026-02-27 11:17:14\",\"id\":18,\"params\":{},\"status\":\"1\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-27 11:17:14\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 11:17:14', 12);
INSERT INTO `sys_oper_log` VALUES (195, '物业维修', 1, 'com.property.system.controller.SysPropertyRepairController.add()', 'POST', 1, '李春伟', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"applicantId\":105,\"applicantName\":\"李春伟\",\"applicantPhone\":\"18846571726\",\"createBy\":\"李春伟\",\"id\":19,\"imageUrl\":\"/profile/upload/2026/02/27/R-C_20260227111817A004.png\",\"params\":{},\"propertyAddress\":\"黑龙江省哈尔滨南岗区\",\"propertyId\":3,\"repairDescription\":\"房屋漏水\",\"repairItem\":\"漏水\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 11:18:21', 6);
INSERT INTO `sys_oper_log` VALUES (196, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"assignTime\":\"2026-02-27 11:18:40\",\"assigneeName\":\"张磊\",\"assigneePhone\":\"18833334444\",\"id\":19,\"params\":{},\"remark\":\"\",\"status\":\"2\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-27 11:18:40\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 11:18:40', 8);
INSERT INTO `sys_oper_log` VALUES (197, '物业维修', 2, 'com.property.system.controller.SysPropertyRepairController.edit()', 'PUT', 1, 'super', NULL, '/system/repair', '127.0.0.1', '内网IP', '{\"completedTime\":\"2026-02-27 11:18:43\",\"id\":19,\"params\":{},\"status\":\"1\",\"updateBy\":\"super\",\"updateTime\":\"2026-02-27 11:18:43\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 11:18:43', 8);
INSERT INTO `sys_oper_log` VALUES (198, '订单', 1, 'com.property.system.controller.SysOrderController.add()', 'POST', 1, 'super', NULL, '/system/order', '127.0.0.1', '内网IP', '{\"actualAmount\":300.00,\"createTime\":\"2026-03-03 14:57:14\",\"id\":39,\"items\":[{\"amount\":300,\"description\":\"\",\"id\":40,\"itemName\":\"房租\",\"orderId\":39,\"params\":{},\"quantity\":1,\"unitPrice\":0}],\"orderNo\":\"ORD20260303145714967\",\"orderType\":\"其它\",\"params\":{},\"pointsUsed\":0,\"propertyId\":3,\"remark\":\"\",\"status\":\"1\",\"totalAmount\":300.00,\"userId\":105,\"userName\":\"赵文浩\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 14:57:14', 30);
INSERT INTO `sys_oper_log` VALUES (199, '订单支付', 2, 'com.property.system.controller.SysOrderController.pay()', 'PUT', 1, '李春伟', NULL, '/system/order/pay', '127.0.0.1', '内网IP', '{\"actualAmount\":299,\"id\":39,\"params\":{},\"pointsUsed\":10,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 14:58:16', 11);
INSERT INTO `sys_oper_log` VALUES (200, '调整积分', 2, 'com.property.system.controller.OwnerPointsController.adjustPoints()', 'POST', 1, '李春伟', NULL, '/system/ownerPoints/adjustPoints', '127.0.0.1', '内网IP', '{\"adjustType\":\"SUBTRACT\",\"ownerPoints\":{\"ownerId\":8,\"params\":{},\"points\":30,\"updateBy\":\"李春伟\",\"updateTime\":\"2026-02-03 14:54:05\"},\"reason\":\"系统缴费扣减积分，订单号：ORD20260303145714967，抵扣金额：¥1\"}', '{\"msg\":\"积分调整成功\",\"code\":200}', 0, NULL, '2026-03-03 14:58:16', 28);
INSERT INTO `sys_oper_log` VALUES (201, '公共设施信息', 2, 'com.property.system.controller.SysPublicFacilityController.edit()', 'PUT', 1, 'super', NULL, '/system/facility', '127.0.0.1', '内网IP', '{\"contactPhone\":\"13800138001\",\"createBy\":\"admin\",\"createTime\":\"2025-12-30 18:03:04\",\"facilityCode\":\"FS-2023-001\",\"facilityId\":1,\"facilityName\":\"儿童滑梯\",\"facilityType\":\"儿童游乐\",\"installDate\":\"2026-02-03\",\"lastMaintainDate\":\"2024-01-10\",\"location\":\"A区儿童乐园\",\"maintainCycle\":30,\"manufacturer\":\"儿童游乐设备厂\",\"nextMaintainDate\":\"2024-02-10\",\"purchasePrice\":15000,\"remarks\":\"定期检查螺丝是否松动\",\"responsibilityDept\":\"物业部\",\"responsibilityPerson\":\"张三\",\"specifications\":\"大型组合滑梯\",\"status\":\"0\",\"updateBy\":\"super\",\"warrantyPeriod\":24}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:39:17', 13);
INSERT INTO `sys_oper_log` VALUES (202, '公共设施信息', 2, 'com.property.system.controller.SysPublicFacilityController.edit()', 'PUT', 1, 'super', NULL, '/system/facility', '127.0.0.1', '内网IP', '{\"contactPhone\":\"13800138001\",\"createBy\":\"admin\",\"createTime\":\"2025-12-30 18:03:04\",\"facilityCode\":\"FS-2023-001\",\"facilityId\":1,\"facilityName\":\"儿童滑梯\",\"facilityType\":\"儿童游乐\",\"installDate\":\"2026-02-03\",\"lastMaintainDate\":\"2024-01-10\",\"location\":\"A区儿童乐园\",\"maintainCycle\":30,\"manufacturer\":\"儿童游乐设备厂\",\"nextMaintainDate\":\"2024-02-10\",\"purchasePrice\":15000,\"remarks\":\"定期检查螺丝是否松动\",\"responsibilityDept\":\"物业部\",\"responsibilityPerson\":\"王刚\",\"specifications\":\"大型组合滑梯\",\"status\":\"0\",\"updateBy\":\"super\",\"updateTime\":\"2026-03-03 15:39:17\",\"warrantyPeriod\":24}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:39:46', 9);
INSERT INTO `sys_oper_log` VALUES (203, '维修维护记录', 2, 'com.property.system.controller.SysMaintenanceRecordController.edit()', 'PUT', 1, 'super', NULL, '/system/maintenance', '127.0.0.1', '内网IP', '{\"attachments\":\"\",\"cost\":300,\"createBy\":\"admin\",\"createTime\":\"2025-12-30 18:03:04\",\"facilityCode\":\"FS-2023-001\",\"facilityId\":1,\"facilityName\":\"儿童滑梯\",\"maintainContent\":\"更换磨损的滑梯垫，加固支架螺丝\",\"maintainDate\":\"2026-03-01\",\"maintainDept\":\"工程部\",\"maintainPerson\":\"维修员A\",\"maintainResult\":\"1\",\"maintainType\":\"2\",\"nextMaintainDate\":\"2024-02-10\",\"recordId\":1,\"remarks\":\"定期维护\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:45:39', 8);
INSERT INTO `sys_oper_log` VALUES (204, '维修维护记录', 2, 'com.property.system.controller.SysMaintenanceRecordController.edit()', 'PUT', 1, 'super', NULL, '/system/maintenance', '127.0.0.1', '内网IP', '{\"attachments\":\"\",\"cost\":300,\"createBy\":\"admin\",\"createTime\":\"2025-12-30 18:03:04\",\"facilityCode\":\"FS-2023-001\",\"facilityId\":1,\"facilityName\":\"儿童滑梯\",\"maintainContent\":\"更换磨损的滑梯垫，加固支架螺丝\",\"maintainDate\":\"2026-03-01\",\"maintainDept\":\"工程部\",\"maintainPerson\":\"维修员A\",\"maintainResult\":\"1\",\"maintainType\":\"2\",\"nextMaintainDate\":\"2026-10-01\",\"recordId\":1,\"remarks\":\"定期维护\",\"updateBy\":\"super\",\"updateTime\":\"2026-03-03 15:45:39\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:45:54', 8);
INSERT INTO `sys_oper_log` VALUES (205, '维修维护记录', 2, 'com.property.system.controller.SysMaintenanceRecordController.edit()', 'PUT', 1, 'super', NULL, '/system/maintenance', '127.0.0.1', '内网IP', '{\"attachments\":\"\",\"cost\":150,\"createBy\":\"admin\",\"createTime\":\"2025-12-30 18:03:04\",\"facilityCode\":\"FS-2023-003\",\"facilityId\":3,\"facilityName\":\"休闲长椅\",\"maintainContent\":\"修复松动螺丝，补漆防腐\",\"maintainDate\":\"2026-03-01\",\"maintainDept\":\"工程部\",\"maintainPerson\":\"维修员B\",\"maintainResult\":\"1\",\"maintainType\":\"2\",\"nextMaintainDate\":\"2026-10-01\",\"recordId\":2,\"remarks\":\"居民报修处理\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:46:10', 8);
INSERT INTO `sys_oper_log` VALUES (206, '损坏报废登记', 2, 'com.property.system.controller.SysDamageRecordController.edit()', 'PUT', 1, 'super', NULL, '/system/damage', '127.0.0.1', '内网IP', '{\"attachments\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-12-30 18:03:04\",\"damageDate\":\"2026-02-19\",\"damageDescription\":\"椅面木板断裂，螺丝松动\",\"damageId\":1,\"damageType\":\"1\",\"facilityCode\":\"FS-2023-003\",\"facilityId\":3,\"facilityName\":\"休闲长椅\",\"handleDate\":\"2026-03-03\",\"handleMethod\":\"1\",\"handlePerson\":\"维修员B\",\"handleStatus\":\"1\",\"remarks\":\"等待配件到货\",\"reporter\":\"赵六\",\"reporterPhone\":\"13800138004\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:46:52', 14);
INSERT INTO `sys_oper_log` VALUES (207, '公共设施信息', 2, 'com.property.system.controller.SysPublicFacilityController.edit()', 'PUT', 1, 'super', NULL, '/system/facility', '127.0.0.1', '内网IP', '{\"contactPhone\":\"13800138001\",\"createBy\":\"admin\",\"createTime\":\"2025-12-30 18:03:04\",\"facilityCode\":\"FS-2023-001\",\"facilityId\":1,\"facilityName\":\"儿童滑梯\",\"facilityType\":\"儿童游乐\",\"installDate\":\"2026-02-03\",\"lastMaintainDate\":\"2026-01-01\",\"location\":\"A区儿童乐园\",\"maintainCycle\":30,\"manufacturer\":\"儿童游乐设备厂\",\"nextMaintainDate\":\"2026-10-01\",\"purchasePrice\":15000,\"remarks\":\"定期检查螺丝是否松动\",\"responsibilityDept\":\"物业部\",\"responsibilityPerson\":\"王刚\",\"specifications\":\"大型组合滑梯\",\"status\":\"0\",\"updateBy\":\"super\",\"updateTime\":\"2026-03-03 15:39:46\",\"warrantyPeriod\":24}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:51:49', 6);
INSERT INTO `sys_oper_log` VALUES (208, '公共设施信息', 2, 'com.property.system.controller.SysPublicFacilityController.edit()', 'PUT', 1, 'super', NULL, '/system/facility', '127.0.0.1', '内网IP', '{\"contactPhone\":\"13800138002\",\"createBy\":\"admin\",\"createTime\":\"2025-12-30 18:03:04\",\"facilityCode\":\"FS-2023-002\",\"facilityId\":2,\"facilityName\":\"健身器材组合\",\"facilityType\":\"健身器材\",\"installDate\":\"2026-03-01\",\"lastMaintainDate\":\"2026-03-03\",\"location\":\"B区健身广场\",\"maintainCycle\":30,\"manufacturer\":\"健身器材公司\",\"nextMaintainDate\":\"2026-10-01\",\"purchasePrice\":25000,\"remarks\":\"注意防锈处理\",\"responsibilityDept\":\"物业部\",\"responsibilityPerson\":\"王明\",\"specifications\":\"多功能健身器\",\"status\":\"0\",\"updateBy\":\"super\",\"warrantyPeriod\":36}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:52:44', 7);
INSERT INTO `sys_oper_log` VALUES (209, '公共设施信息', 2, 'com.property.system.controller.SysPublicFacilityController.edit()', 'PUT', 1, 'super', NULL, '/system/facility', '127.0.0.1', '内网IP', '{\"contactPhone\":\"13800138001\",\"createBy\":\"admin\",\"createTime\":\"2025-12-30 18:03:04\",\"facilityCode\":\"FS-2023-001\",\"facilityId\":1,\"facilityName\":\"儿童滑梯\",\"facilityType\":\"儿童游乐\",\"installDate\":\"2026-02-03\",\"lastMaintainDate\":\"2026-03-01\",\"location\":\"A区儿童乐园\",\"maintainCycle\":30,\"manufacturer\":\"儿童游乐设备厂\",\"nextMaintainDate\":\"2026-10-01\",\"purchasePrice\":15000,\"remarks\":\"定期检查螺丝是否松动\",\"responsibilityDept\":\"物业部\",\"responsibilityPerson\":\"王刚\",\"specifications\":\"大型组合滑梯\",\"status\":\"0\",\"updateBy\":\"super\",\"updateTime\":\"2026-03-03 15:51:49\",\"warrantyPeriod\":24}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:53:03', 8);
INSERT INTO `sys_oper_log` VALUES (210, '公共设施信息', 2, 'com.property.system.controller.SysPublicFacilityController.edit()', 'PUT', 1, 'super', NULL, '/system/facility', '127.0.0.1', '内网IP', '{\"contactPhone\":\"13800138003\",\"createBy\":\"admin\",\"createTime\":\"2025-12-30 18:03:04\",\"facilityCode\":\"FS-2023-003\",\"facilityId\":3,\"facilityName\":\"休闲长椅\",\"facilityType\":\"休闲椅\",\"installDate\":\"2026-03-01\",\"lastMaintainDate\":\"2026-03-03\",\"location\":\"C区湖边步道\",\"maintainCycle\":90,\"manufacturer\":\"户外家具厂\",\"nextMaintainDate\":\"2026-10-01\",\"purchasePrice\":800,\"remarks\":\"部分螺丝松动，已报修\",\"responsibilityDept\":\"绿化部\",\"responsibilityPerson\":\"肖龙\",\"specifications\":\"防腐木长椅\",\"status\":\"1\",\"updateBy\":\"super\",\"warrantyPeriod\":12}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:53:44', 5);
INSERT INTO `sys_oper_log` VALUES (211, '公共设施信息', 2, 'com.property.system.controller.SysPublicFacilityController.edit()', 'PUT', 1, 'super', NULL, '/system/facility', '127.0.0.1', '内网IP', '{\"contactPhone\":\"13800138001\",\"createBy\":\"admin\",\"createTime\":\"2025-12-30 18:03:04\",\"facilityCode\":\"FS-2023-001\",\"facilityId\":1,\"facilityName\":\"儿童滑梯\",\"facilityType\":\"儿童游乐\",\"installDate\":\"2026-02-03\",\"lastMaintainDate\":\"2026-03-03\",\"location\":\"A区儿童乐园\",\"maintainCycle\":30,\"manufacturer\":\"儿童游乐设备厂\",\"nextMaintainDate\":\"2026-10-01\",\"purchasePrice\":15000,\"remarks\":\"定期检查螺丝是否松动\",\"responsibilityDept\":\"物业部\",\"responsibilityPerson\":\"王刚\",\"specifications\":\"大型组合滑梯\",\"status\":\"0\",\"updateBy\":\"super\",\"updateTime\":\"2026-03-03 15:53:03\",\"warrantyPeriod\":24}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:54:15', 4);
INSERT INTO `sys_oper_log` VALUES (212, '维修维护记录', 2, 'com.property.system.controller.SysMaintenanceRecordController.edit()', 'PUT', 1, 'super', NULL, '/system/maintenance', '127.0.0.1', '内网IP', '{\"attachments\":\"\",\"cost\":300,\"createBy\":\"admin\",\"createTime\":\"2025-12-30 18:03:04\",\"facilityCode\":\"FS-2023-001\",\"facilityId\":1,\"facilityName\":\"儿童滑梯\",\"maintainContent\":\"更换磨损的滑梯垫，加固支架螺丝\",\"maintainDate\":\"2026-03-03\",\"maintainDept\":\"工程部\",\"maintainPerson\":\"维修员A\",\"maintainResult\":\"1\",\"maintainType\":\"2\",\"nextMaintainDate\":\"2026-10-01\",\"recordId\":1,\"remarks\":\"定期维护\",\"updateBy\":\"super\",\"updateTime\":\"2026-03-03 15:45:54\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:54:26', 8);
INSERT INTO `sys_oper_log` VALUES (213, '维修维护记录', 2, 'com.property.system.controller.SysMaintenanceRecordController.edit()', 'PUT', 1, 'super', NULL, '/system/maintenance', '127.0.0.1', '内网IP', '{\"attachments\":\"\",\"cost\":150,\"createBy\":\"admin\",\"createTime\":\"2025-12-30 18:03:04\",\"facilityCode\":\"FS-2023-003\",\"facilityId\":3,\"facilityName\":\"休闲长椅\",\"maintainContent\":\"修复松动螺丝，补漆防腐\",\"maintainDate\":\"2026-03-03\",\"maintainDept\":\"工程部\",\"maintainPerson\":\"维修员B\",\"maintainResult\":\"1\",\"maintainType\":\"2\",\"nextMaintainDate\":\"2026-10-01\",\"recordId\":2,\"remarks\":\"居民报修处理\",\"updateBy\":\"super\",\"updateTime\":\"2026-03-03 15:46:10\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:54:32', 7);
INSERT INTO `sys_oper_log` VALUES (214, '用户投诉与反馈', 2, 'com.property.system.controller.SysFeedbackController.edit()', 'PUT', 1, 'super', NULL, '/system/feedback', '127.0.0.1', '内网IP', '{\"id\":5,\"params\":{},\"replyContent\":\"已处理\",\"replyTime\":\"2026-03-03 15:56:18\",\"replyUserId\":1,\"replyUserName\":\"super\",\"updateBy\":\"super\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-03 15:56:18', 8);

-- ----------------------------
-- Table structure for sys_order
-- ----------------------------
DROP TABLE IF EXISTS `sys_order`;
CREATE TABLE `sys_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单编号',
  `order_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单类型（rent/repair/parking等）',
  `user_id` bigint NOT NULL COMMENT '用户ID（业主）',
  `property_id` bigint NULL DEFAULT NULL COMMENT '房产ID（适用于房租/维修）',
  `total_amount` decimal(10, 2) NOT NULL COMMENT '订单总金额',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '订单状态（0已支付，1待支付）',
  `remark` int NULL DEFAULT NULL COMMENT '积分',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户姓名（业主）',
  `association_id` bigint NULL DEFAULT NULL COMMENT '关联单id， 停车单/维修单',
  `actual_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '实付金额',
  `points_used` int NULL DEFAULT 0 COMMENT '积分使用数量',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_no`(`order_no` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单主表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_order
-- ----------------------------
INSERT INTO `sys_order` VALUES (4, 'TCF20250510023017255', '停车费', 103, NULL, 6.00, '0', NULL, '2025-05-10 02:30:17', '2025-05-10 02:30:18', '张敏', 50, 6.00, 0);
INSERT INTO `sys_order` VALUES (5, 'REP20250510024240658', '维修', 103, 3, 40.00, '0', NULL, '2025-05-10 02:42:40', '2025-05-10 02:43:32', '张敏', 2, 40.00, 0);
INSERT INTO `sys_order` VALUES (6, 'REP20250510025054960', '维修', 103, 3, 40.00, '0', NULL, '2025-05-10 02:50:54', '2025-05-10 02:58:53', '张敏', 3, 40.00, 0);
INSERT INTO `sys_order` VALUES (7, 'TCF20251230144043720', '停车费', 1, NULL, 6.00, '0', NULL, '2025-12-30 14:40:43', '2025-12-30 14:40:44', 'super', 51, 6.00, 0);
INSERT INTO `sys_order` VALUES (8, 'REP20251230151252186', '维修', 103, 3, 80.00, '0', NULL, '2025-12-30 15:12:52', '2025-12-30 15:14:25', '张敏', 4, 80.00, 0);
INSERT INTO `sys_order` VALUES (9, 'REN20251230211320373', '房租', 105, 4, 5000.00, '0', NULL, '2025-12-30 21:13:20', '2025-12-30 22:08:38', '李春伟', NULL, 5000.00, 0);
INSERT INTO `sys_order` VALUES (10, 'REN20251230225545249', '房租', 105, 4, 1000.00, '0', NULL, '2025-12-30 22:55:45', '2025-12-30 23:20:49', '李春伟', NULL, 1000.00, 0);
INSERT INTO `sys_order` VALUES (11, 'REN20251231063337435', '房租', 105, 4, 300.00, '0', NULL, '2025-12-31 06:33:37', '2025-12-31 06:34:31', '李春伟', NULL, 300.00, 0);
INSERT INTO `sys_order` VALUES (12, 'ORD20251231063926646', '其它', 105, 4, 50.00, '0', NULL, '2025-12-31 06:39:26', '2025-12-31 06:40:04', '李春伟', NULL, 50.00, 0);
INSERT INTO `sys_order` VALUES (13, 'ORD20251231064917521', '其它', 105, 4, 300.00, '0', NULL, '2025-12-31 06:49:17', '2025-12-31 06:53:40', '李春伟', NULL, 300.00, 0);
INSERT INTO `sys_order` VALUES (14, 'ORD20251231065715873', '其它', 105, 4, 300.00, '0', NULL, '2025-12-31 06:57:15', '2025-12-31 06:57:56', '李春伟', NULL, 300.00, 0);
INSERT INTO `sys_order` VALUES (15, 'ORD20251231070509523', '其它', 105, 4, 200.00, '0', NULL, '2025-12-31 07:05:09', '2025-12-31 07:47:59', '李春伟', NULL, 200.00, 0);
INSERT INTO `sys_order` VALUES (16, 'ORD20251231075006170', '其它', 105, 4, 20.00, '0', NULL, '2025-12-31 07:50:06', '2025-12-31 07:50:51', '李春伟', NULL, 20.00, 0);
INSERT INTO `sys_order` VALUES (17, 'ORD20251231082030566', '其它', 105, 4, 2333.00, '0', NULL, '2025-12-31 08:20:30', '2025-12-31 08:22:44', '李春伟', NULL, 2333.00, 0);
INSERT INTO `sys_order` VALUES (18, 'ORD20251231082516588', '其它', 105, 4, 3444.00, '0', NULL, '2025-12-31 08:25:16', '2025-12-31 08:25:58', '李春伟', NULL, 3444.00, 0);
INSERT INTO `sys_order` VALUES (19, 'ORD20251231083114865', '其它', 105, 4, 500.00, '0', NULL, '2025-12-31 08:31:14', '2025-12-31 08:31:46', '李春伟', NULL, 500.00, 0);
INSERT INTO `sys_order` VALUES (20, 'ORD20251231083326516', '其它', 105, 4, 400.00, '0', NULL, '2025-12-31 08:33:26', '2025-12-31 08:34:01', '李春伟', NULL, 400.00, 0);
INSERT INTO `sys_order` VALUES (21, 'ORD20251231083549163', '其它', 105, 4, 300.00, '0', NULL, '2025-12-31 08:35:49', '2025-12-31 08:36:22', '李春伟', NULL, 300.00, 0);
INSERT INTO `sys_order` VALUES (22, 'ORD20251231092227984', '其它', 105, 4, 400.00, '0', NULL, '2025-12-31 09:22:27', '2025-12-31 09:27:03', '李春伟', NULL, 400.00, 0);
INSERT INTO `sys_order` VALUES (23, 'ORD20251231092825335', '其它', 105, 4, 300.00, '0', NULL, '2025-12-31 09:28:26', '2025-12-31 09:29:03', '李春伟', NULL, 300.00, 0);
INSERT INTO `sys_order` VALUES (24, 'ORD20251231095056448', '其它', 105, 4, 500.00, '0', NULL, '2025-12-31 09:50:56', '2025-12-31 09:51:34', '李春伟', NULL, 500.00, 0);
INSERT INTO `sys_order` VALUES (25, 'ORD20251231095424953', '其它', 105, 4, 500.00, '0', NULL, '2025-12-31 09:54:24', '2025-12-31 09:54:48', '李春伟', NULL, 500.00, 0);
INSERT INTO `sys_order` VALUES (26, 'ORD20251231095546205', '其它', 105, 4, 500.00, '0', NULL, '2025-12-31 09:55:46', '2025-12-31 09:56:17', '李春伟', NULL, 500.00, 0);
INSERT INTO `sys_order` VALUES (27, 'ORD20251231101104658', '其它', 105, 4, 400.00, '0', NULL, '2025-12-31 10:11:04', '2025-12-31 10:11:45', '李春伟', NULL, 400.00, 0);
INSERT INTO `sys_order` VALUES (28, 'ORD20251231175331806', '其它', 105, 4, 300.00, '0', NULL, '2025-12-31 17:53:31', '2025-12-31 17:54:02', '李春伟', NULL, 300.00, 0);
INSERT INTO `sys_order` VALUES (29, 'ORD20260113095438705', '其它', 105, 4, 500.00, '0', NULL, '2026-01-13 09:54:38', '2026-01-13 14:23:48', '李春伟', NULL, 500.00, 0);
INSERT INTO `sys_order` VALUES (30, 'ORD20260113145354400', '其它', 105, 4, 500.00, '0', NULL, '2026-01-13 14:53:54', '2026-01-13 14:54:48', '李春伟', NULL, 500.00, 0);
INSERT INTO `sys_order` VALUES (31, 'ORD20260113145834507', '其它', 105, 4, 300.00, '0', NULL, '2026-01-13 14:58:34', '2026-01-13 14:59:21', '李春伟', NULL, 300.00, 0);
INSERT INTO `sys_order` VALUES (32, 'REN20260118101419827', '房租', 105, 4, 500.00, '0', NULL, '2026-01-18 10:14:19', '2026-01-18 10:15:29', '李春伟', NULL, 500.00, 0);
INSERT INTO `sys_order` VALUES (33, 'ORD20260118103026238', '其它', 105, 4, 300.00, '0', NULL, '2026-01-18 10:30:26', '2026-01-18 10:31:15', '李春伟', NULL, 300.00, 0);
INSERT INTO `sys_order` VALUES (34, 'ORD20260118104810743', '其它', 105, 4, 600.00, '0', NULL, '2026-01-18 10:48:10', '2026-01-18 10:49:12', '李春伟', NULL, 599.00, 10);
INSERT INTO `sys_order` VALUES (35, 'ORD20260118105443962', '其它', 105, 4, 600.00, '0', NULL, '2026-01-18 10:54:43', '2026-01-18 10:56:13', '李春伟', NULL, 596.00, 40);
INSERT INTO `sys_order` VALUES (36, 'TCF20260118112032368', '停车费', 1, NULL, 6.00, '0', NULL, '2026-01-18 11:20:32', '2026-01-18 11:20:33', 'super', 52, 6.00, 0);
INSERT INTO `sys_order` VALUES (37, 'REN20260202124317589', '房租', 105, 4, 2100.00, '0', NULL, '2026-02-02 12:43:17', '2026-02-03 14:54:05', '李春伟', NULL, 2096.00, 40);
INSERT INTO `sys_order` VALUES (38, 'REP20260203144106524', '维修', 105, 4, 30.00, '0', NULL, '2026-02-03 14:41:06', '2026-02-03 14:53:00', '李春伟', 13, 30.00, 0);
INSERT INTO `sys_order` VALUES (39, 'ORD20260303145714967', '其它', 105, 3, 300.00, '0', NULL, '2026-03-03 14:57:14', '2026-03-03 14:58:16', '赵文浩', NULL, 299.00, 10);

-- ----------------------------
-- Table structure for sys_order_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_order_item`;
CREATE TABLE `sys_order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `order_id` bigint NOT NULL COMMENT '订单ID，关联order表',
  `item_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '明细名称（如水费、电费、维修项目等）',
  `quantity` int NULL DEFAULT NULL COMMENT '数量（适用于维修等场景）',
  `unit_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额（也可 = 单价 * 数量）',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '详细描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_order_item
-- ----------------------------
INSERT INTO `sys_order_item` VALUES (4, 4, '停车费用支付', NULL, NULL, 6.00, '车牌号为【沪KR9888】的车在北停车场总停车费为：6.00');
INSERT INTO `sys_order_item` VALUES (5, 5, '灯泡维修', 2, 20.00, 40.00, '新换灯泡');
INSERT INTO `sys_order_item` VALUES (6, 6, '门锁', 1, 40.00, 40.00, NULL);
INSERT INTO `sys_order_item` VALUES (7, 7, '停车费用支付', NULL, NULL, 6.00, '车牌号为【粤S6A86G】的车在北停车场总停车费为：6.00');
INSERT INTO `sys_order_item` VALUES (8, 8, '水管90度转接头', 1, 50.00, 50.00, '水管转接头');
INSERT INTO `sys_order_item` VALUES (9, 8, '水管直管5米', 1, 30.00, 30.00, '水管');
INSERT INTO `sys_order_item` VALUES (10, 9, '房租', 1, 0.00, 5000.00, '2026年1-3月房租');
INSERT INTO `sys_order_item` VALUES (11, 10, '房租', 1, 0.00, 1000.00, NULL);
INSERT INTO `sys_order_item` VALUES (12, 11, '水电费', 1, 0.00, 300.00, NULL);
INSERT INTO `sys_order_item` VALUES (13, 12, '网费', 1, 0.00, 50.00, NULL);
INSERT INTO `sys_order_item` VALUES (14, 13, '维护费', 1, 0.00, 300.00, NULL);
INSERT INTO `sys_order_item` VALUES (15, 14, '111111', 1, 0.00, 300.00, NULL);
INSERT INTO `sys_order_item` VALUES (16, 15, '1111', 1, 0.00, 200.00, NULL);
INSERT INTO `sys_order_item` VALUES (17, 16, '123121', 1, 0.00, 20.00, NULL);
INSERT INTO `sys_order_item` VALUES (18, 17, '1213213', 1, 0.00, 2333.00, NULL);
INSERT INTO `sys_order_item` VALUES (19, 18, '213123', 1, 0.00, 3444.00, NULL);
INSERT INTO `sys_order_item` VALUES (20, 19, '测试', 1, 0.00, 500.00, NULL);
INSERT INTO `sys_order_item` VALUES (21, 20, '测试', 1, 0.00, 400.00, NULL);
INSERT INTO `sys_order_item` VALUES (22, 21, '测试', 1, 0.00, 300.00, NULL);
INSERT INTO `sys_order_item` VALUES (23, 22, '3333', 1, 0.00, 400.00, NULL);
INSERT INTO `sys_order_item` VALUES (24, 23, '3434', 1, 0.00, 300.00, NULL);
INSERT INTO `sys_order_item` VALUES (25, 24, 'wewewe', 1, 0.00, 500.00, NULL);
INSERT INTO `sys_order_item` VALUES (26, 25, '343434', 1, 0.00, 500.00, NULL);
INSERT INTO `sys_order_item` VALUES (27, 26, '34234234', 1, 0.00, 500.00, NULL);
INSERT INTO `sys_order_item` VALUES (28, 27, '3434343', 1, 0.00, 400.00, NULL);
INSERT INTO `sys_order_item` VALUES (29, 28, '232323', 1, 0.00, 300.00, NULL);
INSERT INTO `sys_order_item` VALUES (30, 29, '物业费', 1, 0.00, 500.00, NULL);
INSERT INTO `sys_order_item` VALUES (31, 30, '测试账单', 1, 0.00, 500.00, NULL);
INSERT INTO `sys_order_item` VALUES (32, 31, '测试', 1, 0.00, 300.00, NULL);
INSERT INTO `sys_order_item` VALUES (33, 32, '房租', 1, 0.00, 500.00, '3月房租');
INSERT INTO `sys_order_item` VALUES (34, 33, '积分扣减测试', 1, 0.00, 300.00, NULL);
INSERT INTO `sys_order_item` VALUES (35, 34, '积分抵扣显示测试', 1, 0.00, 600.00, '测试数据');
INSERT INTO `sys_order_item` VALUES (36, 35, '测试', 1, 0.00, 600.00, '测试数据');
INSERT INTO `sys_order_item` VALUES (37, 36, '停车费用支付', NULL, NULL, 6.00, '车牌号为【粤S6A86G】的车在北停车场总停车费为：6.00');
INSERT INTO `sys_order_item` VALUES (38, 37, '房租2026年2月', 1, 0.00, 2100.00, '房租2026年2月');
INSERT INTO `sys_order_item` VALUES (39, 38, '人工费', 1, 30.00, 30.00, NULL);
INSERT INTO `sys_order_item` VALUES (40, 39, '房租', 1, 0.00, 300.00, NULL);

-- ----------------------------
-- Table structure for sys_owner_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_owner_info`;
CREATE TABLE `sys_owner_info`  (
  `owner_id` int NOT NULL AUTO_INCREMENT COMMENT '业主ID',
  `owner_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '业主姓名',
  `date_of_birth` date NULL DEFAULT NULL COMMENT '出生日期',
  `identity_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系地址',
  `occupation` int NULL DEFAULT NULL COMMENT '积分',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '个性签名',
  `phone_number` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系号码',
  `user_id` int NULL DEFAULT NULL COMMENT '用户编码',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  PRIMARY KEY (`owner_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '业主信息管理表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_owner_info
-- ----------------------------
INSERT INTO `sys_owner_info` VALUES (6, '王佳怡', '1992-06-18', '310104199206182458', '上海市徐汇区虹桥路 355 号', 20, NULL, NULL, '一切皆有可能', '13812345678', 103, '', '');
INSERT INTO `sys_owner_info` VALUES (7, '张伟', '1985-11-03', '440106198511037890', '黑龙江省哈尔滨市南岗区复旦街', 132, NULL, '2026-01-18 13:47:23', '热爱生活，保持热忱', '13987654321', 1, '', 'super');
INSERT INTO `sys_owner_info` VALUES (8, '赵文浩', '1990-05-12', '232303199005154217', '黑龙江省绥化市海伦市伦河镇', 30, NULL, '2026-03-03 14:58:16', '努力为计算机事业添砖Java', '18846571726', 105, '', '李春伟');

-- ----------------------------
-- Table structure for sys_park_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_park_info`;
CREATE TABLE `sys_park_info`  (
  `park_id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `park_amount` bigint NULL DEFAULT NULL COMMENT '车位数',
  `park_spare` bigint NULL DEFAULT NULL COMMENT '剩余车位数',
  `park_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '停车场地址',
  `park_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '停车场名字',
  `park_rule` decimal(10, 2) NULL DEFAULT NULL COMMENT '收费规则',
  `park_pic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '停车场照片地址',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `remark` varchar(520) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`park_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '停车场信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_park_info
-- ----------------------------
INSERT INTO `sys_park_info` VALUES (2, 10, 10, '北街2号', '北停车场', 6.00, '/profile/upload/2025/12/31/11111111_20251231160559A001.jpg', '0', NULL, NULL, NULL);
INSERT INTO `sys_park_info` VALUES (3, 200, 200, '南街3号', '南停车场', 3.00, '/profile/upload/2025/12/31/222222222_20251231160633A002.jpg', '0', NULL, NULL, NULL);
INSERT INTO `sys_park_info` VALUES (15, 20, 20, '东街1号', '东停车场', 10.00, '/profile/upload/2025/12/31/3333333333_20251231160704A003.jpg', '0', NULL, 'admin', '2025-04-13 20:23:49');

-- ----------------------------
-- Table structure for sys_park_order
-- ----------------------------
DROP TABLE IF EXISTS `sys_park_order`;
CREATE TABLE `sys_park_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `park_id` bigint NULL DEFAULT NULL COMMENT '停车场ID',
  `type` int NULL DEFAULT NULL COMMENT '是否固定车（0不是 1是）',
  `plate_color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车牌颜色',
  `plate_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车牌号',
  `entry_time` datetime NULL DEFAULT NULL COMMENT '进入停车场时间',
  `exit_time` datetime NULL DEFAULT NULL COMMENT '离开停车场时间',
  `parking_duration` double NULL DEFAULT NULL COMMENT '停车时长',
  `park_fee` decimal(10, 2) NULL DEFAULT NULL COMMENT '停车收费金额',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标识（0代表存在 1代表删除）',
  `user_id` int NULL DEFAULT NULL COMMENT '用户编号',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '状态： 0表示已支付，1 表示未支付',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '订单信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_park_order
-- ----------------------------
INSERT INTO `sys_park_order` VALUES (50, 2, 0, 'blue', '沪KR9888', '2025-05-10 02:08:36', '2025-05-10 02:12:46', 0, 6.00, '0', 103, '0');
INSERT INTO `sys_park_order` VALUES (51, 2, 0, 'blue', '粤S6A86G', '2025-12-30 14:39:57', '2025-12-30 14:40:32', 0, 6.00, '0', 1, '0');
INSERT INTO `sys_park_order` VALUES (52, 2, 0, 'blue', '粤S6A86G', '2026-01-18 10:59:00', '2026-01-18 11:19:21', 20, 6.00, '0', 1, '0');
INSERT INTO `sys_park_order` VALUES (53, 2, 1, 'blue', '粤S6A86G', '2026-01-22 12:41:22', '2026-01-22 13:00:15', 18, 6.00, '0', 1, '1');
INSERT INTO `sys_park_order` VALUES (54, 2, 0, 'blue', '苏EG08P9', '2026-01-22 12:42:40', '2026-01-22 13:00:03', 17, 6.00, '0', 1, '1');
INSERT INTO `sys_park_order` VALUES (55, 2, 1, 'blue', '粤S6A86G', '2026-02-10 08:36:49', '2026-02-10 08:37:20', 0, 6.00, '0', 1, '1');

-- ----------------------------
-- Table structure for sys_property_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_property_info`;
CREATE TABLE `sys_property_info`  (
  `property_id` int NOT NULL AUTO_INCREMENT COMMENT '房产ID',
  `property_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '房产地址',
  `region` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所属区域',
  `building_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所属楼栋',
  `unit_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单元号',
  `floor` int NULL DEFAULT NULL COMMENT '所在楼层',
  `room_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房间号',
  `building_area` decimal(10, 2) NULL DEFAULT NULL COMMENT '建筑面积（平方米）',
  `usable_area` decimal(10, 2) NULL DEFAULT NULL COMMENT '使用面积（平方米）',
  `owner_id` int NULL DEFAULT NULL COMMENT '主业主ID',
  `owner` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '主业主名称',
  `manager_id` int NULL DEFAULT NULL COMMENT '负责人ID',
  `manager` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `property_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房屋类型（住宅/商用/办公等）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '房屋状态（0正常 1空置）',
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房产图片地址',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`property_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '房产信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_property_info
-- ----------------------------
INSERT INTO `sys_property_info` VALUES (3, '黑龙江省哈尔滨南岗区', '12号楼', '12', '1', 2, '202', 100.00, 90.00, 8, '赵文浩', 1, 'super', '住宅', '0', '/profile/upload/2026/02/07/0227.jpg_wh860_20260207115639A001.jpg', '2025-04-12 13:22:03', '2026-02-07 11:57:22', NULL);
INSERT INTO `sys_property_info` VALUES (4, '黑龙江省哈尔滨市', '11号楼', '11栋', '3', 5, '521', 150.00, 130.00, 6, '王佳怡', 1, 'super', '住宅', '0', '/profile/upload/2026/02/07/0227.jpg_wh860_20260207115648A002.jpg', '2025-12-30 15:39:59', '2026-02-07 11:56:48', NULL);

-- ----------------------------
-- Table structure for sys_property_repair
-- ----------------------------
DROP TABLE IF EXISTS `sys_property_repair`;
CREATE TABLE `sys_property_repair`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '维修单ID',
  `property_id` bigint NOT NULL COMMENT '房产ID',
  `property_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房产地址',
  `applicant_id` bigint NOT NULL COMMENT '申请人用户ID',
  `applicant_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '申请人姓名',
  `applicant_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '申请人联系电话',
  `repair_item` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '维修项目',
  `repair_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '维修描述',
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '维修相关图片 URL',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0待处理 1已处理 2维修中 3已完成）',
  `submit_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  `assignee_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '维修人姓名',
  `assignee_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '维修人联系方式',
  `assign_time` datetime NULL DEFAULT NULL COMMENT '维修开始时间（分配时间）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `completed_time` datetime NULL DEFAULT NULL COMMENT '处理完成时间',
  `score` int NULL DEFAULT NULL COMMENT '评分（1-5分）',
  `comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评语',
  `rate_time` datetime NULL DEFAULT NULL COMMENT '评分时间',
  `rate_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '评分人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '物业维修管理表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_property_repair
-- ----------------------------
INSERT INTO `sys_property_repair` VALUES (2, 3, '广西桂林1111街道风格小区二街三号', 103, '张敏', '1302566206356', '房间灯泡有问题', '房间灯泡有问题', '/profile/upload/2025/05/10/OIP (1)_20250510024001A001.jpg', '3', '2025-05-10 02:40:41', '张立', '1526262603', '2025-05-10 02:41:00', '0', '2025-05-10 02:41:12', NULL, NULL, NULL, '', NULL, NULL);
INSERT INTO `sys_property_repair` VALUES (3, 3, '广西桂林1111街道风格小区二街三号', 103, '张敏', '12523253265', '门锁维修', '房间门锁头坏了', '/profile/upload/2025/05/10/OIP (1)_20250510024958A001.jpg', '3', '2025-05-10 02:50:00', '张旭', '152558888', '2025-05-10 02:50:10', '0', '2025-05-10 02:50:33', NULL, NULL, NULL, '', NULL, NULL);
INSERT INTO `sys_property_repair` VALUES (4, 3, '广西桂林1111街道风格小区二街三号', 103, '张敏', '17871878787', '水管', '房屋漏水', '/profile/upload/2025/12/30/R-C_20251230144945A006.png', '3', '2025-12-30 14:49:49', '张三', '18867676767', '2025-12-30 14:50:10', '0', '2025-12-30 14:50:34', NULL, NULL, NULL, '', NULL, NULL);
INSERT INTO `sys_property_repair` VALUES (5, 4, '黑龙江省哈尔滨市', 105, '李春伟', '18846571726', '漏水', '屋顶漏水', '/profile/upload/2025/12/31/R-C_20251231104030A002.png', '1', '2025-12-31 10:40:33', '王刚', '13800138005', '2025-12-31 10:53:10', '0', '2025-12-31 10:53:22', NULL, NULL, NULL, '', NULL, NULL);
INSERT INTO `sys_property_repair` VALUES (6, 4, '黑龙江省哈尔滨市', 105, '李春伟', '18846571726', '测试', '12342142342', '/profile/upload/2025/12/31/R-C_20251231105600A003.png', '1', '2025-12-31 10:56:02', '王刚', '13800138005', '2025-12-31 11:39:10', '0', '2025-12-31 11:39:28', 5, '', '2025-12-31 11:41:53', '李春伟', '李春伟', '2025-12-31 11:41:53');
INSERT INTO `sys_property_repair` VALUES (7, 4, '黑龙江省哈尔滨市', 105, '李春伟', '18846571726', '测试', '213213123123', '/profile/upload/2025/12/31/R-C_20251231122653A001.png', '1', '2025-12-31 12:26:55', '李梅', '13800138003', '2025-12-31 12:33:40', '0', '2025-12-31 12:33:51', 5, '服务态度很好，效率很高！', '2026-01-13 17:49:43', '李春伟', '李春伟', '2026-01-13 17:49:43');
INSERT INTO `sys_property_repair` VALUES (9, 4, '黑龙江省哈尔滨市', 105, '李春伟', '21212121', '1212', '1212121', '/profile/upload/2026/01/19/R-C_20260119101216A001.png', '1', '2026-01-19 10:12:18', 'demo1', '18833334444', NULL, '0', '2026-01-19 10:12:52', NULL, NULL, NULL, '', NULL, NULL);
INSERT INTO `sys_property_repair` VALUES (11, 4, '黑龙江省哈尔滨市', 105, '李春伟', '12355556666', '测试', '测试数据', '/profile/upload/2026/01/19/R-C_20260119111624A002.png', '1', '2026-01-19 11:16:25', 'demo1', '18833334444', '2026-01-19 11:19:03', '0', '2026-01-19 11:19:16', 5, '服务态度很好！', '2026-01-20 14:27:12', '李春伟', '李春伟', '2026-01-20 14:27:12');
INSERT INTO `sys_property_repair` VALUES (12, 4, '黑龙江省哈尔滨市', 105, '李春伟', '18846571726', '漏水', '楼上漏水', '/profile/upload/2026/02/02/R-C_20260202140631A001.png', '1', '2026-02-02 14:06:33', 'demo1', '18833334444', '2026-02-02 14:07:09', '0', '2026-02-02 14:07:32', NULL, NULL, NULL, '', NULL, '2026-02-02 14:07:32');
INSERT INTO `sys_property_repair` VALUES (13, 4, '黑龙江省哈尔滨市', 105, '李春伟', '12344445555', '漏水', '楼上漏水了', '/profile/upload/2026/02/02/R-C_20260202151501A002.png', '3', '2026-02-02 15:15:24', 'demo1', '18833334444', '2026-02-02 15:35:34', '0', '2026-02-02 15:44:46', 5, '很好', '2026-02-02 15:54:46', '李春伟', '李春伟', '2026-02-03 14:53:00');
INSERT INTO `sys_property_repair` VALUES (14, 4, '黑龙江省哈尔滨市', 105, '李春伟', '18846571726', '测试', '测试数据', '/profile/upload/2026/02/03/R-C_20260203164617A001.png', '1', '2026-02-03 16:46:51', 'demo1', '18833334444', '2026-02-03 16:52:49', '0', '2026-02-03 16:54:45', 5, '很好', '2026-02-03 17:00:38', '李春伟', '李春伟', '2026-02-03 17:00:38');
INSERT INTO `sys_property_repair` VALUES (15, 3, '黑龙江省哈尔滨南岗区', 105, '李春伟', '18846571726', '漏水', '楼上漏水了', '/profile/upload/2026/02/07/R-C_20260207122041A003.png', '1', '2026-02-07 12:20:43', '张磊', '18833334444', '2026-02-07 12:22:26', '0', '2026-02-07 12:22:44', NULL, NULL, NULL, '', NULL, '2026-02-07 12:22:44');
INSERT INTO `sys_property_repair` VALUES (16, 3, '黑龙江省哈尔滨南岗区', 105, '李春伟', '18846571726', '漏水', '房屋漏水了', '/profile/upload/2026/02/27/R-C_20260227111049A001.png', '1', '2026-02-27 11:10:51', '张磊', '18833334444', '2026-02-27 11:11:16', '0', '2026-02-27 11:11:38', 1, '不满意', '2026-02-27 11:12:11', '李春伟', '李春伟', '2026-02-27 11:12:11');
INSERT INTO `sys_property_repair` VALUES (17, 3, '黑龙江省哈尔滨南岗区', 105, '李春伟', '18846571726', '漏水', '房屋漏水', '/profile/upload/2026/02/27/R-C_20260227111451A002.png', '1', '2026-02-27 11:14:56', '张磊', '18833334444', '2026-02-27 11:15:13', '0', '2026-02-27 11:15:15', 2, '一般', '2026-02-27 11:15:58', '李春伟', '李春伟', '2026-02-27 11:15:58');
INSERT INTO `sys_property_repair` VALUES (18, 3, '黑龙江省哈尔滨南岗区', 105, '李春伟', '18846571726', '漏水', '房屋漏水', '/profile/upload/2026/02/27/R-C_20260227111621A003.png', '1', '2026-02-27 11:16:24', '张磊', '18833334444', '2026-02-27 11:17:10', '0', '2026-02-27 11:17:14', 3, '一般', '2026-02-27 11:17:54', '李春伟', '李春伟', '2026-02-27 11:17:54');
INSERT INTO `sys_property_repair` VALUES (19, 3, '黑龙江省哈尔滨南岗区', 105, '李春伟', '18846571726', '漏水', '房屋漏水', '/profile/upload/2026/02/27/R-C_20260227111817A004.png', '1', '2026-02-27 11:18:21', '张磊', '18833334444', '2026-02-27 11:18:40', '0', '2026-02-27 11:18:43', 4, '还行', '2026-02-27 11:19:09', '李春伟', '李春伟', '2026-02-27 11:19:09');

-- ----------------------------
-- Table structure for sys_public_facility
-- ----------------------------
DROP TABLE IF EXISTS `sys_public_facility`;
CREATE TABLE `sys_public_facility`  (
  `facility_id` bigint NOT NULL AUTO_INCREMENT COMMENT '设施ID',
  `facility_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设施编号',
  `facility_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设施名称',
  `facility_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设施类型（健身器材/儿童游乐/休闲椅等）',
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在位置',
  `install_date` date NULL DEFAULT NULL COMMENT '安装日期',
  `manufacturer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `specifications` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格型号',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '设施状态（0正常 1维修中 2已报废）',
  `maintain_cycle` int NULL DEFAULT NULL COMMENT '维护周期（天）',
  `last_maintain_date` date NULL DEFAULT NULL COMMENT '上次维护日期',
  `next_maintain_date` date NULL DEFAULT NULL COMMENT '下次维护日期',
  `responsibility_dept` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '责任部门',
  `responsibility_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '责任人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `purchase_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '采购价格',
  `warranty_period` int NULL DEFAULT NULL COMMENT '保修期（月）',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`facility_id`) USING BTREE,
  UNIQUE INDEX `facility_code`(`facility_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公共设施信息档案表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_public_facility
-- ----------------------------
INSERT INTO `sys_public_facility` VALUES (1, 'FS-2023-001', '儿童滑梯', '儿童游乐', 'A区儿童乐园', '2026-02-03', '儿童游乐设备厂', '大型组合滑梯', '0', 30, '2026-03-03', '2026-10-01', '物业部', '王刚', '13800138001', 15000.00, 24, '定期检查螺丝是否松动', 'admin', '2025-12-30 18:03:04', 'super', '2026-03-03 15:54:15');
INSERT INTO `sys_public_facility` VALUES (2, 'FS-2023-002', '健身器材组合', '健身器材', 'B区健身广场', '2026-03-01', '健身器材公司', '多功能健身器', '0', 30, '2026-03-03', '2026-10-01', '物业部', '王明', '13800138002', 25000.00, 36, '注意防锈处理', 'admin', '2025-12-30 18:03:04', 'super', '2026-03-03 15:52:44');
INSERT INTO `sys_public_facility` VALUES (3, 'FS-2023-003', '休闲长椅', '休闲椅', 'C区湖边步道', '2026-03-01', '户外家具厂', '防腐木长椅', '1', 90, '2026-03-03', '2026-10-01', '绿化部', '肖龙', '13800138003', 800.00, 12, '部分螺丝松动，已报修', 'admin', '2025-12-30 18:03:04', 'super', '2026-03-03 15:53:44');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-04-07 21:33:13', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '工人', 'manager', 2, '2', 1, 1, '0', '0', 'admin', '2025-04-07 21:33:13', 'super', '2026-01-19 08:01:49', '工人');
INSERT INTO `sys_role` VALUES (100, '业主', 'owner', 3, '1', 1, 1, '0', '0', 'admin', '2025-04-08 01:06:58', 'super', '2026-01-13 10:29:37', NULL);
INSERT INTO `sys_role` VALUES (101, '系统管理员', 'systemAdmin', 3, '1', 1, 1, '0', '0', 'admin', '2025-05-09 23:27:46', 'super', '2025-05-09 23:44:49', NULL);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2040);
INSERT INTO `sys_role_menu` VALUES (1, 2041);
INSERT INTO `sys_role_menu` VALUES (1, 2042);
INSERT INTO `sys_role_menu` VALUES (1, 2043);
INSERT INTO `sys_role_menu` VALUES (1, 2044);
INSERT INTO `sys_role_menu` VALUES (1, 2045);
INSERT INTO `sys_role_menu` VALUES (1, 2046);
INSERT INTO `sys_role_menu` VALUES (1, 2047);
INSERT INTO `sys_role_menu` VALUES (1, 2048);
INSERT INTO `sys_role_menu` VALUES (1, 2049);
INSERT INTO `sys_role_menu` VALUES (1, 2050);
INSERT INTO `sys_role_menu` VALUES (1, 2051);
INSERT INTO `sys_role_menu` VALUES (1, 2052);
INSERT INTO `sys_role_menu` VALUES (1, 2053);
INSERT INTO `sys_role_menu` VALUES (1, 2054);
INSERT INTO `sys_role_menu` VALUES (1, 2055);
INSERT INTO `sys_role_menu` VALUES (1, 2056);
INSERT INTO `sys_role_menu` VALUES (1, 2057);
INSERT INTO `sys_role_menu` VALUES (1, 2058);
INSERT INTO `sys_role_menu` VALUES (1, 2059);
INSERT INTO `sys_role_menu` VALUES (1, 2060);
INSERT INTO `sys_role_menu` VALUES (1, 2061);
INSERT INTO `sys_role_menu` VALUES (1, 2062);
INSERT INTO `sys_role_menu` VALUES (1, 2063);
INSERT INTO `sys_role_menu` VALUES (1, 2064);
INSERT INTO `sys_role_menu` VALUES (1, 2065);
INSERT INTO `sys_role_menu` VALUES (1, 2066);
INSERT INTO `sys_role_menu` VALUES (1, 2067);
INSERT INTO `sys_role_menu` VALUES (1, 2068);
INSERT INTO `sys_role_menu` VALUES (1, 2069);
INSERT INTO `sys_role_menu` VALUES (1, 2070);
INSERT INTO `sys_role_menu` VALUES (1, 2071);
INSERT INTO `sys_role_menu` VALUES (1, 2072);
INSERT INTO `sys_role_menu` VALUES (1, 2073);
INSERT INTO `sys_role_menu` VALUES (1, 2074);
INSERT INTO `sys_role_menu` VALUES (1, 2075);
INSERT INTO `sys_role_menu` VALUES (1, 2076);
INSERT INTO `sys_role_menu` VALUES (1, 2077);
INSERT INTO `sys_role_menu` VALUES (1, 2130);
INSERT INTO `sys_role_menu` VALUES (1, 2131);
INSERT INTO `sys_role_menu` VALUES (1, 2132);
INSERT INTO `sys_role_menu` VALUES (1, 2133);
INSERT INTO `sys_role_menu` VALUES (1, 2134);
INSERT INTO `sys_role_menu` VALUES (1, 2135);
INSERT INTO `sys_role_menu` VALUES (1, 2136);
INSERT INTO `sys_role_menu` VALUES (1, 2138);
INSERT INTO `sys_role_menu` VALUES (1, 2139);
INSERT INTO `sys_role_menu` VALUES (1, 2140);
INSERT INTO `sys_role_menu` VALUES (1, 2141);
INSERT INTO `sys_role_menu` VALUES (1, 2142);
INSERT INTO `sys_role_menu` VALUES (1, 2145);
INSERT INTO `sys_role_menu` VALUES (2, 2023);
INSERT INTO `sys_role_menu` VALUES (2, 2025);
INSERT INTO `sys_role_menu` VALUES (2, 2027);
INSERT INTO `sys_role_menu` VALUES (2, 2028);
INSERT INTO `sys_role_menu` VALUES (2, 2029);
INSERT INTO `sys_role_menu` VALUES (100, 2007);
INSERT INTO `sys_role_menu` VALUES (100, 2015);
INSERT INTO `sys_role_menu` VALUES (100, 2017);
INSERT INTO `sys_role_menu` VALUES (100, 2018);
INSERT INTO `sys_role_menu` VALUES (100, 2023);
INSERT INTO `sys_role_menu` VALUES (100, 2024);
INSERT INTO `sys_role_menu` VALUES (100, 2028);
INSERT INTO `sys_role_menu` VALUES (100, 2030);
INSERT INTO `sys_role_menu` VALUES (100, 2031);
INSERT INTO `sys_role_menu` VALUES (101, 1);
INSERT INTO `sys_role_menu` VALUES (101, 2);
INSERT INTO `sys_role_menu` VALUES (101, 100);
INSERT INTO `sys_role_menu` VALUES (101, 105);
INSERT INTO `sys_role_menu` VALUES (101, 108);
INSERT INTO `sys_role_menu` VALUES (101, 500);
INSERT INTO `sys_role_menu` VALUES (101, 501);
INSERT INTO `sys_role_menu` VALUES (101, 1000);
INSERT INTO `sys_role_menu` VALUES (101, 1001);
INSERT INTO `sys_role_menu` VALUES (101, 1002);
INSERT INTO `sys_role_menu` VALUES (101, 1003);
INSERT INTO `sys_role_menu` VALUES (101, 1006);
INSERT INTO `sys_role_menu` VALUES (101, 1025);
INSERT INTO `sys_role_menu` VALUES (101, 1026);
INSERT INTO `sys_role_menu` VALUES (101, 1027);
INSERT INTO `sys_role_menu` VALUES (101, 1028);
INSERT INTO `sys_role_menu` VALUES (101, 1029);
INSERT INTO `sys_role_menu` VALUES (101, 1039);
INSERT INTO `sys_role_menu` VALUES (101, 1040);
INSERT INTO `sys_role_menu` VALUES (101, 1041);
INSERT INTO `sys_role_menu` VALUES (101, 1042);
INSERT INTO `sys_role_menu` VALUES (101, 1043);
INSERT INTO `sys_role_menu` VALUES (101, 1044);
INSERT INTO `sys_role_menu` VALUES (101, 1045);
INSERT INTO `sys_role_menu` VALUES (101, 2000);
INSERT INTO `sys_role_menu` VALUES (101, 2001);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'super', '超级管理员', '00', '123@163.com', '15888888888', '0', '/profile/avatar/2026/01/24/头像_20260124161538A001.jpg', '$2a$10$67Y0WNl0MK7LBcGs3NH1fOdFATrSWjygJRuI.RgGpG8ZSQOPGi8ZS', '0', '0', '127.0.0.1', '2026-03-03 15:32:35', 'admin', '2025-04-07 21:33:13', '', '2026-03-03 15:32:35', '管理员');
INSERT INTO `sys_user` VALUES (2, 'manager', '工人', '00', '1122@qq.com', '15666666666', '0', '/profile/avatar/2025/12/30/1mSjxwzqiQZwqJO_20251230144706A004.jpg', '$2a$10$ura351mFebY19udVjKQVrOXkqYVpM56fYnGCVU0d3XqURoEyVslju', '0', '0', '127.0.0.1', '2026-01-19 08:02:08', 'admin', '2025-04-07 21:33:13', 'super', '2026-01-19 08:05:41', '工人');
INSERT INTO `sys_user` VALUES (100, 'admin', '系统管理员', '00', '85@qq.com', '13252546212', '0', '', '$2a$10$ura351mFebY19udVjKQVrOXkqYVpM56fYnGCVU0d3XqURoEyVslju', '0', '0', '127.0.0.1', '2026-01-13 15:12:08', 'admin', '2025-05-09 23:34:07', 'super', '2026-01-13 15:12:07', NULL);
INSERT INTO `sys_user` VALUES (103, 'asd', 'asd', '00', '2220@qq.com', '13025262222', '0', '', '$2a$10$vnbITnEBMr.SK3ijjkGj6uTHQ0p3NkQd27ApmsVW83oNboVPcgWuq', '0', '0', '127.0.0.1', '2025-12-30 21:06:25', '', '2025-05-10 01:20:47', 'super', '2026-02-05 08:34:04', NULL);
INSERT INTO `sys_user` VALUES (104, 'mov', '李春伟', '00', '3340136981@qq.com', '18846571726', '0', '', '$2a$10$Ttdtyod4XeLK6roz727yiObJTI99eUqiWCKh75nrcWi/jTgeOxTLe', '0', '0', '127.0.0.1', '2025-12-30 15:37:25', '', '2025-12-30 15:37:11', 'super', '2025-12-30 15:45:34', NULL);
INSERT INTO `sys_user` VALUES (105, '李春伟', '李春伟', '00', 'adr666666@163.com', '18846571726', '0', '', '$2a$10$7jvt.PnnR3FjkSJhqqVTsO5CNOpYhLWfhX5XLn.Dc8Dd8S.nda63a', '0', '0', '127.0.0.1', '2026-03-03 15:28:03', '', '2025-12-30 15:46:21', '', '2026-03-03 15:28:02', NULL);
INSERT INTO `sys_user` VALUES (106, 'xiaoming', 'xiaoming', '00', '334013@qq.com', '18834341726', '0', '', '$2a$10$semVdBbKobCH0ot7w2Wdce0TXKjnE.8i50/UT3At7CcU1u78OAdbe', '0', '0', '127.0.0.1', '2026-01-19 08:13:21', '', '2026-01-19 08:13:11', '', '2026-01-19 08:13:21', NULL);
INSERT INTO `sys_user` VALUES (107, 'demo', 'demo', '00', '2323232@qq.com', '13344445555', '0', '', '$2a$10$RRpWz/5svxtE4BAMghGRROeB9MVm/I4.3T9CtoSlJqp/idZLcU.K2', '0', '0', '', NULL, '', '2026-01-19 08:18:02', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (108, 'demo1', 'demo1', '00', 'addddd@qq.com', '18833334444', '0', '', '$2a$10$aPqh8zmpzC2wf7hWhSqRfeS.QaOiGj5gBfeOBqjlDzWYwZAtzscoC', '0', '0', '127.0.0.1', '2026-02-27 11:11:29', '', '2026-01-19 08:58:40', '', '2026-02-27 11:11:28', NULL);
INSERT INTO `sys_user` VALUES (109, 'aaa', 'aaa', '00', 'as123@qq.com', '18966665555', '0', '', '$2a$10$wG.UpUf98y.1VnbLEv16zOTqEVTTZUTSRLdwuJI5AN2MFc07Hmdwu', '0', '0', '127.0.0.1', '2026-01-21 11:44:28', '', '2026-01-21 11:24:09', '', '2026-01-21 11:44:27', NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 101);
INSERT INTO `sys_user_role` VALUES (103, 100);
INSERT INTO `sys_user_role` VALUES (104, 100);
INSERT INTO `sys_user_role` VALUES (105, 100);
INSERT INTO `sys_user_role` VALUES (106, 2);
INSERT INTO `sys_user_role` VALUES (107, 2);
INSERT INTO `sys_user_role` VALUES (108, 2);
INSERT INTO `sys_user_role` VALUES (109, 100);

-- ----------------------------
-- Table structure for sys_violation_record
-- ----------------------------
DROP TABLE IF EXISTS `sys_violation_record`;
CREATE TABLE `sys_violation_record`  (
  `violation_id` bigint NOT NULL AUTO_INCREMENT COMMENT '违规ID',
  `plate_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '车牌号码',
  `violation_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '违规类型',
  `violation_time` datetime NOT NULL COMMENT '违规时间',
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '违规地点',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '违规描述',
  `evidence_img` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '证据图片',
  `status` tinyint NULL DEFAULT 0 COMMENT '处理状态（0未处理 1已处理 2已撤销）',
  `penalty_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '罚款金额',
  `penalty_date` datetime NULL DEFAULT NULL COMMENT '处罚日期',
  `processor_id` bigint NULL DEFAULT NULL COMMENT '处理人员ID',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`violation_id`) USING BTREE,
  INDEX `idx_plate_num`(`plate_num` ASC) USING BTREE,
  INDEX `idx_violation_time`(`violation_time` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '违规信息记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_violation_record
-- ----------------------------
INSERT INTO `sys_violation_record` VALUES (1, '京A53765', '违章停车', '2024-01-15 08:30:00', '小区东门消防通道', '在消防通道违规停车，影响消防车辆通行', '/profile/upload/2025/12/31/11111111_20251231174324A001.jpg', 1, 200.00, '2024-01-15 10:00:00', 1, NULL, 'admin', '2025-12-31 17:06:24', 'super', '2025-12-31 17:43:27');
INSERT INTO `sys_violation_record` VALUES (2, '沪B56129', '超速行驶', '2024-01-16 14:20:00', '小区主干道', '在限速20km/h区域以45km/h速度行驶', '/profile/upload/2025/12/31/222222222222_20251231174501A002.jpg', 0, 150.00, NULL, NULL, NULL, 'admin', '2025-12-31 17:06:24', 'super', '2025-12-31 17:45:04');
INSERT INTO `sys_violation_record` VALUES (3, '粤C56231', '占用残疾人车位', '2024-01-17 09:15:00', '1号地下车库', '无残疾人证件占用残疾人专用车位', '/profile/upload/2025/12/31/3_20251231174607A003.jpg', 1, 100.00, '2025-12-31 17:52:08', 1, NULL, 'admin', '2025-12-31 17:06:24', 'super', '2025-12-31 17:52:08');

-- ----------------------------
-- Table structure for sys_violation_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_violation_type`;
CREATE TABLE `sys_violation_type`  (
  `type_id` bigint NOT NULL AUTO_INCREMENT COMMENT '类型ID',
  `type_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '类型编码',
  `type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '类型名称',
  `penalty_min` decimal(10, 2) NULL DEFAULT NULL COMMENT '最低罚款金额',
  `penalty_max` decimal(10, 2) NULL DEFAULT NULL COMMENT '最高罚款金额',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`type_id`) USING BTREE,
  UNIQUE INDEX `uniq_type_code`(`type_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '违规类型字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_violation_type
-- ----------------------------
INSERT INTO `sys_violation_type` VALUES (1, 'PARKING_ILLEGAL', '违章停车', 100.00, 500.00, 0, 'admin', '2025-12-31 17:06:24', '', NULL, NULL);
INSERT INTO `sys_violation_type` VALUES (2, 'SPEEDING', '超速行驶', 100.00, 1000.00, 0, 'admin', '2025-12-31 17:06:24', '', NULL, NULL);
INSERT INTO `sys_violation_type` VALUES (3, 'HANDICAP_PARKING', '占用残疾人车位', 100.00, 300.00, 0, 'admin', '2025-12-31 17:06:24', '', NULL, NULL);
INSERT INTO `sys_violation_type` VALUES (4, 'BLOCKING_FIRE_LANE', '堵塞消防通道', 200.00, 1000.00, 0, 'admin', '2025-12-31 17:06:24', '', NULL, NULL);
INSERT INTO `sys_violation_type` VALUES (5, 'UNAUTHORIZED_PARKING', '未授权停车', 50.00, 200.00, 0, 'admin', '2025-12-31 17:06:24', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_worker
-- ----------------------------
DROP TABLE IF EXISTS `sys_worker`;
CREATE TABLE `sys_worker`  (
  `worker_id` bigint NOT NULL AUTO_INCREMENT COMMENT '工人ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户ID（关联用户表）',
  `worker_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工人姓名',
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '性别（0男 1女 2未知）',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `phone_number` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `id_card` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '家庭住址',
  `worker_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工种',
  `entry_date` datetime NULL DEFAULT NULL COMMENT '入职日期',
  `work_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '工作状态（0空闲 1忙碌 2请假 3离职）',
  `emergency_contact` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '紧急联系人',
  `emergency_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '紧急联系电话',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`worker_id`) USING BTREE,
  UNIQUE INDEX `idx_user_id`(`user_id` ASC) USING BTREE COMMENT '用户ID唯一索引',
  UNIQUE INDEX `idx_phone`(`phone_number` ASC) USING BTREE,
  INDEX `idx_worker_type`(`worker_type` ASC) USING BTREE,
  INDEX `idx_work_status`(`work_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工人信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_worker
-- ----------------------------
INSERT INTO `sys_worker` VALUES (1, NULL, '张三', '0', 35, '13800138001', '110101198801011234', '北京市朝阳区', '电工', '2025-12-17 00:00:00', '0', '李四', '13800138002', '经验丰富，技术娴熟', 'admin', '2025-12-31 10:24:50', 'super', '2026-01-19 11:40:57');
INSERT INTO `sys_worker` VALUES (2, NULL, '李梅', '1', 28, '13800138003', '110101199501011235', '上海市浦东新区', '水工', '2025-12-17 00:00:00', '0', '王五', '13800138004', '细心负责', 'admin', '2025-12-31 10:24:50', 'super', '2025-12-31 11:56:28');
INSERT INTO `sys_worker` VALUES (3, NULL, '王刚', '0', 42, '13800138005', '110101198101011236', '广州市天河区', '木工', '2025-12-17 00:00:00', '0', '赵六', '13800138006', '多年工作经验', 'admin', '2025-12-31 10:24:50', '', NULL);
INSERT INTO `sys_worker` VALUES (4, 108, '张磊', '0', 18, '18833334444', NULL, NULL, '水工', '2026-02-07 00:00:00', '0', NULL, NULL, NULL, 'demo1', '2026-01-19 08:58:40', 'super', '2026-02-07 12:19:46');

SET FOREIGN_KEY_CHECKS = 1;
