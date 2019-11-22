package com.dhc.fastersoft.controller.store;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.controller.BaseController;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.store.StoreEnterpriseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.*;

@Controller
@RequestMapping("StoreEnterprise")
public class StoreEnterpriseController extends BaseController{

	 @Autowired
     StoreEnterpriseService storeEnterpriseService;
	 @Autowired
     SysDictService sysDictService;
	 @Autowired
     SysUserService sysUserService;
	 @RequestMapping("index")
	 public String index(ModelMap map) {
		//现获取用户的权限
		
		 return "/StoreEnterprise/storeEnterprise_list";
	 }

	@SysLogAn("访问：代储监管-企业信息-企业基本信息")
	 @RequestMapping("")
		public String main(ModelMap map) {
		//现获取用户的权限
			return "/StoreEnterprise/storeEnterprise_list";
		}

		
		/**
		* 方法名 toAdd
		* 方法作用: 添加
		* 作者：张乐 
		* 修改时间: 2017年9月28日 下午5:03:12
		 */
		@RequestMapping("add")
		public String toAdd(HttpServletRequest request,ModelMap map){
			 List<SysDict> bankCreditRatings = sysDictService.getSysDictListByType("银行信用等级");
			 map.put("bankCreditRatings", bankCreditRatings);
			 SysUser sysUser = sysUserService.selectByPrimaryKey(TokenManager.getSysUserId());
			 //代储人的公司就是企业基本信息的企业名称
			 map.put("enterpriseName",sysUser.getCompany());
			return "/StoreEnterprise/storeEnterprise_add";
		}
		
		/**
		* 方法名 edit
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年9月29日 下午5:59:25
		 */
		@RequestMapping("edit")
		public String edit(HttpServletRequest request,ModelMap map,String id){
			 List<SysDict> bankCreditRatings = sysDictService.getSysDictListByType("银行信用等级");
			 map.put("bankCreditRatings", bankCreditRatings);
			StoreEnterprise storeEnterprise = storeEnterpriseService.getStoreEnterpriseByID(id);
			map.addAttribute("storeEnterprise", storeEnterprise);
			return "/StoreEnterprise/storeEnterprise_edit";
		}
		
		/**
		* 方法名 edit
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年9月29日 下午5:59:25
		 */
		@SysLogAn("访问：代储监管-企业信息-企业基本信息-打印")
		@RequestMapping("print")
		public String print(HttpServletRequest request,ModelMap map,String id){
			 List<SysDict> bankCreditRatings = sysDictService.getSysDictListByType("银行信用等级");
			 map.put("bankCreditRatings", bankCreditRatings);
			StoreEnterprise storeEnterprise = storeEnterpriseService.getStoreEnterpriseByID(id);
			map.addAttribute("storeEnterprise", storeEnterprise);
			return "/StoreEnterprise/storeEnterprise_print";
		}
		
		/**
		* 方法名 edit
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年9月29日 下午5:59:25
		 */
		@RequestMapping("view")
		public String view(HttpServletRequest request,ModelMap map,String id){
			 List<SysDict> bankCreditRatings = sysDictService.getSysDictListByType("银行信用等级");
			 map.put("bankCreditRatings", bankCreditRatings);
			StoreEnterprise storeEnterprise = storeEnterpriseService.getStoreEnterpriseByID(id);
			map.addAttribute("storeEnterprise", storeEnterprise);
			return "/StoreEnterprise/storeEnterprise_view";
		}
		
		/**
		* 方法名 save
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年9月28日 下午5:03:37
		 */
		@RequestMapping(value="/Create",method={RequestMethod.POST})
		@ResponseBody
		public ActionResultModel Create(StoreEnterprise storeEnterprise, HttpServletRequest request, ModelMap modelMap){
			//User user=(User) WebUtils.getSessionAttribute(request, "user");
			
			
		
			ActionResultModel actionResultModel = new ActionResultModel();
//			JSONObject ret = new JSONObject();
			String id = request.getParameter("id");
			
			
//			StoreEnterprise StoreEnterprise = new StoreEnterprise();
			try {
	
				storeEnterprise.setCreator(TokenManager.getNickname());
				storeEnterprise.setCreatorId(TokenManager.getSysUserId());
				if (id.length()==0) {
					if (storeEnterpriseService.getenterpriseSerialCount(storeEnterprise.getEnterpriseSerial())==0) {
						storeEnterprise.setId(UUID.randomUUID().toString().replace("-", ""));
						storeEnterpriseService.add(storeEnterprise);
					}else {
						actionResultModel.setSuccess(false);
						actionResultModel.setData("企业编号已存在!");
					}
					sysLogService.add(request, "代储监管-企业信息-企业基本信息-新增");
				}else {
					storeEnterprise.setId(id);
					storeEnterpriseService.update(storeEnterprise);
					sysLogService.add(request, "代储监管-企业信息-企业基本信息-修改");
				}
				actionResultModel.setSuccess(true);
			} catch (Exception e) {
				actionResultModel.setSuccess(false);
				e.printStackTrace();
			}
			
			 return actionResultModel;
		}
		
		

		
		/**
		* 方法名 list
		* 方法作用: 获取列表(过滤储备库)
		* 作者：张乐 
		* 修改时间: 2017年10月3日 下午8:11:08
		 */
		@RequestMapping(value="/list")
		@ResponseBody
		public LayPage<StoreEnterprise> list(HttpServletRequest request) {
			
			LayPage<StoreEnterprise> list = storeEnterpriseService.list(request);
			return list;
		}

		/**
		 * 方法名 thisList
		 * 方法作用: 获取列表
		 * 作者：彭少坤
		 * 修改时间: 2018年10月22日 下午4:16:37
		 */
		@RequestMapping(value="/thisList")
		@ResponseBody
		public LayPage<StoreEnterprise> ThisList(HttpServletRequest request) {

			LayPage<StoreEnterprise> list = storeEnterpriseService.ThisList(request);
			return list;
		}
		/**
		* 方法名 delete
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年10月3日 下午1:37:42
		 */
		@SysLogAn("代储监管-企业信息-企业基本信息-删除")
		@RequestMapping(value="/remove",method=RequestMethod.POST)
		@ResponseBody
		public ActionResultModel delete(String id) {
			ActionResultModel actionResultModel = new ActionResultModel();
			int nameCount = storeEnterpriseService.existCount(id);
//			int row=storeEnterpriseService.remove(id);
			if(nameCount == 0) {
				storeEnterpriseService.remove(id);
				actionResultModel.setSuccess(true);
				actionResultModel.setMsg("删除成功");
			}else {
				actionResultModel.setSuccess(false);
				actionResultModel.setMsg("删除失败,此企业下有库点");
			}
			return actionResultModel;
		}
	 
		/**
		 * 導出
		 */
		@SysLogAn("代储监管-企业信息-企业基本信息-导出")
		@RequestMapping("/exportxls")
		public String export(HttpServletRequest request, HttpServletResponse response) {
			List<StoreEnterprise> list = new ArrayList();
			try {
				//list = userService.export(request);
				String sEcho = request.getParameter("sEcho");
				list=storeEnterpriseService.exportxls(request);
			} catch (Exception e) {
				e.printStackTrace();
			}
			String fileName = "代储企业信息.xls";
			try {
				fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
//			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
			request.setAttribute("exportList", list);
			return "/StoreEnterprise/storeEnterprise_exportxls";
		}


	@RequestMapping(value="/enterpriseList")
	@ResponseBody
	public LayPage<StoreEnterprise> enterpriseList(HttpServletRequest request) {
		LayPage<StoreEnterprise> list = storeEnterpriseService.enterpriseList(request);
		//
		return list;
	}

	/**
	 * 查询代储公司及其下的主库点ID
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/enterprises")
	public LayPage<StoreEnterprise> getEnterprises(HttpServletRequest request){
		LayPage page = storeEnterpriseService.enterpriseList(request);
		return page;
	}
}
