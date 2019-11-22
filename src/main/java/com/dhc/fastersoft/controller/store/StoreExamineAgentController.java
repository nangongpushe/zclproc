package com.dhc.fastersoft.controller.store;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.controller.BaseController;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.store.StoreExamine;
import com.dhc.fastersoft.entity.store.StoreExamineItem;
import com.dhc.fastersoft.entity.store.StoreTemplate;
import com.dhc.fastersoft.entity.store.StoreTemplateItem;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.store.*;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.system.SysRoleService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayPage;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("StoreExamineAgent")
public class StoreExamineAgentController extends BaseController {

    @Autowired
    StoreExamineService storeExamineService;
    @Autowired
    StoreTemplateService storeTemplateService;
    @Autowired
    StoreExamineItemService storeExamineItemService;
    @Autowired
    SysFileService sysFileService;
    @Autowired
    SysDictService sysDictService;
    @Autowired
    SysRoleService sysRoleService;
    @Autowired
    SysUserService sysUserService;
    @Autowired
    StoreEnterpriseService storeEnterpriseService;
    @Autowired
    StoreTemplateItemService storeTemplateItemService;
    @Autowired
    StorageWarehouseService storageWarehouseService;


    @RequestMapping("index")
    public String index(ModelMap map) {
//		 List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
//			map.put("storehouses", storehouses);
//			List<SysDict> storehouses1 = new ArrayList<SysDict>() ;
//			//现获取用户的权限
//			Set<String> types = sysRoleService.findRoleTypeByUserId(TokenManager.getSysUserId());
//			for (String type : types) {
//				 if (type.equals("库点管理员")) {
//					//去分片监管查库看监管的企业  通过企业编号唯一去查找库的名称
//					SysUser sysUser = 	sysUserService.selectByPrimaryKey(TokenManager.getSysUserId());
//					SysDict sysDict = new SysDict();
//					storehouses1.add(sysDict);
//					sysDict.setValue(TokenManager.getToken().getShortName());
//					map.put("storehouses", storehouses1);
//				
//				}
//			}
        HashMap<String, Object> maps = new HashMap<>();
        maps.put("warehouseType", "代储库");
        List<StorageWarehouse> storehouses = storageWarehouseService.listValidWarehouse(maps);
        map.put("storehouses", storehouses);
        map.put("falg", "");


        maps.put("warehouseShort", TokenManager.getToken().getShortName());
        int i = storageWarehouseService.check(maps);
        List<StorageWarehouse> storehouses1 = new ArrayList<StorageWarehouse>();
        if (i > 0) {
            StorageWarehouse storageWarehouse = new StorageWarehouse();
            storageWarehouse.setWarehouseShort(TokenManager.getToken().getShortName());
            storehouses1.add(storageWarehouse);
            map.put("storehouses", storehouses1);
            map.put("falg", "1");
        }

        return "/StoreExamineAgent/storeExamine_list";
    }

    @SysLogAn("访问：代储监管-业务信息-考核评分")
    @RequestMapping("")
    public String main(ModelMap map) {
//		 List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
//		 map.put("storehouses", storehouses);
        HashMap<String, Object> maps = new HashMap<>();
        maps.put("warehouseType", "代储库");
        //监管的
        List<StorageWarehouse> storehouses = storageWarehouseService.listValidWarehouse(maps);
        map.put("storehouses", storehouses);
        map.put("falg", "");
        List<String> kudianCodes = storageWarehouseService.listKudianCode();
        boolean isKudian = kudianCodes.contains(TokenManager.getToken().getOriginCode());
        //代储
        if ("cbl".equals(TokenManager.getToken().getOriginCode().toLowerCase())) {


        } else {


            if (!"".equals(TokenManager.getToken().getShortName())) {
                if (isKudian) {
                    storehouses = storageWarehouseService.listSuperviseOfWarehouse(TokenManager.getToken().getShortName());
                    map.put("storehouses", storehouses);
                } else {
                    maps.put("warehouseShort", TokenManager.getToken().getShortName());
                    int i = storageWarehouseService.check(maps);
                    //自己  就要自评
                    List<StorageWarehouse> storehouses1 = new ArrayList<StorageWarehouse>();
                    if (i > 0) {
                        StorageWarehouse storageWarehouse = new StorageWarehouse();
                        storageWarehouse.setWarehouseShort(TokenManager.getToken().getShortName());
                        storehouses1.add(storageWarehouse);
                        map.put("storehouses", storehouses1);
                        map.put("falg", "1");
                    }
                }

            }
        }
        return "/StoreExamineAgent/storeExamine_list";
    }

    @RequestMapping("/select_templet_list")
    public String selectDurablesList() {
        return "/StoreExamineAgent/select_templet_list";
    }

    /**
     * 方法名 list
     * 方法作用: 获取列表
     * 作者：张乐
     * 修改时间: 2017年10月3日 下午8:11:08
     */
    @RequestMapping(value = "/listValidWarehouse")
    @ResponseBody
    public List<StorageWarehouse> listValidWarehouse(HttpServletRequest request) {

//			LayPage<StoreFeedBack> list = storeFeedBackService.list(request,"0");
        HashMap<String, Object> maps = new HashMap<>();
        maps.put("warehouseType", "代储库");
        List<StorageWarehouse> list = storageWarehouseService.listValidWarehouse(maps);
//				map.put("storehouses", storehouses);
        return list;
    }


    /**
     * 方法名 toAdd
     * 方法作用: 添加
     * 作者：张乐
     * 修改时间: 2017年9月28日 下午5:03:12
     */
    @RequestMapping("add")
    public String toAdd(ModelMap modelMap) {
        SysUser user = TokenManager.getToken();

        modelMap.put("examineSerial", this.getId());
        modelMap.put("storehouse", user.getShortName());
        modelMap.put("falg", "");

        List<StorageWarehouse> warehouseList;
        HashMap<String, Object> maps = new HashMap<>();
        maps.put("warehouseType", "代储库");
        warehouseList = storageWarehouseService.listValidWarehouse(maps);
        modelMap.put("storehouses", warehouseList);

        List<String> baseWarehouseCodeList = storageWarehouseService.listKudianCode();
        boolean isBaseWarehouse = baseWarehouseCodeList.contains(user.getOriginCode());
        if (user.getShortName() != null && !"".equals(user.getShortName())) {
            if (isBaseWarehouse) {//分片监管库点
                warehouseList = storageWarehouseService.listSuperviseOfWarehouse(user.getShortName());
                modelMap.put("storehouses", warehouseList);
            } else {//代储库点
                String warehouseId  = user.getWareHouseId();
                warehouseList = new ArrayList<>();
                if(StringUtils.isNotEmpty(warehouseId)){
                    StorageWarehouse storageWarehouse = storageWarehouseService.getWarehouseById(warehouseId);
                    warehouseList.add(storageWarehouse);
                    modelMap.put("storehouses", warehouseList);
                    modelMap.put("falg", "1");
                }
            }
        }

        return "/StoreExamineAgent/storeExamine_add";
    }


    /**
     * 方法名 edit
     * 方法作用:
     * 作者：张乐
     * 修改时间: 2017年9月29日 下午5:59:25
     */
    @RequestMapping("edit")
    public String edit(HttpServletRequest request, ModelMap modelMap, String id) {
        SysUser user = TokenManager.getToken();
        StoreExamine StoreExamine = storeExamineService.getStoreExamineByID(id);
        modelMap.put("storeExamine", StoreExamine);
        modelMap.put("storehouse", user.getShortName());

        HashMap<String, Object> maps = new HashMap<>();
        maps.put("warehouseType", "代储库");
        List<StorageWarehouse> warehouseList = storageWarehouseService.listValidWarehouse(maps);
        modelMap.put("storehouses", warehouseList);

        modelMap.put("falg", "");
        List kudianCodes = storageWarehouseService.listKudianCode();
        boolean isKudian = kudianCodes.contains(user.getOriginCode());
        //代储

        if (!"".equals(user.getShortName())) {
            if (isKudian) {
                warehouseList = storageWarehouseService.listSuperviseOfWarehouse(user.getShortName());
                modelMap.put("storehouses", warehouseList);
            } else {
                String warehouseId = storageWarehouseService.getWarehouseIdByShortname(user.getShortName());
                warehouseList = new ArrayList<>();
                if(warehouseId != null){
                    StorageWarehouse storageWarehouse = new StorageWarehouse();
                    storageWarehouse.setId(warehouseId);
                    storageWarehouse.setWarehouseShort(user.getShortName());
                    warehouseList.add(storageWarehouse);
                    modelMap.put("storehouses", warehouseList);
                    modelMap.put("falg", "1");
                }
            }

			}
			SysFile myFile=sysFileService.selectById(StoreExamine.getGroupId());
            modelMap.addAttribute("myFile", myFile);
			if(myFile!=null){
				String downloadUrl = myFile.getDownloadUrl();
				String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
                modelMap.addAttribute("suffix", suffix);
			}
			return "/StoreExamineAgent/storeExamine_edit";
		}
		
		@RequestMapping("print")
		public String print(HttpServletRequest request,ModelMap map,String id){
			StoreExamine StoreExamine = storeExamineService.getStoreExamineByID(id);
			map.addAttribute("storeExamine", StoreExamine);
//			List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
//			map.put("storehouses", storehouses);
//			SysFile sysFile=sysFileService.selectById(StoreExamine.getGroupId());
//			map.addAttribute("sysFile", sysFile);
			return "/StoreExamineAgent/storeExamine_print";
		}
		
		/**
		* 方法名 edit
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年9月29日 下午5:59:25
		 */
		@RequestMapping("view")
		public String view(HttpServletRequest request,ModelMap map,String id){
			StoreExamine StoreExamine = storeExamineService.getStoreExamineByID(id);
			map.addAttribute("storeExamine", StoreExamine);
			List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
			map.put("storehouses", storehouses);
			SysFile myFile=sysFileService.selectById(StoreExamine.getGroupId());
			map.addAttribute("myFile", myFile);
			if(myFile!=null){
				String downloadUrl = myFile.getDownloadUrl();
				String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
				map.addAttribute("suffix", suffix);
			}
			return "/StoreExamineAgent/storeExamine_view";
		}
		
		/**
		* 方法名 save
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年9月28日 下午5:03:37
		 */
		@RequestMapping(value="/Create",method={RequestMethod.POST})
		@ResponseBody
		public ActionResultModel Create(StoreExamine storeExamine, HttpServletRequest request, ModelMap modelMap, @RequestParam(value="file",required=false) MultipartFile[] files){
			//User user=(User) WebUtils.getSessionAttribute(request, "user");
			
		
			ActionResultModel actionResultModel = new ActionResultModel();
//			JSONObject ret = new JSONObject();
        String id = request.getParameter("id");
        storeExamine.setCreatorId(TokenManager.getSysUserId());
        storeExamine.setType("0");
//			StoreExamine StoreExamine = new StoreExamine();
        try {

            if (files.length > 0) {
                String groupId = UUID.randomUUID().toString().replace("-", "");
                sysFileService.uploadFile(request, groupId, files[0], "storeExamine");
                storeExamine.setGroupId(groupId);
            }

            if (id.length() == 0) {
                storeExamine.setId(UUID.randomUUID().toString().replace("-", ""));

                storeExamineService.add(storeExamine);
                sysLogService.add(request, "代储监管-业务信息-考核评分-新增");
            } else {
                storeExamine.setId(id);
                storeExamineService.update(storeExamine);
                sysLogService.add(request, "代储监管-业务信息-考核评分-修改");
            }

            //先删除所有选择
            String[] itemNames = request.getParameterValues("itemName");
            String[] points = request.getParameterValues("point");
            String[] standards = request.getParameterValues("standard");
            String[] parentIds = request.getParameterValues("parentId");


            //先删除所有附件
            storeExamineItemService.remove(storeExamine.getExamineSerial());

            if (standards != null) {
                for (int i = 0; i < standards.length; i++) {
                    StoreExamineItem storeExamineItem = new StoreExamineItem();
                    storeExamineItem.setId(UUID.randomUUID().toString().replace("-", ""));
                    storeExamineItem.setItem(itemNames[i]);
                    storeExamineItem.setPoint(points[i]);
                    storeExamineItem.setStandard(standards[i]);
                    storeExamineItem.setExamineId(storeExamine.getExamineSerial());
                    storeExamineItem.setParentId(parentIds[i]);
                    storeExamineItemService.add(storeExamineItem);
                }
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
     * 方法作用: 获取列表
     * 作者：张乐
     * 修改时间: 2017年10月3日 下午8:11:08
     */
    @RequestMapping(value = "/list")
    @ResponseBody
    public LayPage<StoreExamine> list(HttpServletRequest request) {

        LayPage<StoreExamine> list = storeExamineService.list(request, "0");
        return list;
    }

    @RequestMapping(value = "/templetList")
    @ResponseBody
    public LayPage<StoreTemplate> selectTempletList(HttpServletRequest request) {

        LayPage<StoreTemplate> list = storeTemplateService.list(request);
        return list;
    }


    /**
     * 方法名 delete
     * 方法作用:
     * 作者：张乐
     * 修改时间: 2017年10月3日 下午1:37:42
     */
    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    @ResponseBody
    public ActionResultModel delete(String id) {
        ActionResultModel actionResultModel = new ActionResultModel();
        int row = storeExamineService.remove(id);
        if (row > 0) {
            actionResultModel.setSuccess(true);
            actionResultModel.setMsg("删除成功");
        } else {
            actionResultModel.setSuccess(false);
            actionResultModel.setMsg("删除失败");
        }
        actionResultModel.setSuccess(true);
        return actionResultModel;
    }

    public String getId() {
        String id = "";
        //获取当前时间戳
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
        String temp = sf.format(new Date());
        //获取6位随机数
        int random = (int) ((Math.random() + 1) * 1000);
        id = temp + random;
        return id;
    }


    /**
     * 方法名 getStoreTemplateContent
     * 方法作用: 获取考核选项
     * 作者：张乐
     * 修改时间: 2017年10月14日 下午1:41:39
     */
    @RequestMapping(value = "getStoreTemplate", method = RequestMethod.POST)
    @ResponseBody
    public ActionResultModel getStoreTemplate(String id, HttpServletRequest request, String templateId, String examineId) {
        ActionResultModel actionResultModel = new ActionResultModel();

        StoreTemplateItem storeTemplateItem0 = new StoreTemplateItem();
        storeTemplateItem0.setItemName("考评项目");
        Integer oneRowSpan = 0;

        //1.找到第一级节点
        List<StoreTemplateItem> storeTemplateItems = storeTemplateItemService.getOneClassList(templateId);
        storeTemplateItem0.setChildren(storeTemplateItems);
        //2.找到第2级节点
        for (StoreTemplateItem storeTemplateItem : storeTemplateItems) {
            HashMap<String, Object> maps = new HashMap<String, Object>();
            maps.put("parentId", storeTemplateItem.getId());
            maps.put("templetId", templateId);
            List<StoreTemplateItem> storeTemplateItems2 = storeTemplateItemService.getTwoClassList(maps);
            storeTemplateItem.setChildren(storeTemplateItems2);
            //3.找到第3级节点
            for (StoreTemplateItem storeTemplateItem2 : storeTemplateItems2) {
                List<StoreExamineItem> storeTemplateItems3 = storeExamineItemService.getItemListByParentId(storeTemplateItem2.getId(), examineId);

                oneRowSpan = oneRowSpan + storeTemplateItems3.size();
                List<StoreTemplateItem> storeTemplateItems4 = new ArrayList<StoreTemplateItem>();
                for (StoreExamineItem storeExamineItem : storeTemplateItems3) {
                    StoreTemplateItem templateItem = new StoreTemplateItem();
                    templateItem.setParentId(storeExamineItem.getParentId());
                    templateItem.setPoint(storeExamineItem.getPoint());
                    templateItem.setStandard(storeExamineItem.getStandard());
                    templateItem.setItemName(storeExamineItem.getItem());
                    storeTemplateItems4.add(templateItem);
                }
                storeTemplateItem2.setChildren(storeTemplateItems4);
            }
            storeTemplateItem.setRowspan(oneRowSpan);

        }
        actionResultModel.setData(storeTemplateItem0);
        actionResultModel.setSuccess(true);
        return actionResultModel;
    }

}
