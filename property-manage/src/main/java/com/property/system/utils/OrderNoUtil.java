package com.property.system.utils;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * 订单编号生成工具类
 */
public class OrderNoUtil {

    /** 时间格式：年月日时分秒（到秒） */
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyyMMddHHmmss");

    private static final Random RANDOM = new Random();

    /**
     * 生成订单编号
     * 格式示例：ORD20250429104530 + 三位随机数
     * @return 订单编号
     */
    public static String generateOrderNo() {
        String timestamp = DATE_FORMAT.format(new Date());
        int random = 100 + RANDOM.nextInt(900); // 100 ~ 999
        return "ORD" + timestamp + random;
    }

    /**
     * 可选：生成带订单类型前缀的编号（例如：FZ20250429104530123）
     * @param prefix 类型前缀（例如：FZ=房租，WX=维修）
     * @return 编号
     */
    public static String generateOrderNo(String prefix) {
        String timestamp = DATE_FORMAT.format(new Date());
        int random = 100 + RANDOM.nextInt(900);
        return prefix.toUpperCase() + timestamp + random;
    }
}
