package com.property.system.utils;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import org.json.JSONObject;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import com.baidu.aip.ocr.AipOcr;

import java.util.HashMap;
import java.util.Map;

/**
 * 百度ocr车牌识别
 */
@Component
@Configuration
public class OcrUtil {

    public static Map<String, Object> plateLicense(String image) {
        try {
            // 将下面的字符串替换为自己的AppID、API Key和Secret Key
            AipOcr client = new AipOcr("XXXXXXXX", "XXXXXXXXXXXXXXXXXXXXXXXXXX", "XXXXXXXXXXXXXXXXXXXXXXXXX");
            client.setConnectionTimeoutInMillis(2000);
            client.setSocketTimeoutInMillis(60000);
            HashMap<String, String> options = new HashMap<>();
            /**
             * 是否检测多张车牌，默认为false
             * 当置为true的时候可以对一张图片内的多张车牌进行识别
             */
            options.put("multi_detect", "true");
            JSONObject res = client.plateLicense(image, options);
            System.out.println("扫描结果：" + res.toString());

            Object result = res.get("words_result");
            JSONArray array = JSON.parseArray(result.toString());
            com.alibaba.fastjson2.JSONObject object = JSON.parseObject(array.get(0).toString());
            Object number = object.get("number");
            Object color = object.get("color");
            Map<String, Object> map = new HashMap<>();
            map.put("number",number);
            map.put("color",color);
            System.out.println("map中的值" + map);

            return map;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
