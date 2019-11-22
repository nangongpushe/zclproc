package com.dhc.fastersoft.service;

import com.dhc.fastersoft.entity.RotateScheme;
import com.dhc.fastersoft.entity.RotateSchemeDetail;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.PageUtil;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public interface RotateSchemeService {
	
	int PLAN = 1;
	int SCHEME = 2;
	
	String WAITSUBMIT = "待提交";
	String OA = "OA审核中";
	String AUDITING = "审核中";
	String DOING = "进行中";
	String COMPLETE = "已完成";
	
	List<RotateScheme> LisLimitScheme(PageUtil<RotateScheme> pageConfig);
	int GetTotcalCount(PageUtil<RotateScheme> pageConfig);
	String SaveScheme(RotateScheme scheme);
	boolean UpdateScheme(RotateScheme scheme);
	boolean EditScheme(RotateScheme scheme);
	RotateScheme GetSchemeInfo(String schemeId);
	List<RotateScheme> ListChildScheme(String originId);
	List<RotateScheme> listScheme(HashMap<String, String> map);
	List<RotateSchemeDetail> listDetail(HashMap<String, String> map);

	List<RotateSchemeDetail> getSchemeDetailByCondition(HashMap<String, String> map);
	int countDetail(HashMap<String, String> map);
	PageUtil<RotateSchemeDetail> listDetailPagination(HashMap<String, String> map);
	void DeleteData(Map tableMap);
	
	int updateState(String id,String state);
	
	int updateStateOfDetail(String dId,String status);
	
	String getSchemeIdByDetailId(String detailId);
	
	List<RotateSchemeDetail> listDetail(String schemeId);
	
	String getDetailBatchById(String id);
	
	
	/**
	 * 获取明细包含baseNames库的所有方案ID
	 * @param baseNames 库点名称列表
	 * @return 方案ID Set
	 */
	Set<String> ListSchemeIDBase(List baseNames);
	BigDecimal PlanTotalCount(String detailId);
	BigDecimal unDealTotalCountByPlanDetailId(String detailId);
	List<RotateScheme> ListSchemeByBase(PageUtil pageUtil);
	int count(HashMap<String, Object> map);

	RotateSchemeDetail getSchemeDetailByDetailId(String detailId);

	String getSchemeNameById(String schemeId);

	LayPage<RotateSchemeDetail> list(HttpServletRequest request);

}
