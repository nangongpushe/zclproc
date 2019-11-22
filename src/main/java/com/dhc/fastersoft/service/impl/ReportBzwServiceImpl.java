package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.dao.report.ReportBzwDao;
import com.dhc.fastersoft.dao.report.ReportMonthDao;
import com.dhc.fastersoft.entity.enumdata.ReportNameEnum;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.*;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportBzwService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.*;

@Service("reportBzwService")
public class ReportBzwServiceImpl implements ReportBzwService {

	@Autowired
	public ReportBzwDao dao;
	@Autowired
	public ReportMonthDao monthDao;

	@Autowired
	public StorageWarehouseDao warehouseDao;

	@Override
	public List<ReportBzw> listBzwByMonthHouse(String month, String reportWarehouse) {
		Map map = new HashMap();
		map.put("reportMonth", month);
		map.put("reportWarehouse", reportWarehouse);
		return dao.listBzwByMonthHouse(map);
	}

	@Override
	public String addBzw(String reportId, String reportMonth, List<ReportBzw> bzwList, String manager) {
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if (StringUtils.isEmpty(reportId)){
			ReportMonth reportMain = new ReportMonth();
			reportId = UUID.randomUUID().toString().replace("-","");
			reportMain.setReportMonth(reportMonth);
			reportMain.setId(reportId);
			reportMain.setReportWarehouse(reportWarehouse);
			reportMain.setReportWarehouseId(user.getWareHouseId());
			reportMain.setReportName(ReportNameEnum.BZW.getValue());
			reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
			reportMain.setCreator(user.getAccount());
			reportMain.setManager(manager);
			monthDao.add(reportMain);
		}else{
			//先清空当月当库数据
			dao.deleteByReportId(reportId);
			//更新状态
			ReportMonth reportMain = new ReportMonth();
			reportMain.setId(reportId);
			reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
			reportMain.setManager(manager);
			reportMain.setCreator(user.getAccount());
			monthDao.update(reportMain);
		}

		for (int i = 0; i < bzwList.size(); i++) {
			ReportBzw reportBzw = bzwList.get(i);
			reportBzw.setReportId(reportId);
			reportBzw.setReportMonth(reportMonth);
			reportBzw.setReportName(ReportNameEnum.BZW.getValue());
			reportBzw.setOrdernum(new BigDecimal(i));
			dao.add(reportBzw);
		}

		return reportId;
	}

	@Override
	public List<ReportBzw> listBzwByReportId(String reportId) {
		return dao.listBzwByReportId(reportId);
	}

	@Override
	public List listSumBzw(ReportMonth report) {
		List bzwList = new ArrayList();
		ReportMonth reportMain = new ReportMonth();
		reportMain.setGatherId(report.getId());
		List<ReportMonth> reportMonths = monthDao.listReport(reportMain);//所有库已上报通过的月报表
		String[] reportWarehouses = new String[reportMonths.size()];//要统计的库名
		BigDecimal[] biaoxinSum = new BigDecimal[reportMonths.size()+1];//各库标新统计
		BigDecimal[] biaoxinEmptySum = new BigDecimal[reportMonths.size()+1];//各库标新空麻袋统计
		BigDecimal[] biaojiuSum = new BigDecimal[reportMonths.size()+1];//各库标旧统计
		BigDecimal[] biaojiuEmptySum = new BigDecimal[reportMonths.size()+1];//各库标旧空麻袋统计
		BigDecimal[] sum = new BigDecimal[reportMonths.size()+1];//总计

		String reportids = "";
		ReportMonth reportMonth = null;
		for (int i = 0; i < reportMonths.size(); i++) {
			reportMonth = reportMonths.get(i);
			reportWarehouses[i] = reportMonth.getReportWarehouse();
			reportids += "," + reportMonth.getId();
		}

		reportids = reportids.substring(1);
		reportids = "'" + reportids.replace(",","','") + "'";
		Map map = new HashMap();
		map.put("reportIds",reportids);
		//查询各库标新与标旧的总数
		List<ReportBzw> reportBzws = dao.listSumBzw(map);
		for (ReportBzw reportBzw : reportBzws) {
			for (int i = 0; i < reportWarehouses.length; i++) {
				if(reportWarehouses[i].equals(reportBzw.getReportWarehouse())){
					biaoxinSum[i] = reportBzw.getBiaoxin();
					biaojiuSum[i] = reportBzw.getBiaojiu();
					sum[i] = biaoxinSum[i].add(biaojiuSum[i]);
					break;
				}
			}
		}

		//查询各库标新与标旧空麻袋的总数
		map.put("packageProperty","空麻袋");
		List<ReportBzw> reportEmptyBzws = dao.listSumBzw(map);
		for (ReportBzw reportBzw : reportEmptyBzws) {
			for (int i = 0; i < reportWarehouses.length; i++) {
				if(reportWarehouses[i].equals(reportBzw.getReportWarehouse())){
					biaoxinEmptySum[i] = reportBzw.getBiaoxin();
					biaojiuEmptySum[i] = reportBzw.getBiaojiu();
//					sum[i] = sum[i].add(biaoxinEmptySum[i]);
//					sum[i] = sum[i].add(biaojiuEmptySum[i]);
					break;
				}
			}
		}

		//公司合计
		companySum(biaoxinSum);
		companySum(biaoxinEmptySum);
		companySum(biaojiuSum);
		companySum(biaojiuEmptySum);
		companySum(sum);

		bzwList.add(reportWarehouses);
		bzwList.add(biaoxinSum);
		bzwList.add(biaoxinEmptySum);
		bzwList.add(biaojiuSum);
		bzwList.add(biaojiuEmptySum);
		bzwList.add(sum);

		return bzwList;
	}
	@Override
	public List listSumBzw1(ReportMonth report,ModelMap modelMap) {
		List bzwList = new ArrayList();
		ReportMonth reportMain = new ReportMonth();
		reportMain.setGatherId(report.getId());
		List<ReportMonth> reportMonths = monthDao.listReport(reportMain);//所有库已上报通过的月报表
		String[] reportWarehouses = new String[reportMonths.size()];//要统计的库名
		ReportMonth reportMonth = null;

		Map map1 = new HashMap();//标新袋
		List<BigDecimal> list1_1=new ArrayList();//标新装粮
		List<BigDecimal> list1_2=new ArrayList();//标新调运
		List<BigDecimal> list1_3=new ArrayList();//标新其他
		List<BigDecimal> list1_4=new ArrayList();//标新空
		List<BigDecimal> list1_5=new ArrayList();//标新小计
		Map map2 = new HashMap();//标旧袋
		List<BigDecimal> list2_1=new ArrayList();//标旧装粮
		List<BigDecimal> list2_2=new ArrayList();//标旧调运
		List<BigDecimal> list2_3=new ArrayList();//标旧其他
		List<BigDecimal> list2_4=new ArrayList();//标旧空
		List<BigDecimal> list2_5=new ArrayList();//标旧小计
		Map map3 = new HashMap();//杂袋
		List<BigDecimal> list3_1=new ArrayList();//杂袋装粮
		List<BigDecimal> list3_2=new ArrayList();//杂袋调运
		List<BigDecimal> list3_3=new ArrayList();//杂袋其他
		List<BigDecimal> list3_4=new ArrayList();//杂袋空
		List<BigDecimal> list3_5=new ArrayList();//杂袋小计
		Map map4 = new HashMap();//废袋
		List<BigDecimal> list4_1=new ArrayList();//废袋空
		List<BigDecimal> list5_1=new ArrayList();//总计
		BigDecimal total1_1 = new BigDecimal(0);//标新装粮合计
		BigDecimal total1_2 = new BigDecimal(0);//标新调运合计
		BigDecimal total1_3 = new BigDecimal(0);//标新其他合计
		BigDecimal total1_4 = new BigDecimal(0);//标新空麻袋合计
		BigDecimal total1_5 = new BigDecimal(0);//标新小计合计
		BigDecimal total2_1 = new BigDecimal(0);//标旧装粮合计
		BigDecimal total2_2 = new BigDecimal(0);//标旧调运合计
		BigDecimal total2_3 = new BigDecimal(0);//标旧其他合计
		BigDecimal total2_4 = new BigDecimal(0);//标旧空麻袋合计
		BigDecimal total2_5 = new BigDecimal(0);//标旧小计合计
		BigDecimal total3_1 = new BigDecimal(0);//杂袋装粮合计
		BigDecimal total3_2 = new BigDecimal(0);//杂袋调运合计
		BigDecimal total3_3 = new BigDecimal(0);//杂袋其他合计
		BigDecimal total3_4 = new BigDecimal(0);//杂袋空麻袋合计
		BigDecimal total3_5 = new BigDecimal(0);//杂袋小计总计
		BigDecimal total4_1 = new BigDecimal(0);//废袋空总计
		BigDecimal total5_1 = new BigDecimal(0);//总计合计


		for (int i = 0; i < reportMonths.size(); i++) {
			reportMonth = reportMonths.get(i);

			reportWarehouses[i] = warehouseDao.getWarehouseShortById(reportMonth.getReportWarehouseId());//存入库点名
			if(reportWarehouses[i] == null){
				reportWarehouses[i] = reportMonth.getReportWarehouse();
			}

			//根据reportid查询当前库对应的明细
			Map map5 = new HashMap();//装粮麻袋
			map5.put("reportIds",reportMonth.getId());
			map5.put("packageProperty","装粮麻袋");
			Map map6 = new HashMap();//装粮麻袋
			map6.put("reportIds",reportMonth.getId());
			map6.put("packageProperty","调运麻袋");
			Map map7 = new HashMap();//其他用途
			map7.put("reportIds",reportMonth.getId());
			map7.put("packageProperty","其他用途");
			Map map8= new HashMap();//其他用途
			map8.put("reportIds",reportMonth.getId());
			map8.put("packageProperty","空麻袋");
			//查询装粮麻袋
			List<ReportBzw> reportBzws = null;
			reportBzws = dao.listSumBzw1(map5);
			if(reportBzws!=null&&reportBzws.size()>0&&null !=reportBzws.get(0)) {
				BigDecimal  bxzlmd = reportBzws.get(0).getBiaoxin();
				BigDecimal  bjzlmd = reportBzws.get(0).getBiaojiu();
				BigDecimal  zdzlmd = reportBzws.get(0).getZadai();
				//BigDecimal  fdzlmd = reportBzws.get(0).getFeidai();
				list1_1.add(bxzlmd);
				list2_1.add(bjzlmd);
				list3_1.add(zdzlmd);

			}else{
				list1_1.add(new BigDecimal(0));
				list2_1.add(new BigDecimal(0));
				list3_1.add(new BigDecimal(0));
			}
			////查询调运麻袋
			reportBzws = dao.listSumBzw1(map6);
			if(reportBzws!=null&&reportBzws.size()>0 &&null !=reportBzws.get(0)) {
				BigDecimal  bxzlmd = reportBzws.get(0).getBiaoxin();
				BigDecimal  bjzlmd = reportBzws.get(0).getBiaojiu();
				BigDecimal  zdzlmd = reportBzws.get(0).getZadai();
				//BigDecimal  fdzlmd = reportBzws.get(0).getFeidai();
				list1_2.add(bxzlmd);
				list2_2.add(bjzlmd);
				list3_2.add(zdzlmd);

			}else{
				list1_2.add(new BigDecimal(0));
				list2_2.add(new BigDecimal(0));
				list3_2.add(new BigDecimal(0));
			}
			//查询其他用途
			reportBzws = dao.listSumBzw1(map7);
			if(reportBzws!=null&&reportBzws.size()>0 &&null !=reportBzws.get(0)) {
				BigDecimal  bxzlmd = reportBzws.get(0).getBiaoxin();
				BigDecimal  bjzlmd = reportBzws.get(0).getBiaojiu();
				BigDecimal  zdzlmd = reportBzws.get(0).getZadai();
				//BigDecimal  fdzlmd = reportBzws.get(0).getFeidai();
				list1_3.add(bxzlmd);
				list2_3.add(bjzlmd);
				list3_3.add(zdzlmd);
			}else{
				list1_3.add(new BigDecimal(0));
				list2_3.add(new BigDecimal(0));
				list3_3.add(new BigDecimal(0));
			}
			//查询空麻袋
			reportBzws = dao.listSumBzw1(map8);
			if(reportBzws!=null&&reportBzws.size()>0 &&null !=reportBzws.get(0)) {
				BigDecimal  bxzlmd = reportBzws.get(0).getBiaoxin();
				BigDecimal  bjzlmd = reportBzws.get(0).getBiaojiu();
				BigDecimal  zdzlmd = reportBzws.get(0).getZadai();
				BigDecimal  fdzlmd = reportBzws.get(0).getFeidai();
				list1_4.add(bxzlmd);
				list2_4.add(bjzlmd);
				list3_4.add(zdzlmd);
				list4_1.add(fdzlmd);
			}else{
				list1_4.add(new BigDecimal(0));
				list2_4.add(new BigDecimal(0));
				list3_4.add(new BigDecimal(0));
				list4_1.add(new BigDecimal(0));
			}
			//统计标新小计
			BigDecimal sum1_1 = list1_1.get(i);
			BigDecimal sum1_2 = list1_2.get(i);
			BigDecimal sum1_3 = list1_3.get(i);
			BigDecimal sum1_4 = list1_4.get(i);
			BigDecimal sum1_5 = sum1_1.add(sum1_2).add(sum1_3).add(sum1_4);
			list1_5.add(sum1_5);
			//统计标旧小计
			BigDecimal sum2_1 = list2_1.get(i);
			BigDecimal sum2_2 = list2_2.get(i);
			BigDecimal sum2_3 = list2_3.get(i);
			BigDecimal sum2_4 = list2_4.get(i);
			BigDecimal sum2_5 = sum2_1.add(sum2_2).add(sum2_3).add(sum2_4);
			list2_5.add(sum2_5);
			//统计杂袋小计
			BigDecimal sum3_1 = list3_1.get(i);
			BigDecimal sum3_2 = list3_2.get(i);
			BigDecimal sum3_3 = list3_3.get(i);
			BigDecimal sum3_4 = list3_4.get(i);
			BigDecimal sum3_5 = sum3_1.add(sum3_2).add(sum3_3).add(sum3_4);
			list3_5.add(sum3_5);
			//统计总计
			list1_5.get(i);//标新小计
			list2_5.get(i);//标旧小计
			list3_5.get(i);//杂袋小计
			list4_1.get(i);//废袋
			BigDecimal sum5_1 = list1_5.get(i).add(list2_5.get(i)).add(list3_5.get(i)).add(list4_1.get(i));
			list5_1.add(sum5_1);

			//计算合计
			total1_1 = total1_1.add(list1_1.get(i));
			total1_2 = total1_2.add(list1_2.get(i));
			total1_3 = total1_3.add(list1_3.get(i));
			total1_4 = total1_4.add(list1_4.get(i));
			total1_5 = total1_5.add(list1_5.get(i));
			total2_1 = total2_1.add(list2_1.get(i));
			total2_2 = total2_2.add(list2_2.get(i));
			total2_3 = total2_3.add(list2_3.get(i));
			total2_4 = total2_4.add(list2_4.get(i));
			total2_5 = total2_5.add(list2_5.get(i));
			total3_1 = total3_1.add(list3_1.get(i));
			total3_2 = total3_2.add(list3_2.get(i));
			total3_3 = total3_3.add(list3_3.get(i));
			total3_4 = total3_4.add(list3_4.get(i));
			total3_5 = total3_5.add(list3_5.get(i));
			total4_1 = total4_1.add(list4_1.get(i));
			total5_1 = total5_1.add(list5_1.get(i));
		}
		list1_1.add(total1_1);
		list1_2.add(total1_2);
		list1_3.add(total1_3);
		list1_4.add(total1_4);
		list1_5.add(total1_5);
		list2_1.add(total2_1);
		list2_2.add(total2_2);
		list2_3.add(total2_3);
		list2_4.add(total2_4);
		list2_5.add(total2_5);
		list3_1.add(total3_1);
		list3_2.add(total3_2);
		list3_3.add(total3_3);
		list3_4.add(total3_4);
		list3_5.add(total3_5);
		list4_1.add(total4_1);
		list5_1.add(total5_1);

		modelMap.put("list1_1",list1_1);
		modelMap.put("list1_2",list1_2);
		modelMap.put("list1_3",list1_3);
		modelMap.put("list1_4",list1_4);
		modelMap.put("list1_5",list1_5);
		modelMap.put("list2_1",list2_1);
		modelMap.put("list2_2",list2_2);
		modelMap.put("list2_3",list2_3);
		modelMap.put("list2_4",list2_4);
		modelMap.put("list2_5",list2_5);
		modelMap.put("list3_1",list3_1);
		modelMap.put("list3_2",list3_2);
		modelMap.put("list3_3",list3_3);
		modelMap.put("list3_4",list3_4);
		modelMap.put("list3_5",list3_5);
		modelMap.put("list4_1",list4_1);
		modelMap.put("list5_1",list5_1);
		modelMap.put("reportWarehouses",reportWarehouses);
		return bzwList;
	}
	@Override
	public List listSumBzw2(ReportMonth report,HttpServletRequest request) {
		List bzwList = new ArrayList();
		ReportMonth reportMain = new ReportMonth();
		reportMain.setGatherId(report.getId());
		List<ReportMonth> reportMonths = monthDao.listReport(reportMain);//所有库已上报通过的月报表
		String[] reportWarehouses = new String[reportMonths.size()];//要统计的库名
		ReportMonth reportMonth = null;

		Map map1 = new HashMap();//标新袋
		List<BigDecimal> list1_1=new ArrayList();//标新装粮
		List<BigDecimal> list1_2=new ArrayList();//标新调运
		List<BigDecimal> list1_3=new ArrayList();//标新其他
		List<BigDecimal> list1_4=new ArrayList();//标新空
		List<BigDecimal> list1_5=new ArrayList();//标新小计
		Map map2 = new HashMap();//标旧袋
		List<BigDecimal> list2_1=new ArrayList();//标旧装粮
		List<BigDecimal> list2_2=new ArrayList();//标旧调运
		List<BigDecimal> list2_3=new ArrayList();//标旧其他
		List<BigDecimal> list2_4=new ArrayList();//标旧空
		List<BigDecimal> list2_5=new ArrayList();//标旧小计
		Map map3 = new HashMap();//杂袋
		List<BigDecimal> list3_1=new ArrayList();//杂袋装粮
		List<BigDecimal> list3_2=new ArrayList();//杂袋调运
		List<BigDecimal> list3_3=new ArrayList();//杂袋其他
		List<BigDecimal> list3_4=new ArrayList();//杂袋空
		List<BigDecimal> list3_5=new ArrayList();//杂袋小计
		Map map4 = new HashMap();//废袋
		List<BigDecimal> list4_1=new ArrayList();//废袋空
		List<BigDecimal> list5_1=new ArrayList();//总计
		BigDecimal total1_1 = new BigDecimal(0);//标新装粮合计
		BigDecimal total1_2 = new BigDecimal(0);//标新调运合计
		BigDecimal total1_3 = new BigDecimal(0);//标新其他合计
		BigDecimal total1_4 = new BigDecimal(0);//标新空麻袋合计
		BigDecimal total1_5 = new BigDecimal(0);//标新小计合计
		BigDecimal total2_1 = new BigDecimal(0);//标旧装粮合计
		BigDecimal total2_2 = new BigDecimal(0);//标旧调运合计
		BigDecimal total2_3 = new BigDecimal(0);//标旧其他合计
		BigDecimal total2_4 = new BigDecimal(0);//标旧空麻袋合计
		BigDecimal total2_5 = new BigDecimal(0);//标旧小计合计
		BigDecimal total3_1 = new BigDecimal(0);//杂袋装粮合计
		BigDecimal total3_2 = new BigDecimal(0);//杂袋调运合计
		BigDecimal total3_3 = new BigDecimal(0);//杂袋其他合计
		BigDecimal total3_4 = new BigDecimal(0);//杂袋空麻袋合计
		BigDecimal total3_5 = new BigDecimal(0);//杂袋小计总计
		BigDecimal total4_1 = new BigDecimal(0);//废袋空总计
		BigDecimal total5_1 = new BigDecimal(0);//总计合计


		for (int i = 0; i < reportMonths.size(); i++) {
			reportMonth = reportMonths.get(i);
			reportWarehouses[i] = reportMonth.getReportWarehouse();//存入库点名
			//根据reportid查询当前库对应的明细
			Map map5 = new HashMap();//装粮麻袋
			map5.put("reportIds",reportMonth.getId());
			map5.put("packageProperty","装粮麻袋");
			Map map6 = new HashMap();//装粮麻袋
			map6.put("reportIds",reportMonth.getId());
			map6.put("packageProperty","调运麻袋");
			Map map7 = new HashMap();//其他用途
			map7.put("reportIds",reportMonth.getId());
			map7.put("packageProperty","其他用途");
			Map map8= new HashMap();//其他用途
			map8.put("reportIds",reportMonth.getId());
			map8.put("packageProperty","空麻袋");
			//查询装粮麻袋
			List<ReportBzw> reportBzws = null;
			reportBzws = dao.listSumBzw1(map5);
			if(reportBzws!=null&&reportBzws.size()>0&&null !=reportBzws.get(0)) {
				BigDecimal  bxzlmd = reportBzws.get(0).getBiaoxin();
				BigDecimal  bjzlmd = reportBzws.get(0).getBiaojiu();
				BigDecimal  zdzlmd = reportBzws.get(0).getZadai();
				//BigDecimal  fdzlmd = reportBzws.get(0).getFeidai();
				list1_1.add(bxzlmd);
				list2_1.add(bjzlmd);
				list3_1.add(zdzlmd);

			}else{
				list1_1.add(new BigDecimal(0));
				list2_1.add(new BigDecimal(0));
				list3_1.add(new BigDecimal(0));
			}
			////查询调运麻袋
			reportBzws = dao.listSumBzw1(map6);
			if(reportBzws!=null&&reportBzws.size()>0 &&null !=reportBzws.get(0)) {
				BigDecimal  bxzlmd = reportBzws.get(0).getBiaoxin();
				BigDecimal  bjzlmd = reportBzws.get(0).getBiaojiu();
				BigDecimal  zdzlmd = reportBzws.get(0).getZadai();
				//BigDecimal  fdzlmd = reportBzws.get(0).getFeidai();
				list1_2.add(bxzlmd);
				list2_2.add(bjzlmd);
				list3_2.add(zdzlmd);

			}else{
				list1_2.add(new BigDecimal(0));
				list2_2.add(new BigDecimal(0));
				list3_2.add(new BigDecimal(0));
			}
			//查询其他用途
			reportBzws = dao.listSumBzw1(map7);
			if(reportBzws!=null&&reportBzws.size()>0 &&null !=reportBzws.get(0)) {
				BigDecimal  bxzlmd = reportBzws.get(0).getBiaoxin();
				BigDecimal  bjzlmd = reportBzws.get(0).getBiaojiu();
				BigDecimal  zdzlmd = reportBzws.get(0).getZadai();
				//BigDecimal  fdzlmd = reportBzws.get(0).getFeidai();
				list1_3.add(bxzlmd);
				list2_3.add(bjzlmd);
				list3_3.add(zdzlmd);
			}else{
				list1_3.add(new BigDecimal(0));
				list2_3.add(new BigDecimal(0));
				list3_3.add(new BigDecimal(0));
			}
			//查询空麻袋
			reportBzws = dao.listSumBzw1(map8);
			if(reportBzws!=null&&reportBzws.size()>0 &&null !=reportBzws.get(0)) {
				BigDecimal  bxzlmd = reportBzws.get(0).getBiaoxin();
				BigDecimal  bjzlmd = reportBzws.get(0).getBiaojiu();
				BigDecimal  zdzlmd = reportBzws.get(0).getZadai();
				BigDecimal  fdzlmd = reportBzws.get(0).getFeidai();
				list1_4.add(bxzlmd);
				list2_4.add(bjzlmd);
				list3_4.add(zdzlmd);
				list4_1.add(fdzlmd);
			}else{
				list1_4.add(new BigDecimal(0));
				list2_4.add(new BigDecimal(0));
				list3_4.add(new BigDecimal(0));
				list4_1.add(new BigDecimal(0));
			}
			//统计标新小计
			BigDecimal sum1_1 = list1_1.get(i);
			BigDecimal sum1_2 = list1_2.get(i);
			BigDecimal sum1_3 = list1_3.get(i);
			BigDecimal sum1_4 = list1_4.get(i);
			BigDecimal sum1_5 = sum1_1.add(sum1_2).add(sum1_3).add(sum1_4);
			list1_5.add(sum1_5);
			//统计标旧小计
			BigDecimal sum2_1 = list2_1.get(i);
			BigDecimal sum2_2 = list2_2.get(i);
			BigDecimal sum2_3 = list2_3.get(i);
			BigDecimal sum2_4 = list2_4.get(i);
			BigDecimal sum2_5 = sum2_1.add(sum2_2).add(sum2_3).add(sum2_4);
			list2_5.add(sum2_5);
			//统计杂袋小计
			BigDecimal sum3_1 = list3_1.get(i);
			BigDecimal sum3_2 = list3_2.get(i);
			BigDecimal sum3_3 = list3_3.get(i);
			BigDecimal sum3_4 = list3_4.get(i);
			BigDecimal sum3_5 = sum3_1.add(sum3_2).add(sum3_3).add(sum3_4);
			list3_5.add(sum3_5);
			//统计总计
			list1_5.get(i);//标新小计
			list2_5.get(i);//标旧小计
			list3_5.get(i);//杂袋小计
			list4_1.get(i);//废袋
			BigDecimal sum5_1 = list1_5.get(i).add(list2_5.get(i)).add(list3_5.get(i)).add(list4_1.get(i));
			list5_1.add(sum5_1);

			//计算合计
			total1_1 = total1_1.add(list1_1.get(i));
			total1_2 = total1_2.add(list1_2.get(i));
			total1_3 = total1_3.add(list1_3.get(i));
			total1_4 = total1_4.add(list1_4.get(i));
			total1_5 = total1_5.add(list1_5.get(i));
			total2_1 = total2_1.add(list2_1.get(i));
			total2_2 = total2_2.add(list2_2.get(i));
			total2_3 = total2_3.add(list2_3.get(i));
			total2_4 = total2_4.add(list2_4.get(i));
			total2_5 = total2_5.add(list2_5.get(i));
			total3_1 = total3_1.add(list3_1.get(i));
			total3_2 = total3_2.add(list3_2.get(i));
			total3_3 = total3_3.add(list3_3.get(i));
			total3_4 = total3_4.add(list3_4.get(i));
			total3_5 = total3_5.add(list3_5.get(i));
			total4_1 = total4_1.add(list4_1.get(i));
			total5_1 = total5_1.add(list5_1.get(i));
		}
		list1_1.add(total1_1);
		list1_2.add(total1_2);
		list1_3.add(total1_3);
		list1_4.add(total1_4);
		list1_5.add(total1_5);
		list2_1.add(total2_1);
		list2_2.add(total2_2);
		list2_3.add(total2_3);
		list2_4.add(total2_4);
		list2_5.add(total2_5);
		list3_1.add(total3_1);
		list3_2.add(total3_2);
		list3_3.add(total3_3);
		list3_4.add(total3_4);
		list3_5.add(total3_5);
		list4_1.add(total4_1);
		list5_1.add(total5_1);

		request.setAttribute("list1_1", list1_1);
		request.setAttribute("list1_2", list1_2);
		request.setAttribute("list1_3", list1_3);
		request.setAttribute("list1_4", list1_4);
		request.setAttribute("list1_5", list1_5);
		request.setAttribute("list2_1", list2_1);

		request.setAttribute("list2_2", list2_2);

		request.setAttribute("list2_3", list2_3);

		request.setAttribute("list2_4", list2_4);

		request.setAttribute("list2_5", list2_5);

		request.setAttribute("list3_1", list3_1);

		request.setAttribute("list3_2", list3_2);

		request.setAttribute("list3_3", list3_3);

		request.setAttribute("list3_4", list3_4);

		request.setAttribute("list3_5", list3_5);

		request.setAttribute("list4_1", list4_1);

		request.setAttribute("list5_1", list5_1);
		request.setAttribute("reportWarehouses", reportWarehouses);
		return bzwList;
	}
	private void companySum(BigDecimal[] bigs) {
		bigs[bigs.length-1] = new BigDecimal(0);
		for (int i = 0; i<bigs.length - 1; i++){
			if(bigs[i] == null) bigs[i] = new BigDecimal(0);
			bigs[bigs.length-1] = bigs[bigs.length-1].add(bigs[i]);
		}
	}

	@Override
	public ReportBzw[] listSumBzwByReportId(String reportId) {
		List<ReportBzw> list = dao.listSumBzwByReportId(reportId);
		ReportBzw[] listNew = {new ReportBzw(),new ReportBzw(),new ReportBzw(),new ReportBzw()};
		//改变包装物性质方便页面定位
		for (ReportBzw bzw : list) {
			if("装粮麻袋".equals(bzw.getPackageProperty())){
				listNew[0] = bzw;
			}else if("调运麻袋".equals(bzw.getPackageProperty())){
				listNew[1] = bzw;
			}else if("空麻袋".equals(bzw.getPackageProperty())){
				listNew[2] = bzw;
			}else if("其他用途".equals(bzw.getPackageProperty())){
				listNew[3] = bzw;
			}
		}
		return listNew;
	}


	@Override
	public String addProxyBzw(String reportWarehouseId, String reportWarehouse,String reportId, String reportMonth, List<ReportBzw> bzwList, String manager) {

		SysUser user = TokenManager.getToken();
		if (StringUtils.isEmpty(reportId)){
			ReportMonth reportMain = new ReportMonth();
			reportId = UUID.randomUUID().toString().replace("-","");
			reportMain.setReportMonth(reportMonth);
			reportMain.setId(reportId);
			reportMain.setReportWarehouse(reportWarehouse);
			reportMain.setReportWarehouseId(reportWarehouseId);
			reportMain.setReportName(ReportNameEnum.BZW.getValue());
			reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
			reportMain.setCreator(user.getAccount());
			reportMain.setManager(manager);
			monthDao.add(reportMain);
		}else{
			//先清空当月当库数据
			dao.deleteByReportId(reportId);
			//更新状态
			ReportMonth reportMain = new ReportMonth();
			reportMain.setId(reportId);
			reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
			reportMain.setManager(manager);
			reportMain.setCreator(user.getAccount());
			reportMain.setReportWarehouse(reportWarehouse);
			monthDao.update(reportMain);
		}

		for (int i = 0, _size = bzwList.size(); i < _size; i++) {
			ReportBzw reportBzw = bzwList.get(i);
			reportBzw.setReportId(reportId);
			reportBzw.setReportMonth(reportMonth);
			reportBzw.setReportName(ReportNameEnum.BZW.getValue());
			reportBzw.setOrdernum(new BigDecimal(i));
			dao.add(reportBzw);
		}

		return reportId;
	}
}
