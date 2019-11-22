package com.dhc.fastersoft.utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;

public class JsonUtil {
    private static final ObjectMapper objectMapper = new ObjectMapper();  
    
    
    
    /** 
     * 对象JSON序列化 
     *  
     * @param object 
     * @return 
     * @throws JsonGenerationException 
     * @throws JsonMappingException 
     * @throws IOException 
     */  
    public static String toJSON(Object object) {  
        try {  
            return objectMapper.writeValueAsString(object);  
        } catch (Exception e) {  
            return null;  
        }  
    }
    /**
     * 列表json字符串，反序列
     * @param jsonListStr
     * @param classType
     * @return
     */
    public static <T> List<T> toObject(String jsonListStr,Class<T> classType){
    	if(jsonListStr == null)
    		return new ArrayList<T>();
    	try {
			return objectMapper.readValue(jsonListStr,
					TypeFactory.defaultInstance()
					.constructCollectionType(List.class,classType));
		} catch (JsonParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return null;
    }
}
