package com.dhc.fastersoft.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.service.*;
import com.dhc.fastersoft.service.store.StoreEnterpriseService;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.entity.ImportParams;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.system.SysLogService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.PageUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 标的物
 * @author lay
 *
 */
@Controller
@RequestMapping("/rotateBID")
public class RotateBIDController {
	private static Logger log = Logger.getLogger(RotateBIDController.class);
	
	@Autowired
	private RotateBIDService service;
	@Autowired
	private StoreEnterpriseService enterpriseService;
	@Autowired
	private RotateInviteService inviteService;
	@Autowired
	private RotateSchemeService schemeService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private SysFileService fileService;
	@Autowired
	private SysLogService sysLogService;
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private StorageWarehouseService storageWarehouseService;

	@RequestMapping("/add")
	public String add(Model model) {
		model.addAttribute("model", new RotateBID());
		List<RotateSchemeDetail> schemeDetails=schemeService.listDetail(new HashMap<String,String>());
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("schemeDetails", schemeDetails);
		model.addAttribute("isEdit", false);
		return "RotateBID/rotatebid_add";
	}
	
	@RequestMapping(value="/edit",params="sid")
	public String update(Model model,@RequestParam("sid") String sid) {
		RotateBID rotateBID=service.get(sid);
		if(BusinessConstants.TENDER_TYPE_ZBCG.equals(rotateBID.getBidType())){
			model.addAttribute("detailList", service.listPurchase(sid));
		}else{
			model.addAttribute("detailList", service.listSale(sid));
		}

		HashMap<String, String> map = new HashMap<>();
		List<RotateSchemeDetail> schemeDetails=schemeService.listDetail(map);
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		SysFile myFile = fileService.selectById(rotateBID.getGroupID());
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("schemeDetails", schemeDetails);
		model.addAttribute("model", rotateBID);
		model.addAttribute("isEdit", true);
		model.addAttribute("myFile", myFile);
		if(myFile!=null){
			String downloadUrl = myFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			model.addAttribute("suffix", suffix);
		}
		return "RotateBID/rotatebid_add";
	}

	@SysLogAn("访问：轮换业务-竞标管理-标的物明细")
	@RequestMapping("/main")
	public String main(Model model,
			@RequestParam(value="isPartial",required=false) boolean isPartial) {
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		return "RotateBID/rotatebid_main";
	}
	
	@RequestMapping(value="/view",params="sid")
	public String view(Model model,@RequestParam("sid") String sid) {
		RotateBID rotateBID=service.get(sid);
		SysFile myFile = fileService.selectById(rotateBID.getGroupID());
		model.addAttribute("model", rotateBID);
		model.addAttribute("myFile", myFile);
		if(myFile!=null){
			String downloadUrl = myFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			model.addAttribute("suffix", suffix);
		}
		return "RotateBID/rotatebid_view";
	}
	
	//---接口----
	/**
	 * excel导入
	 * @param file
	 * @param bidType
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	@SysLogAn("轮换业务-竞标管理-标的物明细-导入模板")
	@RequestMapping(value = "/importExcel",method=RequestMethod.POST)
	@ResponseBody
	public Object importExcel(@RequestParam(value="file") MultipartFile file,
			@RequestParam(value="bidType") String bidType) throws IOException, Exception {
		ActionResultModel actionResultModel = new ActionResultModel();
		ImportParams params = new ImportParams();
		if (BusinessConstants.TENDER_TYPE_ZBCG.equals(bidType)) {
			List<RotateBIDPurchase> purchaseList = ExcelImportUtil.importExcel(file.getInputStream(), RotateBIDPurchase.class, params);
			actionResultModel.setData(purchaseList);
		} else {
			List<RotateBIDSale> saleList = ExcelImportUtil.importExcel(file.getInputStream(), RotateBIDSale.class, params);
			actionResultModel.setData(saleList);
		}
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}
	/**
	 * 新增、更新
	 * @param rotateBID
	 * @param isedit
	 * @param
	 * @param
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveOrUpdate(RotateBID rotateBID, HttpServletRequest request,
			@RequestParam(value="isedit",required=false) Boolean isedit,
			@RequestParam(value="detailList",required=false) String detailList) throws IOException {
		SysUser user = TokenManager.getToken();
		ObjectMapper mapper = new ObjectMapper();
		if(rotateBID.getBidType().contains("采购")) {
				List<RotateBIDPurchase> purchaseList = mapper.readValue(detailList,
						TypeFactory.defaultInstance()
						.constructCollectionType(List.class,RotateBIDPurchase.class));
			//先判断导入的库点是否存在需要关联库点id
			for (RotateBIDPurchase rotateBIDSale:purchaseList) {
				if(rotateBIDSale!=null && rotateBIDSale.getEnterprise()!=null){
                    StoreEnterprise enterprise = enterpriseService.getStoreEnterpriseByEnterpriseName(rotateBIDSale.getEnterprise().trim());
                    if(enterprise!=null && StringUtils.isNotEmpty(enterprise.getId())){
                        rotateBIDSale.setEnterpriseId(enterprise.getId());
                    }else{
                        ActionResultModel actionResultModel = new ActionResultModel();
                        actionResultModel.setMsg("明细中的" + rotateBIDSale.getEnterprise() + "不存在");
                        actionResultModel.setSuccess(false);
                        return actionResultModel;
                    }
                }else{
                    ActionResultModel actionResultModel = new ActionResultModel();
                    actionResultModel.setMsg("明细中的" + rotateBIDSale.getEnterprise() + "不存在");
                    actionResultModel.setSuccess(false);
                    return actionResultModel;
                }

			    if(rotateBIDSale!=null && StringUtils.isNotEmpty(rotateBIDSale.getCompany())) {
					List<StorageWarehouse> list = storageWarehouseService.getWarehouseCode(rotateBIDSale.getCompany());
					if (list.size() > 0) {
						rotateBIDSale.setWareHouseId(list.get(0).getId());
					} else {
						//不存在
						ActionResultModel actionResultModel = new ActionResultModel();
						actionResultModel.setMsg("明细中的" + rotateBIDSale.getCompany() + "不存在");
						actionResultModel.setSuccess(false);
						return actionResultModel;
					}
				}
				//判断对应子方案中数量和采购标的物明细表中（对应子方案数量+当前保存数据中数量）的大小关系
				/*子方案数量*/
				RotateSchemeDetail RotateSchemeDetail = schemeService.getSchemeDetailByDetailId(rotateBIDSale.getSchemeID());
				Double rotateNumber =  RotateSchemeDetail.getRotateNumber();
				BigDecimal schemeQuantity = BigDecimal.valueOf(rotateNumber);
				/*采购标的明细表中对应子方案中数量和*/
				Map<String, Object> map = new HashMap<String ,Object>();
				map.put("rotateSchemeDetailId",rotateBIDSale.getSchemeID());
				BigDecimal sumQuantity = new BigDecimal(0);
				sumQuantity =sumQuantity.add(service.sumQuantityByBidId(map));
				//前台出入的数量
				BigDecimal quantity = rotateBIDSale.getQuantity();
				if(null == isedit || !isedit){
					//新增时对应子方案已有的数量要加上前台传入的数量
					sumQuantity = sumQuantity.add(quantity);
				}else{
					map.put("rotateBIDId",rotateBID.getId());
					//编辑时对应子方案已有的数量要减去当前标的中对应子方案的数量再加上前台传入的数量
					sumQuantity =sumQuantity.subtract(service.sumQuantityByBidId(map)).add(quantity);
				}

				//如果标的总和大于子方案数量，则不让保存
				if(sumQuantity.compareTo(schemeQuantity) == 1){
					ActionResultModel actionResultModel = new ActionResultModel();
					actionResultModel.setMsg("明细中的"+rotateBIDSale.getBidSerial()+"数量超过子方案中的数量");
					actionResultModel.setSuccess(false);
					return actionResultModel;
				}

			}
				rotateBID.setPurchaseList(purchaseList);

		}else {
				List<RotateBIDSale> saleList = mapper.readValue(detailList,
						TypeFactory.defaultInstance()
						.constructCollectionType(List.class,RotateBIDSale.class));;
						//先判断导入的库点是否存在需要关联库点id
			for (RotateBIDSale rotateBIDSale:saleList) {
				List<StorageWarehouse> list =storageWarehouseService.getWarehouseCode(rotateBIDSale.getDeliveryPlace());
				if(list.size()>0){
					rotateBIDSale.setWareHouseId(list.get(0).getId());
				}else {
					//不存在
					ActionResultModel actionResultModel = new ActionResultModel();
					actionResultModel.setMsg("明细中的"+rotateBIDSale.getDeliveryPlace()+"不存在");
					actionResultModel.setSuccess(false);
					return actionResultModel;
				}
				//判断对应子方案中数量和销售标的物明细表中（对应子方案数量+当前保存数据中数量）的大小关系
				/*子方案数量*/
				RotateSchemeDetail RotateSchemeDetail = schemeService.getSchemeDetailByDetailId(rotateBIDSale.getSchemeID());
				Double rotateNumber =  RotateSchemeDetail.getRotateNumber();
				BigDecimal schemeQuantity = BigDecimal.valueOf(rotateNumber);
				/*销售标的明细表中对应子方案中数量和*/
				Map<String, Object> map = new HashMap<String ,Object>();
				map.put("rotateSchemeDetailId",rotateBIDSale.getSchemeID());
				BigDecimal sumQuantity = new BigDecimal(0);
				sumQuantity =sumQuantity.add(service.sumSaleQuantityByBidId(map));

				BigDecimal quantity = rotateBIDSale.getTotal();

				if(null == isedit || !isedit){
					//新增时对应子方案已有的数量要加上前台传入的数量
					sumQuantity = sumQuantity.add(quantity);
				}else{
					map.put("rotateBIDId",rotateBID.getId());
					//编辑时对应子方案已有的数量要减去当前标的中对应子方案的数量再加上前台传入的数量
					sumQuantity =sumQuantity.subtract(service.sumSaleQuantityByBidId(map)).add(quantity);
				}
				//如果标的总和大于子方案数量，则不让保存
				if(sumQuantity.compareTo(schemeQuantity) == 1){
					ActionResultModel actionResultModel = new ActionResultModel();
					actionResultModel.setMsg("明细中的"+rotateBIDSale.getBidSerial()+"数量超过子方案中的数量");
					actionResultModel.setSuccess(false);
					return actionResultModel;
				}

			}
				rotateBID.setSaleList(saleList);
		}
		
		if(null == isedit || !isedit) {
			sysLogService.add(request, "轮换业务-竞标管理-标的物明细-新增");
			rotateBID.setCreator(user.getId());
			service.save(rotateBID);
		}else {
			// 查询是否存在招标结果
			int count= inviteService.count(0,0,null,null,null,rotateBID.getId());
			if(count != 0){
				ActionResultModel actionResultModel = new ActionResultModel();
				actionResultModel.setSuccess(false);
				actionResultModel.setMsg("已存在对应的招标结果");
				return actionResultModel;
			}
			sysLogService.add(request, "轮换业务-竞标管理-标的物明细-编辑");
			rotateBID.setModifier(user.getId());
			service.update(rotateBID);
		}
		
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}
	/**
	 * 删除
	 * @param sid
	 * @return
	 */
	@SysLogAn("轮换业务-竞标管理-标的物明细-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel delete(String sid) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=service.remove(sid);
		int row2=service.removeDetail(sid);
		if(row>0&&row2>0) {
			actionResultModel.setSuccess(true);
			actionResultModel.setMsg("删除成功");
		}else {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("删除失败");
		}
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	/**
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/listPagination")
	@ResponseBody
	public LayPage<RotateBID> listPagination(
			@RequestParam(value="pageIndex",required=false) int pageIndex,
			@RequestParam(value="pageSize",required=false) int pageSize,
			@RequestParam(value="bidType",required=false) String bidType,
			@RequestParam(value="tenderee",required=false) String tenderee,
			@RequestParam(value="saler",required=false) String saler,
			@RequestParam(value="foodType",required=false) String foodType,
			@RequestParam(value="createDate",required=false) String createDate) throws UnsupportedEncodingException {
		

		HashMap<String, String> map =new HashMap<>();
		map.put("pageIndex", String.valueOf(pageIndex));
		map.put("pageSize", String.valueOf(pageSize));
		map.put("bidType", bidType);
		map.put("tenderee", tenderee);
		map.put("foodType", foodType);
		map.put("createDate", createDate);
		map.put("saler", saler);
		int total=service.count(map);
		List<RotateBID> list =null;
		if(total>0)
			list = service.list(map);
		
		LayPage<RotateBID> pageUtil=new LayPage<>(list,total);
		return pageUtil;
	}
	
	/**
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	public PageUtil<RotateBID> list(
			@RequestParam(value="pageIndex",required=false) int pageIndex,
			@RequestParam(value="pageSize",required=false) int pageSize,
			@RequestParam(value="bidType",required=false) String bidType,
			@RequestParam(value="tenderee",required=false) String tenderee,
			@RequestParam(value="foodType",required=false) String foodType,
			@RequestParam(value="createDate",required=false) String createDate,
			@RequestParam(value="saler",required=false) String saler) throws UnsupportedEncodingException {
		

		HashMap<String, String> map =new HashMap<>();
		map.put("pageIndex", String.valueOf(pageIndex));
		map.put("pageSize", String.valueOf(pageSize));
		map.put("bidType", bidType);
		map.put("tenderee", tenderee);
		map.put("foodType", foodType);
		map.put("createDate", createDate);
		map.put("saler", saler);
		int total=service.count(map);
		List<RotateBID> list =null;
		if(total>0)
			list = service.list(map);
		
		PageUtil<RotateBID> pageUtil=new PageUtil<>();
		pageUtil.setPageIndex(pageIndex);
		pageUtil.setPageSize(pageSize);
		pageUtil.setResult(list);
		pageUtil.setTotalCount(total);
		return pageUtil;
	}

}
