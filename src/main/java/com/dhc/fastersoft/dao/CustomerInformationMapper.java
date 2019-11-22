package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.entity.CustomerInformation;
import com.dhc.fastersoft.entity.QualityResult;
import com.dhc.fastersoft.utils.LayPage;

public interface CustomerInformationMapper {
    int insert(CustomerInformation record);

    int insertSelective(CustomerInformation record);
    
    int getRecordCount(HashMap<String, String> maps);
    
    List<PageList> pageQuery(HashMap<String, String> map);

	int update(CustomerInformation customer);

	CustomerInformation getCIById(@Param("id")String id);


	List<CustomerInformation> query(HashMap<String, String> map);
	
	int delete(@Param("id")String id);

	int inblacklist(@Param("id")String id);

	int outblacklist(@Param("id")String id);
	
	int checkIsAdd(@Param("socialCreditCode")String socialCreditCode);

	int count(HashMap<String, String> map);

	List<String> clientNameList();

	List<CustomerInformation> list(HashMap<String, String> map);

	List<CustomerInformation> listEcharts(HashMap<String, String> map);

	String getClientIdByName(String clientName);

	CustomerInformation getClientInfoByName(String clientName);

	List<String> getIdByClientNameOrsocialCreditCode(Map<String, Object> params);
}