package com.dhc.fastersoft.service;

import com.dhc.fastersoft.entity.CustomerInformation;
import com.dhc.fastersoft.utils.LayPage;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;


public interface CustomerInformationService {


	LayPage<CustomerInformation> importExcel(List<CustomerInformation> list) throws Exception;

	int add(CustomerInformation customer);

	int update(CustomerInformation customer);

	List query(HttpServletRequest request);

	CustomerInformation getCIById(String id);

	CustomerInformation getClientInfoByName(String clientName);
	int delete(String id);

	int inblacklist(String id);

	int outblacklist(String id);

	LayPage<CustomerInformation> list(HttpServletRequest request);

	List<CustomerInformation> listEcharts(HttpServletRequest request);

	List<CustomerInformation> listCustomer(HashMap<String, String> map);
	
	int checkIsAdd(String socialCreditCode);

	List<String> clientNameList();
	
	String getClientIdByName(String clientName);
}
