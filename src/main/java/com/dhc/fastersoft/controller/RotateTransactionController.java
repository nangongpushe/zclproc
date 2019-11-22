package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.RotatePlanDao;
import com.dhc.fastersoft.dao.RotatePlanmainDetailDao;
import com.dhc.fastersoft.dao.RotateSchemeDao;
import com.dhc.fastersoft.entity.RotateConclute;
import com.dhc.fastersoft.entity.RotateConcluteDetail;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.CustomerInformationService;
import com.dhc.fastersoft.service.RotateConcluteService;
import com.dhc.fastersoft.service.StorageStoreHouseService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.DateUtil;
import com.dhc.fastersoft.utils.JsonUtil;
import com.dhc.fastersoft.utils.LayPage;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


/**
 * 标的物
 * @author lay
 *
 */
@Controller
@RequestMapping("/rotateTransaction")
public class RotateTransactionController extends BaseController{
	private static Logger log = Logger.getLogger(RotateTransactionController.class);
	
	@Autowired
	private RotateConcluteService concluteService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private StorageWarehouseService storageWarehouseService;
	@Autowired
	private StorageStoreHouseService storageStoreHouseService;
	@Autowired
	private CustomerInformationService customerInformationService;
	@Autowired
	private RotateSchemeDao rotateSchemeDao;
	@Autowired
	private RotatePlanmainDetailDao rotatePlanmainDetailDao;
	@Autowired
	private RotatePlanDao rotatePlanDao;
	/**
	 * 手动汇总成交明细(针对订单粮、进口粮)
	 * @param model
	 * @return
	 */
	@RequestMapping("/add")
	public String add(Model model) {
		SysUser currentUser = TokenManager.getToken();
		RotateConclute rotateConclute = new RotateConclute();
		rotateConclute.setGather(currentUser.getName());
		rotateConclute.setGatherDate(new Date());
		//库点
		List<StorageWarehouse> storageWarehouses = storageWarehouseService.getAllWarehouseOrderBy();
		model.addAttribute("storageWarehouses",storageWarehouses);
		//仓号
		String[] encodes = storageStoreHouseService.getAllEncode();
		model.addAttribute("branNumbers",encodes);
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);

		// 查询所有客户名称
//		List<String> clientNameList = customerInformationService.clientNameList();
//		model.addAttribute("clientNameList",clientNameList);

		// 查询所有客户名称
		HashMap<String,String> map = new HashMap<>();
		model.addAttribute("customers", customerInformationService.listCustomer(map));

		model.addAttribute("model", rotateConclute);
		return "RotateTransaction/rotatetransaction_add";
	}
	
	@SysLogAn("访问：轮换业务-竞标管理-交易明细")
	@RequestMapping("/main")
	public String main(Model model,@RequestParam(value="type",required=false)String type) {
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")) {
			type="ProviceUnit";
		}else {
			type="Base";
		}
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("type",type);
		return "RotateTransaction/rotatetransaction_main";
	}
	
	@RequestMapping(value="/view",params="sid")
	public String view(Model model,@RequestParam("sid") String sid,
			@RequestParam(value="type",required=false)String type) {
		
		RotateConclute rotateConclute = concluteService.get(sid);
		List<RotateConcluteDetail> detailList=concluteService.listDetail(sid);
		
		//对数据进行权限上的控制
		List<String> wareHouseIds = new ArrayList<>();
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			//---------Jovan--------------------------------------//
			String wareHouseId = user.getWareHouseId();
			wareHouseIds.add(wareHouseId);
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
				wareHouseIds.add(base.getId());

			//---------Jovan--------------------------------------//
		}
		for(int i=0;i<detailList.size();i++) {
			if(null!=wareHouseIds&&wareHouseIds.size()>0&&!wareHouseIds.contains(detailList.get(i).getReceiveId())) {

				detailList.remove(i--);
				continue;

			}
		}
		rotateConclute.setDetailList(detailList);
		model.addAttribute("model", rotateConclute);
		model.addAttribute("type",type);
		return "RotateTransaction/rotatetransaction_view";
	}
	
	//---接口----
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveOrUpdate(RotateConclute rotateConclute,
			@RequestParam(value="isedit",required=false) Boolean isedit,
			@RequestParam(value="detaillist",required=false) String detaillist) throws IOException {

		SysUser currentUser = TokenManager.getToken();
		rotateConclute.setGatherUnit(currentUser.getDepartment());
		List<RotateConcluteDetail> details = JsonUtil.toObject(detaillist, RotateConcluteDetail.class);

		for(RotateConcluteDetail concluteDetail : details){
			if(StringUtils.isNotEmpty(concluteDetail.getReceivePlace()))
				concluteDetail.setWarehouseId(
						storageWarehouseService.getWarehouseIdByShortname(concluteDetail.getReceivePlace()));
		}

		rotateConclute.setDetailList(details);
		if(null==isedit||!isedit) {
			concluteService.save(rotateConclute);
			sysLogService.add(request, "轮换业务-竞标管理-交易明细-新增");
		}else {
			//目前只有新增功能，下方代码没有用到，后期如果用到，也请更新计划申报子表中的已轮换数量
			concluteService.update(rotateConclute);
			sysLogService.add(request, "轮换业务-竞标管理-交易明细-修改");
		}
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}


	/**
	 * 分页
	 * @param pageIndex
	 * @param pageSize
	 * @param grainType
	 * @param inviteType
	 * @param
	 * @return
	 * 
	 */
	@RequestMapping(value="/listPagination",method=RequestMethod.POST)
	@ResponseBody
	public LayPage<RotateConclute> listPagination(
			@RequestParam(value="pageIndex")int pageIndex,
			@RequestParam(value="pageSize")int pageSize,
			@RequestParam(value="grainType",required=false)String grainType,
			@RequestParam(value="inviteType",required=false)String inviteType,
			@RequestParam(value="type",required=false)String type,
			@RequestParam(value="status",required=false)String status) {
		
        HashMap<String,Object> map = new HashMap<>();
        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("grainType", grainType);
        if(null==inviteType||"".equals(inviteType))
        	map.put("inviteTypes", "进口粮采购,订单采购");
        else
        	map.put("inviteType", inviteType);
        map.put("status", status);
        
		//对数据进行权限上的控制
		List<String> wareHouseIds = new ArrayList<>();
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作
		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			//---------Jovan--------------------------------------//
			String wareHouseId = user.getWareHouseId();
			wareHouseIds.add(wareHouseId);
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
				wareHouseIds.add(base.getId());
			map.put("wareHouseIds", wareHouseIds);

			//---------Jovan--------------------------------------//
		}
        
        int total=concluteService.count(map);
        List<RotateConclute> list=null;
        if(total>0) {
        	list = concluteService.list(map);
        	for(RotateConclute rotateConclute:list) {
        		rotateConclute.setDealDateStr(DateUtil.DateToString(
        				rotateConclute.getDealDate(), DateUtil.LONG_DATE_FORMAT));
        		rotateConclute.setGatherDateStr(DateUtil.DateToString(
        				rotateConclute.getGatherDate(), DateUtil.LONG_DATE_FORMAT));
        	}
        }
		LayPage<RotateConclute> layPage=new LayPage<>(list,total,0,"");
		return layPage;
	}
}
