package com.dhc.fastersoft.util;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.security.MessageDigest;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 字符串操作类
 */
public class StringUtil {


    private static Pattern REGEX = Pattern.compile("\\{(.*?)\\}");

    /**
     * 对字符串 escape 编码
     *
     * @param src src
     * @return String
     */
    public static String escape(String src) {
        int i;
        char j;
        StringBuffer tmp = new StringBuffer();
        tmp.ensureCapacity(src.length() * 6);

        for (i = 0; i < src.length(); i++) {

            j = src.charAt(i);

            if (Character.isDigit(j) || Character.isLowerCase(j)
                    || Character.isUpperCase(j)) {
                tmp.append(j);
            } else if (j < 256) {
                tmp.append("%");
                if (j < 16) {
                    tmp.append("0");
                }
                tmp.append(Integer.toString(j, 16));
            } else {
                tmp.append("%u");
                tmp.append(Integer.toString(j, 16));
            }
        }
        return tmp.toString();
    }

    /**
     * 替换字符串中的变量
     *
     * @param template template
     * @param map      map
     * @return String
     * @throws Exception Exception
     */
    public static String replaceVariable(String template,
                                         Map<String, String> map) throws Exception {
        Matcher regexMatcher = REGEX.matcher(template);
        while (regexMatcher.find()) {
            String key = regexMatcher.group(1);
            String toReplace = regexMatcher.group(0);
            String value = map.get(key);
            if (value != null) {
                template = template.replace(toReplace, value);
            } else {
                throw new Exception(String.format("没有找到[%s]对应的变量值，请检查表变量配置!", key));
            }
        }
        return template;
    }

    /**
     * 对编码的字符串解码
     *
     * @param src src
     * @return String
     */
    public static String unescape(String src) {
        StringBuilder tmp = new StringBuilder();
        tmp.ensureCapacity(src.length());
        int lastPos = 0, pos;
        char ch;
        while (lastPos < src.length()) {
            pos = src.indexOf("%", lastPos);
            if (pos == lastPos) {
                if (src.charAt(pos + 1) == 'u') {
                    ch = (char) Integer.parseInt(
                            src.substring(pos + 2, pos + 6), 16);
                    tmp.append(ch);
                    lastPos = pos + 6;
                } else {
                    ch = (char) Integer.parseInt(
                            src.substring(pos + 1, pos + 3), 16);
                    tmp.append(ch);
                    lastPos = pos + 3;
                }
            } else {
                if (pos == -1) {
                    tmp.append(src.substring(lastPos));
                    lastPos = src.length();
                } else {
                    tmp.append(src.substring(lastPos, pos));
                    lastPos = pos;
                }
            }
        }
        return tmp.toString();
    }

    /**
     * 判断字符串是否在是否包函内容
     *
     * @param content content
     * @param begin   begin
     * @param end     end
     * @return boolean
     */
    public static boolean isExist(String content, String begin, String end) {
        String tmp = content.toLowerCase();
        begin = begin.toLowerCase();
        end = end.toLowerCase();
        int beginIndex = tmp.indexOf(begin);
        int endIndex = tmp.indexOf(end);
        return (beginIndex != -1) && (endIndex != -1) && (beginIndex < endIndex);
    }

    /**
     * 去掉前面的指定字符
     *
     * @param toTrim  toTrim
     * @param trimStr trimStr
     * @return String
     */
    public static String trimPrefix(String toTrim, String trimStr) {
        while (toTrim.startsWith(trimStr)) {
            toTrim = toTrim.substring(trimStr.length());
        }
        return toTrim;
    }

    /**
     * 删除后面指定的字符
     *
     * @param toTrim  toTrim
     * @param trimStr trimStr
     * @return String
     */
    public static String trimSufffix(String toTrim, String trimStr) {
        while (toTrim.endsWith(trimStr)) {
            toTrim = toTrim.substring(0, toTrim.length() - trimStr.length());
        }
        return toTrim;
    }

    /**
     * 删除指定的字符
     *
     * @param toTrim  toTrim
     * @param trimStr trimStr
     * @return String
     */
    public static String trim(String toTrim, String trimStr) {
        return trimSufffix(trimPrefix(toTrim, trimStr), trimStr);
    }

    /**
     * 编码html
     *
     * @param content content
     * @return String
     */
    public static String escapeHtml(String content) {
        return StringEscapeUtils.escapeHtml(content);
    }

    /**
     * 反编码html
     *
     * @param content content
     * @return String
     */
    public static String unescapeHtml(String content) {
        return StringEscapeUtils.unescapeHtml(content);
    }

    /**
     * 判断字符串是否为空
     *
     * @param str str
     * @return boolean
     */
    public static boolean isEmpty(String str) {
        return str == null || "".equals(str.trim()) || "null".equals(str.trim());
    }

    /**
     * 判断字符串非空
     *
     * @param str str
     * @return boolean
     */
    public static boolean isNotEmpty(String str) {
        return !isEmpty(str);
    }

    /**
     * 截取字符串 中文为两个字节，英文为一个字节。 两个英文为一个中文。
     *
     * @param str str
     * @param len len
     * @return String
     */
    public static String subString(String str, int len) {
        int strLen = str.length();
        if (strLen < len) {
            return str;
        }
        char[] chars = str.toCharArray();
        int cnLen = len * 2;
        StringBuilder tmp = new StringBuilder();
        int iLen = 0;
        for (char aChar : chars) {
            int iChar = (int) aChar;
            if (iChar <= 128) {
                iLen = iLen + 1;
            } else {
                iLen = iLen + 2;
            }
            if (iLen >= cnLen) {
                break;
            }
            tmp.append(String.valueOf(aChar));
        }
        return tmp.toString();
    }

    /**
     * 判读输入字符是否是数字
     *
     * @param s s
     * @return boolean
     */
    public static boolean isNumberic(String s) {
        if (StringUtils.isEmpty(s)) {
            return false;
        }
        boolean rtn = validByRegex("^[-+]{0,1}\\d*\\.{0,1}\\d+$", s);
        return rtn || validByRegex("^0[x|X][\\da-eA-E]+$", s);

    }

    /**
     * 是否是整数。
     *
     * @param s s
     * @return boolean
     */
    public static boolean isInteger(String s) {
        return validByRegex("^[-+]{0,1}\\d*$", s);

    }

    /**
     * 是否是电子邮箱
     *
     * @param s s
     * @return boolean
     */
    public static boolean isEmail(String s) {
        return validByRegex(
                "(\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*)*", s);
    }

    /**
     * 手机号码
     *
     * @param s s
     * @return boolean
     */
    public static boolean isMobile(String s) {
        return validByRegex(
                "^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\\d{8})$", s);
    }

    /**
     * 电话号码
     *
     * @param s s
     * @return boolean
     */
    public static boolean isPhone(String s) {
        return validByRegex(
                "(0[0-9]{2,3}\\-)?([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?", s);
    }

    /**
     * 邮编
     *
     * @param s s
     * @return boolean
     */
    public static boolean isZip(String s) {
        return validByRegex("^[0-9]{6}$", s);
    }

    /**
     * qq号码
     *
     * @param s s
     * @return boolean
     */
    public static boolean isQq(String s) {
        return validByRegex("^[1-9]\\d{4,9}$", s);
    }

    /**
     * ip地址
     *
     * @param s s
     * @return boolean
     */
    public static boolean isIp(String s) {
        return validByRegex(
                "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",
                s);
    }

    /**
     * 判断是否中文
     *
     * @param s s
     * @return boolean
     */
    public static boolean isChinese(String s) {
        return validByRegex("^[\u4e00-\u9fa5]+$", s);
    }

    /**
     * 字符和数字
     *
     * @param s s
     * @return boolean
     */
    public static boolean isChrNum(String s) {
        return validByRegex("^([a-zA-Z0-9]+)$", s);
    }

    /**
     * 判断是否是URL
     *
     * @param url url
     * @return boolean
     */
    public static boolean isUrl(String url) {
        return validByRegex(
                "(http://|https://)?([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?",
                url);

    }

    //使用正则表达式实现不区分大小写替换

    public static String replaceStringP(String source, String regex, String newstring) {
        Matcher m = Pattern.compile(regex, Pattern.CASE_INSENSITIVE).matcher(source);
        return m.replaceAll(newstring);
    }

    /**
     * 使用正则表达式验证。
     *
     * @param regex regex
     * @param input input
     * @return boolean
     */
    public static boolean validByRegex(String regex, String input) {
        Pattern p = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
        Matcher regexMatcher = p.matcher(input);
        return regexMatcher.find();
    }

    /**
     * 使用正则表达式验证。
     *
     * @param regex regex
     * @param input input
     * @return int
     */
    public static int validByRegexend(String regex, String input) {
        Pattern p = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
        Matcher regexMatcher = p.matcher(input);
        int end = -1;
        if (regexMatcher.find()) {
            end = regexMatcher.end();
        }
        return end;
    }

    /**
     * 判断某个字符串是否为数字
     *
     * @param str str
     * @return boolean
     */
    public static boolean isNumeric(String str) {
        for (int i = str.length(); --i >= 0; ) {
            if (!Character.isDigit(str.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    /**
     * 把字符串的第一个字母转为大写
     *
     * @param newStr newStr
     * @return String
     */
    public static String makeFirstLetterUpperCase(String newStr) {
        if (newStr.length() == 0) {
            return newStr;
        }

        char[] oneChar = new char[1];
        oneChar[0] = newStr.charAt(0);
        String firstChar = new String(oneChar);
        return (firstChar.toUpperCase() + newStr.substring(1));
    }

    /**
     * 把字符串的第一字每转为小写
     *
     * @param newStr newStr
     * @return String
     */
    public static String makeFirstLetterLowerCase(String newStr) {
        if (newStr.length() == 0) {
            return newStr;
        }

        char[] oneChar = new char[1];
        oneChar[0] = newStr.charAt(0);
        String firstChar = new String(oneChar);
        return (firstChar.toLowerCase() + newStr.substring(1));
    }

    /**
     * 格式化带参数的字符串，如 /param/detail.ht?a={0}&b={1}
     *
     * @param message message
     * @param args    args
     * @return String
     */
    public static String formatParamMsg(String message, Object... args) {
        for (int i = 0; i < args.length; i++) {
            message = message.replace("{" + i + "}", args[i].toString());
        }
        return message;
    }

    /**
     * 格式化如下字符串 http://www.bac.com?a=${a}&b=${b}
     *
     * @param message message
     * @param params  params
     */
    public static String formatParamMsg(String message, Map params) {
        if (params == null) {
            return message;
        }
        Iterator<String> keyIts = params.keySet().iterator();
        while (keyIts.hasNext()) {
            String key = keyIts.next();
            Object val = params.get(key);
            if (val != null) {
                message = message.replace("${" + key + "}", val.toString());
            }
        }
        return message;
    }

    /**
     * 简单的字符串格式化，性能较好。支持不多于10个占位符，从%1开始计算，数目可变。参数类型可以是字符串、Integer、Object，
     * 甚至int等基本类型
     * 、以及null，但只是简单的调用toString()，较复杂的情况用String.format()。每个参数可以在表达式出现多次。
     *
     * @param msgWithFormat msgWithFormat
     * @param autoQuote     autoQuote
     * @param args          args
     * @return StringBuilder
     */
    public static StringBuilder formatMsg(CharSequence msgWithFormat,
                                          boolean autoQuote, Object... args) {
        int argsLen = args.length;
        boolean markFound = false;

        StringBuilder sb = new StringBuilder(msgWithFormat);

        if (argsLen > 0) {
            for (int i = 0; i < argsLen; i++) {
                String flag = "%" + (i + 1);
                int idx = sb.indexOf(flag);
                // 支持多次出现、替换的代码
                while (idx >= 0) {
                    markFound = true;
                    sb.replace(idx, idx + 2, toString(args[i], autoQuote));
                    idx = sb.indexOf(flag);
                }
            }

            if (args[argsLen - 1] instanceof Throwable) {
                StringWriter sw = new StringWriter();
                ((Throwable) args[argsLen - 1])
                        .printStackTrace(new PrintWriter(sw));
                sb.append("\n").append(sw.toString());
            } else if (argsLen == 1 && !markFound) {
                sb.append(args[argsLen - 1].toString());
            }
        }
        return sb;
    }

    public static StringBuilder formatMsg(String msgWithFormat, Object... args) {
        return formatMsg(new StringBuilder(msgWithFormat), true, args);
    }

    public static String toString(Object obj, boolean autoQuote) {
        StringBuilder sb = new StringBuilder();
        if (obj == null) {
            sb.append("NULL");
        } else {
            if (obj instanceof Object[]) {
                for (int i = 0; i < ((Object[]) obj).length; i++) {
                    sb.append(((Object[]) obj)[i]).append(", ");
                }
                if (sb.length() > 0) {
                    sb.delete(sb.length() - 2, sb.length());
                }
            } else {
                sb.append(obj.toString());
            }
        }
        if (autoQuote
                && sb.length() > 0
                && !((sb.charAt(0) == '[' && sb.charAt(sb.length() - 1) == ']') || (sb
                .charAt(0) == '{' && sb.charAt(sb.length() - 1) == '}'))) {
            sb.insert(0, "[").append("]");
        }
        return sb.toString();
    }

    public static String returnSpace(String str) {
        String space = "";
        if (!str.isEmpty()) {
            String[] path = str.split("\\.");
            if (path.length == 1) {
                path = str.split("\\,");
            }
            for (int i = 0; i < path.length - 1; i++) {
                space += "&nbsp;&emsp;";
            }
        }
        return space;
    }

    /**
     * 输出明文按sha-256加密后的密文
     *
     * @param inputStr 明文
     * @return String
     */
    public static synchronized String encryptSha256(String inputStr) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] digest = md.digest(inputStr.getBytes("UTF-8"));
            return new String(Base64.encodeBase64(digest));
        } catch (Exception e) {
            return null;
        }
    }

    public static synchronized String encryptMd5(String inputStr) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(inputStr.getBytes());
            byte[] digest = md.digest();
            StringBuffer sb = new StringBuffer();
            for (byte b : digest) {
                sb.append(Integer.toHexString((int) (b & 0xff)));
            }

            return sb.toString();
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 把字符串数组转成带，的字符串
     *
     * @param arr arr
     * @return 返回字符串，格式如1,2,3
     */
    public static String getArrayAsString(List<String> arr) {
        if (arr == null || arr.size() == 0) {
            return "";
        }
        return listToString(arr, "", ",");
    }

    /**
     * 把字符串数组转成带，的字符串
     *
     * @param arr arr
     * @return 返回字符串，格式如1,2,3
     */
    public static String getArrayAsString(String[] arr) {
        if (arr == null || arr.length == 0) {
            return "";
        }
        return listToString(Arrays.asList(arr), "", ",");
    }

    /**
     * 把Set转成带，的字符串
     *
     * @param set set
     * @return 返回字符串，格式如1,2,3
     */
    public static String getSetAsString(Set set) {
        if (set == null || set.size() == 0) {
            return "";
        }
        List<String> list = new ArrayList<>();
        list.addAll(set);
        return listToString(list, "", ",");
    }

    /**
     * 将人名币转成大写。
     *
     * @param value amount
     * @return String
     */
    public static String hangeToBig(double value) {
        char[] hunit = {'拾', '佰', '仟'}; // 段内位置表示
        char[] vunit = {'万', '亿'}; // 段名表示
        char[] digit = {'零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖'}; // 数字表示
        long midVal = (long) (value * 100); // 转化成整形
        String valStr = String.valueOf(midVal); // 转化成字符串

        String head = valStr.substring(0, valStr.length() - 2); // 取整数部分
        String rail = valStr.substring(valStr.length() - 2); // 取小数部分

        String prefix = ""; // 整数部分转化的结果
        String suffix = ""; // 小数部分转化的结果
        // 处理小数点后面的数
        if ("00".equals(rail)) { // 如果小数部分为0
            suffix = "整";
        } else {
            suffix = digit[rail.charAt(0) - '0'] + "角"
                    + digit[rail.charAt(1) - '0'] + "分"; // 否则把角分转化出来
        }
        // 处理小数点前面的数
        char[] chDig = head.toCharArray(); // 把整数部分转化成字符数组
        char zero = '0'; // 标志'0'表示出现过0
        byte zeroSerNum = 0; // 连续出现0的次数
        for (int i = 0; i < chDig.length; i++) { // 循环处理每个数字
            int idx = (chDig.length - i - 1) % 4; // 取段内位置
            int vidx = (chDig.length - i - 1) / 4; // 取段位置
            // 如果当前字符是0
            if (chDig[i] == '0') {
                // 连续0次数递增
                zeroSerNum++;
                // 标志
                if (zero == '0') {
                    zero = digit[0];
                } else if (idx == 0 && vidx > 0 && zeroSerNum < 4) {
                    prefix += vunit[vidx - 1];
                    zero = '0';
                }
                continue;
            }
            // 连续0次数清零
            zeroSerNum = 0;
            // 如果标志不为0,则加上,例如万,亿什么的
            if (zero != '0') {
                prefix += zero;
                zero = '0';
            }
            // 转化该数字表示
            prefix += digit[chDig[i] - '0'];
            if (idx > 0) {
                prefix += hunit[idx - 1];
            }
            if (idx == 0 && vidx > 0) {
                // 段结束位置应该加上段名如万,亿
                prefix += vunit[vidx - 1];
            }
        }

        if (prefix.length() > 0) {
            // 如果整数部分存在,则有圆的字样
            prefix += '圆';
        }
        // 返回正确表示
        return prefix + suffix;
    }

    /**
     * @param str str
     * @return String
     */
    public static String jsonUnescape(String str) {
        return str.replace("&quot;", "\"").replace("&nuot;", "\n");
    }

    /**
     * HTML实体编码转成普通的编码
     *
     * @param dataStr dataStr
     * @return String
     */
    public static String htmlEntityToString(String dataStr) {
        dataStr = dataStr.replace("&apos;", "'").replace("&quot;", "\"")
                .replace("&gt;", ">").replace("&lt;", "<")
                .replace("&amp;", "&");

        int start = 0;
        int end;
        final StringBuilder buffer = new StringBuilder();

        while (start > -1) {
            int system = 10;// 进制
            if (start == 0) {
                int t = dataStr.indexOf("&#");
                if (start != t) {
                    start = t;
                }
                if (start > 0) {
                    buffer.append(dataStr.substring(0, start));
                }
            }
            end = dataStr.indexOf(";", start + 2);
            String charStr = "";
            if (end != -1) {
                charStr = dataStr.substring(start + 2, end);
                // 判断进制
                char s = charStr.charAt(0);
                if (s == 'x' || s == 'X') {
                    system = 16;
                    charStr = charStr.substring(1);
                }
            }
            // 转换
            try {
                char letter = (char) Integer.parseInt(charStr, system);
                buffer.append(Character.toString(letter));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }

            // 处理当前unicode字符到下一个unicode字符之间的非unicode字符
            start = dataStr.indexOf("&#", end);
            if (start - end > 1) {
                buffer.append(dataStr.substring(end + 1, start));
            }

            // 处理最后面的非unicode字符
            if (start == -1) {
                int length = dataStr.length();
                if (end + 1 != length) {
                    buffer.append(dataStr.substring(end + 1, length));
                }
            }
        }
        return buffer.toString();
    }

    /**
     * 把String转成html实体字符
     *
     * @param str str
     * @return String
     */
    public static String stringToHtmlEntity(String str) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < str.length(); i++) {
            char c = str.charAt(i);

            switch (c) {
                case 0x0A:
                    sb.append(c);
                    break;

                case '<':
                    sb.append("&lt;");
                    break;

                case '>':
                    sb.append("&gt;");
                    break;

                case '&':
                    sb.append("&amp;");
                    break;

                case '\'':
                    sb.append("&apos;");
                    break;

                case '"':
                    sb.append("&quot;");
                    break;

                default:
                    if ((c < ' ') || (c > 0x7E)) {
                        sb.append("&#x");
                        sb.append(Integer.toString(c, 16));
                        sb.append(';');
                    } else {
                        sb.append(c);
                    }
            }
        }
        return sb.toString();
    }


    public static String encodingString(String str, String from, String to) {
        String result;
        try {
            result = new String(str.getBytes(from), to);
        } catch (Exception e) {
            result = str;
        }
        return result;
    }

    /**
     * 在字符串sr中搜索字符串ar出现的次数方法
     *
     * @param sr sr
     * @param ar ar
     * @return int
     * @author <a href="mailto:yangc@jxyckj.com">yangchao</a>
     */
    public static int searchCount(String sr, String ar) {

        if (isNotEmpty(sr) && isNotEmpty(ar)) {
            String subSr = sr.replace(ar, "");
            int difference = sr.length() - subSr.length();
            return difference / ar.length();
        } else {
            return 0;
        }
    }

    /**
     * 得到一个字符串的长度,显示的长度,一个汉字或日韩文长度为2,英文字符长度为1
     *
     * @param s 需要得到长度的字符串
     * @return int 得到的字符串长度
     */
    public static int getcharacterLength(String s) {
        if (s == null) {
            return 0;
        }
        char[] c = s.toCharArray();
        int len = 0;
        for (char chr : c) {
            len++;
            if (!isLetter(chr)) {
                len++;
            }
        }
        return len;
    }

    /**
     * 判断汉字字符
     *
     * @param c c
     * @return boolean
     */
    public static boolean isLetter(char c) {
        int k = 0x80;
        return c / k == 0;
    }

    /**
     * 数组转字符
     *
     * @param list        数组
     * @param placeholder 占位符
     * @param separator   分隔符
     * @return 字符
     */
    public static String listToString(List<String> list, String placeholder, String separator) {
        if (list == null || list.isEmpty()) {
            return null;
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            String str = list.get(i);
            if (i > 0) {
                sb.append(separator);
            }
            sb.append(placeholder);
            sb.append(str);
            sb.append(placeholder);
        }
        return sb.toString();
    }

    /**
     * 数组转字符 默认占位符‘ 分隔符，
     *
     * @param list 数组
     * @return 字符
     */
    public static String listToString(List<String> list) {
        return listToString(list, "'", ",");
    }

    /**
     * 数组转字符 默认占位符‘ 分隔符，
     *
     * @param list 数组
     * @return 字符
     */
    public static String listToString(String[] list) {
        return listToString(Arrays.asList(list));
    }

    /**
     * 数组转字符 默认占位符‘ 分隔符，
     *
     * @param set 数组
     * @return 字符
     */
    public static String setToString(Set<String> set) {
        List<String> list = new ArrayList<>();
        list.addAll(set);
        return listToString(list);
    }


}
