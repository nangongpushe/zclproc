package com.dhc.fastersoft.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.entity.ExportRotateSum;
import com.dhc.fastersoft.entity.RotateConclute;
import com.dhc.fastersoft.entity.RotateConcluteDetail;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.service.RotateConcluteService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.StringUtil;
import com.dhc.fastersoft.utils.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/rotateSum")
public class RotateSumController  extends BaseController{
    @Autowired
    private SysDictService sysDictService;
    @Autowired
    private RotateConcluteService concluteService;
    @SysLogAn("访问：轮换业务-货款管理-货款汇总")
    @RequestMapping("/main")
    public String main(Model model) {
        //粮油品种
        List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
        model.addAttribute("grainTypes", grainTypes);
        return "RotateSum/rotatesum_main";
    }

    @RequestMapping(value="/listPagination")
    @ResponseBody
    public LayPage<RotateConclute> listPagination(
            @RequestParam(value="pageIndex")int pageIndex,
            @RequestParam(value="pageSize")int pageSize,
            @RequestParam(value="grainType",required=false)String grainType,
            @RequestParam(value="inviteType",required=false)String inviteType,
            @RequestParam(value="dealDate",required=false)String dealDate)
            throws UnsupportedEncodingException {

        HashMap<String,Object> map = new HashMap<>();

        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("grainType", grainType);
        map.put("inviteType", inviteType);
        map.put("dealDate", dealDate);
        map.put("inviteTypes", "竞价销售,协议销售,内部销售,内部招标,其他");
        int total=concluteService.countRotateSum(map);
        List<RotateConclute> list=null;
        if(total>0)
            list = concluteService.listRotateSum(map);

        LayPage<RotateConclute> pageUtil=new LayPage<>(list,total);

        return pageUtil;
    }


    @RequestMapping(value="/view")
    public String view(Model model, HttpServletRequest request) {
        String sid = request.getParameter("sid");
        String deliveryPlace = request.getParameter("deliveryPlace");
        String encode = request.getParameter("encode");
        String receiverPlace = request.getParameter("receiverPlace");
        String grainType = request.getParameter("grainType");
        List<SysDict> processTypes = sysDictService.getSysDictListByType("商务处理类型");

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("sid",sid);
        map.put("deliveryPlace",deliveryPlace);
        map.put("encode", StringUtils.isNotEmpty(encode)?encode.toUpperCase():encode);
        map.put("processTypes",processTypes);
        map.put("receiverPlace",receiverPlace);
        map.put("grainType", grainType);
        List<RotateConcluteDetail> detailList=concluteService.listOutDetail(map);
        model.addAttribute("sid",sid);
        model.addAttribute("deliveryPlace",deliveryPlace);
        model.addAttribute("encode",encode);
        model.addAttribute("grainType",grainType);
        model.addAttribute("receiverPlace",receiverPlace);
        model.addAttribute("detailList", detailList);
        model.addAttribute("processTypes",processTypes);
        //粮油品种
        List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
        model.addAttribute("grainTypes", grainTypes);

        BigDecimal allDealAmount = BigDecimal.ZERO; // 总成交金额
        BigDecimal allQuantity = BigDecimal.ZERO;   // 总成交吨数
        BigDecimal allPayedMoney = BigDecimal.ZERO; // 已付总金额

        for(RotateConcluteDetail rotateConcluteDetail: detailList){
            allDealAmount = allDealAmount.add(rotateConcluteDetail.getDealAmount());
            allQuantity = allQuantity.add(new BigDecimal(rotateConcluteDetail.getQuantity()));
            allPayedMoney = allPayedMoney.add(rotateConcluteDetail.getPayedMoney());
        }

        model.addAttribute("allDealAmount",allDealAmount);
        model.addAttribute("allQuantity",allQuantity);
        model.addAttribute("allPayedMoney",allPayedMoney);
        model.addAttribute("allUnpayedMoney",allDealAmount.subtract(allPayedMoney));   // 未付总金额

        return "RotateSum/rotatesum_view";
    }

    @RequestMapping(value="/exportRotateSum1")
    @ResponseBody
    public void exportRotateSum(HttpServletResponse response,HttpServletRequest request) throws IOException {
        String sid = request.getParameter("sid");
        String deliveryPlace = request.getParameter("deliveryPlace");
        String encode = request.getParameter("encode");
        String receiverPlace = request.getParameter("receiverPlace");
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("sid",sid);
        map.put("deliveryPlace",deliveryPlace);
        map.put("encode",encode);
        map.put("receiverPlace",receiverPlace);
        List<ExportRotateSum> detailList=concluteService.listOutExportDetail(map);
        String title = "货款汇总";
        response.setHeader("content-Type", "application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".xls");
        response.setCharacterEncoding("UTF-8");
        Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),ExportRotateSum.class, detailList);

        workbook.write(response.getOutputStream());
    }
    @RequestMapping(value="/exportRotateSum")
    public String exportSwtz(HttpServletRequest request, HttpServletResponse response) {
        String sid = request.getParameter("sid");
        String deliveryPlace = request.getParameter("deliveryPlace");
        String encode = request.getParameter("encode");
        String receiverPlace = request.getParameter("receiverPlace");
        List<SysDict> processTypes = sysDictService.getSysDictListByType("商务处理类型");
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("sid",sid);
        map.put("deliveryPlace",deliveryPlace);
        map.put("encode",encode);
        map.put("receiverPlace",receiverPlace);
        map.put("processTypes",processTypes);
        List<ExportRotateSum> detailList=concluteService.listOutExportDetail(map);
        String fileName = "货款汇总.xls";
        try {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        }catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
        request.setAttribute("detailList", detailList);
        request.setAttribute("processTypes",processTypes);
        return "RotateSum/rotatesum_export";
    }
}
