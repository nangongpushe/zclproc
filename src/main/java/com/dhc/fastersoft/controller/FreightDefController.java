package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.FreightDef;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.service.FreightDefService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


@RequestMapping("/freightDef")
@Controller
public class FreightDefController  extends BaseController{
    @Autowired
    private FreightDefService freightDefService;
    @Autowired
    private SysDictService sysDictService;
    /**
     * 列表页面
     *
     * @param request
     * @return
     */
    @SysLogAn("访问：轮换业务-运费管理-运费定义")
    @RequestMapping()
    public String index(HttpServletRequest request) {
        return "freightdef/freightdef_list";
    }

    /**
     * 增加
     *
     * @param request
     * @return
     */
    @RequestMapping(value="/add")
    public String add(Model model, HttpServletRequest request) {
        request.setAttribute("type", "添加");
        //运输方式
        List<SysDict> shipTypes = sysDictService.getSysDictListByType("运输方式");
        model.addAttribute("shipTypes", shipTypes);
        return "freightdef/freightdef_edit";
    }

    /**
     * @Title: save
     * @Description: save方法
     * @throws
     */

    @RequestMapping(value="/save")
    @ResponseBody
    public ActionResultModel save(FreightDef freightDef){
        ActionResultModel actionResultModel = new ActionResultModel();
        if(StringUtils.isBlank(freightDef.getId())){
            //根据包装类型、运输方式判断是否已存在
           List<FreightDef> freightDefList = freightDefService.selectByType(freightDef);
           if(freightDefList.size()>0){
               actionResultModel.setMsg("运输类型为"+freightDef.getShipType()+"包装类型为"+freightDef.getPackageType()+"的数据已存在,请勿重复添加!");
               actionResultModel.setSuccess(false);
               return actionResultModel;
           }
            freightDef.setId(StringUtils.createUUID());
            freightDef.setCreateBy(TokenManager.getSysUserId());
            freightDefService.save(freightDef);
            sysLogService.add(request, "轮换业务-运费管理-运费定义-新增");
        }else {
            freightDef.setUpdateBy(TokenManager.getSysUserId());
            freightDefService.updateById(freightDef);
            sysLogService.add(request, "轮换业务-运费管理-运费定义-修改");
        }
        actionResultModel.setSuccess(true);
        return actionResultModel;
    }

    @RequestMapping("/list")
    @ResponseBody
    public LayPage<FreightDef> list(HttpServletRequest request){

        LayPage<FreightDef> page = freightDefService.pageList(request);
        return page;
    }

    /**
     * 修改
     *
     * @param request
     * @return
     */
    @RequestMapping(value="/edit")
    public String edit(Model model, HttpServletRequest request) {
        request.setAttribute("type", "编辑");
        String id = request.getParameter("id");
        //运输方式
        List<SysDict> shipTypes = sysDictService.getSysDictListByType("运输方式");
        model.addAttribute("shipTypes", shipTypes);
        FreightDef freightDef  = freightDefService.selectById(id);
        request.setAttribute("freightDef", freightDef);
        return "freightdef/freightdef_edit";
    }


    @RequestMapping(value="/selectByShipType")
    @ResponseBody
    public List<FreightDef> selectByShipType(HttpServletRequest request) {
        List<FreightDef> freightDefList = freightDefService.selectByShipType(request);
        return  freightDefList;
    }
    /**
     * 查看
     *
     * @param request
     * @return
     */
    @RequestMapping(value="/detail")
    public String detail(Model model, HttpServletRequest request) {
        request.setAttribute("type", "详情");
        String id = request.getParameter("id");
        //运输方式
        List<SysDict> shipTypes = sysDictService.getSysDictListByType("运输方式");
        model.addAttribute("shipTypes", shipTypes);
        FreightDef freightDef  = freightDefService.selectById(id);
        request.setAttribute("freightDef", freightDef);
        return "freightdef/freightdef_edit";
    }

    @SysLogAn("轮换业务-运费管理-运费定义-删除")
    @RequestMapping("/del")
    public void list(@RequestParam("id")String id){
        freightDefService.deleteById(id);
    }
}
