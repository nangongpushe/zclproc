package com.dhc.fastersoft.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.service.system.SysUserService;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.RotateSchedule;
import com.dhc.fastersoft.entity.RotateScheduleDetail;
import com.dhc.fastersoft.entity.RotateScheme;
import com.dhc.fastersoft.entity.RotateSchemeDetail;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.RotateConcluteService;
import com.dhc.fastersoft.service.RotateScheduleService;
import com.dhc.fastersoft.service.RotateSchemeService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysOAService;
import com.dhc.fastersoft.utils.JsonUtil;
import com.dhc.fastersoft.utils.LayPage;


/**
 * 标的物
 * @author lay
 *
 */
@Controller
@RequestMapping("/rotateSchedule")
public class RotateScheduleController extends BaseController{
	private static Logger log = Logger.getLogger(RotateScheduleController.class);
	
	@Autowired
	private RotateScheduleService scheduleService;
	@Autowired
	private RotateConcluteService concluteSerive;
	@Autowired
	private RotateSchemeService schemeSerive;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private StorageWarehouseService storageWarehouseService;
	@Autowired
	private SysOAService sysOAService;
	@Autowired
	private SysUserService sysUserService;
	/**
	 * 新增页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/add")
	public String add(Model model) {
		RotateSchedule rotateSchedule = new RotateSchedule();
		SysUser user =TokenManager.getToken();
		rotateSchedule.setOperator(user.getName());
		rotateSchedule.setDepartment(user.getDepartment());
		rotateSchedule.setReportTime(new Date());
		rotateSchedule.setReportUnit(user.getShortName());
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("model", rotateSchedule);
		model.addAttribute("isedit", false);
		return "RotateSchedule/rotateschedule_add";
	}
	
	@RequestMapping(value="/edit",params="sid")
	public String edit(Model model,@RequestParam("sid") String sid) {
		RotateSchedule rotateSchedule = scheduleService.get(sid);
		HashMap<String, String> map= new HashMap<>();
		map.put("scheduleId", sid);
		List<RotateScheduleDetail> details=scheduleService.listDetail(map);
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("model", rotateSchedule);
		model.addAttribute("details", details);
		model.addAttribute("isedit", true);
		return "RotateSchedule/rotateschedule_add";
	}
	
	/**
	 * 主页面
	 * @return
	 */
	@SysLogAn("访问：轮换业务-执行进度-进度上报")
	@RequestMapping("/main")
	public String main(Model model,@RequestParam(value="type",required=false)String type) {
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")) {
			type="ProviceUnit";

		}else {
			type="Base";
		}
		model.addAttribute("type",type);
		return "RotateSchedule/rotateschedule_main";
	}
	/**
	 * 详情页
	 * @param model
	 * @param sid
	 * @return
	 */
	@RequestMapping(value="/view",params="sid")
	public String view(Model model,@RequestParam("sid") String sid) {
		RotateSchedule rotateSchedule = scheduleService.get(sid);
		HashMap<String, String> map= new HashMap<>();
		map.put("scheduleId", sid);
		List<RotateScheduleDetail> details=scheduleService.listDetail(map);
		model.addAttribute("noticeType", rotateSchedule.getNoticeType());
//		model.addAttribute("model", rotateSchedule);
		model.addAttribute("detailList", details);
		return "RotateSchedule/rotateschedule_view";
	}
	/**
	 * 查询页面
	 * @return
	 */
	@SysLogAn("访问：轮换业务-执行进度-进度查询")
	@RequestMapping("/main2")
	public String main2(Model model,@RequestParam(value="type",required=false)String type) {

		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")) {
			type="ProviceUnit";
		}else {
			type="Base";
		}
		model.addAttribute("type",type);
		return "RotateSchedule/rotateschedule_main2";
	}
	/**
	 * 进度历史详情页
	 * @param model
	 * @param noticeSerial
	 * @return
	 */
	@RequestMapping(value="/view2")
	public String view2(Model model,@RequestParam("noticeSerial") String noticeSerial,
			@RequestParam("noticeType") String noticeType) {
		
		List<RotateScheduleDetail> details=scheduleService.listDetailHistory(noticeSerial);
				
		model.addAttribute("noticeType", noticeType);
		model.addAttribute("detailList", details);
		return "RotateSchedule/rotateschedule_view2";
	}
	/**
	 * 汇总主页面
	 * @return
	 */
	@SysLogAn("访问：轮换业务-执行进度-进度汇总")
	@RequestMapping("/gather_main")
	public String gather_main(Model model) {
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		return "RotateSchedule/rotateschedule_gather_main";
	}
	/**
	 * 汇总详情
	 * @param model
	 * @param schemeBatch
	 * @param grainType
	 * @return
	 */
	@RequestMapping(value="/view_gather_detail",method=RequestMethod.POST)
	public String viewGatherDetail(Model model,@RequestParam(value="schemeBatch")String schemeBatch,
			@RequestParam(value="grainType")String grainType,
			@RequestParam(value="rotateType")String rotateType) {
		HashMap<String, String> map = new HashMap<>();
		map.put("schemeBatch", schemeBatch);
		map.put("grainType", grainType);
		map.put("schemeType", rotateType);
		map.put("status", "已通过");
		List<RotateScheduleDetail> details=scheduleService.viewGatherDetail(map);
		for(RotateScheduleDetail detail:details)
			detail.setRotateType(rotateType);
		model.addAttribute("schemeBatch", schemeBatch);
		model.addAttribute("length", details.size());
		model.addAttribute("detailList", details);
		model.addAttribute("rotateType", rotateType);
		return "RotateSchedule/rotateschedule_gather_view";		
	}
	
	
	//---接口----
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveOrUpdate(RotateSchedule rotateSchedule,
			@RequestParam(value="isedit",required=false) Boolean isedit,
			@RequestParam(value="detaillist",required=false) String detaillist) throws IOException {
		
		List<RotateScheduleDetail> details=JsonUtil.toObject(detaillist, RotateScheduleDetail.class);
		rotateSchedule.setDetailList(details);
		if(null==isedit||!isedit) {
			//获取是否已经上报
			HashMap  map = new HashMap();
			map.put("noticeId",rotateSchedule.getNoticeId());

			int  count=scheduleService.count(map);
			if(count>0){
				ActionResultModel actionResultModel = new ActionResultModel();
				actionResultModel.setMsg("当前通知书还有未通过的审批");
				actionResultModel.setSuccess(false);

				return actionResultModel;
			}
			rotateSchedule.setReporterId(TokenManager.getSysUserId());
			rotateSchedule.setOperator(TokenManager.getSysUserId());

			if(StringUtils.isNotEmpty(rotateSchedule.getReportUnit()))
				rotateSchedule.setReportUnitId(
						storageWarehouseService.getWarehouseIdByShortname(rotateSchedule.getReportUnit()));

			scheduleService.save(rotateSchedule);
			sysLogService.add(request, "轮换业务-执行进度-进度上报-新增");
		}else {
			scheduleService.update(rotateSchedule);
			sysLogService.add(request, "轮换业务-执行进度-进度上报-修改");
		}
		if("审核中".equals(rotateSchedule.getStatus())){
			sysLogService.add(request, "轮换业务-执行进度-进度上报-提交");
		}
			
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}


	/**
	 * 
	 * @param pageIndex
	 * @param pageSize
	 * @param operator
	 * @param department
	 * @param reportTime
	 * @param reportUnit
	 * @return
	 */
	@RequestMapping(value="/listPagination",method=RequestMethod.POST)
	@ResponseBody
	public LayPage<RotateSchedule> listPagination(
			@RequestParam(value="pageIndex")int pageIndex,
			@RequestParam(value="pageSize")int pageSize,
			@RequestParam(value="operator",required=false)String operator,
			@RequestParam(value="department",required=false)String department,
			@RequestParam(value="reportTime",required=false)String reportTime,
			@RequestParam(value="reportUnit",required=false)String reportUnit,
			@RequestParam(value="status",required=false)String status,
            @RequestParam(value="noticeType",required=false)String noticeType,
            @RequestParam(value="noticeSerial",required=false)String noticeSerial,
			@RequestParam(value="type",required=false)String type) {
		
        HashMap<String,Object> map = new HashMap<>();
        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("operator", operator);
        map.put("department", department);
        map.put("reportTime", reportTime);
        map.put("reportUnit", reportUnit);
        map.put("status", status);
        map.put("noticeType", noticeType);
        map.put("noticeSerial", noticeSerial);
		//对数据进行权限上的控制
		List<String> wareHouseIds = new ArrayList<>();
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			//---------Jovan--------------------------------------//
			String wareHouseId = user.getWareHouseId();
			wareHouseIds.add(wareHouseId);
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId)) {
				wareHouseIds.add(base.getId());
			}
			map.put("wareHouseIds", wareHouseIds);
			//---------Jovan--------------------------------------//

		}
        
        int count=scheduleService.count(map);
        List<RotateSchedule> list=null;
        if(count>0)
        	list = scheduleService.list(map);
		
		LayPage<RotateSchedule> page=new LayPage<>(list, count, 0, "");
		return page;
	}
	
	@RequestMapping(value="/getPriorPeriod",method=RequestMethod.POST)
	@ResponseBody
	public double getPriorPeriod(@RequestParam(value="dealSerial")String dealSerial) {
		return scheduleService.getPriorPeriod(dealSerial);		
	}
	/**
	 * 进度汇总
	 * @param pageIndex
	 * @param pageSize
	 * @param schemeType
	 * @return
	 */
	@RequestMapping(value="/gatherScheduleDetail",method=RequestMethod.POST)
	@ResponseBody
	public LayPage<RotateScheduleDetail> gatherScheduleDetail(
			@RequestParam(value="pageIndex")int pageIndex,
			@RequestParam(value="pageSize")int pageSize,
			@RequestParam(value="schemeType",required=false)String schemeType,
			@RequestParam(value="grainType",required=false)String grainType,
			@RequestParam(value="schemeBatch",required=false)String schemeBatch,
			@RequestParam(value="endTime",required=false)String endTime) {
		HashMap<String, String> map = new HashMap<>();
		map.put("pageIndex", String.valueOf(pageIndex));
		map.put("pageSize", String.valueOf(pageSize));
		map.put("schemeType", schemeType);
		map.put("grainType", grainType);
		map.put("schemeBatch", schemeBatch);
		map.put("endTime", endTime);
		map.put("status", "已通过");
		int count = scheduleService.countGather(map);
		List<RotateScheduleDetail> list=null;
		if(count>0)
			list=scheduleService.gatherScheduleDetail(map);
		LayPage<RotateScheduleDetail> page=new LayPage<>(list, count);
		return page;		
	}
	
	/**
	 * 进度历史查询
	 * @param pageIndex
	 * @param pageSize
	 * @param operator
	 * @param department
	 * @param reportTime
	 * @param reportUnit
	 * @return
	 */
	@RequestMapping(value="/listScheduleHistory",method=RequestMethod.POST)
	@ResponseBody
	public LayPage<RotateSchedule> listScheduleHistory(
			@RequestParam(value="pageIndex")int pageIndex,
			@RequestParam(value="pageSize")int pageSize,
			@RequestParam(value="operator",required=false)String operator,
			@RequestParam(value="department",required=false)String department,
			@RequestParam(value="reportTime",required=false)String reportTime,
			@RequestParam(value="reportUnit",required=false)String reportUnit,
			@RequestParam(value="noticeType",required=false)String noticeType,
			@RequestParam(value="noticeSerial",required=false)String noticeSerial,
			@RequestParam(value="type",required=false)String type) {
		
        HashMap<String,Object> map = new HashMap<>();
        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("operator", operator);
        map.put("department", department);
        map.put("reportTime", reportTime);
        map.put("reportUnit", reportUnit);
        map.put("noticeType", noticeType);
        map.put("noticeSerial", noticeSerial);
        map.put("status", "已通过");
        HashMap map1 = new HashMap();
        if(operator==null){
        	operator="";
		}
        if(!"".equals(operator)){
			map1.put("name",operator);
			List<SysUser> sysUsers = sysUserService.getUserIds(map1);
			operator="";
			for (SysUser s:sysUsers) {
				operator=operator+"'"+s.getId()+"',";
			}
			if(operator.length()>0){
				operator =operator.substring(0,operator.length()-1);
				map.put("operator",operator);
			}
		}


        
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
		
        int count=scheduleService.count(map);
        List<RotateSchedule> list=null;
        if(count>0)
        	list = scheduleService.list(map);
		
		LayPage<RotateSchedule> page=new LayPage<>(list, count, 0, "");
		return page;
	}
	
	@RequestMapping(value="/updateStatus",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel updateStatus(@RequestParam(value="id")String id,
			@RequestParam(value="status")String status) {
		HashMap<String, String> map = new HashMap<>();

		map.put("id", id);
		map.put("status", status);
		scheduleService.updateStatus(map);
		HashMap<String, String> map2 = new HashMap<>();
		map2.put("scheduleId", id);
		List<RotateScheduleDetail> details = scheduleService.listDetail(map2);
		if("已通过".equals(status)) {
			String schemeId=null;
			for(int i =0;i<details.size();i++) {
				String dealSerial = details.get(i).getDealSerial();
				String schemeDetailId = concluteSerive.getSchemeDetailIdByDealSerial(dealSerial);
//				if(i==0) {
//					schemeId = schemeSerive.getSchemeIdByDetailId(schemeDetailId);
//				}
				if(StringUtils.isNotEmpty(schemeDetailId)) {
					if (details.get(i).getCompleRate() < 100) {
						schemeSerive.updateStateOfDetail(schemeDetailId, "执行中");
					} else if (details.get(i).getCompleRate() >= 100) {
						schemeSerive.updateStateOfDetail(schemeDetailId, "已完成");
					}
				}
			}
			for(int i =0;i<details.size();i++) {
				String dealSerial = details.get(i).getDealSerial();
				String schemeDetailId = concluteSerive.getSchemeDetailIdByDealSerial(dealSerial);
				if(StringUtils.isNotEmpty(schemeDetailId)) {
					schemeId = schemeSerive.getSchemeIdByDetailId(schemeDetailId);
					if (StringUtils.isNotEmpty(schemeId)) {
						RotateScheme scheme = schemeSerive.GetSchemeInfo(schemeId);
						List<RotateSchemeDetail> schemeDetails = scheme.getSchemeDetail();
						boolean isFinish = true;
						for (RotateSchemeDetail schemeDetail : schemeDetails) {
							String detailStatus = schemeDetail.getStatus();
							if (null == detailStatus || !"已完成".equals(detailStatus)) {
								isFinish = false;
								break;
							}
						}
						if (isFinish) {
							schemeSerive.updateState(schemeId, "已完成");
						} else if (!isFinish && "未执行".equals(scheme.getExecuteState())) {
							schemeSerive.updateState(schemeId, "执行中");
						}
					}
				}

			}

		}else if("未通过".equals(status)) {
			RotateSchedule rotateSchedule = scheduleService.get(id);
			sysOAService.SendMessage(rotateSchedule.getReporterId(), "msg", "进度上报驳回通知", "进度上报未通过", "");
		}
		sysLogService.add(request, "轮换业务-执行进度-进度上报-"+status);
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}

	@SysLogAn("轮换业务-执行进度-进度上报-删除")
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	@ResponseBody
	public Object  remove(@RequestParam(value="id")String id) throws IOException {
			
		ActionResultModel actionResultModel = new ActionResultModel();
		scheduleService.remove(id);
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}
	
}
