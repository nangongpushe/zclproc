package com.dhc.fastersoft.controller.statistics;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.report.ReportSwtz;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportSwtzService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.store.StoreEnterpriseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("kccx")
public class KccxController {

	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private ReportSwtzService reportSwtzService;
	@Autowired
	private StoreEnterpriseService storeEnterpriseService;
	@Autowired
	StorageWarehouseService warehouseService;
	@Autowired
	SysUserService sysUserService;

	@SysLogAn("访问：报表台账-统计分析-库存查询")
	@RequestMapping()
	private String index(ModelMap map,HttpServletRequest request){

		SysUser user = TokenManager.getToken();

		//来自远程监管系统
		String userId = request.getParameter("userId");
		if (userId != null && !"".equals(userId)) {
			user = sysUserService.selectByPrimaryKey(userId);
		}
		List<StoreEnterprise> enterpriseList = new ArrayList<>();

		List kudianCodes = warehouseService.listKudianCode();
		List enterpriseIds = warehouseService.listEntrepriseId();
		boolean isKudian = kudianCodes.contains(user.getOriginCode());


		if(user.getOriginCode() != null
				&& BusinessConstants.CBL_CODE.equals(user.getOriginCode().toLowerCase())){
			map.addAttribute("isShowSuper","N");
			//公司人员查看所有公司
			enterpriseList = reportSwtzService.getAllStoreEnterprise();
			map.put("enterprises",enterpriseList == null
					? Collections.emptyList()
					: enterpriseList);
		}else if(isKudian){
			map.addAttribute("isShowSuper","Y");
			//6个直属库点选择本身所在公司及所有代储公司
			Map<String,Object> enterpriseIdMap = new HashMap<String,Object>();
			//StorageWarehouse storageWarehouse = warehouseService.get(user.getWareHouseId());
			StorageWarehouse storageWarehouse = warehouseService.getStorageWarehouse(user.getOriginCode());
			Iterator<String> it = enterpriseIds.iterator();
			while(it.hasNext()){
				String item = it.next();
				if(item.equals(storageWarehouse.getEnterpriseId())){
					it.remove();
				}
			}
           // enterpriseIds = Arrays.asList(enterpriseIds);
			enterpriseIdMap.put("excludeEnterpriseId",enterpriseIds);
			//enterpriseIdMap.put("enterprises",enterpriseList);
			enterpriseList =storeEnterpriseService.getEnterpriseByIds(enterpriseIdMap);
			map.put("enterprises",enterpriseList == null
					? Collections.emptyList()
					: enterpriseList);
		}else{
			map.addAttribute("isShowSuper","N");
			//代储点人员显示自己所在公司
			StorageWarehouse warehouse;
			if(user.getOriginCode() != null){
				warehouse = warehouseService.getStorageWarehouse(user.getOriginCode());
				StoreEnterprise enterprise = reportSwtzService.getStoreEnterpriseById(warehouse.getEnterpriseId());
				if(enterprise != null){
					enterpriseList.add(enterprise);
				}
				map.put("enterprises",enterpriseList == null
						? Collections.emptyList()
						: enterpriseList);
			}else{
				//如果库点代码为空统一按公司人员权限处理
				enterpriseList = reportSwtzService.getAllStoreEnterprise();
				map.put("enterprises",enterpriseList == null
						? Collections.emptyList()
						: enterpriseList);
			}
		}

		List<SysDict> varietyList = sysDictService.getSysDictListByType("粮油品种");
		map.addAttribute("varietyList",varietyList);
		map.addAttribute("userId",request.getParameter("userId"));
		return "report/statistical/KCCX_view";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public LayPage<ReportSwtz> list(HttpServletRequest request){

		LayPage<ReportSwtz> page = reportSwtzService.pageList(request);
		return page;
	}

	@RequestMapping("/list1")
	@ResponseBody
	public LayPage<ReportSwtz> list1(HttpServletRequest request,@RequestParam("plandetailid") String plandetailid){

		LayPage<ReportSwtz> page = reportSwtzService.pageList1(request,plandetailid);
		return page;
	}
	
}
