package com.dhc.fastersoft.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.*;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysRoleService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.PageUtil;
import com.dhc.fastersoft.utils.StringUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.*;



/**
 * 标的物
 * @author lay
 *
 */
@Controller
@RequestMapping("/rotateConclute")
public class RotateConcluteController extends BaseController{
	private static Logger log = Logger.getLogger(RotateConcluteController.class);

	@Autowired
	private RotateConcluteService concluteService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private StorageWarehouseService storageWarehouseService;
	@Autowired
	private SysRoleService sysRoleService;
	@Autowired
	private QualityResultService qualityResultService;
	@Autowired
	private QualityThirdService qualityThirdService;
	@Autowired
	private QualitySampleService qualitySampleService;
	@Autowired
	CustomerInformationService customerService;
	/**
	 * 手动汇总成交明细(针对订单粮、进口粮)
	 * @param model
	 * @return
	 */
	@RequestMapping("/add")
	public String add(Model model) {
		RotateConclute rotateConclute = new RotateConclute();
		model.addAttribute("model", rotateConclute);
		return "RotateTransaction/rotatetransaction_add";
	}

	@SysLogAn("访问：轮换业务-竞标管理-成交结果明细管理")
	@RequestMapping("/main")
	public String main(Model model,@RequestParam(value="type",required=false)String type) {
		SysUser user = TokenManager.getToken();
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")&&!"业务部".equals(user.getDepartment())) {
			type="ProviceUnit";
		}else if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")&&"业务部".equals(user.getDepartment())){
			type="";
		}else {
			type="Base";
		}
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("type",type);
		return "RotateConclute/rotateconclute_main";
	}

	@RequestMapping(value="/view",params="sid")
	public String view(Model model,@RequestParam("sid") String sid,
			@RequestParam(value="type",required=false)String type) {
		RotateConclute rotateConclute = concluteService.get(sid);
		/*-----------------------jovan------------------------------*/
//		根据表T_ROTATE_CONCLUTE中INVITE_TYPE字段查出在详细表（T_ROTATE_CONCLUTE_DETAIL）中是
// 根据出库ID（DELIVERY_PLACE)还是入库ID（RECEIVE_ID)关联查出库点名字
		String[] array = {"招标采购","订单采购","进口粮采购"};
		String inviteType = rotateConclute.getInviteType();
		String warehouseId = "";
		boolean flag = Arrays.asList(array).contains(inviteType);
		if(flag){
			warehouseId = "RECEIVE_ID";
		}else {
			warehouseId = "DELIVERY_ID";
		}
		/*-----------------------jovan------------------------------*/
		List<RotateConcluteDetail> detailList=concluteService.listDetail2(sid,warehouseId);
		//对数据进行权限上的控制
		List<String> baseNames = new ArrayList<>();
		List<String> wareHouseIds = new ArrayList<>();
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			String wareHouseId = user.getWareHouseId();
			wareHouseIds.add(wareHouseId);
			/*2019年3月18日 09:17:50客户让改为直属库点只看自己的
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
				wareHouseIds.add(base.getId());
				*/
		}
		boolean isPurchase = rotateConclute.getInviteType().contains("采购");
		boolean isSale = rotateConclute.getInviteType().contains("销售");
		for(int i=0;i<detailList.size();i++) {
			if(null!=wareHouseIds&&wareHouseIds.size()>0) {
				if(isPurchase
						&&!wareHouseIds.contains(detailList.get(i).getReceiveId())) {
					detailList.remove(i--);
					continue;
				}else if(isSale
						&&!wareHouseIds.contains(detailList.get(i).getDeliveryId())) {
					detailList.remove(i--);
					continue;

				}
			}
		}

		rotateConclute.setDetailList(detailList);
		model.addAttribute("model", rotateConclute);
		model.addAttribute("type",type);
		return "RotateConclute/rotateconclute_view";
	}

	/**
	 * 根据成交结果明细ID获取成交结果
	 * @param id
	 * @return
	 */
	@RequestMapping("/concluteDetail")
	@ResponseBody
	public Map<String,Object> concluteDetailById(String id){
		Map<String,Object> map = new HashMap<>();
		try {
			RotateConcluteDetail rotateConcluteDetail = concluteService.getRotateConcluteDetailById(id);
			map.put("code","success");
			map.put("data",rotateConcluteDetail);
		}catch (Exception e){
			map.put("code","error");
		}
		return map;
	}

	/**
	 * 导出
	 * @param request
	 * @param response
	 * @param id
	 * @throws IOException
	 */
	@SysLogAn("轮换业务-竞标管理-成交结果明细管理-导出")
	@RequestMapping(value="/exportExcel")
	@ResponseBody
	public void ExportExcel(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value="id")String id,@RequestParam(value="type")String type) throws IOException {

		List<RotateConclute> list = new ArrayList<>();
		RotateConclute rotateConclute = concluteService.get(id);
		List<RotateConcluteDetail> detailList = concluteService.listDetail(id);

		//对数据进行权限上的控制
		List<String> wareHouseIds = new ArrayList<>();
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			String wareHouseId = user.getWareHouseId();
			wareHouseIds.add(wareHouseId);
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
				wareHouseIds.add(base.getId());
		}
		boolean isPurchase = rotateConclute.getInviteType().contains("采购");
		boolean isSale = rotateConclute.getInviteType().contains("销售");
		for(int i=0;i<detailList.size();i++) {
			if(null!=wareHouseIds&&wareHouseIds.size()>0) {
				if(isPurchase
						&&!wareHouseIds.contains(detailList.get(i).getReceiveId())) {
					detailList.remove(i--);
					continue;
				}else if(isSale
						&&!wareHouseIds.contains(detailList.get(i).getDeliveryId())) {
					detailList.remove(i--);
					continue;

				}
			}
		}

		rotateConclute.setDetailList(detailList);
		list.add(rotateConclute);
		String title = String.format("浙江省省级储备%s%s成交明细表", rotateConclute.getGrainType(),rotateConclute.getInviteType());

		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),
				RotateConclute.class, list);

		workbook.write(response.getOutputStream());

	}

	//---接口----
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveOrUpdate(RotateConclute rotateConclute,
			@RequestParam(value="isedit",required=false) Boolean isedit,
			@RequestParam(value="detailList",required=false) String detailList) throws IOException {

		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);

		return actionResultModel;
	}

	/*@RequestMapping(value="/ListDetail",method= {RequestMethod.POST})
	@ResponseBody
	public List ListDetailById(@RequestParam("sid")String sid) {
		return concluteService.listDetail(sid);
	}*/
	@RequestMapping(value="/ListDetail",method= {RequestMethod.POST})
	@ResponseBody
	public List ListDetailById(@RequestParam(value = "grainType",required = false)String grainType,	// 粮食品种
							   @RequestParam(value = "receivePlace",required = false)String receivePlace,	//承储单位
							   @RequestParam(value = "warehoueYear",required = false)String warehoueYear,
							   @RequestParam(value = "quantity", required = false) String quantity,
							   @RequestParam(value = "storehouse",required = false)String storehouse,	// 仓号
							   @RequestParam(value = "dealUnit",required = false)String dealUnit,	// 提货单位
							   @RequestParam(value="isCompletionDeal",required = false,defaultValue = "false") boolean isCompletionDeal,	// 是否只显示完成交易的明细
							   HttpServletRequest request) {
		HashMap<String,Object> map = new HashMap<>();
		String noticeType = request.getParameter("noticeType");
		//String schemeType = request.getParameter("schemeType");
		map.put("grainType",grainType);
		map.put("noticeType",noticeType);
		//map.put("schemeType",schemeType);
		map.put("schemeType","1");
		if(StringUtils.isNotEmpty(receivePlace) && receivePlace.contains("hostId-")){
			map.put("hostId",receivePlace.replace("hostId-", ""));
		}else{
			map.put("receivePlace",receivePlace);

		}
		String  deliveryPlace= request.getParameter("deliveryPlace");

		//出库
		if(StringUtils.isNotEmpty(deliveryPlace) && deliveryPlace.contains("hostId-")){
			map.put("hostId",deliveryPlace.replace("hostId-", ""));
		}else{
			map.put("deliveryPlace",deliveryPlace);

		}



		//提货单
		String  isOut= request.getParameter("isOut");
		if(isOut!=null){
			String deliveryId = request.getParameter("deliveryId");
			map.put("deliveryId", deliveryId);
			map.put("isOut",isOut);
		}

		//合同履约管理
		String  isIn= request.getParameter("isIn");
		if(isIn!=null){
			if(isIn.equals("1")){
				//入库
				if(StringUtils.isEmpty(receivePlace)){
					map.put("isIn",isIn);

				}else {
					map.put("receivePlace",receivePlace);
					map.put("isIn","");
				}
			}else {
				//出
				if(StringUtils.isEmpty(receivePlace)){
					map.put("isOut",isOut);

				}else {
					map.put("isOut","");
					//出入都是name  为receivePlace
					map.put("deliveryPlace",receivePlace);
					map.put("receivePlace","");
				}
			}



		}

		//商务处理记录,合同履约管理
		String  rotateProcessFlag= request.getParameter("rotateProcessFlag");
		if(rotateProcessFlag!=null){

			map.put("deliveryPlace",receivePlace);
			map.put("receivePlace",receivePlace);
			map.put("rotateProcessFlag","1");
		}

		map.put("warehoueYear",warehoueYear);
		//入库年份
		String  produceYear= request.getParameter("produceYear");
		map.put("produceYear",produceYear);
		map.put("storehouse",storehouse);
		map.put("quantity",quantity);
		map.put("dealUnit",dealUnit);
		List<RotateConcluteDetail> list = null;
		if(isCompletionDeal){
			list= concluteService.finishRotateConclute(map);
		} else {
			if("入库".equals(noticeType)){
				//入库用receive_id关联库点表
				map.put("WAREHOUSE_ID","RECEIVE_ID");
			}else{
				//出库用delivery_id关联库点表
				map.put("WAREHOUSE_ID","DELIVERY_ID");
			}
			list = concluteService.listDetails(map);    //  查询成交明细
		}
//
//		if(rotateProcessFlag!=null) {
//
//				//商务处理记录
//				for (RotateConcluteDetail rotateConcluteDetail : list
//						) {
//					if(noticeType.equals("出库")){
//						//出库：delivery_id为库点，receive_id为客户
//						String warehouseId = rotateConcluteDetail.getDeliveryId();//库点
//						String clientId = rotateConcluteDetail.getReceiveId();//客户
//						StorageWarehouse storageWarehouse = storageWarehouseService.get(warehouseId);
//						CustomerInformation customerInformation = customerService.getCIById(clientId);
//						if(null != customerInformation){
//							rotateConcluteDetail.setReceivePlace(customerInformation.getClientName());
//						}
//						if(null != storageWarehouse){
//							rotateConcluteDetail.setDeliveryPlace(storageWarehouse.getWarehouseShort());
//						}
//					}else {
//						  /* String  temp=rotateConcluteDetail.getDealUnit();
//							rotateConcluteDetail.setDealUnit(rotateConcluteDetail.getReceivePlace());
//							rotateConcluteDetail.setDeliveryPlace(temp);*/
//						//入库：receive_id为库点，delivery_id为客户
//						String warehouseId = rotateConcluteDetail.getReceiveId();//库点
//						String clientId = rotateConcluteDetail.getDeliveryId();//客户
//						StorageWarehouse storageWarehouse = storageWarehouseService.get(warehouseId);
//						CustomerInformation customerInformation = customerService.getCIById(clientId);
//						if(null != storageWarehouse){
//							rotateConcluteDetail.setReceivePlace(storageWarehouse.getWarehouseShort());
//						}
//						if(null != customerInformation){
//							rotateConcluteDetail.setDeliveryPlace(customerInformation.getClientName());
//						}
//					}
//
//				}
//
//
//		}
//		if(isIn!=null){
//			for (RotateConcluteDetail rotateConcluteDetail : list
//					) {
//				//轮入  库点为买方
//				if (rotateConcluteDetail.getProduceYear() != null) {
//					if (rotateConcluteDetail.getProduceYear().length() > 3) {
//
//						if(isIn.equals("1")){
//							String  temp=rotateConcluteDetail.getDealUnit();
//							rotateConcluteDetail.setDealUnit(rotateConcluteDetail.getReceivePlace());
//							rotateConcluteDetail.setDeliveryPlace(temp);
//						}
////						rotateConcluteDetail.setDeliveryPlace(rotateConcluteDetail.getReceivePlace());
//					}
//				}
//			}
//		}

		return list;
	}


	@RequestMapping(value="/outList",method= {RequestMethod.POST})
	@ResponseBody
	public List List(@RequestParam(value = "grainType",required = false)String grainType,	// 粮食品种
							   @RequestParam(value = "receivePlace",required = false)String receivePlace,	//承储单位
							   @RequestParam(value = "warehoueYear",required = false)String warehoueYear,
							   @RequestParam(value = "quantity", required = false) String quantity,
							   @RequestParam(value = "storehouse",required = false)String storehouse,	// 仓号
							   @RequestParam(value="isCompletionDeal",required = false,defaultValue = "false") boolean isCompletionDeal,	// 是否只显示完成交易的明细
							   HttpServletRequest request) {
		HashMap<String,Object> map = new HashMap<>();
		String noticeType = request.getParameter("noticeType");
		String  deliveryPlace= request.getParameter("deliveryPlace");
		map.put("grainType",grainType);
		map.put("noticeType",noticeType);
		map.put("schemeType","1");
		map.put("deliveryPlace",deliveryPlace);
		map.put("warehoueYear",warehoueYear);
		map.put("storehouse",storehouse);
		map.put("quantity",quantity);
		List<RotateConcluteDetail> list = null;
		//出库用delivery_id关联库点表
		map.put("WAREHOUSE_ID", "DELIVERY_ID");

		list = concluteService.outListDetail(map);    //  查询成交明细

		return list;
	}

	@RequestMapping(value="/outManuList",method= {RequestMethod.POST})
	@ResponseBody
	public List manList(@RequestParam(value = "grainType",required = false)String grainType,	// 粮食品种
					 @RequestParam(value = "warehoueYear",required = false)String warehoueYear,
					 @RequestParam(value = "quantity", required = false) String quantity,
					 @RequestParam(value = "storehouse",required = false)String storehouse,	// 仓号
					 HttpServletRequest request) {
		HashMap<String,Object> map = new HashMap<>();
		String  deliveryPlace= request.getParameter("deliveryPlace");
		map.put("grainType",grainType);
		map.put("deliveryPlace",deliveryPlace);
		map.put("warehoueYear",warehoueYear);
		map.put("storehouse",storehouse);
		map.put("quantity",quantity);
//        map.put("WAREHOUSE_ID", "DELIVERY_ID");
		List<RotateManuDetail> list = concluteService.outManuListDetail(map);

		return list;
	}

	@ResponseBody
	@RequestMapping("/surplusPlanNum")
	public ActionResultModel surplusPlanNum(@RequestParam String dealSerial, @RequestParam(required = false) String noticeId){
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		Map<String, Object> param = new HashMap<>();
		param.put("dealSerial", dealSerial);
		param.put("noticeId", noticeId);
		BigDecimal num = concluteService.getSurplusPlanNum(param);
		actionResultModel.setData(num);
		return actionResultModel;
	}
	/**
	 * 分页
	 * @param pageIndex
	 * @param pageSize
	 * @param grainType
	 * @param inviteType
	 * @param dealDate
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value="/listPagination")
	@ResponseBody
	public LayPage<RotateConclute> listPagination(
			@RequestParam(value="pageIndex")int pageIndex,
			@RequestParam(value="pageSize")int pageSize,
			@RequestParam(value="grainType",required=false)String grainType,
			@RequestParam(value="inviteType",required=false)String inviteType,
			@RequestParam(value="dealDate",required=false)String dealDate,
			@RequestParam(value="type",required=false)String type,
			@RequestParam(value="status",required=false)String status)
			throws UnsupportedEncodingException {

        HashMap<String,Object> map = new HashMap<>();

        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("grainType", grainType);
        map.put("inviteType", inviteType);
        map.put("dealDate", dealDate);
        map.put("status", status);
        map.put("inviteTypes", "招标采购,竞价销售,内部销售,协议销售,内部招标");

		//对数据进行权限上的控制
		List<String> baseNames = new ArrayList<>();
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			//---------Jovan--------------------------------------//
			List<String> wareHouseIds = new ArrayList<>();
			String wareHouseId = user.getWareHouseId();
			wareHouseIds.add(wareHouseId);
			/*
			2019年3月18日 09:04:06客户让改成直属库点只看自己库点的
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
				wareHouseIds.add(base.getId());
				*/
			map.put("wareHouseIds", wareHouseIds);

			//---------Jovan--------------------------------------//
		}

        int total=concluteService.count(map);
        List<RotateConclute> list=null;
        if(total>0)
        	list = concluteService.list(map);

        LayPage<RotateConclute> pageUtil=new LayPage<>(list,total);

		return pageUtil;
	}
	@RequestMapping(value="/listPage")
	@ResponseBody
	public PageUtil<RotateConclute> listPage(
			@RequestParam(value="pageIndex")int pageIndex,
			@RequestParam(value="pageSize")int pageSize,
			@RequestParam(value="grainType",required=false)String grainType,
			@RequestParam(value="inviteType",required=false)String inviteType,
			@RequestParam(value="dealDate",required=false)String dealDate,
			@RequestParam(value="type",required=false)String type,
			@RequestParam(value="status",required=false)String status)
			throws UnsupportedEncodingException {

        HashMap<String,Object> map = new HashMap<>();

        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("grainType", grainType);
        map.put("inviteType", inviteType);
        map.put("dealDate", dealDate);
        map.put("status", status);
        map.put("inviteTypes", "招标采购,竞价销售,内部销售,协议销售");

		//对数据进行权限上的控制
		List<String> baseNames = new ArrayList<>();
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			//---------Jovan--------------------------------------//
			List<String> wareHouseIds = new ArrayList<>();
			String wareHouseId = user.getWareHouseId();
			wareHouseIds.add(wareHouseId);
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
				wareHouseIds.add(base.getId());
			map.put("wareHouseIds", wareHouseIds);
			//---------Jovan--------------------------------------//
		}

        int total=concluteService.count(map);
        List<RotateConclute> list=null;
        if(total>0)
        	list = concluteService.list(map);

        PageUtil<RotateConclute> pageUtil=new PageUtil<>();
        pageUtil.setPageIndex(pageIndex);
        pageUtil.setPageSize(pageSize);
        pageUtil.setTotalCount(total);
        pageUtil.setResult(list);

		return pageUtil;
	}

	@RequestMapping(value="/listDetailPagination",method=RequestMethod.POST)
	@ResponseBody
	public PageUtil<RotateConcluteDetail> listDetailPagination(
			@RequestParam(value="pageIndex",required=false,defaultValue = "1")Integer pageIndex,
			@RequestParam(value="pageSize",required=false,defaultValue = "10")Integer pageSize,
			@RequestParam(value="grainType",required=false)String grainType,
			@RequestParam(value="inviteTypes",required=false)String inviteTypes,
			@RequestParam(value="inviteType",required=false)String inviteType,
			@RequestParam(value="dealDate",required=false)String dealDate,
			@RequestParam(value="dealUnit",required=false)String dealUnit,
			@RequestParam(value="dealSerial",required=false)String dealSerial,
			@RequestParam(value="dealId",required=false)String dealId)  {

        HashMap<String,Object> map = new HashMap<>();
        map.put("pageIndex", pageIndex);
        map.put("pageSize", pageSize);
        map.put("grainType", grainType);
        map.put("dealDate", dealDate);
        map.put("inviteTypes", inviteTypes);
        map.put("inviteType", inviteType);
        map.put("dealUnit", dealUnit);
        map.put("dealSerial", dealSerial);
        map.put("dealId", dealId);

        SysUser user = TokenManager.getToken();
        if(!"cbl".equals(user.getOriginCode().toLowerCase())) {
        	RotateConclute rotateConclute = concluteService.get(dealId);
        	boolean isPurchase = rotateConclute.getInviteType().contains("采购");
    		boolean isSale = rotateConclute.getInviteType().contains("销售");
        	if(isPurchase) {
        		map.put("receivePlace",user.getShortName());
        	}else if(isSale) {
        		map.put("deliveryPlace",user.getShortName());
        	}
        }
        int total=concluteService.countDetailByCondition(map);
        List<RotateConcluteDetail> list=null;
        if(total>0)
        	list = concluteService.listDetailByCondition(map);
		PageUtil<RotateConcluteDetail> pageUtil=new PageUtil<>();
		pageUtil.setResult(list);
		pageUtil.setTotalCount(total);
		pageUtil.setPageSize(pageSize);
		pageUtil.setPageIndex(pageIndex);
		return pageUtil;
	}

	@RequestMapping(value="/listDetailForSample",method=RequestMethod.POST)
	@ResponseBody
	public PageUtil<RotateConcluteDetail> listDetailForSample(
			@RequestParam(value="pageIndex",required=false)int pageIndex,
			@RequestParam(value="pageSize",required=false)int pageSize,
			@RequestParam(value="grainType",required=false)String grainType,
			@RequestParam(value="inviteTypes",required=false)String inviteTypes,
			@RequestParam(value="inviteType",required=false)String inviteType,
			@RequestParam(value="dealDate",required=false)String dealDate,
			@RequestParam(value="dealUnit",required=false)String dealUnit,
			@RequestParam(value="dealSerial",required=false)String dealSerial,
			@RequestParam(value="dealId",required=false)String dealId,
			@RequestParam(value="receivePlace",required=false)String receivePlace,
			@RequestParam(value="warehoueYear",required=false)String warehoueYear,
			@RequestParam(value="produceArea",required=false)String produceArea,
			@RequestParam(value="storehouse",required=false)String storehouse,
			@RequestParam(value="noticeType",required = false) String noticeType,
			@RequestParam(value="status",required=false)String status)  {

        HashMap<String,Object> map = new HashMap<>();
		map.put("noticeType",noticeType);
        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("grainType", grainType);
        map.put("dealDate", dealDate);
        map.put("inviteTypes", inviteTypes);
        map.put("inviteType", inviteType);
        map.put("dealUnit", dealUnit);
        map.put("dealSerial", dealSerial);
        map.put("dealId", dealId);
        map.put("receivePlace", receivePlace);
        map.put("warehoueYear", warehoueYear);
        map.put("produceArea", produceArea);
        map.put("storehouse", storehouse);
        map.put("status", status);

        if(status != null) {
        	map.put("expands", "--");
        }

        SysUser user = TokenManager.getToken();
        Set<String> types = sysRoleService.findRoleTypeByUserId(user.getId());

		if(types!=null && types.contains("中心化验室")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(types != null && (types.contains("库化验室") || !"cbl".equals(user.getOriginCode().toLowerCase()))) {
//    		map.put("receivePlace",user.getShortName());
    		map.put("warehouseCode",user.getOriginCode().toUpperCase());
//    		map.put("deliveryPlace",user.getShortName());
		}

		map.put("produceYear", warehoueYear);
		String start="";
		String end="";
		if(pageIndex==1){
			start = "select * from (";
			end = ") where rownum <= " + pageSize;
		} else {
			start = "select * from ( select row_.*, rownum rownum_ from (";
			end = ") row_ where rownum <= "+pageIndex*pageSize+") where rownum_ > " + (pageIndex-1)*pageSize;
		}
		HashMap<String,String> maps = new HashMap<String,String>();
		map.put("start", start);
		map.put("end", end);
		map.put("isImport",1);
        int total=concluteService.countDetailByCondition(map);
        List<RotateConcluteDetail> list=null;
        if(total>0){
			list = concluteService.listDetailByCondition(map);
			for(RotateConcluteDetail rotateConcluteDetail:list ){
				if(rotateConcluteDetail.getProduceYear()!=null){
					rotateConcluteDetail.setWarehoueYear(rotateConcluteDetail.getProduceYear());
				}
			}
		}

		PageUtil<RotateConcluteDetail> pageUtil=new PageUtil<>();
		pageUtil.setResult(list);
		pageUtil.setTotalCount(total);
		pageUtil.setPageSize(pageSize);
		pageUtil.setPageIndex(pageIndex);
		return pageUtil;
	}

	@RequestMapping(value="/listDetailPageByNotice",method=RequestMethod.POST)
	@ResponseBody
	public PageUtil<RotateConcluteDetail> listDetailPageByNotice(
			@RequestParam(value="pageIndex",required=false)int pageIndex,
			@RequestParam(value="pageSize",required=false)int pageSize,
			@RequestParam(value="noticeId")String noticeId,
			@RequestParam(value="grainType",required=false)String grainType,
			@RequestParam(value="bidSerial",required=false)String bidSerial,
			@RequestParam(value="storehouse",required=false)String storehouse,
			@RequestParam(value="dealSerial",required=false)String dealSerial)  {

        HashMap<String,String> map = new HashMap<>();
        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("noticeId", noticeId);
        map.put("grainType", grainType);
        map.put("dealSerial", dealSerial);
		map.put("bidSerial", bidSerial);
		map.put("storehouse", storehouse);

        int total;
        //查非手工填报
        total = concluteService.countConcluteDetailByNotice(map);
        //查手工填报
		if (total == 0){
			 total = concluteService.countConcluteDetailByNoticeMaun(map);
		}

        List<RotateConcluteDetail> list=null;
        if(total>0){
			list = concluteService.listConcluteDetailByNotice(map);
			if (list.size() == 0){
				list = concluteService.listConcluteDetailByNoticeMaun(map);
			}

		}

		PageUtil<RotateConcluteDetail> pageUtil=new PageUtil<>();
		pageUtil.setResult(list);
		pageUtil.setTotalCount(total);
		pageUtil.setPageSize(pageSize);
		pageUtil.setPageIndex(pageIndex);
		return pageUtil;
	}

	@RequestMapping(value="/updateStatus",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel updateStatus(
			@RequestParam(value="id")String id,
			@RequestParam(value="status")String status) {
		sysLogService.add(request, "轮换业务-竞标管理-成交结果明细管理-"+status);
		concluteService.updateStatus(id, status);
		RotateConclute conclute = concluteService.get(id);
		if(status.equals("已分发")) {
			/*sysOAService.SendMessage(
					sysUserService.getUserByPosition("仓储部经理").getId(),
					"msg",
					"已可开具通知单",
					"成交明细" + conclute.getDealSerial() + "已完成，可开具通知单",
					"");*/
		}
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	@RequestMapping(value="/listDetailForRefund",method=RequestMethod.POST)
	@ResponseBody
	public PageUtil<RotateConcluteDetail> listDetailForRefund(
			@RequestParam(value="pageIndex")int pageIndex,
			@RequestParam(value="pageSize")int pageSize,
			@RequestParam(value="dealUnit",required=false)String dealUnit,
			@RequestParam(value="dealDate",required=false)String dealDate,
			@RequestParam(value="dealSerial",required=false)String dealSerial,
			@RequestParam(value="inviteType",required=false)String inviteType,
			@RequestParam(value="bidSerial",required=false)String bidSerial,
			@RequestParam(value="ids",required=false)String ids)  {

        HashMap<String,Object> map = new HashMap<>();
        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("dealUnit", dealUnit);
        map.put("dealDate", dealDate);
//        map.put("dealSerial", dealSerial);
        map.put("inviteType", inviteType);
        map.put("bidSerial", bidSerial);
        if(!StringUtil.isEmpty(ids)){
			String [] id= ids.split(",");
			map.put("ids",id);
		}
        map.put("flage","1");	//标识

        int total=concluteService.countDetailForRefundNew(map);
        List<RotateConcluteDetail> list = new ArrayList<>();
        if(total>0)
        	list = concluteService.listDetailForRefundNew(map);

		PageUtil<RotateConcluteDetail> pageUtil=new PageUtil<>();
		pageUtil.setResult(list);
		pageUtil.setTotalCount(total);
		pageUtil.setPageSize(pageSize);
		pageUtil.setPageIndex(pageIndex);
		return pageUtil;
	}

	@RequestMapping(value="/listDetailByJoin",method=RequestMethod.POST)
	@ResponseBody
	public LayPage<RotateConcluteDetail> listDetailByJoin(
			@RequestParam(value="pageIndex")int pageIndex,
			@RequestParam(value="pageSize")int pageSize,
			@RequestParam(value="dealSerial",required=false)String dealSerial,
			@RequestParam(value="inviteType",required=false)String inviteType,
			@RequestParam(value="grainType",required=false)String grainType,
			@RequestParam(value="dealUnit",required=false)String dealUnit,
			@RequestParam(value="dealDate",required=false)String dealDate)  {

        HashMap<String,String> map = new HashMap<>();
        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("dealSerial", dealSerial);
        map.put("inviteType", inviteType);
		map.put("grainType", grainType);
		map.put("dealUnit", dealUnit);
		map.put("dealDate", dealDate);
        int total=concluteService.countDetailForRefund(map);
        List<RotateConcluteDetail> list=null;
        if(total>0)
        	list = concluteService.listDetailForRefund(map);

        LayPage<RotateConcluteDetail> pageUtil=new LayPage<>(list,total);
		return pageUtil;
	}

	@RequestMapping(value="/listDetailForPay",method=RequestMethod.POST)
	@ResponseBody
	public LayPage<RotateConcluteDetail> listDetailForPay(
			@RequestParam(value="pageIndex")int pageIndex,
			@RequestParam(value="pageSize")int pageSize,
			@RequestParam(value="dealSerial",required=false)String dealSerial,
			@RequestParam(value="dealUnit",required = false) String dealUnit,
			@RequestParam(value = "grainType",required = false) String grainType,
			@RequestParam(value = "startDealDate",required = false) String startDealDate,
			@RequestParam(value = "endDealDate",required = false) String endDealDate){

        HashMap<String,String> map = new HashMap<>();
        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("dealSerial", dealSerial);
        map.put("startDealDate",startDealDate);
        map.put("endDealDate",endDealDate);
        map.put("dealUnit",dealUnit);
        map.put("grainType",grainType);

        int total=concluteService.countDetailJoinScheme(map);
        List<RotateConcluteDetail> list=null;
        if(total>0) {
        	list = concluteService.listDetailJoinScheme(map);

        }

        LayPage<RotateConcluteDetail> pageUtil=new LayPage<>(list,total);
		return pageUtil;
	}


	@RequestMapping(value="/GetQualityResult",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel GetQualityInfo(@RequestParam(value="dealSerial")String dealSerial) {
		ActionResultModel actionResultModel = new ActionResultModel();
		Map<String,Object> result = new HashMap<>();
		Map<String,Object> paramSample = new HashMap<>();
		paramSample.put("dealSerial", dealSerial);
		paramSample.put("sort", "ASC");
		paramSample.put("validType", "入库质检");
		String sampleNo = qualitySampleService.getQualityInfo(paramSample);
		Map<String,Object> param = new HashMap<>();
		if(sampleNo==null) {
			//没有质检或者是轮入
			sampleNo="";
		}
		param.put("sampleNo", sampleNo);
		param.put("validType", "入库质检");
		List<QualityResult> qualityResult_in = qualityResultService.getResultBySampleNo(param);
		if(qualityResult_in == null) {
			Map<String,QualityThird> qualityThird = qualityThirdService.queryBySampleNo(Arrays.asList(new String[] {sampleNo}));
			result.put("In", qualityThird.size() == 0? null:qualityThird.get(sampleNo));
		}else
			result.put("In", qualityResult_in.size() ==0? null:qualityResult_in.get(0));

		actionResultModel.setData(result);
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	@RequestMapping(value="/listDetailPagination1",method=RequestMethod.POST)
	@ResponseBody
	public PageUtil<RotateConcluteDetail> listDetailPagination1(
			@RequestParam(value="pageIndex",required=false,defaultValue = "1")Integer pageIndex,
			@RequestParam(value="pageSize",required=false,defaultValue = "10")Integer pageSize,
			@RequestParam(value="grainType",required=false)String grainType,
			@RequestParam(value="inviteTypes",required=false)String inviteTypes,
			@RequestParam(value="inviteType",required=false)String inviteType,
			@RequestParam(value="dealDate",required=false)String dealDate,
			@RequestParam(value="dealUnit",required=false)String dealUnit,
			@RequestParam(value="dealSerial",required=false)String dealSerial,
			@RequestParam(value="dealId",required=false)String dealId)  {

		HashMap<String,Object> map = new HashMap<>();
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("grainType", grainType);
		map.put("dealDate", dealDate);
		map.put("inviteTypes", inviteTypes);
		map.put("inviteType", inviteType);
		map.put("dealUnit", dealUnit);
		map.put("dealSerial", dealSerial);
		map.put("dealId", dealId);

		SysUser user = TokenManager.getToken();
		if(!"cbl".equals(user.getOriginCode().toLowerCase())) {
			/*
			 * 不理解代码含义 暂时处理
			 */
//			RotateConclute rotateConclute = concluteService.get(dealId);
//			boolean isPurchase = rotateConclute.getInviteType().contains("采购");
//			boolean isSale = rotateConclute.getInviteType().contains("销售");
//			if(isPurchase) {
//				map.put("receivePlace",user.getShortName());
//			}else if(isSale) {
//				map.put("deliveryPlace",user.getShortName());
//			}
			map.put("deliveryPlace",user.getShortName());
		}
		int total=concluteService.countDetailByCondition1(map);
		List<RotateConcluteDetail> list=null;
		if(total>0)
			list = concluteService.listDetailByCondition1(map);
		PageUtil<RotateConcluteDetail> pageUtil=new PageUtil<>();
		pageUtil.setResult(list);
		pageUtil.setTotalCount(total);
		pageUtil.setPageSize(pageSize);
		pageUtil.setPageIndex(pageIndex);
		return pageUtil;
	}
}
