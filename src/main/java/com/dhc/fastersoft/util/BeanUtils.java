package com.dhc.fastersoft.util;

import org.apache.commons.beanutils.*;
import org.apache.commons.beanutils.converters.LongConverter;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.core.type.classreading.CachingMetadataReaderFactory;
import org.springframework.core.type.classreading.MetadataReader;
import org.springframework.core.type.classreading.MetadataReaderFactory;
import org.springframework.util.ReflectionUtils;
import org.springframework.web.context.ContextLoader;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.*;


/**
 * BeanUtils的等价类，只是将check exception改为uncheck exception
 *
 * @author wulp
 */
public class BeanUtils {
    private static Logger logger = LoggerFactory.getLogger(BeanUtils.class);
    /**
     * BeanUtil类型转换器
     */
    private static ConvertUtilsBean convertUtilsBean = new ConvertUtilsBean();

    private static BeanUtilsBean beanUtilsBean = new BeanUtilsBean(convertUtilsBean, new PropertyUtilsBean());

    static {
        convertUtilsBean.register(new BeanDateConnverter(), Date.class);
        convertUtilsBean.register(new LongConverter(null), Long.class);
    }


    /**
     * 可以用于判断 Map,Collection,String,Array,Long是否为空
     *
     * @param o java.lang.Object.
     * @return boolean.
     */
    public static boolean isEmpty(Object o) {
        if (o == null) {
            return true;
        }
        if (o instanceof String) {
            return ((String) o).trim().length() == 0;
        } else if (o instanceof Collection) {
            return ((Collection) o).isEmpty();
        } else if (o.getClass().isArray()) {
            return ((Object[]) o).length == 0;
        } else if (o instanceof Map) {
            return ((Map) o).isEmpty();
        }
//		else if (o instanceof Long)
//		{
//			if(((Long)o)==null)
//			{
//				return true;
//			}
//		}
//		else if (o instanceof Short)
//		{
//			if(((Short)o)==null)
//			{
//				return true;
//			}
//		}
        else {
            return false;
        }

    }


    /**
     * 可以用于判断 Map,Collection,String,Array是否不为空
     *
     * @param o 判断对象
     * @return 返回是否匹配
     */
    public static boolean isNotEmpty(Object o) {
        return !isEmpty(o);
    }

    public static boolean isNotEmpty(Long o) {
        return !isEmpty(o);
    }


    /**
     * 判断是否为数字
     *
     * @param o 判断对象
     * @return 是否匹配成功
     */
    public static boolean isNumber(Object o) {
        if (o == null) {
            return false;
        }
        if (o instanceof Number) {
            return true;
        }
        if (o instanceof String) {
            try {
                Double.valueOf((String) o);
                return true;
            } catch (NumberFormatException e) {
                return false;
            }
        }
        return false;
    }


    /**
     * 封装
     *
     * @param map    map对象
     * @param entity 实体对象
     * @return 返回结果对象
     * @throws IllegalAccessException    异常错误
     * @throws InvocationTargetException 异常错误
     */
    public static Object populateEntity(Map map, Object entity) throws IllegalAccessException, InvocationTargetException {
        beanUtilsBean.populate(entity, map);
        return entity;
    }

    /**
     * 根据指定的类名判定指定的类是否存在。
     *
     * @param className
     * @return
     */
    public static boolean validClass(String className) {
        try {
            Class.forName(className);
            return true;
        } catch (ClassNotFoundException e) {
            return false;
        }
    }

    /**
     * 判定类是否继承自父类
     *
     * @param cls         子类
     * @param parentClass 父类
     * @return
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    public static boolean isInherit(Class cls, Class parentClass) {
        return parentClass.isAssignableFrom(cls);
    }

    /**
     * 克隆对象
     *
     * @param bean bean对象
     * @return 返回对象
     */
    public static Object cloneBean(Object bean) {
        try {
            return beanUtilsBean.cloneBean(bean);
        } catch (Exception e) {
            handleReflectionException(e);
            return null;
        }
    }

    /**
     * 获取bean
     *
     * @param cls
     * @return
     */
    public static Object getBean(Class cls) {
        ApplicationContext ctx = ContextLoader.getCurrentWebApplicationContext();
        return ctx.getBean(cls);
    }


    /**
     * 输入基类包名，扫描其下的类，返回类的全路径
     *
     * @param basePackages 如：com.platform
     * @return
     * @throws IllegalArgumentException
     */
    @SuppressWarnings("all")
    public static List<String> scanPackages(String basePackages) throws IllegalArgumentException {
        ResourcePatternResolver rl = new PathMatchingResourcePatternResolver();
        MetadataReaderFactory metadataReaderFactory = new CachingMetadataReaderFactory(rl);
        List result = new ArrayList();
        String[] arrayPackages = basePackages.split(",");
        try {
            for (int j = 0; j < arrayPackages.length; j++) {
                String packageToScan = arrayPackages[j];
                String packagePart = packageToScan.replace('.', '/');
                String classPattern = "classpath*:/" + packagePart + "/**/*.class";
                Resource[] resources = rl.getResources(classPattern);
                for (int i = 0; i < resources.length; i++) {
                    Resource resource = resources[i];
                    MetadataReader metadataReader = metadataReaderFactory.getMetadataReader(resource);
                    String className = metadataReader.getClassMetadata().getClassName();
                    result.add(className);
                }
            }
        } catch (Exception e) {
            new IllegalArgumentException("scan pakcage class error,pakcages:" + basePackages);
        }
        return result;
    }

    /**
     * 拷贝一个bean中的非空属性于另一个bean中
     *
     * @param dest
     * @param orig
     * @throws IllegalAccessException
     * @throws InvocationTargetException
     */
    public static void copyNotNullProperties(Object dest, Object orig) {
        // Validate existence of the specified beans
        if (dest == null) {
            logger.error("No destination bean specified");
            return;
        }
        if (orig == null) {
            logger.error("No origin bean specified");
            return;
        }

        try {
            // Copy the properties, converting as necessary
            if (orig instanceof DynaBean) {
                DynaProperty[] origDescriptors = ((DynaBean) orig).getDynaClass().getDynaProperties();
                for (DynaProperty origDescriptor : origDescriptors) {
                    String name = origDescriptor.getName();
                    if (beanUtilsBean.getPropertyUtils().isReadable(orig, name) && beanUtilsBean.getPropertyUtils().isWriteable(dest, name)) {
                        Object value = ((DynaBean) orig).get(name);
                        beanUtilsBean.copyProperty(dest, name, value);
                    }
                }
            } else if (orig instanceof Map) {
                for (Object o : ((Map) orig).entrySet()) {
                    Map.Entry entry = (Map.Entry) o;
                    String name = (String) entry.getKey();
                    Object value = entry.getValue();
                    if (value != null && beanUtilsBean.getPropertyUtils().isWriteable(dest, name)) {
                        try {
                            beanUtilsBean.copyProperty(dest, name, entry.getValue());
                        } catch (Exception e) {
                            LogUtils.error(e.getMessage());
                        }
                    }
                }
            } else /* if (orig is a standard JavaBean) */ {
                PropertyDescriptor[] origDescriptors = beanUtilsBean.getPropertyUtils().getPropertyDescriptors(orig);
                for (PropertyDescriptor origDescriptor : origDescriptors) {
                    String name = origDescriptor.getName();
                    if ("class".equals(name)) {
                        continue; // No point in trying to set an object's class
                    }
                    if (beanUtilsBean.getPropertyUtils().isReadable(orig, name) && beanUtilsBean.getPropertyUtils().isWriteable(dest, name)) {
                        try {
                            Object value = beanUtilsBean.getPropertyUtils().getSimpleProperty(orig, name);
                            if (value != null) {
                                beanUtilsBean.copyProperty(dest, name, value);
                            }
                        } catch (NoSuchMethodException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        } catch (Exception ex) {
            handleReflectionException(ex);
        }
    }

    @SuppressWarnings("unchecked")
    public static <T> T copyProperties(Class<T> destClass, Object orig) {
        Object target;
        try {
            target = destClass.newInstance();
            copyProperties((Object) target, orig);
            return (T) target;
        } catch (Exception e) {
            handleReflectionException(e);
            return null;
        }
    }

    public static void copyProperties(Object dest, Object orig) {
        try {
            if (orig instanceof DynaBean || orig instanceof Map) {
                copyNotNullProperties(dest, orig);
            } else {
                org.springframework.beans.BeanUtils.copyProperties(orig, dest);
            }
        } catch (Exception e) {
            handleReflectionException(e);
        }
    }

    public static void copyProperty(Object bean, String name, Object value) {
        try {
            beanUtilsBean.copyProperty(bean, name, value);
        } catch (Exception e) {
            handleReflectionException(e);
        }
    }

    public static Map<String, Object> transBean2Map(Object obj) {
        if (obj == null) {
            return null;
        }

        Map<String, Object> map = new HashMap<>();
        try {
            BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
            for (PropertyDescriptor property : propertyDescriptors) {
                String key = property.getName();
                // 过滤class属性
                if (!"class".equals(key)) {
                    // 得到property对应的getter方法
                    Method getter = property.getReadMethod();
                    Object value = getter.invoke(obj);
                    map.put(key, value);
                }
            }
        } catch (Exception e) {
            logger.error("transBean2Map Error " + e);
        }
        return map;
    }

    @SuppressWarnings("unchecked")
    public static Map describe(Object bean) {
        try {
            return beanUtilsBean.describe(bean);
        } catch (Exception e) {
            handleReflectionException(e);
            return null;
        }
    }

    public static String[] getArrayProperty(Object bean, String name) {
        try {
            return beanUtilsBean.getArrayProperty(bean, name);
        } catch (Exception e) {
            handleReflectionException(e);
            return null;
        }
    }

    public static ConvertUtilsBean getConvertUtils() {
        return beanUtilsBean.getConvertUtils();
    }

    public static String getIndexedProperty(Object bean, String name, int index) {
        try {
            return beanUtilsBean.getIndexedProperty(bean, name, index);
        } catch (Exception e) {
            handleReflectionException(e);
            return null;
        }
    }

    public static String getIndexedProperty(Object bean, String name) {
        try {
            return beanUtilsBean.getIndexedProperty(bean, name);
        } catch (Exception e) {
            handleReflectionException(e);
            return null;
        }
    }

    public static String getMappedProperty(Object bean, String name, String key) {
        try {
            return beanUtilsBean.getMappedProperty(bean, name, key);
        } catch (Exception e) {
            handleReflectionException(e);
            return null;
        }
    }

    public static String getMappedProperty(Object bean, String name) {
        try {
            return beanUtilsBean.getMappedProperty(bean, name);
        } catch (Exception e) {
            handleReflectionException(e);
            return null;
        }
    }

    public static String getNestedProperty(Object bean, String name) {
        try {
            return beanUtilsBean.getNestedProperty(bean, name);
        } catch (Exception e) {
            handleReflectionException(e);
            return null;
        }
    }

    public static String getProperty(Object bean, String name) {
        try {
            return beanUtilsBean.getProperty(bean, name);
        } catch (Exception e) {
            handleReflectionException(e);
            return null;
        }
    }

    public static PropertyUtilsBean getPropertyUtils() {
        try {
            return beanUtilsBean.getPropertyUtils();
        } catch (Exception e) {
            handleReflectionException(e);
            return null;
        }
    }

    public static String getSimpleProperty(Object bean, String name) {
        try {
            return beanUtilsBean.getSimpleProperty(bean, name);
        } catch (Exception e) {
            handleReflectionException(e);
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    public static void populate(Object bean, Map properties) {
        try {
            beanUtilsBean.populate(bean, properties);
        } catch (Exception e) {
            handleReflectionException(e);
        }
    }

    public static void setProperty(Object bean, String name, Object value) {
        try {
            beanUtilsBean.setProperty(bean, name, value);
        } catch (Exception e) {
            handleReflectionException(e);
        }
    }

    private static void handleReflectionException(Exception e) {
        ReflectionUtils.handleReflectionException(e);
    }

    public static String getObjVal(Object obj, String field) {
        if (BeanUtils.isEmpty(obj) || StringUtils.isBlank(field)) {
            return null;
        }

        Set<Class<?>> clazzSet = new HashSet<>(Arrays.asList(obj.getClass().getInterfaces()));
        if (clazzSet.contains(Map.class)) {
            return ((Map<String, String>) obj).get(field);
        } else {
            return BeanUtils.getProperty(obj, field);
        }
    }

    public static void setObjVal(Object obj, String field, String value) {
        if (BeanUtils.isEmpty(obj) || StringUtils.isBlank(field)) {
            return;
        }

        Set<Class<?>> clazzSet = new HashSet<>(Arrays.asList(obj.getClass().getInterfaces()));
        if (clazzSet.contains(Map.class)) {
            ((Map) obj).put(field, value);
        } else {
            BeanUtils.setProperty(obj, field, value);
        }
    }
}
