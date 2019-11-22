/*
 * Copyright (c) 2015-2018 SHENZHEN TOMTOP SCIENCE AND TECHNOLOGY DEVELOP CO., LTD. All rights reserved.
 *
 * 注意：本内容仅限于深圳市通拓科技研发有限公司内部传阅，禁止外泄以及用于其他的商业目的 
 */
package com.dhc.fastersoft.entity;

import com.dhc.fastersoft.utils.excel.AbstractVerifyBuidler;
import com.dhc.fastersoft.utils.excel.CellVerifyEntity;
import com.dhc.fastersoft.utils.excel.IntegerVerify;
import com.dhc.fastersoft.utils.excel.StringVerify;

/**
 * 导入用户校验类
 * @author Administrator
 *
 */
public class TestVerifyBuilder extends AbstractVerifyBuidler {

	private static TestVerifyBuilder builder = new TestVerifyBuilder();

	public static TestVerifyBuilder getInstance() {
		return builder;
	}

	/**
	 * 定义列校验实体：提取的字段、提取列、校验规则
	 */
	private TestVerifyBuilder() {
		cellEntitys.add(new CellVerifyEntity("name", "A", new StringVerify("姓名", true)));
		cellEntitys.add(new CellVerifyEntity("age", "B", new IntegerVerify("年龄", true)));
		cellEntitys.add(new CellVerifyEntity("note", "D", new StringVerify("备注", true)));
//		cellEntitys.add(new CellVerifyEntity("note", "D", new StringToIntegerVerify("枚举",
//				new AbstractCellValueVerify() {
//					@Override
//					public Object verify(Object fileValue) {
//						// TODO 转换：从excel中得到string转成需要的integer
//						return 1;
//					}
//				}, true)));
//		cellEntitys.add(new CellVerifyEntity("date", "F", new DateTimeVerify("创建日期", "yyyy/MM/dd",
//				true)));

		// 必须调用
		super.init();
	}
}
