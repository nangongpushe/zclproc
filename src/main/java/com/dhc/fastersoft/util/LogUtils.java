package com.dhc.fastersoft.util;

import org.apache.log4j.Level;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.log4j.Priority;

import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.StringReader;
import java.io.StringWriter;

/**
 * 日志通用方法
 */
public class LogUtils {

    private static Logger objLog;

    private static Logger getLogger() {
        if (objLog == null) {
            objLog = LogManager.getLogger(LogUtils.class);
        }
        return objLog;
    }

    /**
     * @param message   记录信息
     * @param exception 信息内容
     */
    public static void info(String message, Exception exception) {
        try {
            log("INFO", message, exception);
        } catch (Exception ex) {
            LogUtils.error(ex.getMessage());
        }
    }

    /**
     * @param message 日志信息内容
     */
    public static void info(Object message) {
        log("INFO", message);
    }

    /**
     * @param message 日志信息内容
     */
    public static void trace(String message) {
        try {
            log("TRACE", message);
        } catch (Exception ex) {
            LogUtils.error(ex.getMessage());
        }
    }

    /**
     * @param message   日志信息
     * @param exception 异常信息
     */
    public static void trace(String message, Exception exception) {
        try {
            log("TRACE", message, exception);
        } catch (Exception ex) {
            LogUtils.error(ex.getMessage());
        }
    }

    /**
     * 记录一个错误信息
     *
     * @param message   信息内容
     * @param exception 异常对象
     */
    public static void error(String message, Exception exception) {
        try {
            log("ERROR", message, exception);
        } catch (Exception ex) {
            LogUtils.error(ex.getMessage());
        }
    }

    /**
     * 记录一个错误信息
     *
     * @param message 信息内容
     */
    public static void error(String message) {
        try {
            log("ERROR", message);
        } catch (Exception ex) {
            LogUtils.error(ex.getMessage());
        }
    }


    /**
     * 记录一个警告信息
     *
     * @param message   信息内容
     * @param exception 异常对象
     */
    public static void warning(String message, Exception exception) {
        try {
            log("WARN", message, exception);
        } catch (Exception ex) {
            LogUtils.error(ex.getMessage());
        }
    }


    /**
     * 记录一个警告信息
     *
     * @param message 信息内容
     */
    public static void warning(String message) {
        try {
            log("WARN", message);
        } catch (Exception ex) {
            LogUtils.error(ex.getMessage());
        }
    }


    /**
     * 记录一个程序致命性错误
     *
     * @param message   信息内容
     * @param exception 异常对象
     */
    public static void fatal(String message, Exception exception) {
        try {
            log("FATAL", message, exception);
        } catch (Exception ex) {
            LogUtils.error(ex.getMessage());
        }
    }


    /**
     * 记录一个程序致命性错误
     *
     * @param message 信息内容
     */
    public static void fatal(String message) {
        try {
            log("FATAL", message);
        } catch (Exception ex) {
            LogUtils.error(ex.getMessage());
        }
    }

    /**
     * 记录调试信息
     *
     * @param message   信息内容
     * @param exception 异常对象
     */
    public static void debug(String message, Exception exception) {
        try {
            log("DEBUG", message, exception);
        } catch (Exception ex) {
            LogUtils.error(ex.getMessage());
        }
    }


    /**
     * 记录调试信息
     *
     * @param message 信息内容
     */
    public static void debug(String message) {
        try {
            log("DEBUG", message);
        } catch (Exception ex) {
            LogUtils.error(ex.getMessage());
        }
    }

    public static void log(String level, Object msg) {
        log(level, msg, null);
    }

    public static void log(String level, Throwable e) {
        log(level, null, e);
    }

    public static void log(String level, Object msg, Throwable e) {
        try {
            StringBuilder sb = new StringBuilder();
            Throwable t = new Throwable();
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            String input = sw.getBuffer().toString();
            StringReader sr = new StringReader(input);
            BufferedReader br = new BufferedReader(sr);
            for (int i = 0; i < 4; i++) {
                br.readLine();
            }
            String line = br.readLine();
            // at com.media.web.action.DicManageAction.list(DicManageAction.java:89)
            int paren = line.indexOf("at ");
            line = line.substring(paren + 3);
            paren = line.indexOf('(');
            String invokeInfo = line.substring(0, paren);
            int period = invokeInfo.lastIndexOf('.');
            sb.append('[');
            sb.append(invokeInfo.substring(0, period));
            sb.append(':');
            sb.append(invokeInfo.substring(period + 1));
            sb.append("():");
            paren = line.indexOf(':');
            period = line.lastIndexOf(')');
            sb.append(line.substring(paren + 1, period));
            sb.append(']');
            sb.append(" - ");
            sb.append(msg);
            getLogger().log((Priority) Level.toLevel(level), sb.toString(), e);
        } catch (Exception ex) {
            LogUtils.info(ex.getLocalizedMessage());
        }
    }

}
