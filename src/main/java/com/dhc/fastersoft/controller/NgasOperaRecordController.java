package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.NgasOperaRecord;
import com.dhc.fastersoft.entity.NgasOperaSituation;
import com.dhc.fastersoft.entity.StorageGrainInspection;
import com.dhc.fastersoft.entity.StorageGrainInspectionTemp;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.NgasOperaRecordService;
import com.dhc.fastersoft.service.StorageGrainInspectionService;
import com.dhc.fastersoft.service.StorageStoreHouseService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@RequestMapping("/ngasOperaRecord")
@Controller
public class NgasOperaRecordController extends BaseController{
    @Autowired
    StorageWarehouseService warehouseService;
    @Autowired
    StorageStoreHouseService storehouseService;
    @Autowired
    SysUserService userService;
    @Autowired
    SysDictService sysService;
    @Autowired
    NgasOperaRecordService service;
    @RequestMapping()
    public String index(Model model, @RequestParam(value="type",required=false)String type) {
        if(type==null){
            type="";
        }

        if("dc".equals(type)){
            sysLogService.add(request, "访问：代储监管-报表台账-充氮气调作业记录");
        }else{
            sysLogService.add(request, "访问：仓储管理-粮油情监测管理-充氮气调作业记录");
        }
        model.addAttribute("type",type);
        return "storageNgasOperaRecord/ngas_opera_record_main";
    }
    @RequestMapping("/addPage")
    public String addPage(Model model, @RequestParam(value="type",required=false)String type){
        model.addAttribute("type",type);
        SysUser user = TokenManager.getToken();
        model.addAttribute("user",user);
        //String warehouse = user.getShortName();
        String warehouse=null!=user.getShortName()?user.getShortName():user.getCompany();
        String warehouseId = user.getWareHouseId();
        if(warehouse==null){
            warehouse="";
        }
        NgasOperaRecord ngasOperaRecord = new NgasOperaRecord();
        ngasOperaRecord.setWarehouseId(user.getWareHouseId());
        ngasOperaRecord.setReportDate(new Date());
        model.addAttribute("storehouses",storehouseService.listStorehouseOfWarehouse(warehouseId));
        //String[] storehouseEncodeArray = storehouseService.getEncodeByWarehouse(warehouse);
        //model.addAttribute("storehouseEncodeArray", storehouseEncodeArray);
        List<SysDict> periods=sysService.getSysDictListByType("阶段");
        List<SysDict> varietyList = sysService.getSysDictListByType("粮油品种");
        model.addAttribute("varietyList",varietyList);
        //仓房类型
        List<SysDict> storehouseTypes = sysService.getSysDictListByType("仓房类型");
        model.addAttribute("storehouseTypes", storehouseTypes);
        model.addAttribute("ngasOperaRecord",ngasOperaRecord);
        model.addAttribute("periods",periods);
        model.addAttribute("auvp","a");

       /* List<SysUser> sysUserList = userService.getList();

        model.addAttribute("sysUserList",sysUserList);*/

        return "storageNgasOperaRecord/ngas_opera_record_add";
    }

    @RequestMapping(value="/save",method=RequestMethod.POST)
    @ResponseBody
    public ActionResultModel save(@RequestBody NgasOperaRecord ngasOperaRecord,
                                  @RequestParam(value="auvp") String auvp) {
        ActionResultModel result = new ActionResultModel();
        String type = request.getParameter("type");
        if ( auvp.equals("a") || auvp.equals("c") ) {
            ngasOperaRecord.setCreatorId(TokenManager.getSysUserId());
            result = service.save(ngasOperaRecord);
            if("dc".equals(type)){
                sysLogService.add(request, "代储监管-报表台账-充氮气调作业记录-增加");
            }else{
                sysLogService.add(request, "仓储管理-粮油情监测管理-充氮气调作业记录-增加");
            }
        } else if ( auvp.equals("u") ) {
            result = service.update(ngasOperaRecord);
            if("dc".equals(type)){
                sysLogService.add(request, "代储监管-报表台账-充氮气调作业记录-修改");
            }else{
                sysLogService.add(request, "仓储管理-粮油情监测管理-充氮气调作业记录-修改");
            }
        }
        return result;
    }


    @RequestMapping("/list")
    @ResponseBody
    public LayPage<NgasOperaRecord> list(HttpServletRequest request) {
        LayPage<NgasOperaRecord> page = service.list(request);
        return page;
    }


    @RequestMapping("/viewPage")
    public String viewPage(Model model,
                           @RequestParam(value="id",required=true) String id,
                           @RequestParam(value="type",required=false)String type,
                           @RequestParam(value="Projectile",required=false, defaultValue="")String Projectile) {
        model.addAttribute("type",type);
        NgasOperaRecord ngasOperaRecord = service.get(id);
        model.addAttribute("ngasOperaRecord", ngasOperaRecord);

        model.addAttribute("auvp", "v");

        String warehouse = ngasOperaRecord.getWarehouse();
        if(warehouse==null){
            warehouse="";
        }
        String[] storehouseEncodeArray = storehouseService.getEncodeByWarehouse(warehouse);
        model.addAttribute("storehouseEncodeArray", storehouseEncodeArray);

        List<SysUser> sysUserList = userService.getList();

        model.addAttribute("sysUserList",sysUserList);

        //获取小表对象
        String p_id = ngasOperaRecord.getId();
        List<NgasOperaSituation> ngasOperaSituations =service.selectNgasOperaSituationByPid(p_id);
        model.addAttribute("ngasOperaSituations", ngasOperaSituations);
        //return "storageNgasOperaRecord/ngas_opera_record_view";
        return Projectile.equals("Projectile")?"storageNgasOperaRecord/ngas_opera_record_view_dialog":"storageNgasOperaRecord/ngas_opera_record_view";
    }


    @RequestMapping("/editPage")
    public String editPage(Model model,
                           @RequestParam(value="type",required=false)String type,
                           @RequestParam(value="id",required=true) String id ,
                           @RequestParam(value="operatorFlag",required=false) String operatorFlag,
                           @RequestParam(value="Projectile",required=false, defaultValue="")String Projectile) {
        NgasOperaRecord ngasOperaRecord = service.get(id);
        model.addAttribute("type",type);
        String warehouseId = ngasOperaRecord.getWarehouseId();
        if(warehouseId==null){
            warehouseId="";
        }
        //String[] storehouseEncodeArray = storehouseService.getEncodeByWarehouse(warehouse);
        model.addAttribute("storehouses",storehouseService.listStorehouseOfWarehouse(warehouseId));
        //model.addAttribute("storehouseEncodeArray", storehouseEncodeArray);

        //获取小表对象
        String p_id = ngasOperaRecord.getId();
        List<NgasOperaSituation> ngasOperaSituations =service.selectNgasOperaSituationByPid(p_id);
        if(operatorFlag != null || "".equals(operatorFlag)){
            ngasOperaRecord.setId(null);
            model.addAttribute("auvp","c");
        }else{
            model.addAttribute("auvp","u");
        }

        //System.out.println(grainInspection.toString());
        List<SysDict> varietyList = sysService.getSysDictListByType("粮油品种");
        model.addAttribute("varietyList",varietyList);
        //仓房类型
        List<SysDict> storehouseTypes = sysService.getSysDictListByType("仓房类型");
        model.addAttribute("storehouseTypes", storehouseTypes);
        model.addAttribute("ngasOperaRecord", ngasOperaRecord);

        model.addAttribute("ngasOperaSituations", ngasOperaSituations);

        //return "storageNgasOperaRecord/ngas_opera_record_add";
        return Projectile.equals("Projectile")?"storageNgasOperaRecord/ngas_opera_record_add_dialog":"storageNgasOperaRecord/ngas_opera_record_add";
    }


    @RequestMapping("/remove")
    @ResponseBody
    public ActionResultModel remove(@RequestParam(value="id",required=true) String id, String type) {
        ActionResultModel result = service.remove(id);
        if("dc".equals(type)){
            sysLogService.add(request, "代储监管-报表台账-充氮气调作业记录-删除");
        }else{
            sysLogService.add(request, "仓储管理-粮油情监测管理-充氮气调作业记录-删除");
        }
        return result;
    }

}

