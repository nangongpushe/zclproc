package com.dhc.fastersoft.utils;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.List;

/**
 * 更新数据工具类
 * @author 少凡
 * 
 */
public class UpdateUtil {
	
	final static String reg ="\\d+\\.{0,1}\\d*";
	
	public static <T> void UpdateField(T newEntity,T oldEntity,String[] notReplace) throws IllegalArgumentException, IllegalAccessException {
		Class entityClass = newEntity.getClass();
		List<String> notReplaceList = Arrays.asList(notReplace);
		for(Field field : entityClass.getDeclaredFields()) {
			if(notReplaceList.contains(field.getName()))
				continue;
			field.setAccessible(true);
			Object newVal = field.get(newEntity),oldVal = field.get(oldEntity);
				if(newVal!=null && !newVal.equals(oldVal)) {
					if(String.valueOf(newVal).matches(reg)) {
						if(Double.valueOf(String.valueOf(newVal)) == 0) {
							continue;
						}
					}
					field.set(oldEntity, newVal);
			}
		}
	}
}
