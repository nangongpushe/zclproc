package com.dhc.fastersoft.entity;

import com.dhc.fastersoft.utils.excel.AbstractVerifyBuidler;
import com.dhc.fastersoft.utils.excel.CellVerifyEntity;
import com.dhc.fastersoft.utils.excel.POIConstant;
import com.dhc.fastersoft.utils.excel.StringVerify;

public class QualitySampleVerifyBuilder extends AbstractVerifyBuidler{
	private static QualitySampleVerifyBuilder builder=new QualitySampleVerifyBuilder();
	public static  QualitySampleVerifyBuilder getInstance(){
		return builder;
	}
	/**
	 * 定义列校验实体：提取的字段、提取列、校验规则
	 */
	private QualitySampleVerifyBuilder(){
		cellEntitys.add(new CellVerifyEntity("sampleNo", "A", new StringVerify("样品编号", true)));
		cellEntitys.add(new CellVerifyEntity("sampleName", "B", new StringVerify("样品名称", true)));
		cellEntitys.add(new CellVerifyEntity("storehouse", "C", new StringVerify("仓/罐号", true)));
		cellEntitys.add(new CellVerifyEntity("variety", "D", new StringVerify("粮食品种", true)));
		cellEntitys.add(new CellVerifyEntity("harvestYear", "E", new StringVerify("收获年份", true)));
		cellEntitys.add(new CellVerifyEntity("origin", "F", new StringVerify("产地", true)));
		cellEntitys.add(new CellVerifyEntity("samplingDate", "G", new StringVerify("扦样日期", true)));
		cellEntitys.add(new CellVerifyEntity("samplingPeople", "H", new StringVerify("扦样人", true)));
		cellEntitys.add(new CellVerifyEntity("testPeople", "I", new StringVerify("检验人", true)));
		cellEntitys.add(new CellVerifyEntity("testDate", "J", new StringVerify("检验时间", true)));
		cellEntitys.add(new CellVerifyEntity("statusValue", "K", new StringVerify("样品状态", true)));
		
		// 必须调用
		super.init();
	}
}
