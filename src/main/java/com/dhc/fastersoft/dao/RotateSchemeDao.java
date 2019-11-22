package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.CommitAndUndeal;
import com.dhc.fastersoft.entity.RotateScheme;
import com.dhc.fastersoft.entity.RotateSchemeDetail;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.PageUtil;

import java.math.BigDecimal;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public interface RotateSchemeDao {
	List<RotateScheme> LisLimitScheme(PageUtil<RotateScheme> pageConfig);
	int GetTotcalCount(PageUtil<RotateScheme> pageConfig);
	void CreateScheme(RotateScheme scheme);
	void UpdateScheme(RotateScheme scheme);
	RotateScheme GetSchemeInfo(String schemeId);
	List<RotateScheme> ListChildScheme(String originId);

	List<RotateScheme> listScheme(HashMap<String, String> map);
	List<RotateSchemeDetail> listDetail(HashMap<String, String> map);

	List<RotateSchemeDetail> getSchemeDetailByCondition(HashMap<String, String> map);
	int countDetail(HashMap<String, String> map);
	int updateState(HashMap<String, Object> map);
	int updateStateOfDetail(HashMap<String, String> map);
	String getSchemeIdByDetailId(String detailId);
	String getDetailBatchById(String id);
	String getSchemeName(String id);
	RotateSchemeDetail getSchemeDetailByDetailId(String id);
	Set<String> ListSchemeIDBase(List baseNames);
	List<RotateScheme> ListSchemeByBase(PageUtil pageUtil);
	int GetCountByBase(PageUtil pageUtil);
	BigDecimal PlanTotalCount(String detailId);

	List<CommitAndUndeal> unDealTotalCountByPlanDetailId(String detailId);
	void DeleteData(Map tableMap);
	int count(HashMap<String, Object> maps);
	//子方案列表
	int count1(HashMap<String, Object> maps);
	List<RotateSchemeDetail> listRotateScheme(HashMap<String, Object> map);

	RotateSchemeDetail getMainPlanDetailBySchemeId(Map<String,Object> getMainPlanDetailCondition);

	RotateSchemeDetail getPlanDetailBySchemeId(Map<String,Object> getMainPlanDetailCondition);

	LayPage<RotateScheme> list(HttpServletRequest request);
}
