package com.dhc.fastersoft.util;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class PropertiesUtil {
    private static Properties properties = null;

    static {
        try {
            properties = getProperties();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getProperty(String key) {
        return properties.getProperty(key);
    }

    public static Properties getProperties() {
        if (properties != null) {
            return properties;
        }
        String filePath;
        InputStream in = null;
        try {
            filePath = PropertiesUtil.class.getClassLoader()
                    .getResource("app.properties").getPath();
            // 将指定文件以流的方式给类
            in = PropertiesUtil.class.getClassLoader()
                    .getResourceAsStream("app.properties");
            if (in == null) {
                in = new FileInputStream(filePath);
            }
            properties = new Properties();
            properties.load(in);
        } catch (Exception e) {
            LogUtils.error(e.getMessage());
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (Exception e) {
                    LogUtils.error(e.getMessage());
                }
            }
        }
        return properties;
    }
}
