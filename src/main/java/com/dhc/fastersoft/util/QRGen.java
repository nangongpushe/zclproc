/**
 * @Title: QRGen.java
 * @Package com.paas.util.cm
 * @Description: TODO(用一句话描述该文件做什么)
 * @Copyright: Copyright (c) 2015-2020
 * @Company:CCS
 * @author zcs
 * @date 2015-12-27 下午1:50:51
 * @version V1.0
 */
package com.dhc.fastersoft.util;


/**
 * @author zcs
 * @Title: QRGen
 * @Description: TODO(二维码)
 * @Copyright: Copyright (c) 2015-2020
 * @Company:CCS
 * @date 2015-12-27 下午1:50:51
 */
public class QRGen {
    public final static String CHARSET = "GBK";//编码格式，默认GBK

    public final static String SPLITER = "|;|";//间隔符号

    public final static String FORMAT = "png";//图像类型

    public final static int PNG_WIDTH = 86;//二维码图片宽度

    public final static int PNG_HEIGHT = 86;//二维码图片高度

    private String content;     //二维码内容
    private String filePath;    //文件存放路径
    private String fileName;    //文件名称
    private int width;          //图像宽度
    private int height;         //图像高度
    private String format;      //图像类型,eg:png
    private int onColor = 0xFF000000;  //默认为黑
    private int offColor = 0xFFFFFFFF; //背景颜色,默认为白

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public int getOnColor() {
        return onColor;
    }

    public void setOnColor(int onColor) {
        this.onColor = onColor;
    }

    public int getOffColor() {
        return offColor;
    }

    public void setOffColor(int offColor) {
        this.offColor = offColor;
    }
}
