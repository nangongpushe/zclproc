package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.ManuReportData;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.store.StoreEnterpriseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 
 * @Title: StorageHouseController.java 
 * @Description:
 * @author 何明
 * @date 2017年9月26日 下午5:44:53
 */
@RequestMapping("/storageWarehouse")
@Controller
public class StorageWarehouseController extends BaseController{
	
	@Autowired
	private StorageWarehouseService service;
	
	@Autowired
	private SysDictService dicService;
	@Autowired
	StoreEnterpriseService storeEnterpriseService;

	@Autowired
	private SysUserService userService;

	@Autowired
	private SysDictService sysDictService;

	/**
	 * 
	 * @Title: index 
	 * @Description:
	 * @return
	 * @return Model
	 * @author 何明
	 * @date 2017年9月30日 下午6:20:50
	 */
	@RequestMapping()
	public String index(Model model, @RequestParam(value="type",required=true) String type) {
		model.addAttribute("type",type);
		model.addAttribute("enterprises", storeEnterpriseService.getAllEnterprise());
		if ("dc".equals(type)){
			sysLogService.add(request, "访问：代储管理-企业信息-库点管理");
		}else{
			sysLogService.add(request, "访问：仓储管理-库点管理");
		}
		return "storageWarehouse/storagewarehouse_main";
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel save(@RequestParam(value="auvp",required=true) String auvp,@RequestParam(value="type",required=true) String type,@RequestParam(value="ishost",required=true) String ishost,
			@RequestBody StorageWarehouse warehouse) {
		ActionResultModel result = new ActionResultModel();
//		warehouse.setCreatorId(TokenManager.getSysUserId());
		//排序号不足7位，前面自动补0
		String orderNo = warehouse.getOrderNo();
		int orderNoLength = orderNo.length();
		for(int i = 0;i<7-orderNoLength;i++ ){
			orderNo = "0"+orderNo;
		}
		warehouse.setOrderNo(orderNo);
        if(type.equals("cc")){
        	warehouse.setIsHost("Y");
		}else{
        	warehouse.setIsHost(ishost);
		}
		if (auvp.equals("a")) {
			warehouse.setId(UUID.randomUUID().toString().replace("-", ""));
			if (service.save(warehouse) == 1) {
				result.setSuccess(true);
				result.setMsg("保存成功");
				if("代储库".equals(warehouse.getWarehouseType())){
					sysLogService.add(request, "代储管理-企业信息-库点管理-新增");
					//warehouse.setIsHost(ishost);
				}else{
					sysLogService.add(request, "储备管理-库点管理-新增");
                   // warehouse.setIsHost("Y");
				}
			} else {
				result.setSuccess(false);
				result.setMsg("保存失败");
			}
			service.reportWarehouse(warehouse);
		} else if (auvp.equals("u")) {
			if (service.update(warehouse) == 1) {
				result.setSuccess(true);
				result.setMsg("更新成功");
				if("代储库".equals(warehouse.getWarehouseType())){
					sysLogService.add(request, "代储管理-企业信息-库点管理-修改");
					//warehouse.setIsHost(ishost);
				}else{
					sysLogService.add(request, "储备管理-库点管理-修改");
                  //  warehouse.setIsHost("Y");
				}
			} else {
				result.setSuccess(false);
				result.setMsg("更新失败");
			}
			service.reportWarehouse(warehouse);
		}
		return result;		
	}

	@RequestMapping("/remove")
	@ResponseBody
	public ActionResultModel remove(@RequestParam(value="id",required=true) String id, String type) {
		ActionResultModel result = new ActionResultModel();
		Integer flag = service.is_exist(id);
		Integer oilcanFlag = service.oilcanFlagIs_exist(id);
		if (flag == 0 && oilcanFlag == 0 ) {
			service.remove(id);
			result.setSuccess(true);
			result.setMsg("删除成功");
			if("dc".equals(type)){
				sysLogService.add(request, "代储管理-企业信息-库点管理-删除");
			}else{
				sysLogService.add(request, "储备管理-库点管理-修改-删除");
			}
		} else {
			if(flag>0){
				result.setSuccess(false);
				result.setMsg("删除失败该库点下有仓房");
			}
			if (oilcanFlag >0){
				result.setSuccess(false);
				result.setMsg("删除失败该库点下有油罐");
			}

		}
		return result;
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public LayPage<StorageWarehouse> list(HttpServletRequest request) {
		LayPage<StorageWarehouse> page = service.list(request);
		return page;	
	}

	@RequestMapping("/viewPage")
	public String viewPage(Model model, 
			@RequestParam(value="id",required=true) String id,
			@RequestParam(value="type",required=true) String type) {
		StorageWarehouse warehouse = service.get(id);
		model.addAttribute("warehouse", warehouse);
		//model.addAttribute("auvp","v");
		model.addAttribute("type",type);
		
		/*String warehouseType = "库点企业性质";
		List<SysDict> typeList = dicService.getSysDictListByType(warehouseType);
		model.addAttribute("typeList", typeList);*/
		
		return "storageWarehouse/storagewarehouse_view";	
	}
	
	@RequestMapping("/updatePage")
	public String updatePage(Model model, 
			@RequestParam(value="id",required=true) String id,
			@RequestParam(value="type",required=true) String type) {
		StorageWarehouse warehouse = service.get(id);
		model.addAttribute("warehouse", warehouse);
		model.addAttribute("auvp","u");
		model.addAttribute("type",type);
		
		String warehouseType = "库点企业性质";
		List<SysDict> typeList = dicService.getSysDictListByType(warehouseType);
		model.addAttribute("typeList", typeList);
		return "storageWarehouse/storagewarehouse_add";
	}
	
	@RequestMapping("/addPage")
	public String addPage(Model model, 
			@RequestParam(value="auvp",required=true) String auvp,
			@RequestParam(value="type",required=true) String type) {
		model.addAttribute("auvp",auvp);
		model.addAttribute("type",type);
		
		String warehouseType = "库点企业性质";
		List<SysDict> typeList = dicService.getSysDictListByType(warehouseType);
		model.addAttribute("typeList", typeList);
		return "storageWarehouse/storagewarehouse_add";
	}
	
	@RequestMapping("/enterpriseSelectPage")
	public String enterpriseSelectPage() {
		return "storageWarehouse/enterprise_colorbox_add";
	}
	@RequestMapping("/check")
	@ResponseBody
	public ActionResultModel  check(String value,String str){
		ActionResultModel actionResultModel = new ActionResultModel();
		int count=service.check(value,str);
		if(count>0) {
			actionResultModel.setSuccess(false);
		}else {
			actionResultModel.setSuccess(true);
		}
		return actionResultModel;
	}

	@RequestMapping(value="/listValidWarehouse")
	@ResponseBody
	public LayPage<StorageWarehouse>  listValidWarehouse(
			@RequestParam(value="pageIndex") String pageIndex,
			@RequestParam(value="pageSize") String pageSize,
			@RequestParam(value="warehouseCode",required=false) String warehouseCode,
			@RequestParam(value="warehouseShort",required=false) String warehouseShort,
			@RequestParam(value="warehouseName",required=false) String warehouseName
			){

		HashMap<String, Object> map = new HashMap<>();
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		
		if(TokenManager.getToken().getOriginCode().equals("CBL")){
			map.put("warehouseCode", null==warehouseCode||"".equals(warehouseCode)?warehouseCode:warehouseCode.toUpperCase());
		}else{
			if(null==warehouseCode||""==warehouseCode){
				warehouseCode=TokenManager.getToken().getOriginCode();
			}else{
				// 这里是什么鬼意思
				warehouseCode="READ ONLY";
			}
			
			map.put("warehouseCode", warehouseCode);
		}
		
        map.put("warehouseShort", warehouseShort);
		map.put("warehouseName", warehouseName);
		int total=service.countValidWarehouse(map);
		List<StorageWarehouse> list=null;
		if(total>0)
			list = service.listValidWarehouse(map);
		StorageWarehouse storageWarehouse = new StorageWarehouse();
		/*storageWarehouse.setWarehouseCode("732315125121024");
		storageWarehouse.setWarehouseShort("中心化验室");
		storageWarehouse.setWarehouseName("中心化验室");
		list.add(storageWarehouse);*/
		LayPage<StorageWarehouse> pageUtil=new LayPage<>(list,total);


		return pageUtil;
	}


	/**
	 * 方法名 list
	 * 方法作用: 获取监管范围内的库点
	 * 作者：张乐
	 * 修改时间: 2017年10月3日 下午8:11:08
	 */
	@RequestMapping(value="/limitPageList")
	@ResponseBody
	public LayPage<StorageWarehouse> limitPageList(HttpServletRequest request) {

		LayPage<StorageWarehouse> list = service.limitPageList(request);
		return list;
	}
	/**
	 * 方法名 listWarehouseByCompany
	 * 方法作用: 公司人员选所有库点，6个直属库点选本身和所有代储库点，代储库点选本公司库点
	 * 作者：cc
	 * 修改时间: 2018年12月23日 下午8:11:08
	 */
	@RequestMapping(value="/listWarehouseByCompany")
	@ResponseBody
	public LayPage<StorageWarehouse> listWarehouseByCompany(HttpServletRequest request) {

		LayPage<StorageWarehouse> list = service.listWarehouseByCompany(request);
		return list;
	}


	/**
	 * 方法名 list
	 * 方法作用: 获取监管范围内的库点
	 * 作者：张乐
	 * 修改时间: 2017年10月3日 下午8:11:08
	 */
	@RequestMapping(value="/hostPageList")
	@ResponseBody
	public LayPage<StorageWarehouse> hostPageList(HttpServletRequest request) {

		LayPage<StorageWarehouse> list = service.limitPageList(request);
		return list;
	}

	/**
	 * 通过主库点查找该企业的所有库点
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/listWarehouseByHost")
	@ResponseBody
	public List<StorageWarehouse> listWarehouseByHost(HttpServletRequest request) {
		List<StorageWarehouse> list = service.listWarehouseByHost(request);
		return list;
	}

	/**
	 * 获取入库手工填报的数据
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/manReport")
	@ResponseBody
    public List<ManuReportData> manReport(HttpServletRequest request){
		List<SysDict> grainList = sysDictService.getSysDictListByType("粮油品种");
		List<String> variety = new ArrayList<>();
		for (SysDict grain : grainList){
			variety.add(grain.getValue());
		}

		//生成入库通知书手工填报的批号
		String manuBatchNumber = "CWD" + new SimpleDateFormat("yyyy/MM/dd-HH:mm:ss:SSS").format(new Date()).replaceAll("[^\\d]", "");

		//查出企业、库点简称和库点的id值
		List<ManuReportData> manuReportDataList = service.manReport(request);

		for (ManuReportData manuReportData : manuReportDataList){
			//得到对应库点ID值的所有仓房编号
			List<String> wareHouseNumberList = service.findWareHouseNumberByStorage(manuReportData.getId());
			//为ManuReportData对象的仓房属性赋值
			manuReportData.setWarehouseNumber(wareHouseNumberList);
			//为ManuReportData对象的品种属性赋值
			manuReportData.setVariety(variety);
			//为ManuReportData对象的批号属性赋值
            manuReportData.setManuBatchNumber(manuBatchNumber);
		}

		return manuReportDataList;
	}

    /**
     * 获取各自库点下的所有仓号集合
     * @param request
     * @return
     */
    @RequestMapping(value="/findStoreHouse")
    @ResponseBody
	public List<ManuReportData> findStoreHouse(HttpServletRequest request){
        //根据前端传入的批号查出库点简称和ID，并封装在ManuReportData对象中
	    List<ManuReportData> mReDataList = service.findStoreHouse(request);
	    for (ManuReportData mReData : mReDataList){
            //得到对应库点ID值的所有仓房编号
            List<String> wareHouseNumberList = service.findWareHouseNumberByStorage(mReData.getId());
            //为ManuReportData对象的仓房属性赋值
            mReData.setWarehouseNumber(wareHouseNumberList);
        }
	    return mReDataList;
    }

	@RequestMapping(value="/listValidWarehouse1")
	@ResponseBody
	public LayPage<StorageWarehouse>  listValidWarehouse1(
			@RequestParam(value="pageIndex") String pageIndex,
			@RequestParam(value="pageSize") String pageSize,
			@RequestParam(value="warehouseCode",required=false) String warehouseCode,
			@RequestParam(value="warehouseShort",required=false) String warehouseShort,
			@RequestParam(value="warehouseName",required=false) String warehouseName
	){
		HashMap<String, Object> map = new HashMap<>();
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("warehouseCode", null==warehouseCode||"".equals(warehouseCode)?warehouseCode:warehouseCode.toUpperCase());
		map.put("warehouseShort", warehouseShort);
		map.put("warehouseName", warehouseName);
		int total=service.countValidWarehouse(map);
		List<StorageWarehouse> list=null;
		if(total>0)
			list = service.listValidWarehouse(map);
		/*StorageWarehouse storageWarehouse = new StorageWarehouse();
		storageWarehouse.setWarehouseCode("732315125121024");
		storageWarehouse.setWarehouseShort("中心化验室");
		storageWarehouse.setWarehouseName("中心化验室");
		list.add(storageWarehouse);*/
		LayPage<StorageWarehouse> pageUtil=new LayPage<>(list,total);


		return pageUtil;
	}


	@RequestMapping("/findConnectorByShortName")
	@ResponseBody
	public StorageWarehouse findConnectorByShortName(String warehouseShort) {
		StorageWarehouse storageWarehouse = service.findConnectorByShortName(warehouseShort);
		return storageWarehouse;
	}


	/**
	 * 根据企业ID 查询是否存在主库点
	 * @param enterpriseId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("countHostWarehouse")
	public ActionResultModel countHostWarehouse(@RequestParam String enterpriseId,
												@RequestParam(required = false) String warehouseId){
		ActionResultModel actionResultModel = new ActionResultModel();
		Map<String, Object> param = new HashMap<>();
		param.put("enterpriseId",enterpriseId);
		param.put("warehouseId",warehouseId);
		int count = service.countHostWarehouse(param);
		actionResultModel.setSuccess(true);
		actionResultModel.setData(count);
		return actionResultModel;
	}

	/*公司人员看全部，代储点和直属单位只能看到自己所属公司下的库点*/
	@RequestMapping(value="/selectWarehouseListByEnterprise")
	@ResponseBody
	public LayPage<StorageWarehouse> selectWarehouseListByEnterprise(HttpServletRequest request) {
		LayPage<StorageWarehouse> list = service.selectWarehouseListByEnterprise(request);
		return list;
	}

}

