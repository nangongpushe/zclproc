package com.dhc.fastersoft.service.impl;


import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.*;
import com.dhc.fastersoft.dao.system.SysRoleDao;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.RotateConcluteService;
import com.dhc.fastersoft.utils.DateUtil;
import com.dhc.fastersoft.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;

@Service("RotateConcluteService")
public class RotateConcluteServiceImpl implements RotateConcluteService {
	
	@Autowired
	private RotateConcluteDao dao;
	@Autowired
	private RotateBIDDao bidDao;
	@Autowired
	private RotateInviteDao inviteDao;
	@Autowired
	SysRoleDao sysRoleDao;
	@Autowired
	public StorageWarehouseDao storageWarehouseDao;
	@Autowired
	private RotateSchemeDao rotateSchemeDao;

    @Autowired
    private RotatePlanmainDetailDao rotatePlanmainDetailDao;
	@Autowired
	private RotatePlanDao rotatePlanDao;
	
	private static String SERIAL_PREFIX = "CJ";
	
	private static String Transaction_SERIAL_PREFIX = "JY";
	
	@Override
	public int save(RotateConclute record) {
		// TODO Auto-generated method stub
		record.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		String date = DateUtil.DateToString(new Date(), DateUtil.LONG_DATE_FORMAT);
		String prefix = Transaction_SERIAL_PREFIX+date.replaceAll("-","");
		String serialCount = String.format("%02d",dao.serialConut(prefix)+1);	// 此处不确定油油什么影响
		String serial = String.format("%s%s%s", Transaction_SERIAL_PREFIX,date.replaceAll("-", ""),serialCount);
		record.setDealSerial(serial);
		record.setUnit("吨");//默认
		List<RotateConcluteDetail> details =record.getDetailList();
		BigDecimal dealPriceTotal = BigDecimal.ZERO,dealAmountTotal = BigDecimal.ZERO, totalQuantity = BigDecimal.ZERO;
		int	count=1;
		for(RotateConcluteDetail detail:details) {
			detail.setId(UUID.randomUUID().toString().replaceAll("-", ""));
			String childSerial = serial + String.format("%03d",count);
			count =	count+1;
			detail.setDealSerial(childSerial);
			dealPriceTotal = dealPriceTotal.add(detail.getDealPrice());
			dealAmountTotal = dealAmountTotal.add(detail.getDealAmount());
			totalQuantity = totalQuantity.add(new BigDecimal(detail.getQuantity()));


			if (org.apache.commons.lang3.StringUtils.isNotEmpty(detail.getSchemeID())) {
				Map<String, Object> getMainPlanDetailCondition = new HashMap<String, Object>();
				getMainPlanDetailCondition.put("schemeDetailId", detail.getSchemeID());
				RotateSchemeDetail rotateSchemeDetail = rotateSchemeDao.getMainPlanDetailBySchemeId(getMainPlanDetailCondition);
				RotateSchemeDetail planDetail = rotateSchemeDao.getPlanDetailBySchemeId(getMainPlanDetailCondition);
				/*更新计划申报明细表数量*/
				RotatePlanmainDetail rotatePlanmainDetail = new RotatePlanmainDetail();
				rotatePlanmainDetail.setId(rotateSchemeDetail.getPlanMainDetailId());
				BigDecimal dealDetailNumber = rotateSchemeDetail.getDealDetailNumber();
				dealDetailNumber = dealDetailNumber.add(new BigDecimal(detail.getQuantity()));
				rotatePlanmainDetail.setDealDetailNumber(dealDetailNumber);
				rotatePlanmainDetailDao.updateDealDetailNumberByid(rotatePlanmainDetail);

				/*更新计划详情明细表数量*/
				RotatePlanDetail rotatePlanDetail = new RotatePlanDetail();//计划申报明细实体对象
				rotatePlanDetail.setId(planDetail.getPlanDetailId());
				BigDecimal dealPlanDetailNumber = planDetail.getDealDetailNumber();
				dealPlanDetailNumber = dealPlanDetailNumber.add(new BigDecimal(detail.getQuantity()));
				rotatePlanDetail.setDealDetailNumber(dealPlanDetailNumber);
				rotatePlanDao.updateDealDetailNumberByid(rotatePlanDetail);
			}
		}
		record.setTotalQuantity(String.valueOf(totalQuantity));
		record.setDealAmountTotal(dealAmountTotal);
		record.setDealPriceTotal(dealPriceTotal);
		return dao.save(record);
	}

	@Override
	public int gather(String inviteId) throws DataAccessException{

		RotateInvite rotateInvite=inviteDao.get(inviteId);
		RotateBID rotateBID=bidDao.get(rotateInvite.getBidId());
		RotateConclute rotateConclute = new RotateConclute();
		String date = DateUtil.DateToString(new Date(), DateUtil.LONG_DATE_FORMAT);

		String prefix = SERIAL_PREFIX+date.replaceAll("-","");

		String serialCount = String.format("%02d",dao.serialConut(prefix)+1);

		String serial = String.format("%s%s%s", SERIAL_PREFIX,date.replaceAll("-", ""),serialCount);
		//-----生成主表信息----
		rotateConclute.setId(UUID.randomUUID().toString().replaceAll("-", ""));//id
		rotateConclute.setDealSerial(serial);//成交明细号
		rotateConclute.setGrainType(rotateBID.getFoodType());//粮食品种
		rotateConclute.setInviteType(rotateInvite.getInviteType());//招标类型
		rotateConclute.setDealDate(rotateBID.getDealDate());//竞价交易时间
		rotateConclute.setUnit("吨");//单位
		rotateConclute.setGatherUnit(rotateInvite.getDepartment());//汇总部门
		rotateConclute.setGather(rotateInvite.getOperator());//汇总人
		rotateConclute.setGatherDate(rotateInvite.getHandleTime());//汇总时间
		rotateConclute.setRemark(rotateBID.getRemark());//备注
		rotateConclute.setTotalQuantity(rotateInvite.getTotalNum());//数量合计
		rotateConclute.setStatus("未分发");
		rotateConclute.setDealPriceTotal(new BigDecimal(rotateInvite.getTotalCompetitivePrice()));//价格合计
		rotateConclute.setDealAmountTotal(new BigDecimal(rotateInvite.getTotalBidPrice()));//金额合计
		rotateConclute.setInviteId(rotateInvite.getId());
		
		//-----明细-----
		List<RotateConcluteDetail> concluteDetails= new ArrayList<>();
		List<RotateInviteDetail> inviteDetails=inviteDao.listDetail(inviteId);
		String inviteType=rotateInvite.getInviteType();
		HashMap<String, String> conditionMap=new HashMap<>();
		conditionMap.put("bidID", rotateInvite.getBidId());
		
		int count = 1;
		for(RotateInviteDetail inviteDetail:inviteDetails) {
			conditionMap.put("bidSerial", inviteDetail.getBidSerial());
			String childSerial = serial + String.format("%03d",count);
			count =	count+1;
			if(inviteType != null && "招标采购".equals(inviteType)) {
				RotateBIDPurchase bidDetail = bidDao.getSinglePurchase(conditionMap);

				Map<String,Object> getMainPlanDetailCondition = new HashMap<String,Object>();
				if(StringUtils.isNotEmpty(bidDetail.getSchemeID())) {
					getMainPlanDetailCondition.put("schemeDetailId", bidDetail.getSchemeID());
					RotateSchemeDetail rotateSchemeDetail = rotateSchemeDao.getMainPlanDetailBySchemeId(getMainPlanDetailCondition);
					RotateSchemeDetail planDetail = rotateSchemeDao.getPlanDetailBySchemeId(getMainPlanDetailCondition);
				//*更新计划申报明细表数量*//*
					RotatePlanmainDetail rotatePlanmainDetail = new RotatePlanmainDetail();//计划申报明细实体对象
					rotatePlanmainDetail.setId(rotateSchemeDetail.getPlanMainDetailId());
					BigDecimal dealDetailNumber = rotateSchemeDetail.getDealDetailNumber();
					dealDetailNumber = dealDetailNumber.add(new BigDecimal(inviteDetail.getNum()));
					rotatePlanmainDetail.setDealDetailNumber(dealDetailNumber);
					rotatePlanmainDetailDao.updateDealDetailNumberByid(rotatePlanmainDetail);
				//*更新计划详情明细表数量*//*
					RotatePlanDetail rotatePlanDetail = new RotatePlanDetail();//计划申报明细实体对象
					rotatePlanDetail.setId(planDetail.getPlanDetailId());
					BigDecimal dealPlanDetailNumber = planDetail.getDealDetailNumber();
					dealPlanDetailNumber = dealPlanDetailNumber.add(new BigDecimal(inviteDetail.getNum()));
					rotatePlanDetail.setDealDetailNumber(dealPlanDetailNumber);
					rotatePlanDao.updateDealDetailNumberByid(rotatePlanDetail);
				}


//				if(null==bidDetail)
//					continue;
				RotateConcluteDetail concluteDetail = new RotateConcluteDetail();
				concluteDetail.setSchemeID(bidDetail.getSchemeID());//子方案ID
				concluteDetail.setId(UUID.randomUUID().toString().replaceAll("-", ""));//id				
				concluteDetail.setDealSerial(childSerial);//成交明细号
				concluteDetail.setBidSerial(bidDetail.getBidSerial());//标的
				concluteDetail.setDeliveryPlace(inviteDetail.getCompetitiveUnit());//交货所属库点	（竞得单位）
				concluteDetail.setDeliveryId(inviteDetail.getCompetitiveUnitId());

				concluteDetail.setReceiveId(bidDetail.getWareHouseId());	// 买方ID
				concluteDetail.setEnterpriseId(bidDetail.getEnterpriseId());	// 所属公司
				concluteDetail.setReceivePlace(bidDetail.getCompany());//库点
				concluteDetail.setStorehouse(bidDetail.getStoreHouse());//仓号
				concluteDetail.setGrainType(rotateBID.getFoodType());//粮食品种
				concluteDetail.setQuantity(inviteDetail.getNum());//数量
				concluteDetail.setProduceArea(bidDetail.getProduceArea());//粮食产地
				concluteDetail.setProduceYear(bidDetail.getProduceYear());//生产年度
				concluteDetail.setWarehoueYear("--");//入库年度
				concluteDetail.setStorageType("--");//储存方式
				concluteDetail.setDealPrice(new BigDecimal(inviteDetail.getCompetitivePrice()));//成交价格
				concluteDetail.setDealAmount(new BigDecimal(inviteDetail.getBidPrice()));//金额
				concluteDetail.setTakeEnd("--");//提货截止时间
				concluteDetail.setDeliveryStart(bidDetail.getDeliveryStart());//交货起始时间
				concluteDetail.setDeliveryEnd(bidDetail.getDeliveryEnd());//交货截止时间
				concluteDetail.setDealUnit(inviteDetail.getCompetitiveUnit());//成交单位
				concluteDetail.setDealDate(DateUtil.DateToString(rotateBID.getDealDate(), DateUtil.LONG_DATE_FORMAT));//竞价交易时间
				concluteDetail.setLoanPaymentEndDate(bidDetail.getLoanPaymentEndDate());
				concluteDetail.setInviteDetailId(inviteDetail.getId());
				concluteDetails.add(concluteDetail);
			}else {
				RotateBIDSale bidDetail = bidDao.getSingleSale(conditionMap);
//				if(null==bidDetail)
////					continue;
				Map<String,Object> getMainPlanDetailCondition = new HashMap<String,Object>();
				if(StringUtils.isNotEmpty(bidDetail.getSchemeID())) {
					getMainPlanDetailCondition.put("schemeDetailId", bidDetail.getSchemeID());
					RotateSchemeDetail rotateSchemeDetail = rotateSchemeDao.getMainPlanDetailBySchemeId(getMainPlanDetailCondition);
					RotateSchemeDetail planDetail = rotateSchemeDao.getPlanDetailBySchemeId(getMainPlanDetailCondition);
					//*更新计划申报明细表数量*//*
					RotatePlanmainDetail rotatePlanmainDetail = new RotatePlanmainDetail();//计划申报明细实体对象
					rotatePlanmainDetail.setId(rotateSchemeDetail.getPlanMainDetailId());
					BigDecimal dealDetailNumber = rotateSchemeDetail.getDealDetailNumber();
					dealDetailNumber = dealDetailNumber.add(new BigDecimal(inviteDetail.getNum()));
					rotatePlanmainDetail.setDealDetailNumber(dealDetailNumber);
					rotatePlanmainDetailDao.updateDealDetailNumberByid(rotatePlanmainDetail);
					//*更新计划详情明细表数量*//*
					RotatePlanDetail rotatePlanDetail = new RotatePlanDetail();//计划申报明细实体对象
					rotatePlanDetail.setId(planDetail.getPlanDetailId());
					BigDecimal dealPlanDetailNumber = planDetail.getDealDetailNumber();
					dealPlanDetailNumber = dealPlanDetailNumber.add(new BigDecimal(inviteDetail.getNum()));
					rotatePlanDetail.setDealDetailNumber(dealPlanDetailNumber);
					rotatePlanDao.updateDealDetailNumberByid(rotatePlanDetail);
				}



				RotateConcluteDetail concluteDetail = new RotateConcluteDetail();
				concluteDetail.setSchemeID(bidDetail.getSchemeID());//子方案ID
				concluteDetail.setId(UUID.randomUUID().toString().replaceAll("-", ""));//id
				concluteDetail.setDealSerial(childSerial);//成交明细号
				concluteDetail.setBidSerial(bidDetail.getBidSerial());//标的
				concluteDetail.setDeliveryPlace(bidDetail.getDeliveryPlace());//交货所属库点
				concluteDetail.setDeliveryId(bidDetail.getWareHouseId());	// 竞得单位

				concluteDetail.setReceivePlace(inviteDetail.getCompetitiveUnit());//库点
				concluteDetail.setReceiveId(inviteDetail.getCompetitiveUnitId());

				concluteDetail.setStorehouse(bidDetail.getStorehouse());//仓号
				concluteDetail.setGrainType(bidDetail.getGrainType());//粮食品种
				concluteDetail.setQuantity(String.valueOf(inviteDetail.getNum()));//数量
				concluteDetail.setProduceArea(bidDetail.getProduceArea());//粮食产地
				concluteDetail.setProduceYear("--");//生产年度
				concluteDetail.setWarehoueYear(bidDetail.getWarehouseYear());//入库年度
				concluteDetail.setStorageType(bidDetail.getStorageType());//储存方式
				concluteDetail.setDealPrice(new BigDecimal(inviteDetail.getCompetitivePrice()));//成交价格
				concluteDetail.setDealAmount(new BigDecimal(inviteDetail.getBidPrice()));//金额
				concluteDetail.setTakeEnd(bidDetail.getTakeEnd());//提货截止时间
				concluteDetail.setDeliveryStart("--");//交货起始时间
				concluteDetail.setDeliveryEnd("--");//交货截止时间
				concluteDetail.setDealUnit(inviteDetail.getCompetitiveUnit());//成交单位
				rotateConclute.setGrainType(bidDetail.getGrainType());//主表粮食品种
				concluteDetail.setDealDate(DateUtil.DateToString(rotateBID.getDealDate(), DateUtil.LONG_DATE_FORMAT));//竞价交易时间
				concluteDetail.setInviteDetailId(inviteDetail.getId());
				concluteDetails.add(concluteDetail);
			}
		}
		if(concluteDetails.size()==0){
			concluteDetails=null;
		}
		rotateConclute.setDetailList(concluteDetails);

		return dao.save(rotateConclute);
	}

	@Override
	public int update(RotateConclute record) {
		// TODO Auto-generated method stub
		return dao.update(record);
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int removeDetail(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public RotateConclute get(String id) {
		// TODO Auto-generated method stub
		RotateConclute rotateConclute=dao.get(id);
		return rotateConclute;
	}

	@Override
	public List<RotateConclute> list(HashMap<String, Object> map) {
		return dao.list(map);
	}

	@Override
	public List<RotateConclute> listRotateSum(HashMap<String, Object> map) {
		return dao.listRotateSum(map);
	}
	@Override
	public int count(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.count(map);
	}

	@Override
	public int countRotateSum(HashMap<String, Object> map) {
		return dao.countRotateSum(map);
	}
	@Override
	public int countDetailByCondition(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.countDetailByCondition(map);
	}

	@Override
	public int countDetailByCondition1(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.countDetailByCondition1(map);
	}
	@Override
	public List<RotateConcluteDetail> listDetailByCondition(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.listDetailByCondition(map);
	}

	@Override
	public List<RotateConcluteDetail> listDetailByCondition1(HashMap<String, Object> map) {
		return dao.listDetailByCondition1(map);
	}
	@Override
	public List<RotateConcluteDetail> listConcluteDetailByNotice(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return dao.listConcluteDetailByNotice(map);
	}

	@Override
	public int countConcluteDetailByNotice(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return dao.countConcluteDetailByNotice(map);
	}

	@Override
	public String getSchemeDetailIdByDealSerial(String dealSerial) {
		// TODO Auto-generated method stub
		return dao.getSchemeDetailIdByDealSerial(dealSerial);
	}

	@Override
	public List<RotateConcluteDetail> listDetail(String dealId) {
		List<RotateConcluteDetail> list=dao.listDetail(dealId);
		// TODO Auto-generated method stub
		return dao.listDetail(dealId);
	}

	@Override
	public List<RotateConcluteDetail> listDetail2(String dealId,String warehouseID) {
		return dao.listDetai2(dealId,warehouseID);
	}

	@Override
	public List<RotateConcluteDetail> listOutDetail(Map<String,Object> map) {
		return dao.listOutDetail(map);
	}

	@Override
	public List<ExportRotateSum> listOutExportDetail(Map<String,Object> map) {
		return dao.listOutExportDetail(map);
	}
	@Override
	public List<RotateConcluteDetail> listDetails(HashMap<String, Object> map) {

		return dao.listDetails(map);
	}

	@Override
	public int updateStatus(String id, String status) {
		/*//更新计划申报子表中的deal_detail_number字段
		List<RotateConcluteDetail> rotateConcluteDetailList = dao.getDetailList(id);
		for (int i = 0; i < rotateConcluteDetailList.size(); i++) {
			Map<String,Object> getMainPlanDetailCondition = new HashMap<String,Object>();
			if(StringUtils.isNotEmpty(rotateConcluteDetailList.get(i).getSchemeID())) {
				getMainPlanDetailCondition.put("schemeDetailId", rotateConcluteDetailList.get(i).getSchemeID());
				RotateSchemeDetail rotateSchemeDetail = rotateSchemeDao.getMainPlanDetailBySchemeId(getMainPlanDetailCondition);
				RotateSchemeDetail planDetail = rotateSchemeDao.getPlanDetailBySchemeId(getMainPlanDetailCondition);
				*//*更新计划申报明细表数量*//*
				RotatePlanmainDetail rotatePlanmainDetail = new RotatePlanmainDetail();//计划申报明细实体对象
				rotatePlanmainDetail.setId(rotateSchemeDetail.getPlanMainDetailId());
				BigDecimal dealDetailNumber = rotateSchemeDetail.getDealDetailNumber();
				dealDetailNumber = dealDetailNumber.add(new BigDecimal(rotateConcluteDetailList.get(i).getQuantity()));
				rotatePlanmainDetail.setDealDetailNumber(dealDetailNumber);
				rotatePlanmainDetailDao.updateDealDetailNumberByid(rotatePlanmainDetail);
				*//*更新计划详情明细表数量*//*
				RotatePlanDetail rotatePlanDetail = new RotatePlanDetail();//计划申报明细实体对象
				rotatePlanDetail.setId(planDetail.getPlanDetailId());
				BigDecimal dealPlanDetailNumber = planDetail.getDealDetailNumber();
				dealPlanDetailNumber = dealPlanDetailNumber.add(new BigDecimal(rotateConcluteDetailList.get(i).getQuantity()));
				rotatePlanDetail.setDealDetailNumber(dealPlanDetailNumber);
				rotatePlanDao.updateDealDetailNumberByid(rotatePlanDetail);
			}
		}*/
		// TODO Auto-generated method stub
		HashMap<String, String> map =new HashMap<>();
		map.put("id", id);
		map.put("status", status);
		return dao.updateStatus(map);
	}

	@Override
	public List<RotateConcluteDetail> listDetailForRefund(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return dao.listDetailForRefund(map);
	}

	@Override
	public int countDetailForRefund(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return dao.countDetailForRefund(map);
	}

	@Override
	public int countDetailForRefundNew(HashMap<String, Object> map) {
		return dao.countDetailForRefundNew(map);
	}

	@Override
	public List<RotateConcluteDetail> listDetailForRefundNew(HashMap<String, Object> map) {
		return dao.listDetailForRefundNew(map);
	}

	@Override
	public List<RotateConcluteDetail> listDetailJoinScheme(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return dao.listDetailJoinScheme(map);
	}

	@Override
	public int countDetailJoinScheme(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return dao.countDetailJoinScheme(map);
	}

	@Override
	public List<RotateConclute> listConclute(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		//对数据进行权限上的控制
        Set<String> types = sysRoleDao.findRoleByUserId(TokenManager.getSysUserId());
		List<String> wareHouseIds = new ArrayList<>();
		if(types!=null && types.contains("中心化验室")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(types != null && (types.contains("库化验室") || !"cbl".equals(TokenManager.getToken().getOriginCode().toLowerCase()))) {
			SysUser user = TokenManager.getToken();
			String wareHouseId = user.getWareHouseId(); //获取到用户的库点信息
			wareHouseIds.add(wareHouseId);
			for(StorageWarehouse base : storageWarehouseDao.listSuperviseOfWarehouse(wareHouseId))
				wareHouseIds.add(base.getId());
			map.put("wareHouseIds", wareHouseIds);
		}
		return dao.list(map);
	}

	@Override
	public List<RotateConcluteDetail> finishRotateConclute(Map<String, Object> map) {
		return dao.finishRotateConclute(map);
	}

	@Override
	public RotateConcluteDetail getRotateConcluteDetailById(String id) {
		return dao.getRotateConcluteDetailById(id);
	}

	@Override
	public List<RotateConcluteDetail> outListDetail(HashMap<String, Object> map) {
		return dao.outListDetail(map);
	}

    @Override
    public BigDecimal getSurplusPlanNum(Map<String, Object> param) {
        return dao.getSurplusPlanNum(param);
    }

	@Override
	public List<RotateManuDetail> outManuListDetail(HashMap<String, Object> map) {
		return dao.outManuListDetail(map);
	}

	@Override
	public int countConcluteDetailByNoticeMaun(HashMap<String, String> map) {
		return dao.countConcluteDetailByNoticeMaun(map);
	}

	@Override
	public List<RotateConcluteDetail> listConcluteDetailByNoticeMaun(HashMap<String, String> map) {
		return dao.listConcluteDetailByNoticeMaun(map);
	}

	@Override
	public List<String> listInDetailSerial(RotateConcluteDetail rotateConcluteDetail) {
		return dao.listInDetailSerial(rotateConcluteDetail);
	}

	@Override
	public RotateConcluteDetail listByDealSerial(String dealSerial) {
		return  dao.listByDealSerial(dealSerial);
	}
}
