package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.StorageStoreHouse;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageOilcanService;
import com.dhc.fastersoft.service.StorageStoreHouseService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.util.BeanUtils;
import com.dhc.fastersoft.util.DataAuthorityUtil;
import com.dhc.fastersoft.utils.LayPage;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.*;

@RequestMapping("/storageStoreHouse")
@Controller
public class StorageStoreHouseController extends BaseController{

    @Autowired
    private StorageStoreHouseService service;
    @Autowired
    private SysDictService dicService;
    @Autowired
    private StorageWarehouseService swService;
    @Autowired
    private StorageOilcanService storageOilcanService;

    @RequestMapping()
    public String index(Model model, HttpServletRequest request) {

        String type = "仓房状态";
        List<SysDict> dictList = dicService.getSysDictListByType(type);
        //System.out.println(dictList.size());
        model.addAttribute("statusDict", dictList);
        String flag = request.getParameter("flag");
        if ("dc".equals(flag)){
            sysLogService.add(request, "访问：代储管理-企业信息-仓房管理");
        }else{
            sysLogService.add(request, "访问：仓储管理-仓房管理-仓房信息管理");
        }
        model.addAttribute("flag", flag);

        return "storageStoreHouse/store_house_main";
    }

    @RequestMapping("/addPage")
    public String addPage(Model model, HttpServletRequest request) {
        model.addAttribute("auvp", "a");
        StorageStoreHouse storageStoreHouse = new StorageStoreHouse();

        String flag = request.getParameter("flag");
        String enterpriseName = DataAuthorityUtil.getDataAuthority(flag);
        List<StorageWarehouse> wareHouses = new ArrayList<StorageWarehouse>();
        if (BeanUtils.isEmpty(enterpriseName)) {
            SysUser user = TokenManager.getToken();
            String warehouseName = user.getShortName();
            storageStoreHouse.setWarehouse(warehouseName);
            storageStoreHouse.setWarehouseCode(user.getOriginCode());

            StorageWarehouse storageWarehouse = new StorageWarehouse();
            storageWarehouse.setWarehouseName(warehouseName);
            storageWarehouse.setWarehouseCode(user.getOriginCode());
            //----------------Jovan-----------------------//
            storageWarehouse.setId(user.getWareHouseId());
            //----------------Jovan-----------------------//
            wareHouses.add(storageWarehouse);
        } else {
            Map<String,String> paramMap = new HashMap<String,String>();
            paramMap.put("enterpriseName",enterpriseName);
            wareHouses = swService.listWareHouseByEnterPriseName(paramMap);
            if (BeanUtils.isNotEmpty(wareHouses)) {
                storageStoreHouse.setWarehouse(wareHouses.get(0).getWarehouseName());
                storageStoreHouse.setWarehouseCode(wareHouses.get(0).getWarehouseCode());
            }
        }

        model.addAttribute("storageStoreHouse", storageStoreHouse);
        model.addAttribute("wareHouses", wareHouses);

        String type = "仓房状态";
        List<SysDict> dictList = dicService.getSysDictListByType(type);
        model.addAttribute("statusDict", dictList);

        String type1 = "仓房类型";
        List<SysDict> typeDict = dicService.getSysDictListByType(type1);
        model.addAttribute("typeDict", typeDict);
        model.addAttribute("flag", request.getParameter("flag"));
        return "storageStoreHouse/store_house_add";
    }

    @RequestMapping(value = "/save", method = {RequestMethod.POST})
    @ResponseBody
    public ActionResultModel save(@RequestParam(value = "auvp") String auvp, @RequestBody StorageStoreHouse storageStoreHouse) {
        ActionResultModel result = new ActionResultModel();
        storageStoreHouse.setCreatorId(TokenManager.getSysUserId());
        //--------------------------Jovan---------------------------//
        String warehouseCode = storageStoreHouse.getWarehouseCode();
        String wareHouseId = swService.getWareHouseIdByCode(warehouseCode);
        storageStoreHouse.setWarehouseId(wareHouseId);
        //--------------------------Jovan---------------------------//
        //如果仓房长度传入的为0，为了避免前端length属性冲突，默认设为null
        BigDecimal length = storageStoreHouse.getLength();
        if((BigDecimal.ZERO).equals(length)){
            storageStoreHouse.setLength(null);
        }

        //System.out.println(auvp + storageStoreHouse.toString());
        String flag = request.getParameter("flag");
        if (auvp.equals("a")) {
            storageStoreHouse.setId(UUID.randomUUID().toString().replace("-", ""));
            result = service.saveForSingle(storageStoreHouse);
            if ("dc".equals(flag)){
                sysLogService.add(request, "代储监管-企业信息-仓房管理-增加");
            }else{
                sysLogService.add(request, "仓储管理-仓房管理-仓房信息管理-增加");
            }
        } else if (auvp.equals("u")) {
            result = service.updateForSingle(storageStoreHouse);
            if ("dc".equals(flag)){
                sysLogService.add(request, "代储监管-企业信息-仓房管理-修改");
            }else{
                sysLogService.add(request, "仓储管理-仓房管理-仓房信息管理-修改");
            }
        }
        return result;
    }

    /**
     * 批量新增或修改数据
     * @param auvp
     * @param storageStoreHouses
     * @return
     */
    @RequestMapping(value = "/manySave", method = {RequestMethod.POST})
    @ResponseBody
    public ActionResultModel manySave(@RequestParam(value = "auvp") String auvp, @RequestBody ArrayList<StorageStoreHouse> storageStoreHouses) {
        ActionResultModel result = new ActionResultModel();
        for (StorageStoreHouse storageStoreHouse:storageStoreHouses) {
            storageStoreHouse.setCreatorId(TokenManager.getSysUserId());
            //--------------------------Jovan---------------------------//
            String warehouseCode = storageStoreHouse.getWarehouseCode();
            String wareHouseId = swService.getWareHouseIdByCode(warehouseCode);
            storageStoreHouse.setWarehouseId(wareHouseId);
            //--------------------------Jovan---------------------------//
            String flag = request.getParameter("flag");
            if (auvp.equals("a")) {
                storageStoreHouse.setId(UUID.randomUUID().toString().replace("-", ""));
                result = service.saveForSingle(storageStoreHouse);
                if ("dc".equals(flag)) {
                    sysLogService.add(request, "代储监管-企业信息-仓房管理-增加");
                } else {
                    sysLogService.add(request, "仓储管理-仓房管理-仓房信息管理-增加");
                }
            } else if (auvp.equals("u")) {
                result = service.updateForSingle(storageStoreHouse);
                if ("dc".equals(flag)) {
                    sysLogService.add(request, "代储监管-企业信息-仓房管理-修改");
                } else {
                    sysLogService.add(request, "仓储管理-仓房管理-仓房信息管理-修改");
                }
            }
        }
        return result;
    }

    @RequestMapping("/list")
    @ResponseBody
    public LayPage<StorageStoreHouse> list(HttpServletRequest request) {
        LayPage<StorageStoreHouse> page = service.list(request);
        return page;
    }

    @RequestMapping("/viewPage")
    public String viewPage(Model model, @RequestParam(value = "id") String id, HttpServletRequest request) {
        StorageStoreHouse storageStoreHouse = service.getSingle(id);
        model.addAttribute("auvp", "v");
        model.addAttribute("storageStoreHouse", storageStoreHouse);

        String type = "仓房状态";
        List<SysDict> dictList = dicService.getSysDictListByType(type);
        model.addAttribute("statusDict", dictList);

        String type1 = "仓房类型";
        List<SysDict> typeDict = dicService.getSysDictListByType(type1);
        model.addAttribute("typeDict", typeDict);
        model.addAttribute("flag", request.getParameter("flag"));
        return "storageStoreHouse/store_house_view";
    }

    @SysLogAn("仓房管理-删除")
    @RequestMapping("/remove")
    @ResponseBody
    public ActionResultModel remove(@RequestParam(value = "id") String id, String flag) {
        ActionResultModel result = new ActionResultModel();
        result = service.remove(id);
        if ("dc".equals(flag)){
            sysLogService.add(request, "代储监管-企业信息-仓房管理-删除");
        }else{
            sysLogService.add(request, "仓储管理-仓房管理-仓房信息管理-删除");
        }
        return result;
    }

    @RequestMapping("/editPage")
    public String editPage(Model model, @RequestParam(value = "id") String id, HttpServletRequest request) {
        StorageStoreHouse storageStoreHouse = service.getSingle(id);
        model.addAttribute("auvp", "u");
        model.addAttribute("storageStoreHouse", storageStoreHouse);

        String flag = request.getParameter("flag");
        String enterpriseName = DataAuthorityUtil.getDataAuthority(flag);
        List<StorageWarehouse> wareHouses = new ArrayList<StorageWarehouse>();
        if (BeanUtils.isEmpty(enterpriseName)) {
            StorageWarehouse storageWarehouse = new StorageWarehouse();
            storageWarehouse.setWarehouseName(storageStoreHouse.getWarehouse());
            storageWarehouse.setWarehouseCode(storageStoreHouse.getWarehouseCode());
            wareHouses.add(storageWarehouse);
        } else {
            Map<String,String> paramMap = new HashMap<String,String>();
            paramMap.put("enterpriseName",enterpriseName);
            wareHouses = swService.listWareHouseByEnterPriseName(paramMap);
            /*if (BeanUtils.isNotEmpty(wareHouses)) {
                storageStoreHouse.setWarehouse(wareHouses.get(0).getWarehouseName());
                storageStoreHouse.setWarehouseCode(wareHouses.get(0).getWarehouseCode());
            }*/
        }
        model.addAttribute("wareHouses", wareHouses);

        String type = "仓房状态";
        List<SysDict> dictList = dicService.getSysDictListByType(type);
        model.addAttribute("statusDict", dictList);

        String type1 = "仓房类型";
        List<SysDict> typeDict = dicService.getSysDictListByType(type1);
        model.addAttribute("typeDict", typeDict);
        model.addAttribute("flag", request.getParameter("flag"));
        return "storageStoreHouse/store_house_add";
    }

    @RequestMapping("/getEncodeByWarehouse")
    @ResponseBody
    public String[] getEncodeByWarehouse(String warehouse,@RequestParam(value = "isHasOil", required = false) String isHasOil) {
        return service.getEncodeAndOilByWarehouse(warehouse,isHasOil);
    }

    ;

    @RequestMapping("/addOptionPage")
    public String addOptionPage(Model model, @RequestParam(value = "storehouseId", required = true) String storehouseId, HttpServletRequest request) {
        StorageStoreHouse storageStoreHouse = service.getSingle(storehouseId);
        model.addAttribute("storageStoreHouse", storageStoreHouse);
        model.addAttribute("auvp", "a");
        model.addAttribute("flag", request.getParameter("flag"));
        return "storageStoreHouse/store_house_option_add";

    }

    @RequestMapping("/proxyStorageStoreHouse")
    public String proxyStorageStoreHouse(Model model, HttpServletRequest request) {

        String type = "仓房状态";
        List<SysDict> dictList = dicService.getSysDictListByType(type);
        //System.out.println(dictList.size());
        model.addAttribute("statusDict", dictList);
         /*String flag = request.getParameter("flag");
       if ("dc".equals(flag)){
            sysLogService.add(request, "访问：代储管理-企业信息-仓房管理");
        }else{
            sysLogService.add(request, "访问：仓储管理-仓房管理-仓房信息管理");
        }
        model.addAttribute("flag", flag);*/

        return "storageStoreHouse/proxy_store_house_main";
    }


    @RequestMapping("/proxyList")
    @ResponseBody
    public LayPage<StorageStoreHouse> proxyList(HttpServletRequest request) {
        LayPage<StorageStoreHouse> page = service.proxyList(request);
        return page;
    }


    @RequestMapping("/addProxyPage")
    public String addProxyPage(Model model, HttpServletRequest request) {
        model.addAttribute("auvp", "a");
        StorageStoreHouse storageStoreHouse = new StorageStoreHouse();

        //String flag = request.getParameter("flag");
        //String enterpriseName = DataAuthorityUtil.getDataAuthority(flag);
        List<StorageWarehouse> wareHouses = new ArrayList<StorageWarehouse>();
        wareHouses = getCurrentWarehouse();

        SysUser user = TokenManager.getToken();
        String warehouseName = user.getShortName();
        storageStoreHouse.setWarehouse(warehouseName);
        storageStoreHouse.setWarehouseCode(user.getOriginCode());


        model.addAttribute("storageStoreHouse", storageStoreHouse);
        model.addAttribute("wareHouses", wareHouses);

        String type = "仓房状态";
        List<SysDict> dictList = dicService.getSysDictListByType(type);
        model.addAttribute("statusDict", dictList);

        String type1 = "仓房类型";
        List<SysDict> typeDict = dicService.getSysDictListByType(type1);
        model.addAttribute("typeDict", typeDict);
        //model.addAttribute("flag", request.getParameter("flag"));
        return "storageStoreHouse/proxy_store_house_add";
    }

    public List<StorageWarehouse> getCurrentWarehouse() {
        String warehouseCode = "";
        // 当前用户信息
        SysUser user = TokenManager.getToken();
        List<StorageWarehouse> storageWarehouseList = new ArrayList<StorageWarehouse>();
        HashMap<String,String> map = new HashMap<String,String>();
        // 管理员能查看所有库点
        if ("admin".equals(user.getAccount())) {
            storageWarehouseList = swService.selectWareHouseByEnterPriseName(map);
            return storageWarehouseList;
        }
        // 获取库点代码
        List kudianCodes = service.listKudianCode();
        if ("CBL".equals(user.getOriginCode())) {
            storageWarehouseList = swService.limitListNOTCBL();
//            storageWarehouseList = swService.selectWareHouseByEnterPriseName(map);
            return storageWarehouseList;
        }

        if (kudianCodes.contains(user.getOriginCode())) {
            //如果是直属库人员，返回直属库代码
            StorageWarehouse storageWarehouse = new StorageWarehouse();
            warehouseCode =  user.getOriginCode();
            storageWarehouse.setWarehouseCode(warehouseCode);

            String warehouseName = user.getShortName();
            storageWarehouse.setWarehouseName(warehouseName);

            storageWarehouseList.add(storageWarehouse);


            return storageWarehouseList;
        }

        if ("本系统创建".equals(user.getNote())) {
            //如果是代储点，返回代储点所在公司的所有库代码
            //根据公司名获取库点

            map.put("enterpriseName", user.getCompany());
            storageWarehouseList = swService.selectWareHouseByEnterPriseName(map);
            return storageWarehouseList;
        }

        return storageWarehouseList;
    }


    @RequestMapping(value = "/proxySave", method = {RequestMethod.POST})
    @ResponseBody
    public ActionResultModel proxySave(@RequestParam(value = "auvp") String auvp, @RequestBody StorageStoreHouse storageStoreHouse) {
        ActionResultModel result = new ActionResultModel();
        storageStoreHouse.setCreatorId(TokenManager.getSysUserId());
        //--------------------------Jovan---------------------------//
        String warehouseCode = storageStoreHouse.getWarehouseCode();
        String wareHouseId = swService.getWareHouseIdByCode(warehouseCode);
        storageStoreHouse.setWarehouseId(wareHouseId);
        //如果仓房长度传入的为0，为了避免前端length属性冲突，默认设为null
        BigDecimal length = storageStoreHouse.getLength();
        if((BigDecimal.ZERO).equals(length)){
            storageStoreHouse.setLength(null);
        }
        //--------------------------Jovan---------------------------//
        //System.out.println(auvp + storageStoreHouse.toString());
//        String flag = request.getParameter("flag");
        if (auvp.equals("a")) {
            storageStoreHouse.setId(UUID.randomUUID().toString().replace("-", ""));
            result = service.saveForSingle(storageStoreHouse);
            sysLogService.add(request, "代储监管-企业信息-[代储]仓房管理-增加");
        } else if (auvp.equals("u")) {
            result = service.updateForSingle(storageStoreHouse);
            sysLogService.add(request, "代储监管-企业信息-[代储]仓房管理-修改");
        }
        return result;
    }

    @RequestMapping("/proxyViewPage")
    public String proxyViewPage(Model model, @RequestParam(value = "id") String id, HttpServletRequest request) {
        StorageStoreHouse storageStoreHouse = service.getSingle(id);
        model.addAttribute("auvp", "v");
        model.addAttribute("storageStoreHouse", storageStoreHouse);

        String type = "仓房状态";
        List<SysDict> dictList = dicService.getSysDictListByType(type);
        model.addAttribute("statusDict", dictList);

        String type1 = "仓房类型";
        List<SysDict> typeDict = dicService.getSysDictListByType(type1);
        model.addAttribute("typeDict", typeDict);
        //model.addAttribute("flag", request.getParameter("flag"));
        return "storageStoreHouse/proxy_store_house_view";
    }

    @RequestMapping("/proxyAddOptionPage")
    public String proxyAddOptionPage(Model model, @RequestParam(value = "storehouseId", required = true) String storehouseId, HttpServletRequest request) {
        StorageStoreHouse storageStoreHouse = service.getSingle(storehouseId);
        model.addAttribute("storageStoreHouse", storageStoreHouse);
        model.addAttribute("auvp", "a");
        //model.addAttribute("flag", request.getParameter("flag"));
        return "storageStoreHouse/proxy_store_house_option_add";

    }

    @RequestMapping("/proxyEditPage")
    public String proxyEditPage(Model model, @RequestParam(value = "id") String id,@RequestParam(required = false) Integer isCopy, HttpServletRequest request) {
        StorageStoreHouse storageStoreHouse = service.getSingle(id);
        model.addAttribute("auvp", isCopy==null?"u":"a");
        model.addAttribute("storageStoreHouse", storageStoreHouse);

        //String flag = request.getParameter("flag");
        List<StorageWarehouse> wareHouses = new ArrayList<StorageWarehouse>();
        wareHouses = getCurrentWarehouse();
        /*SysUser user = TokenManager.getToken();
        String warehouseName = user.getShortName();
        storageStoreHouse.setWarehouse(warehouseName);
        storageStoreHouse.setWarehouseCode(user.getOriginCode());*/
        //String enterpriseName = DataAuthorityUtil.getDataAuthority(flag);

        model.addAttribute("wareHouses", wareHouses);

        String type = "仓房状态";
        List<SysDict> dictList = dicService.getSysDictListByType(type);
        model.addAttribute("statusDict", dictList);

        String type1 = "仓房类型";
        List<SysDict> typeDict = dicService.getSysDictListByType(type1);
        model.addAttribute("typeDict", typeDict);
        //model.addAttribute("flag", request.getParameter("flag"));
//        model.addAttribute("isCopy",isCopy==1?true:false);
        return "storageStoreHouse/proxy_store_house_add";
    }

    @SysLogAn("仓房管理-删除")
    @RequestMapping("/proxyRemove")
    @ResponseBody
    public ActionResultModel proxyRemove(@RequestParam(value = "id") String id) {
        ActionResultModel result = new ActionResultModel();
        result = service.remove(id);
        sysLogService.add(request, "代储监管-企业信息-[代储]仓房管理-删除");
        return result;
    }

    /**
     * 根据库点名称获取仓罐号
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/listStoreHouseAndOilcan")
    public String[] findStoreHouseByWareHouse(
            @RequestParam(value = "warehouseId", required = false) String warehouseId,
            @RequestParam(value = "warehouseCode",required = false) String warehouseCode
    ){
        if(StringUtils.isEmpty(warehouseId) && StringUtils.isEmpty(warehouseCode)){
            return null;
        }
        return service.listStoreHouseAndOilCanByWarehouse(warehouseId,warehouseCode);
    }

    @RequestMapping("/storelist")
    @ResponseBody
    public LayPage<StorageStoreHouse> list1(HttpServletRequest request,@RequestParam("warehouseId") String warehouseId){

        int total =service.getcountByWarehouseId(warehouseId);
        int total1 =storageOilcanService.getcountByWarehouseId(warehouseId);
        List<StorageStoreHouse> list=null;
        if(total+total1>0)
            list = service.findAllByWarehouseId(request,warehouseId);
        LayPage<StorageStoreHouse> pageUtil=new LayPage<>(list, total+total1);
        return pageUtil;
    }

    @ResponseBody
    @RequestMapping("/storehouselist")
    public LayPage<StorageStoreHouse> storeHouseList(HttpServletRequest request,@RequestParam("warehouseName") String name){
        LayPage<StorageStoreHouse> list = service.storeHouseListByWarehouseName(request,name);
        return list;
    }

    /**
     * 批量新增页面
     * @return
     */
    @RequestMapping(value = "/addBatchStorageStoreHouse", method = RequestMethod.GET)
    public String batchAddStorehouse(Model model){
        String type = "仓房状态";
        List<SysDict> dictList = dicService.getSysDictListByType(type);
        model.addAttribute("statusDict", dictList);

        String type1 = "仓房类型";
        List<SysDict> typeDict = dicService.getSysDictListByType(type1);
        model.addAttribute("typeDict", typeDict);
        return "storageStoreHouse/store_house_batch_add";
    }

    @ResponseBody
    @RequestMapping(value = "addBatchStorageStoreHouse", method = RequestMethod.POST)
    public ActionResultModel batchAddStorehouse(@RequestBody List<StorageStoreHouse> list){
        ActionResultModel actionResultModel = new ActionResultModel();
        actionResultModel.setSuccess(true);
        int failCount = 0;
        int successCount = 0;
        List<StorageStoreHouse> tempList = new ArrayList<>();   // 记录存在问题的数据
        for (StorageStoreHouse storeHouse : list){
            String message = "";
            storeHouse.setMessage(message);
            //检验begin
            //1.校验同一库点下仓号是否重复
            checkRepeatEncode(storeHouse);
            //校验end;
            if(StringUtils.isEmpty(storeHouse.getMessage())){
                storeHouse.setId(UUID.randomUUID().toString().replace("-",""));
                service.saveForSingle(storeHouse);
                successCount=successCount+1;
            }else{
                tempList.add(storeHouse);
                failCount=failCount+1;
                //actionResultModel.setSuccess(false);
            }

        }
        /*for(StorageStoreHouse storeHouse : list){
            if(StringUtils.isNotEmpty(storeHouse.getEncode())){
                int count = service.countStoreHouseByEncode(storeHouse.getEncode(),storeHouse.getWarehouseId());    // 判断是否重复
                if(count == 0){
                    storeHouse.setId(UUID.randomUUID().toString().replace("-",""));
                    service.saveForSingle(storeHouse);
                } else {
                  tempList.add(storeHouse);
                  actionResultModel.setSuccess(false);
                }
            } else {
                tempList.add(storeHouse);
                actionResultModel.setSuccess(false);
            }
        }*/
        actionResultModel.setMsg("共"+list.size()+"条，"+ successCount + "条保存成功,"+failCount +"条保存失败");
        actionResultModel.setData(tempList);
        return actionResultModel;
    }
    //校验仓号是否重复
    public void checkRepeatEncode(StorageStoreHouse storehouse){
        int count = service.countStoreHouseByEncode(storehouse.getEncode(),storehouse.getWarehouseId());
        if(count>0){
            String message = storehouse.getMessage();
            message = message+"[仓号重复]";
            storehouse.setMessage(message);
        }
    }

}
