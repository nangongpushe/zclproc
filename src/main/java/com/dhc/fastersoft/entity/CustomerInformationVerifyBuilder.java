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
public class CustomerInformationVerifyBuilder extends AbstractVerifyBuidler{
	private static CustomerInformationVerifyBuilder builder=new CustomerInformationVerifyBuilder();
	public static CustomerInformationVerifyBuilder getInstance() {
		return builder;
	}
	/**
	 * 定义列校验实体：提取的字段、提取列、校验规则
	 */
	private CustomerInformationVerifyBuilder() {
		/*cellEntitys.add(new CellVerifyEntity("clientName", "A", new StringVerify("企业名称", true)));
		cellEntitys.add(new CellVerifyEntity("socialCreditCode", "B", new StringVerify("企业统一社会信用代码", true)));
		cellEntitys.add(new CellVerifyEntity("organizationCode", "C", new StringVerify("企业注册号", true)));
		cellEntitys.add(new CellVerifyEntity("registType", "D", new StringVerify("登记注册类型", true)));
		cellEntitys.add(new CellVerifyEntity("extraQualification", "E", new StringVerify("是否具备储备粮代储资格", true)));
		cellEntitys.add(new CellVerifyEntity("personIncharge", "F", new StringVerify("法定代表人", true)));
		cellEntitys.add(new CellVerifyEntity("telephone", "G", new StringVerify("企业电话", true)));
		cellEntitys.add(new CellVerifyEntity("contactor", "H", new StringVerify("企业联系人", true)));
		cellEntitys.add(new CellVerifyEntity("employedNum", "I", new StringVerify("企业从事人员数", true)));
		
		*/
		
		cellEntitys.add(new CellVerifyEntity("clientName", "A", new StringVerify("*客户名称", true)));
		cellEntitys.add(new CellVerifyEntity("clientType", "B", new StringVerify("*客户分类", true)));
		cellEntitys.add(new CellVerifyEntity("organizationCode", "C", new StringVerify("*组织机构代码", true)));
		cellEntitys.add(new CellVerifyEntity("socialCreditCode", "D", new StringVerify("*统一社会信用代码", true)));
		cellEntitys.add(new CellVerifyEntity("enterpriseNature", "E", new StringVerify("*企业性质", true)));
		cellEntitys.add(new CellVerifyEntity("registType", "F", new StringVerify("*登记注册类型", true)));
		cellEntitys.add(new CellVerifyEntity("businessNo", "G", new StringVerify("*工商登记注册号", true)));
		cellEntitys.add(new CellVerifyEntity("extraQualification", "H", new StringVerify("*是否具备代储资格", true)));
		cellEntitys.add(new CellVerifyEntity("province", "I", new StringVerify("*省", true)));
		cellEntitys.add(new CellVerifyEntity("provinceCode", "J", new StringVerify("*省代码", true)));
		cellEntitys.add(new CellVerifyEntity("city", "K", new StringVerify("*市", true)));
		cellEntitys.add(new CellVerifyEntity("cityCode", "L", new StringVerify("*市代码", true)));
		cellEntitys.add(new CellVerifyEntity("area", "M", new StringVerify("*区", true)));
		cellEntitys.add(new CellVerifyEntity("areaCode", "N", new StringVerify("*区代码", true)));
		cellEntitys.add(new CellVerifyEntity("postalcode", "O", new StringVerify("*企业邮政编码", true)));
		cellEntitys.add(new CellVerifyEntity("personIncharge", "P", new StringVerify("*法定代表人", true)));
		cellEntitys.add(new CellVerifyEntity("contactor", "Q", new StringVerify("*联系人", true)));
		cellEntitys.add(new CellVerifyEntity("contactTel", "R", new StringVerify("*联系电话", true)));
		cellEntitys.add(new CellVerifyEntity("industry", "S", new StringVerify("*从事行业", true)));
		
		cellEntitys.add(new CellVerifyEntity("processVariety", "T", new StringVerify("加工品种", true)));
		cellEntitys.add(new CellVerifyEntity("processCapability", "U", new StringVerify("加工能力", true)));
		cellEntitys.add(new CellVerifyEntity("contactFax", "V", new StringVerify("企业传真", true)));
		cellEntitys.add(new CellVerifyEntity("invoiceTitle", "W", new StringVerify("发票抬头", true)));
		cellEntitys.add(new CellVerifyEntity("taxId", "X", new StringVerify("发票税号", true)));
		cellEntitys.add(new CellVerifyEntity("depositBank", "Y", new StringVerify("开户行", true)));
		cellEntitys.add(new CellVerifyEntity("depositAccount", "Z", new StringVerify("开户账号", true)));
		cellEntitys.add(new CellVerifyEntity("telephone", "AA", new StringVerify("*企业电话", true)));
		cellEntitys.add(new CellVerifyEntity("address", "AB", new StringVerify("*企业地址", true)));
		cellEntitys.add(new CellVerifyEntity("bankCreditRating", "AC", new StringVerify("银行信用等级", true)));
		cellEntitys.add(new CellVerifyEntity("fixedAssets", "AD", new StringVerify("固定资产", true)));
		cellEntitys.add(new CellVerifyEntity("registeredCapital", "AE", new StringVerify("注册资本", true)));
		cellEntitys.add(new CellVerifyEntity("employedNum", "AF", new StringVerify("从业人员数", true)));
		cellEntitys.add(new CellVerifyEntity("remark", "AG", new StringVerify("备注", true)));
		
		// 必须调用
		super.init();
	}
}
