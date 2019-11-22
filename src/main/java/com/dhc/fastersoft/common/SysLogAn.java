package com.dhc.fastersoft.common;

import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@Documented
public @interface SysLogAn {
    // 默认验证
    String value();

}