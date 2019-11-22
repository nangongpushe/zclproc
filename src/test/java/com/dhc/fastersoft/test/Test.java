package com.dhc.fastersoft.test;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class Test {
    public static void main(String[] args) {
        //0、格式化日期
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-M-d");
            Date date = (Date) sdf.parse("2019-1-2");
            boolean a = "2019-1-2".equals(sdf.format(date));
        }catch (Exception e){

        }

        //1、数组添加元素
        String s1[]={"aa","bb","cc","dd"};
        s1 = insertElment(s1,2,"xx","yy","zz");
//        s1=insertElment(s1,3,"xx");
        for(String temp:s1){
            System.out.println(temp);
        }
//        System.out.println(s1);
    }

    private static String[] insertElment(String strs[],int index,String ... elment){
        List<String> list = new LinkedList<>(Arrays.asList(strs));
        for (String  str: elment){
            list.add(index++,str);
        }
        return list.toArray(new String[list.size()]);
    }

    /**
     * 返回已经插入后的数组
     * @param str
     * @param index
     * @param elment
     * @return
     */
//    public  static String[] insertElment(String str[],int index,String elment){
//        String s2[]=new String[str.length+1];
//        System.arraycopy(str,0,s2,0,index);
//        s2[index]=elment;
//        System.arraycopy(str,index,s2,index+1,str.length-index);
//        return s2;
//    }
}
