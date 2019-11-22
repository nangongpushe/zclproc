package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.CustomerInformationMapper;
import com.dhc.fastersoft.entity.CustomerInformation;
import com.dhc.fastersoft.exception.ImportException;
import com.dhc.fastersoft.service.CustomerInformationService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.StringUtil;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service("customerInformationService")
public class CustomerInformationServiceimpl implements CustomerInformationService {
	@Autowired
	public CustomerInformationMapper dao;
	
	public String checkMseeage(CustomerInformation entity){
		String str="";
		String clientName = entity.getClientName();
		if (clientName==""||clientName==null) {
			if (str=="") {
				str+="客户名称为必填字段不能为空";
			}else {
				str+=",  客户名称为必填字段不能为空";
			}
		} 
		String clientType = entity.getClientType();
		if (clientType==""||clientType==null) {
			if (str=="") {
				str+="客户分类为必填字段不能为空";
			}else {
				str+=",  客户分类为必填字段不能为空";
			}
		} 
		String organizationCode = entity.getOrganizationCode();
		if (organizationCode==""||organizationCode==null) {
			if (str=="") {
				str+="组织机构代码为必填字段不能为空";
			}else {
				str+=",  组织机构代码为必填字段不能为空";
			}
		} 
		String socialCreditCode = entity.getSocialCreditCode();
		if (socialCreditCode==""||socialCreditCode==null) {
			if (str=="") {
				str+="统一社会信用代码为必填字段不能为空";
			}else {
				str+=",  统一社会信用代码为必填字段不能为空";
			}
			
		}else{
			int  clientCount=checkIsAdd(socialCreditCode);

			if(clientCount>0){
				str+="统一社会信用代码已存在,不可重复添加";
			}
		}
		String enterpriseNature = entity.getEnterpriseNature();
		if (enterpriseNature==""||enterpriseNature==null) {
			if (str=="") {
				str+="企业性质为必填字段不能为空";
			}else {
				str+=",  企业性质为必填字段不能为空";
			}
		} 
		String registType = entity.getRegistType();
		if (registType==""||registType==null) {
			if (str=="") {
				str+="登记注册类型为必填字段不能为空";
			}else {
				str+=",  登记注册类型为必填字段不能为空";
			}
		} 
		String businessNo = entity.getBusinessNo();
		if (businessNo==""||businessNo==null) {
			if (str=="") {
				str+="工商登记注册号为必填字段不能为空";
			}else {
				str+=",  工商登记注册号为必填字段不能为空";
			}
		} 
		String extraQualification = entity.getExtraQualification();
		if (extraQualification==""||extraQualification==null) {
			if (str=="") {
				str+="是否具备代储资格为必填字段不能为空";
			}else {
				str+=",  是否具备代储资格为必填字段不能为空";
			}
		} 
		String province = entity.getProvince();
		if (province==""||province==null) {
			if (str=="") {
				str+="省为必填字段不能为空";
			}else {
				str+=",  省为必填字段不能为空";
			}
		} 
		String provinceCode = entity.getProvinceCode();
		if (provinceCode==""||provinceCode==null) {
			if (str=="") {
				str+="省代码为必填字段不能为空";
			}else {
				str+=",  省代码为必填字段不能为空";
			}
		} 
		String city = entity.getCity();
		if (city==""||city==null) {
			if (str=="") {
				str+="市为必填字段不能为空";
			}else {
				str+=",  市为必填字段不能为空";
			}
		} 
		String cityCode = entity.getCityCode();
		if (cityCode==""||cityCode==null) {
			if (str=="") {
				str+="市代码为必填字段不能为空";
			}else {
				str+=",  市代码为必填字段不能为空";
			}
		} 
		String area = entity.getArea();
		if (area==""||area==null) {
			if (str=="") {
				str+="区为必填字段不能为空";
			}else {
				str+=",  区为必填字段不能为空";
			}
		} 
		String areaCode = entity.getAreaCode();
		if (areaCode==""||areaCode==null) {
			if (str=="") {
				str+="区代码为必填字段不能为空";
			}else {
				str+=",  区代码为必填字段不能为空";
			}
		} 
		String postalcode = entity.getPostalcode();
		if (postalcode==""||postalcode==null) {
			if (str=="") {
				str+="企业邮政编码为必填字段不能为空";
			}else {
				str+=",  企业邮政编码为必填字段不能为空";
			}
		} 
		String personIncharge = entity.getPersonIncharge();
		if (personIncharge==""||personIncharge==null) {
			if (str=="") {
				str+="法定代表人为必填字段不能为空";
			}else {
				str+=",  法定代表人为必填字段不能为空";
			}
		} 
		String contactor = entity.getContactor();
		if (contactor==""||contactor==null) {
			if (str=="") {
				str+="联系人为必填字段不能为空";
			}else {
				str+=",  联系人为必填字段不能为空";
			}
		} 
		String contactTel = entity.getContactTel();
		if (contactTel==""||contactTel==null) {
			if (str=="") {
				str+="联系电话为必填字段不能为空";
			}else {
				str+=",  联系电话为必填字段不能为空";
			}
		} 
		String industry = entity.getIndustry();
		if (industry==""||industry==null) {
			if (str=="") {
				str+="从事行业为必填字段不能为空";
			}else {
				str+=",  从事行业为必填字段不能为空";
			}
		}else if (industry=="加工类") {
			String processVariety = entity.getProcessVariety();
			String processCapability = entity.getProcessCapability();
			if (processVariety==""||processVariety==null) {
				if (str=="") {
					str+="从事行业为(加工类)时加工品种为必填字段不能为空";
				}else {
					str+=",  从事行业为(加工类)时加工品种为必填字段不能为空";
				}
			}else if (processCapability==""||processCapability==null) {
				if (str=="") {
					str+="从事行业为(加工类)时加工能力为必填字段不能为空";
				}else {
					str+=",  从事行业为(加工类)时加工能力为必填字段不能为空";
				}
			}
			
		}
		
		String tel = entity.getTelephone();
		if (tel==""||tel==null) {
			if (str=="") {
				str+="企业电话为必填字段不能为空";
			}else {
				str+=",  企业电话为必填字段不能为空";
			}
		} 
		
		
		String addr = entity.getAddress();
		if (addr==""||addr==null) {
			if (str=="") {
				str+="企业地址为必填字段不能为空";
			}else {
				str+=",  企业地址为必填字段不能为空";
			}
		}
		return str;
	}

	public LayPage<CustomerInformation> importExcel(List<CustomerInformation> list) throws Exception {
		// TODO Auto-generated method stub
		LayPage<CustomerInformation> page=new LayPage<>();
		int i=0;
		int j=0;
		Pattern p = Pattern.compile("(\\d+)");
		for (CustomerInformation entity : list) {
		    if(checkObjectIsNull(entity)){
		        continue;
            }

			if(StringUtils.isEmpty(entity.getClientName())){
				throw new ImportException("客户名称不能为空");
			}

			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			String date = df.format(new Date());
			entity.setCreator(TokenManager.getNickname());
			entity.setCreateDate(date);
			entity.setCompany(TokenManager.getToken().getShortName());
			entity.setCreatorId(TokenManager.getSysUserId());

			if (StringUtils.isNotEmpty(entity.getEmployedNum())) {
				Matcher matcher = p.matcher(entity.getEmployedNum());
				while (matcher.find()) {
					entity.setEmployedNum(matcher.group());
					break;
				}
			}

			// 根据企业统一社会信用编码，或者用户名称查询
			Map<String, Object> params = new HashMap<>();
			params.put("clientName", entity.getClientName());
			params.put("socialCreditCode", entity.getSocialCreditCode());
			List<String> tempList = dao.getIdByClientNameOrsocialCreditCode(params);
			int changeNum = 0;
			if (tempList == null || tempList.size() == 0) {
				changeNum = dao.insert(entity);
			} else if (tempList.size() == 1) {
				entity.setId(tempList.get(0));
				changeNum = dao.update(entity);
			} else {
				throw new ImportException(entity.getClientName() + " " + entity.getSocialCreditCode() + " 查询到多条数据！");
			}

			i += changeNum;
		}
		page.setCount(i);
		page.setMsg("");
		return page;
	}

	private boolean checkObjectIsNull(Object obj){
	    if(obj == null)
	        return true;

	    try{
	        for(Field field: obj.getClass().getDeclaredFields()){
                field.setAccessible(true);
                if(field.get(obj) != null && StringUtils.isNotBlank(field.get(obj).toString()))
                    return false;
            }
        }catch (Exception e){
	        e.printStackTrace();
        }
        return true;
    }

	public int add(CustomerInformation customer) {
		// TODO Auto-generated method stub
		return dao.insert(customer);
	}

	public int update(CustomerInformation customer) {
		// TODO Auto-generated method stub
		return dao.update(customer);
	}

	public CustomerInformation getCIById(String id) {
		return dao.getCIById(id);
	}

	public CustomerInformation getClientInfoByName(String clientName) {
		return dao.getClientInfoByName(clientName);
	}
	public List<CustomerInformation> query(HttpServletRequest request) {
		LayPage<CustomerInformation> page=new LayPage<>();
        HashMap<String,String> map = QueryUtil.pageQuery(request);
        String clientName;
		String enterpriseNature;
		String industry;
		String blacklist;
		try {
			clientName = new String(request.getParameter("clientName").getBytes("iso-8859-1"),"utf-8").toString();
			enterpriseNature = new String(request.getParameter("enterpriseNature").getBytes("iso-8859-1"),"utf-8").toString();
			industry = new String(request.getParameter("industry").getBytes("iso-8859-1"),"utf-8").toString();
			blacklist = new String(request.getParameter("blacklist").getBytes("iso-8859-1"),"utf-8").toString();
			map.put("clientName", clientName);
			map.put("enterpriseNature", enterpriseNature);
			map.put("industry", industry);
			map.put("blacklist", blacklist);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dao.query(map);
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return dao.delete(id);
	}

	@Override
	public int inblacklist(String ids) {
		// TODO Auto-generated method stub
		String id[]=ids.split("-");
		int i;
		for ( i = 0; i < id.length; i++) {
			dao.inblacklist(id[i]);
		}
		return i;
	}

	@Override
	public int outblacklist(String ids) {
		// TODO Auto-generated method stub
		String id[]=ids.split("-");
		int i;
		for ( i = 0; i < id.length; i++) {
			dao.outblacklist(id[i]);
		}
		return i;
	}

	@Override
	public LayPage<CustomerInformation> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<CustomerInformation> page=new LayPage<>();
        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        String clientName=request.getParameter("clientName");
        String enterpriseNature=request.getParameter("enterpriseNature");
        String industry=request.getParameter("industry");
        String blacklist=request.getParameter("blacklist");
        map.put("clientName", clientName);
        map.put("enterpriseNature", enterpriseNature);
        map.put("industry", industry);
        map.put("blacklist", blacklist);
        int count=dao.count(map);
        if (count<=0) {
			return page;
		}
        List<CustomerInformation> data=dao.list(map);
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}

	@Override
	public List<CustomerInformation> listEcharts(HttpServletRequest request) {
		// TODO Auto-generated method stub
		HashMap<String,String> map = QueryUtil.pageQuery(request);
		String industry=request.getParameter("industry");
		map.put("industry", industry);
		return dao.listEcharts(map);
	}

	@Override
	public List<CustomerInformation> listCustomer(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return dao.list(map);
	}

	@Override
	public int checkIsAdd(String socialCreditCode){
		return dao.checkIsAdd(socialCreditCode);
	}

	@Override
	public List<String> clientNameList() {
		return dao.clientNameList();
	}

	@Override
	public String getClientIdByName(String clientName) {

		return dao.getClientIdByName(clientName);
	}
}
