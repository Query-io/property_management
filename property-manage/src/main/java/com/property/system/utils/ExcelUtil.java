package com.property.system.utils;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Excel工具类
 */
public class ExcelUtil {

    /**
     * 导出Excel（支持DTO对象）并设置固定列宽
     * @param columnWidth 列宽（单位：字符数），默认30
     */
    public static <T> void exportExcel(HttpServletResponse response, List<T> dataList,
                                       String fileName, String sheetName,
                                       String[] headers, String[] fields, int columnWidth) {
        try (Workbook workbook = new XSSFWorkbook();
             OutputStream out = response.getOutputStream()) {

            if (dataList == null || dataList.isEmpty()) {
                throw new RuntimeException("没有数据可导出");
            }

            Sheet sheet = workbook.createSheet(sheetName);

            // 设置固定列宽
            for (int i = 0; i < headers.length; i++) {
                sheet.setColumnWidth(i, columnWidth * 256); // POI单位：1/256字符宽度
            }

            // 创建标题行
            Row headerRow = sheet.createRow(0);
            CellStyle headerStyle = createHeaderStyle(workbook);

            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // 创建数据行样式
            CellStyle dataStyle = createDataStyle(workbook);

            // 填充数据
            for (int i = 0; i < dataList.size(); i++) {
                Row row = sheet.createRow(i + 1);
                T data = dataList.get(i);

                for (int j = 0; j < fields.length; j++) {
                    Cell cell = row.createCell(j);
                    cell.setCellStyle(dataStyle);
                    try {
                        Object value = getFieldValue(data, fields[j]);
                        // ========== 新增：对奖惩类型字段进行映射 ==========
                        if ("rewardType".equals(fields[j])) {
                            value = mapRewardType(value);
                        }
                        // ===========================================
                        setCellValue(cell, value);
                    } catch (Exception e) {
                        cell.setCellValue("");
                        System.err.println("获取字段 " + fields[j] + " 失败: " + e.getMessage());
                    }
                }
            }

            // 设置响应头
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setCharacterEncoding("utf-8");
            String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + encodedFileName);

            workbook.write(out);

        } catch (IOException e) {
            throw new RuntimeException("导出Excel失败", e);
        } catch (Exception e) {
            throw new RuntimeException("导出Excel失败: " + e.getMessage(), e);
        }
    }

    /**
     * 导出Excel（支持DTO对象）- 默认列宽30
     */
    public static <T> void exportExcel(HttpServletResponse response, List<T> dataList,
                                       String fileName, String sheetName,
                                       String[] headers, String[] fields) {
        exportExcel(response, dataList, fileName, sheetName, headers, fields, 30);
    }

    /**
     * 导出Excel（支持Map对象）并设置固定列宽
     * @param columnWidth 列宽（单位：字符数），默认30
     */
    public static void exportExcel(HttpServletResponse response, List<Map<String, Object>> dataList,
                                   String fileName, String sheetName, String[] headers, int columnWidth) {
        try (Workbook workbook = new XSSFWorkbook();
             OutputStream out = response.getOutputStream()) {

            if (dataList == null || dataList.isEmpty()) {
                throw new RuntimeException("没有数据可导出");
            }

            Sheet sheet = workbook.createSheet(sheetName);

            // 设置固定列宽
            for (int i = 0; i < headers.length; i++) {
                sheet.setColumnWidth(i, columnWidth * 256); // POI单位：1/256字符宽度
            }

            // 创建标题行
            Row headerRow = sheet.createRow(0);
            CellStyle headerStyle = createHeaderStyle(workbook);

            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // 创建数据行样式
            CellStyle dataStyle = createDataStyle(workbook);

            // 填充数据
            for (int i = 0; i < dataList.size(); i++) {
                Row row = sheet.createRow(i + 1);
                Map<String, Object> data = dataList.get(i);

                for (int j = 0; j < headers.length; j++) {
                    Cell cell = row.createCell(j);
                    cell.setCellStyle(dataStyle);

                    String fieldName = getFieldNameFromHeader(headers[j]);
                    Object value = data.get(fieldName);
                    // ========== 新增：对奖惩类型字段进行映射 ==========
                    if ("rewardType".equals(fieldName)) {
                        value = mapRewardType(value);
                    }
                    // ===========================================
                    setCellValue(cell, value);
                }
            }

            // 设置响应头
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setCharacterEncoding("utf-8");
            String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + encodedFileName);

            workbook.write(out);

        } catch (IOException e) {
            throw new RuntimeException("导出Excel失败", e);
        } catch (Exception e) {
            throw new RuntimeException("导出Excel失败: " + e.getMessage(), e);
        }
    }

    /**
     * 导出Excel（支持Map对象）- 默认列宽30
     */
    public static void exportExcel(HttpServletResponse response, List<Map<String, Object>> dataList,
                                   String fileName, String sheetName, String[] headers) {
        exportExcel(response, dataList, fileName, sheetName, headers, 30);
    }

    /**
     * 创建表头样式
     */
    private static CellStyle createHeaderStyle(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();
        Font font = workbook.createFont();

        // 设置字体
        font.setBold(true);
        font.setFontHeightInPoints((short) 12);
        font.setColor(IndexedColors.WHITE.getIndex()); // 白色字体
        style.setFont(font);

        // 设置背景色
        style.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex()); // 深蓝色背景
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        // 设置边框样式和颜色
        style.setBorderBottom(BorderStyle.MEDIUM);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());

        style.setBorderTop(BorderStyle.MEDIUM);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());

        style.setBorderRight(BorderStyle.MEDIUM);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());

        style.setBorderLeft(BorderStyle.MEDIUM);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());

        // 设置对齐方式
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);

        // 设置自动换行
        style.setWrapText(true);

        return style;
    }

    /**
     * 创建数据行样式
     */
    private static CellStyle createDataStyle(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();
        Font font = workbook.createFont();

        // 设置字体
        font.setFontHeightInPoints((short) 11);
        style.setFont(font);

        // 设置边框样式和颜色
        style.setBorderBottom(BorderStyle.THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());

        style.setBorderTop(BorderStyle.THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());

        style.setBorderRight(BorderStyle.THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());

        style.setBorderLeft(BorderStyle.THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());

        // 设置对齐方式
        style.setAlignment(HorizontalAlignment.LEFT);
        style.setVerticalAlignment(VerticalAlignment.CENTER);

        // 设置自动换行
        style.setWrapText(true);

        return style;
    }

    /**
     * 获取字段值（通过反射）
     */
    private static Object getFieldValue(Object obj, String fieldName) {
        try {
            // 尝试不同的getter方法
            String getterMethodName = "get" +
                    fieldName.substring(0, 1).toUpperCase() +
                    fieldName.substring(1);

            Method method = obj.getClass().getMethod(getterMethodName);
            return method.invoke(obj);
        } catch (NoSuchMethodException e) {
            // 尝试直接获取字段
            try {
                Field field = obj.getClass().getDeclaredField(fieldName);
                field.setAccessible(true);
                return field.get(obj);
            } catch (NoSuchFieldException | IllegalAccessException ex) {
                // 如果都失败，返回null
                return null;
            }
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 从表头获取字段名
     */
    private static String getFieldNameFromHeader(String header) {
        // 简单映射，根据实际的表头返回对应的字段名
        switch (header) {
            case "工人姓名": return "workerName";
            case "报修单编号": return "repairNo";
            case "打分": return "score";
            case "评价": return "evaluation";
            case "完成时间": return "completionTime";
            case "报修项目": return "repairTitle";
            case "奖惩类型": return "rewardType";
            case "奖惩金额": return "rewardAmount";
            case "备注": return "remark";
            case "联系电话": return "phoneNumber";
            case "完成工单数": return "completedCount";
            case "平均评分": return "avgScore";
            case "奖励次数": return "rewardCount";
            case "惩罚次数": return "penaltyCount";
            case "总奖励金额": return "totalReward";
            case "总惩罚金额": return "totalPenalty";
            case "奖惩合计": return "rewardTotal";
            default:
                // 将中文转换为驼峰格式（简单处理）
                return header.replaceAll(" ", "");
        }
    }

    /**
     * 设置单元格值
     */
    private static void setCellValue(Cell cell, Object value) {
        if (value == null) {
            cell.setCellValue("");
        } else if (value instanceof Date) {
            cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format((Date) value));
        } else if (value instanceof Integer) {
            cell.setCellValue(((Integer) value).doubleValue());
        } else if (value instanceof Long) {
            cell.setCellValue(((Long) value).doubleValue());
        } else if (value instanceof Double) {
            cell.setCellValue((Double) value);
        } else if (value instanceof Float) {
            cell.setCellValue(((Float) value).doubleValue());
        } else if (value instanceof BigDecimal) {
            cell.setCellValue(((BigDecimal) value).doubleValue());
        } else if (value instanceof Boolean) {
            cell.setCellValue((Boolean) value);
        } else {
            cell.setCellValue(value.toString());
        }
    }

    /**
     * 简化版本：直接导出数据并设置固定列宽
     * @param columnWidth 列宽（单位：字符数），默认30
     */
    public static <T> void exportExcelSimple(HttpServletResponse response, List<T> dataList,
                                             String fileName, String sheetName,
                                             String[] headers, int columnWidth) {
        try (Workbook workbook = new XSSFWorkbook();
             OutputStream out = response.getOutputStream()) {

            if (dataList == null || dataList.isEmpty()) {
                throw new RuntimeException("没有数据可导出");
            }

            Sheet sheet = workbook.createSheet(sheetName);

            // 设置固定列宽
            for (int i = 0; i < headers.length; i++) {
                sheet.setColumnWidth(i, columnWidth * 256); // POI单位：1/256字符宽度
            }

            // 创建标题行
            Row headerRow = sheet.createRow(0);
            CellStyle headerStyle = createHeaderStyle(workbook);

            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // 创建数据行样式
            CellStyle dataStyle = createDataStyle(workbook);

            // 填充数据（遍历对象的字段）
            for (int i = 0; i < dataList.size(); i++) {
                Row row = sheet.createRow(i + 1);
                T data = dataList.get(i);

                // 获取所有字段
                Field[] fields = data.getClass().getDeclaredFields();
                for (int j = 0; j < Math.min(fields.length, headers.length); j++) {
                    Cell cell = row.createCell(j);
                    cell.setCellStyle(dataStyle);

                    try {
                        fields[j].setAccessible(true);
                        Object value = fields[j].get(data);
                        // ========== 新增：对奖惩类型字段进行映射 ==========
                        if ("rewardType".equals(fields[j].getName())) {
                            value = mapRewardType(value);
                        }
                        // ===========================================
                        setCellValue(cell, value);
                    } catch (Exception e) {
                        cell.setCellValue("");
                    }
                }
            }

            // 设置响应头
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setCharacterEncoding("utf-8");
            String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + encodedFileName);

            workbook.write(out);

        } catch (IOException e) {
            throw new RuntimeException("导出Excel失败", e);
        } catch (Exception e) {
            throw new RuntimeException("导出Excel失败: " + e.getMessage(), e);
        }
    }

    /**
     * 简化版本：直接导出数据 - 默认列宽30
     */
    public static <T> void exportExcelSimple(HttpServletResponse response, List<T> dataList,
                                             String fileName, String sheetName, String[] headers) {
        exportExcelSimple(response, dataList, fileName, sheetName, headers, 30);
    }

    /**
     * 设置所有列的宽度（辅助方法）
     * @param sheet Excel工作表
     * @param columnWidth 列宽（字符数）
     * @param columnCount 列数
     */
    public static void setAllColumnWidth(Sheet sheet, int columnWidth, int columnCount) {
        for (int i = 0; i < columnCount; i++) {
            sheet.setColumnWidth(i, columnWidth * 128);
        }
    }

    /**
     * 将奖惩类型数字映射为文字
     * 规则：0 -> 无奖惩，1 -> 奖励，2 -> 惩罚
     */
    private static Object mapRewardType(Object value) {
        if (value == null) {
            return "";
        }
        Integer intVal;
        if (value instanceof Number) {
            intVal = ((Number) value).intValue();
        } else {
            try {
                intVal = Integer.parseInt(value.toString());
            } catch (NumberFormatException e) {
                // 无法转换则返回原值
                return value;
            }
        }
        switch (intVal) {
            case 0:
                return "无奖惩";
            case 1:
                return "奖励";
            case 2:
                return "惩罚";
            default:
                return "未知类型(" + intVal + ")";
        }
    }
}