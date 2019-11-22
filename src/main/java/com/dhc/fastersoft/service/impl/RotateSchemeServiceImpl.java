package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.QualityResultMapper;
import com.dhc.fastersoft.dao.QualitySampleMapper;
import com.dhc.fastersoft.dao.RotatePlanDao;
import com.dhc.fastersoft.dao.RotateSchemeDao;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.service.RotateSchemeService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.PageUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.*;

@Service("RotateSchemeService")
public class RotateSchemeServiceImpl implements RotateSchemeService {

	@Autowired
	private RotateSchemeDao rotateSchemeDao;
	@Autowired
	private RotatePlanDao rotatePlanDao;
	@Autowired
	public QualitySampleMapper qualitySampleMapper;
	@Autowired
	public QualityResultMapper qualityResultMapper;
	public RotateSchemeDao getRotateSchemeDao() {
		return rotateSchemeDao;
	}
	public void setRotateSchemeDao(RotateSchemeDao rotateSchemeDao) {
		this.rotateSchemeDao = rotateSchemeDao;
	}

	@Override
	public String SaveScheme(RotateScheme scheme) {
		scheme.setId(UUID.randomUUID().toString().replace("-", ""));
		rotateSchemeDao.CreateScheme(scheme);
		return scheme.getId();
	}
	
	@Override
	public boolean EditScheme(RotateScheme scheme) {
		rotateSchemeDao.UpdateScheme(scheme);
		return false;
	}

	@Override
	public List<RotateScheme> LisLimitScheme(PageUtil<RotateScheme> pageUtil) {
		pageUtil.setTotalCount(rotateSchemeDao.GetTotcalCount(pageUtil));
		return rotateSchemeDao.LisLimitScheme(pageUtil);
	}

	@Override
	public int GetTotcalCount(PageUtil<RotateScheme> pageConfig) {
		return rotateSchemeDao.GetTotcalCount(pageConfig);
	}
	@Override
	public RotateScheme GetSchemeInfo(String schemeId) {
		RotateScheme rotateScheme = rotateSchemeDao.GetSchemeInfo(schemeId);
		//客户要导出出库质检信息
		List<RotateSchemeDetail>  rotateSchemeDetails = rotateScheme.getSchemeDetail();
		for(int i=0;i<rotateSchemeDetails.size();i++){
		    BigDecimal qualityResultNum = new BigDecimal(0);//质检个数
			RotateSchemeDetail rotateSchemeDetail = rotateSchemeDetails.get(i);
			String planDetailId = rotateSchemeDetails.get(i).getPlanDetailId();
			RotatePlanDetail rotatePlanDetail = rotatePlanDao.getPlanDetail(planDetailId);
			//计算质检个数，且set
            countQualityResultNum(rotateSchemeDetail,rotatePlanDetail,qualityResultNum);
			//计算剩余计划数量,且set
            countRestPlanNum(rotateSchemeDetail,rotatePlanDetail);
            if(null != rotatePlanDetail){
				String dealSerial = null;	// 成交明细号
				dealSerial = rotatePlanDetail.getDealSerial();
				if(StringUtils.isNotEmpty(dealSerial)){
					String storehouse = rotateSchemeDetail.getBranNumber();//出库质检需要根据仓号带出
					storehouse = org.apache.commons.lang.StringUtils.deleteWhitespace(storehouse);
					Map<String,Object> paramSample = new HashMap<>();
					paramSample.put("dealSerial", dealSerial);
					if("出库".equals(rotateSchemeDetail.getSchemeType())) {
						paramSample.put("validType", "出库质检");
						paramSample.put("storehouse", storehouse);
						paramSample.put("sort", "DESC");
					}else if("入库".equals(rotateSchemeDetail.getSchemeType())){
						paramSample.put("sort", "ASC");
						paramSample.put("validType", "入库质检");
					}
					String sampleNo = qualitySampleMapper.getQualityInfo(paramSample);
					Map<String,Object> param = new HashMap<>();
					if(StringUtils.isNotEmpty(sampleNo)) {
						if("出库".equals(rotateSchemeDetail.getSchemeType())) {
							param.put("sampleNo", sampleNo);
							param.put("validType", "出库质检");
						}else if("入库".equals(rotateSchemeDetail.getSchemeType())){
							param.put("sampleNo", sampleNo);
							param.put("validType", "入库质检");
						}
						List<QualityResult> qualityResult = qualityResultMapper.getResultBySampleNo(param);

						if(null != qualityResult && qualityResult.size()>0){
							//存储品质判定
							rotateSchemeDetail.setStoreJudeg(qualityResult.get(0).getStoreJudge());
							List<QualityResultItem> qualityResultItems = qualityResult.get(0).getQualityResultItems();
							if(null !=qualityResultItems && qualityResultItems.size()>0){
								//质量等级
								rotateSchemeDetail.setQualityGrade(qualityResultItems.get(0).getGrade());
							}
							for (int j = 0;j<qualityResultItems.size();j++){
								QualityResultItem qualityResultItem = qualityResultItems.get(j);
								if(qualityResultItem.getItemName().indexOf("出糙率")!=-1){
									rotateSchemeDetail.setBrown(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("容重")!=-1){
									rotateSchemeDetail.setUnitWeight(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().equals("杂质(%)")){
									rotateSchemeDetail.setImpurity(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().equals("水分(%)")){
									rotateSchemeDetail.setDew(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().equals("黄粒米(%)")){
									rotateSchemeDetail.setYellowRice(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().equals("不完善粒(%)")){
									rotateSchemeDetail.setUnsoundGrain(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("酸价")!=-1){
									rotateSchemeDetail.setKoh(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("过氧化值")!=-1){
									rotateSchemeDetail.setMmol(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("三唑磷")!=-1){
									rotateSchemeDetail.setTriazophos(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("不溶性杂质")!=-1){
									rotateSchemeDetail.setInsolubleImpurity(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("乐果")!=-1){
									rotateSchemeDetail.setRogor(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("亚油酸")!=-1){
									rotateSchemeDetail.setLinoleicAcid(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("亚麻酸")!=-1){
									rotateSchemeDetail.setLinolenicAcid(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("其中:矿物质")!=-1){
									rotateSchemeDetail.setMineral(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("加热试验")!=-1){
									rotateSchemeDetail.setHeat(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("品尝评分值")!=-1){
									rotateSchemeDetail.setTasteScore(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("总汞")!=-1){
									rotateSchemeDetail.setTotalArsenic(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("总砷")!=-1){
									rotateSchemeDetail.setTotalArsenic(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("整精米率")!=-1){
									rotateSchemeDetail.setPolishedRice(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("无机砷")!=-1){
									rotateSchemeDetail.setInorganicArsenic(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("杂质总量")!=-1){
									rotateSchemeDetail.setTotalImpurities(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("棕榈酸")!=-1){
									rotateSchemeDetail.setCetylicAcid(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("毒死蜱")!=-1){
									rotateSchemeDetail.setChlorpyrifos(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("比重")!=-1){
									rotateSchemeDetail.setProportion(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().equals("气味")){
									rotateSchemeDetail.setSmell(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("水分及挥发物")!=-1){
									rotateSchemeDetail.setDewVolatile(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("水胺硫磷")!=-1){
									rotateSchemeDetail.setIsocarbophos(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("汞(mg/kg)")!=-1){
									rotateSchemeDetail.setMercury(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().equals("油酸")){
									rotateSchemeDetail.setOleicAcid(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("溶剂残留量")!=-1){
									rotateSchemeDetail.setResidualSolvents(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("玉米赤霉烯酮")!=-1){
									rotateSchemeDetail.setZearalenone(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("硬度指数")!=-1){
									rotateSchemeDetail.setHardnessIndex(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("硬脂酸")!=-1){
									rotateSchemeDetail.setStearicAcid(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("脂肪酸值")!=-1){
									rotateSchemeDetail.setFatAcidity(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("脱氧雪腐镰刀菌烯醇")!=-1){
									rotateSchemeDetail.setDeoxynivalenol(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().equals("色泽")){
									rotateSchemeDetail.setColourOdor(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("芥酸")!=-1){
									rotateSchemeDetail.setErucicAcid(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("花生烯酸")!=-1){
									rotateSchemeDetail.setArachidonicAlkeneAcid(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("花生酸")!=-1){
									rotateSchemeDetail.setArachidonicAcid(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("谷外糙米")!=-1){
									rotateSchemeDetail.setOutBrownRice(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("铅")!=-1){
									rotateSchemeDetail.setLead(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("镉")!=-1){
									rotateSchemeDetail.setCadmium(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("面筋吸水量")!=-1){
									rotateSchemeDetail.setGlutenSoakage(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("马拉硫磷")!=-1){
									rotateSchemeDetail.setMalathion(qualityResultItem.getResult());
								}else if(qualityResultItem.getItemName().indexOf("黄曲霉毒素B1")!=-1){
									rotateSchemeDetail.setAflatoxinB1(qualityResultItem.getResult());
								}else if("气味、滋味".equals(qualityResultItem.getItemName())){
									rotateSchemeDetail.setSmellAndTaste(qualityResultItem.getResult());
								}
							}
						}
					}
				}
			}
		}
		return rotateScheme;
	}
	@Override
	public boolean UpdateScheme(RotateScheme scheme) {
		rotateSchemeDao.UpdateScheme(scheme);
		return false;
	}
	@Override
	public List<RotateScheme> ListChildScheme(String originId) {
		return rotateSchemeDao.ListChildScheme(originId);
	}
	
	@Override
	public List<RotateScheme> listScheme(HashMap<String, String> map) {
		// TODO Auto-generated method stub
//		HashMap<String, String> map = new HashMap<>();
//		map.put("schemeType", schemeType);
//		map.put("rotateType", rotateType);
		return rotateSchemeDao.listScheme(map);
	}

	@Override
	public List<RotateSchemeDetail> listDetail(HashMap<String, String> map) {
		List<RotateSchemeDetail> details = rotateSchemeDao.listDetail(map);
		for (RotateSchemeDetail detail:details) {
			detail.setMainSchemeName(rotateSchemeDao.getSchemeName(detail.getSchemeId()));
		}
		return details;
	}

	@Override
	public List<RotateSchemeDetail> getSchemeDetailByCondition(HashMap<String, String> map) {
		List<RotateSchemeDetail> details = rotateSchemeDao.getSchemeDetailByCondition(map);
		for (RotateSchemeDetail detail:details) {
			detail.setMainSchemeName(rotateSchemeDao.getSchemeName(detail.getSchemeId()));
		}
		return details;
	}
	@Override
	public PageUtil<RotateSchemeDetail> listDetailPagination(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		int total=rotateSchemeDao.countDetail(map);
		List<RotateSchemeDetail> schemeDetail=null;
		if(total>0)
			schemeDetail=rotateSchemeDao.listDetail(map);
		PageUtil<RotateSchemeDetail> pageUtil =new PageUtil<>();
		pageUtil.setPageIndex(Integer.parseInt(map.get("pageIndex")));
		pageUtil.setPageSize(Integer.parseInt(map.get("pageSize")));
		pageUtil.setResult(schemeDetail);
		pageUtil.setTotalCount(total);
		return pageUtil;
	}
	@Override
	public int countDetail(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return rotateSchemeDao.countDetail(map);
	}
	@Override
	public int updateState(String id,String state) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("state", state);
		if("已完成".equals(state)) {
			map.put("completeDate", new Date());
		}
		return rotateSchemeDao.updateState(map);
	}
	@Override
	public int updateStateOfDetail(String dId, String status) {
		// TODO Auto-generated method stub
		HashMap<String, String> map = new HashMap<>();
		map.put("dId", dId);
		map.put("status", status);
		return rotateSchemeDao.updateStateOfDetail(map);
	}
	@Override
	public String getSchemeIdByDetailId(String detailId) {
		// TODO Auto-generated method stub
		return rotateSchemeDao.getSchemeIdByDetailId(detailId);
	}
	@Override
	public List<RotateSchemeDetail> listDetail(String schemeId) {
		// TODO Auto-generated method stub
		HashMap<String, String> map = new HashMap<>();
		map.put("schemeId", schemeId);
		return rotateSchemeDao.listDetail(map);
	}
	@Override
	public String getDetailBatchById(String id) {
		// TODO Auto-generated method stub
		return rotateSchemeDao.getDetailBatchById(id);
	}
	@Override
	public void DeleteData(Map tableMap) {
		rotateSchemeDao.DeleteData(tableMap);
	}
	@Override
	public Set<String> ListSchemeIDBase(List baseNames) {
		return rotateSchemeDao.ListSchemeIDBase(baseNames);
	}
	@Override
	public List<RotateScheme> ListSchemeByBase(PageUtil pageUtil) {
		pageUtil.setTotalCount(rotateSchemeDao.GetCountByBase(pageUtil));
		return rotateSchemeDao.ListSchemeByBase(pageUtil);
	}
	@Override
	public BigDecimal PlanTotalCount(String detailId) {
		return rotateSchemeDao.PlanTotalCount(detailId);
	}
	@Override
	public BigDecimal unDealTotalCountByPlanDetailId(String detailId) {
		 List<CommitAndUndeal> commitAndUndeals = rotateSchemeDao.unDealTotalCountByPlanDetailId(detailId);
		 //BigDecimal commitBidNum = new BigDecimal(0);
		 //BigDecimal dealNum = new BigDecimal(0);
		 //BigDecimal undealSchemeDetailNum = new BigDecimal(0);
		//未成交的计划详情数量
		 BigDecimal undealPlanDetailTotal = new BigDecimal(0);
		 if(null != commitAndUndeals &&commitAndUndeals.size()>0){
		 	for(int i = 0;i<commitAndUndeals.size();i++){
				if(null == commitAndUndeals.get(i).getIsEnd() || "0".equals(commitAndUndeals.get(i).getIsEnd())){
					//如果是未终结的子方案，则计算出该子方案对应的标的物对应的招标结果已提交且未成交的数量
					BigDecimal commitBidNum = commitAndUndeals.get(i).getCommitBidNum();
					BigDecimal dealNum = commitAndUndeals.get(i).getDealNum();
					BigDecimal undealSchemeDetailNum =  commitBidNum.subtract(dealNum);
					undealPlanDetailTotal = undealPlanDetailTotal.add(undealSchemeDetailNum);
				}else if("1".equals(commitAndUndeals.get(i).getIsEnd())){
					//如果是终结的子方案，则计算出该子方案未成交的数量
					BigDecimal undealSchemeDetailNum = commitAndUndeals.get(i).getRotateNum().subtract(commitAndUndeals.get(i).getDealNum());
					undealPlanDetailTotal = undealPlanDetailTotal.add(undealSchemeDetailNum);
				}
		 	}
		 }
		 //BigDecimal commitAndUnDealNum = commitBidNum.subtract(dealNum);
		 return undealPlanDetailTotal;
	}


	@Override
	public int count(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return rotateSchemeDao.count(map);
	}

	@Override
	public RotateSchemeDetail getSchemeDetailByDetailId(String detailId) {
		return rotateSchemeDao.getSchemeDetailByDetailId(detailId);
	}

	@Override
	public String getSchemeNameById(String schemeId) {
		return rotateSchemeDao.getSchemeName(schemeId);
	}

	/**
	* @Author : xy_pengsk
	* @Description:
	* @Date: Created 16:14 2019/3/7
	*/
	@Override
	public LayPage<RotateSchemeDetail> list(HttpServletRequest request) {
		LayPage<RotateSchemeDetail> page = new LayPage<>();
		HashMap map = QueryUtil.pageHashMap(request);

		String schemeName = request.getParameter("schemeName");//方案名称
		String year = request.getParameter("year");//计划年份
		String originId = request.getParameter("originId");//所属计划
		String schemeType = request.getParameter("schemeType");//轮换类别
		String rotateType = request.getParameter("rotateType");//轮换方式
		String completeDate = request.getParameter("completeDate");//分发时间
		String executeState = request.getParameter("executeState");//执行状态
		String enterpriseName = request.getParameter("enterpriseName");//企业
		String libraryId = request.getParameter("libraryId");//库点
		String branNumber = request.getParameter("branNumber");//仓房
		String foodType = request.getParameter("foodType");//粮食品种
		String yieldTime = request.getParameter("yieldTime");//收获年份
		String ogirin = request.getParameter("ogirin");//产地

		map.put("schemeName",schemeName);
		map.put("year",year);
		map.put("originId",originId);
		map.put("schemeType",schemeType);
		map.put("rotateType",rotateType);
		map.put("completeDate",completeDate);
		map.put("executeState",executeState);
		map.put("enterpriseName",enterpriseName);
		map.put("libraryId",libraryId);
		map.put("branNumber",branNumber);
		map.put("foodType",foodType);
		map.put("yieldTime",yieldTime);
		map.put("ogirin",ogirin);

		int count = rotateSchemeDao.count1(map);
		if (count <= 0) {
			return page;
		}
		List<RotateSchemeDetail> data = rotateSchemeDao.listRotateScheme(map);

		page.setCount(count);
		page.setData(data);
		page.setCode(0);
		page.setMsg("");
		return page;
	}
	/*计算质检个数*/
    public void countQualityResultNum(RotateSchemeDetail rotateSchemeDetail,RotatePlanDetail rotatePlanDetail,BigDecimal qualityResultNum){
        if(null !=rotatePlanDetail) {
            String dealSerial = null;	// 成交明细号
            dealSerial = rotatePlanDetail.getDealSerial();
            if(StringUtils.isNotEmpty(dealSerial)){
                Map<String,Object> paramSample = new HashMap<>();
                paramSample.put("dealSerial", dealSerial);
                // 入库质检
                paramSample.put("sort", "ASC");
                paramSample.put("validType", "入库质检");
                // 查询对应样品信息	 入库只取第一条数据
                String sampleNo = qualitySampleMapper.getQualityInfo(paramSample);
                Map<String,Object> param = new HashMap<>();
                if(StringUtils.isNotEmpty(sampleNo)) {
                    param.put("sampleNo", sampleNo);
                    param.put("validType", "入库质检");
                    List<QualityResult> qualityResult_in = qualityResultMapper.getResultBySampleNo(param);	// 实际上一个样品信息只对应一条质检
                    if(null != qualityResult_in && qualityResult_in.size()>0){
                        qualityResultNum = qualityResultNum.add(new BigDecimal(1));
                    }
                }

                // 出库质检
                String storehouse = rotateSchemeDetail.getBranNumber();//出库质检需要根据仓号带出
                storehouse = org.apache.commons.lang.StringUtils.deleteWhitespace(storehouse);
                paramSample.put("validType", "出库质检");
                paramSample.put("storehouse", org.apache.commons.lang.StringUtils.deleteWhitespace(storehouse));
                paramSample.put("sort", "DESC");
                // 出库查询最后一条
                sampleNo = qualitySampleMapper.getQualityInfo(paramSample);
                if(StringUtils.isNotEmpty(sampleNo)) {
                    param.put("sampleNo", sampleNo);
                    param.put("validType", "出库质检");
                    List<QualityResult> qualityResult_out = qualityResultMapper.getResultBySampleNo(param);	// 实际上一个样品信息只对应一条质检
                    if(null != qualityResult_out && qualityResult_out.size()>0){
                        qualityResultNum = qualityResultNum.add(new BigDecimal(1));
                    }
                }
                rotateSchemeDetail.setQualityResultNum(qualityResultNum);
            }else{
                rotateSchemeDetail.setQualityResultNum(qualityResultNum);
            }
        }else{
            rotateSchemeDetail.setQualityResultNum(qualityResultNum);
        }
    }

    public void  countRestPlanNum(RotateSchemeDetail rotateSchemeDetail,RotatePlanDetail rotatePlanDetail){
        //剩余计划数量= 计划数量-已加入方案的计划数量+交易失败的数量
        //计划数量
        BigDecimal planRotateNumber = rotatePlanDetail.getRotateNumber();
        //已加入方案的计划数量
        BigDecimal planTotalCount = rotateSchemeDao.PlanTotalCount(rotatePlanDetail.getId());
        //交易失败的数量
        //BigDecimal unDealNumber = rotateSchemeService.unDealTotalCountByPlanDetailId(rotatePlanDetail.getId());
        BigDecimal unDealNumber = unDealTotalCountByPlanDetailId(rotatePlanDetail.getId());
        BigDecimal restNumber = planRotateNumber.subtract(planTotalCount).add(unDealNumber);
        rotateSchemeDetail.setRestNumber(restNumber);
    }
}
