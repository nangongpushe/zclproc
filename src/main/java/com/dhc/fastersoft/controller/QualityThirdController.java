package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.QualitySample;
import com.dhc.fastersoft.entity.QualityResult;
import com.dhc.fastersoft.entity.QualityResultItem;
import com.dhc.fastersoft.entity.system.SysDict;

import com.dhc.fastersoft.service.QualityResultItemService;
import com.dhc.fastersoft.service.QualityResultService;
import com.dhc.fastersoft.service.QualitySampleService;


import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

@RequestMapping("QualityThird")
@Controller
public class QualityThirdController extends BaseController{

	@Autowired
	QualityResultService  service;
	@Autowired
	QualityResultItemService serviceItem;
		@Autowired
		private QualitySampleService qualitySampleService;
		@Autowired
		SysDictService sysService;

		// 导出excel方法
	@SysLogAn("质量管理-检验任务-第三方质检记录-导出")
		@RequestMapping("/exportExcel")
		public String export(HttpServletRequest request, HttpServletResponse response) {
			List<QualityResult> list = new ArrayList();
			Map<String,List<String>> testItem = new HashMap<>();
			try {
				//list = userService.export(request);
				String sEcho = request.getParameter("sEcho");
				list=service.query(request);
				List<String> thirdIds = new ArrayList<>();
				for(QualityResult item : list)
					thirdIds.add(item.getId());
				List<QualityResultItem> testData = serviceItem.queryByResultId(thirdIds);
				for(QualityResult item : list) {
					for(QualityResultItem cItem : testData) {
						if(cItem.getResultId().equals(item.getId())) {
							if(item.getQualityResultItems() == null)
								item.setQualityResultItems(new ArrayList<QualityResultItem>());
							item.getQualityResultItems().add(cItem);
						}
					}
				}
				//检索出所有属性
				for(QualityResult item : list) {
					for(QualityResultItem cItem : item.getQualityResultItems()) {
						if(cItem.getItemName()!= null && !testItem.containsKey(cItem.getItemName())) {
							List<String> values = new ArrayList<>();
							testItem.put(cItem.getItemName(), values);
						}
					}
				}
				for(QualityResult item : list) {
					for(String testKey : testItem.keySet()) {
						if(!item.getQualityResultItems().contains(new QualityResultItem(testKey)))
							testItem.get(testKey).add("");//补齐空串
					}
					for(QualityResultItem cItem : item.getQualityResultItems()) {
						if(cItem.getItemName() != null)
							testItem.get(cItem.getItemName()).add(cItem.getResult());
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			String fileName = "第三方质检记录.xls";
			try {
				fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
			request.setAttribute("exportList", list);
			request.setAttribute("testItes",testItem);
			return "/QualityThird/export";
		}
		/**
		 * 跳转到列表页面
		 * @return
		 */
		@SysLogAn("访问：质量管理-检验任务-第三方质检记录")
		@RequestMapping()
		public String index(Model model) {
			List<SysDict> varietyList = sysService.getSysDictListByType("粮油品种");
			model.addAttribute("varietyList",varietyList);
			// 质检类型
			List<SysDict> validTypes=sysService.getSysDictListByType("质检类型");
			model.addAttribute("validTypes",validTypes);
			return "QualityThird/list";
		}
		/**
		 * 跳转到选择页面
		 * @return
		 */
		@RequestMapping("/listChoice")
		public String listChoice(Map<String,Object> map){
            List<SysDict> type=sysService.getSysDictListByType("粮油品种");
            map.put("type",type);
		    return "QualityThird/listChoice";
		}
		/**
		 * 列表页面信息
		 * 
		 * @param request
		 * @return
		 */
		@RequestMapping(value="/list")
		@ResponseBody
		private LayPage<QualityResult> list(HttpServletRequest request) {
			// TODO Auto-generated method stub
			LayPage<QualityResult> list=service.list(request);
			return list;
		}
		/**
		 * 跳转到查看
		 * @param request
		 * @param map
		 * @param id
		 * @return
		 */
		@RequestMapping("/detailPage")
		public String detailPage(HttpServletRequest request,ModelMap map,String id, String Projectile){
			QualityResult entity = service.getByID(id);
			map.addAttribute("entity", entity);
			List<QualityResultItem> entityItem = serviceItem.getByID(id);
			map.addAttribute("entityItem", entityItem);
			List<SysDict> variety=sysService.getSysDictListByType("粮油品种");
			map.addAttribute("variety",variety);
			List<SysDict> storeType=sysService.getSysDictListByType("粮油存储方式");
			map.addAttribute("storeType",storeType);
			List<SysDict> acceptedUnit=sysService.getSysDictListByType("承检单位");
			map.addAttribute("acceptedUnit",acceptedUnit);
			map.put("auvp", "v");
			map.put("pageType","view");
			//return "/QualityThird/add";
			return Projectile.equals("Projectile")?"QualityThird/add_dialog":"QualityThird/add";
		}
		/**
		 * 跳转到编辑
		 * @param request
		 * @param map
		 * @param id
		 * @return
		 */
		@RequestMapping("/editPage")
		public String editPage(HttpServletRequest request,ModelMap map,String id, String Projectile){
			QualityResult entity = service.getByID(id);
			if(entity.getStoreDate()!=null) {
				if (entity.getStoreDate().length() > 0) {
					//兼容日期字段
					entity.setStoreDate(entity.getStoreDate().substring(0, entity.getStoreDate().length() - 3));
				}
			}

			map.addAttribute("entity", entity);
			List<QualityResultItem> entityItem = serviceItem.getByID(id);
			map.addAttribute("entityItem", entityItem);
			List<SysDict> variety=sysService.getSysDictListByType("粮油品种");
			map.addAttribute("variety",variety);
			List<SysDict> storeType=sysService.getSysDictListByType("粮油存储方式");
			map.addAttribute("storeType",storeType);
			List<SysDict> acceptedUnit=sysService.getSysDictListByType("承检单位");
			map.addAttribute("acceptedUnit",acceptedUnit);
			map.put("auvp", "u");
			map.put("pageType","edit");
			//return "/QualityThird/add";
			return Projectile.equals("Projectile")?"QualityThird/add_dialog":"QualityThird/add";
		}
		/***
		 * 跳转到登记页面
		 * @param
		 * @return
		 */
		@RequestMapping("/addPage")
		public String addPage(ModelMap map){
			List<SysDict> variety=sysService.getSysDictListByType("粮油品种");
			map.addAttribute("variety",variety);
			List<SysDict> storeType=sysService.getSysDictListByType("粮油存储方式");
			map.addAttribute("storeType",storeType);
			List<SysDict> acceptedUnit=sysService.getSysDictListByType("承检单位");
			HashMap<String, Object> searchMap = new HashMap<>();
			map.addAttribute("acceptedUnit",acceptedUnit);
			searchMap.put("checkType",2);	// 只查询第三方质检
			List<QualitySample> qualitySamples = qualitySampleService.getMessage(searchMap);
			map.put("qualitySamples", qualitySamples);
			boolean isRun=true;
			String str="";
			while(isRun){
				str=getSampleNo();
				int countSampleNo=service.countSampleNo(str);
				if (countSampleNo<=0) {
					isRun=false;
				}
			}
			
			QualityResult entity=new QualityResult();
			entity.setSampleNo(str);
			map.addAttribute("entity",entity);
			map.put("auvp", "a");
			map.put("pageType","add");
			return "QualityThird/add";
		}

		private String getSampleNo() {
			// TODO Auto-generated method stub
			int random=(int)(Math.random()*10000-1);
			String str="浙粮检"+new SimpleDateFormat("yyyy").format(new Date())+"-"+random+"号";
			return str;
		}

		/**
		 * 删除
		 * @param id
		 * @return
		 */
		@SysLogAn("质量管理-检验任务-第三方质检记录-删除")
		@RequestMapping(value="/remove",method=RequestMethod.POST)
		@ResponseBody
		public ActionResultModel delete(String id) {
			ActionResultModel actionResultModel = new ActionResultModel();
			int row=service.remove(id);
			int countItem=serviceItem.count(id);
			if (countItem>0) {
				int row2=serviceItem.deleteItem(id);
				if(row>0&&row2>0) {
					actionResultModel.setSuccess(true);
					actionResultModel.setMsg("删除成功");
				}else {
					actionResultModel.setSuccess(false);
					actionResultModel.setMsg("删除失败");
				}
			}else {
				if(row>0) {
					actionResultModel.setSuccess(true);
					actionResultModel.setMsg("删除成功");
				}else {
					actionResultModel.setSuccess(false);
					actionResultModel.setMsg("删除失败");
				}
			}
			return actionResultModel;
		}
		/**
		 * 添加或修改
		 *
		 * @return
		 */
		@RequestMapping(value="/save",method={RequestMethod.POST}) 
		@ResponseBody
		public ActionResultModel save(QualityResult entity,HttpServletRequest request,ModelMap modelMap){
			ActionResultModel actionResultModel = new ActionResultModel();
			String sqlId="";
			try{
			entity.setStoreDate(entity.getStoreDate()+"-01");

			String id=request.getParameter("id");
			String[] resultId = request.getParameterValues("resultId");
			String[] itemName = request.getParameterValues("itemName");
			String[] grade = request.getParameterValues("gradeItem");
			String[] standard = request.getParameterValues("standard");
			String[] result = request.getParameterValues("result");
			String[] remark = request.getParameterValues("remarkItem");
			String[] orderNo = request.getParameterValues("orderNo");
				if (id.length()==0) {
					int random = (int) (Math.random() * 999 + 1);
					entity.setReportSerial(new SimpleDateFormat("yyyyMMdd").format(new Date()) + random);

					sqlId=UUID.randomUUID().toString().replace("-", "");
				entity.setId(sqlId);
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
				String date=df.format(new Date());
				entity.setCreator(TokenManager.getSysUserId());
				entity.setCreateDate(date);
				entity.setCompany(TokenManager.getToken().getCompany());
				service.add(entity);
				sysLogService.add(request, "质量管理-检验任务-第三方质检记录-新增");
				
			}else {
				entity.setId(id);
				if (entity.getCreator()==""||entity.getCreator()==null) {
					entity.setCreator(TokenManager.getSysUserId());
				}
				if (entity.getCreateDate()==""||entity.getCreateDate()==null) {
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
					String date=df.format(new Date());
					entity.setCreateDate(date);
				}
				if (entity.getCompany()==""||entity.getCompany()==null) {
					entity.setCompany(TokenManager.getToken().getCompany());
				}
				service.update(entity);
				serviceItem.deleteItem(id);
				sqlId=id;
				sysLogService.add(request, "质量管理-检验任务-第三方质检记录-修改");
				
			}
			if(resultId!=null){
				for (int i = 0; i < resultId.length; i++) {
					QualityResultItem qtiItem =new QualityResultItem();
					qtiItem.setResultId(sqlId);
					qtiItem.setItemName(itemName[i]);
					qtiItem.setGrade(grade[i]);
					qtiItem.setStandard(standard[i]);
					qtiItem.setResult(result[i]);
					qtiItem.setRemark(remark[i]);
					qtiItem.setId(UUID.randomUUID().toString().replace("-", ""));
					BigDecimal c = new BigDecimal(orderNo[i]);
					qtiItem.setOrderNo(c);
					serviceItem.add(qtiItem);
				}
			}
			//给中穗库推数据
			service.sendMessage(sqlId,"1");
			actionResultModel.setSuccess(true);
		} catch (Exception e) {
			actionResultModel.setSuccess(false);
			int row=service.remove(sqlId);
			int row2=serviceItem.deleteItem(sqlId);
			e.printStackTrace();
		}
			return actionResultModel;
			
		}
}
