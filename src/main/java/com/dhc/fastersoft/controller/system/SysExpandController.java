package com.dhc.fastersoft.controller.system;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.RotateNoticeService;
import com.dhc.fastersoft.service.StorageOilcanService;
import com.dhc.fastersoft.service.StorageStoreHouseService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.util.BeanUtils;
import com.dhc.fastersoft.utils.DateUtil;
import com.dhc.fastersoft.utils.PageUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

@Controller
@RequestMapping(value = "/SysExpand")
public class SysExpandController {
    //油罐
    @Autowired
    private StorageOilcanService storageOilcanService;
    //仓房
    @Autowired
    private StorageStoreHouseService storageStoreHouseService;
    //库点
    @Autowired
    private StorageWarehouseService storageWarehouseService;
    //字典
    @Autowired
    private SysDictService sysDictService;
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private RotateNoticeService rotateNoticeService;
    @Autowired
    private HttpServletRequest request;

    static Map<String, String> mapper = new HashMap<>();
    
    private Properties prop = new Properties();

    static {
        //企业性质
        mapper.put("CompanyNature", "库点企业性质");
        //仓房类型
        mapper.put("StoreHouseType", "仓房类型");
        //仓房状态
        mapper.put("StoreHouseStatus", "仓房状态");
        //粮食品种
        mapper.put("Varieties", "粮油品种");
        //粮食等级
        mapper.put("Level", "粮油等级");
    }
    
    {
    	try {
			prop.load(this.getClass().getResourceAsStream("/AC_code.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
    }

    @RequestMapping(value = "/GrainDepotInfo", params = "baseCode")
    @ResponseBody
    public ActionResultModel GetWarehouseInfo(@RequestParam("baseCode") String baseCode) {
        ActionResultModel model = new ActionResultModel();
        StorageWarehouse wareHouse = null;
        try {
            wareHouse = storageWarehouseService.getStorageWarehouse(baseCode);
        } catch (Exception e) {
            model.setMsg("未找到所对应数据");
            return model;
        }
        if(wareHouse != null) {
        	StorageWarehouse data = new StorageWarehouse();
            //修改接口
            StorageWarehouseDto dataDto = new StorageWarehouseDto();

            /*try {
                UpdateUtil.UpdateField(wareHouse, data, new String[]{"province", "provinceCode", "city", "cityCode", "area", "areaCode", "creator", "createDate", "remark"});
            } catch (IllegalArgumentException | IllegalAccessException e) {
                e.printStackTrace();
            }*/

            dataDto.setId(wareHouse.getId());
            dataDto.setGraindepot(wareHouse.getWarehouseCode()); //库点代码
            dataDto.setGraindepotname(wareHouse.getWarehouseName()); //库点名称
            dataDto.setGraindepotshort(wareHouse.getWarehouseShort());//库点简称
            dataDto.setEnterprisenature(wareHouse.getWarehouseNature());//库点企业性质
            dataDto.setGraindepottype(wareHouse.getWarehouseType());//库点类别
            dataDto.setCompletiondate(wareHouse.getCompletionDate());//建成时间
            dataDto.setStorecapacity(wareHouse.getStorageCapacity());//库点设计仓容
            dataDto.setAcreage(wareHouse.getAcreage());//库点面积
            dataDto.setPhonenumber(wareHouse.getTelphone());//库点电话
            dataDto.setFax(wareHouse.getFax());//库点传真
            dataDto.setAddress(wareHouse.getAddress());//库点地址
            dataDto.setLongitude(wareHouse.getLongitude());//库点经度
            dataDto.setLatitude(wareHouse.getLatitude());//库点维度
            dataDto.setPostalcode(wareHouse.getPostalcode());//库点邮政编码
            dataDto.setEnterprisename(wareHouse.getEnterpriseName());//所属企业名称(代储库点用)
            dataDto.setOrganizationcode(wareHouse.getOrganizationCode());//组织机构代码(代储库点用)
            dataDto.setSocialcreditcode(wareHouse.getSocialCreditCode());//统一社会信用代码(代储库点用)

            //model.setData(data);
            model.setData(dataDto);
            model.setMsg("200");
            model.setSuccess(true);
            return model;
        }
        model.setMsg("未找到所对应数据");
        return model;
    }

    @RequestMapping(value = "/GranaryInfo", params = "baseCode")
    @ResponseBody
    public ActionResultModel GetStoragehouseInfo(@RequestParam("baseCode") String baseCode) {
        ActionResultModel model = new ActionResultModel();
        String wareHouse = null;
        try {
            wareHouse = storageWarehouseService.getStorageWarehouse(baseCode).getWarehouseShort();
        } catch (Exception e) {
            model.setMsg("未找到所对应数据");
            return model;
        }
        List<StorageStoreHouse> result = storageStoreHouseService.list(wareHouse).getData();
        if (result != null && result.size() > 0) {
            List<StorageStoreHouseDto> data = new ArrayList<>();
            try {
                for (StorageStoreHouse storageStoreHouse : result) {
                    StorageStoreHouseDto item = new StorageStoreHouseDto();
//                    UpdateUtil.UpdateField(storageStoreHouse, item, new String[]{"warehouse", "bulkHeight", "gateNum", "cfa", "siloDiameter", "siloHore", "siloVolume", "gateHeight", "gateWidth", "eavesHeight", "bulkArea", "ventNum", "ductType", "siloTightness", "axialNum", "heatInsulation", "creator", "createDate"});
                    setStorageStoreObjectDto(storageStoreHouse,item);
                    data.add(item);
                }
                model.setData(data);
                model.setMsg("200");
                model.setSuccess(true);
                return model;
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            }
        }
        model.setMsg("未找到所对应数据");
        return model;
    }

    /**
     * 类型转化
     * @param storageStoreHouse
     * @param storeHouseDto
     */
    private void setStorageStoreObjectDto(StorageStoreHouse storageStoreHouse, StorageStoreHouseDto storeHouseDto) {
        if(storeHouseDto == null) {
            return ;
        }

        storeHouseDto.setId(storageStoreHouse.getId());
        storeHouseDto.setGranaryCode(storageStoreHouse.getWarehouseCode());
        storeHouseDto.setGranaryType(storageStoreHouse.getType());
        storeHouseDto.setGranaryStatus(storageStoreHouse.getStatus());
        storeHouseDto.setEnableDate(storageStoreHouse.getEnableDate());
        storeHouseDto.setStructure(storageStoreHouse.getStructure());
        storeHouseDto.setDesignedCapacity(storageStoreHouse.getDesignedCapacity());
        storeHouseDto.setAuthorizedCapacity(storageStoreHouse.getAuthorizedCapacity());
        storeHouseDto.setGraindEpot(storageStoreHouse.getWarehouseCode());
        storeHouseDto.setStoreType(storageStoreHouse.getStoreType());
        storeHouseDto.setKeeper(storageStoreHouse.getKeeper());
        storeHouseDto.setRemark(storageStoreHouse.getRemark());
        storeHouseDto.setBuildingType(storageStoreHouse.getBuildingType());
        storeHouseDto.setLength(storageStoreHouse.getLength());
        storeHouseDto.setWidth(storageStoreHouse.getWidth());
        storeHouseDto.setHeight(storageStoreHouse.getHeight());
        storeHouseDto.setLongitude(storageStoreHouse.getLongitude());
        storeHouseDto.setLatitude(storageStoreHouse.getLatitude());
        storeHouseDto.setGranaryName(storageStoreHouse.getStorehouseName());
    }

    @RequestMapping(value = "/StorageOilcanInfo", params = "baseCode")
    @ResponseBody
    public ActionResultModel GetStorageOilcanInfo(@RequestParam("baseCode") String baseCode) {
        ActionResultModel model = new ActionResultModel();
        String wareHouse = null;
        try {
            wareHouse = storageWarehouseService.getStorageWarehouse(baseCode).getWarehouseShort();
        } catch (Exception e) {
            model.setMsg("未找到所对应数据");
            return model;
        }
        List<StorageOilcan> result = storageOilcanService.list(wareHouse).getData();
        if (result != null && result.size() > 0) {
            List<StorageOilcan> data = new ArrayList<>();
            /*try {
                for (StorageOilcan storageOilcan : result) {
                    StorageOilcan item = new StorageOilcan();
                    UpdateUtil.UpdateField(storageOilcan, item, new String[]{"warehouse", "oilcanBody", "oilcanFloor", "oilcanTop", "heatInsulation", "creator", "createDate", "remark"});
                    data.add(item);
                }*/
           //修改接口
            StorageOilcanDto dataDto = new StorageOilcanDto();
            StorageOilcan storageOilcan = result.get(0);

            dataDto.setId(storageOilcan.getId());
            dataDto.setOilcanserial(storageOilcan.getOilcanSerial());//油罐编号
            dataDto.setOilcantype(storageOilcan.getOilcanType());//油罐类型
            dataDto.setOilcanstatus(storageOilcan.getOilcanStatus());//油罐状态
            dataDto.setDeliverdate(storageOilcan.getDeliverDate());//交付使用日期
            dataDto.setDesignedcapacity(storageOilcan.getDesignedCapacity());//设计容量
            dataDto.setAuthorizedcapacity(storageOilcan.getAuthorizedCapacity());//核定容量
            dataDto.setOilcanheigh(storageOilcan.getOilcanHeigh());//罐高
            dataDto.setOilcaninnerdiameter(storageOilcan.getOilcanInnerDiameter());//罐内径
            dataDto.setOilcanouterdiameter(storageOilcan.getOilcanOuterDiameter());//罐外径
            dataDto.setDesignedoilline(storageOilcan.getDesignedOilLine());//设计装油线高
            dataDto.setAuthorizedoilline(storageOilcan.getAuthorizedOilLine());//实际装油线高
            dataDto.setLongitude(storageOilcan.getLongitude());//油罐经度
            dataDto.setLatitude(storageOilcan.getLatitude());//油罐纬度
            dataDto.setOilcanname(storageOilcan.getOilcanName());//油罐名称


                //model.setData(data);
                model.setData(dataDto);
                model.setMsg("200");
                model.setSuccess(true);
                return model;
           /* } catch (IllegalArgumentException | IllegalAccessException e) {
                e.printStackTrace();
            }*/
        }
        model.setMsg("未找到所对应数据");
        return null;
    }

    @RequestMapping(value = "/RotateNoticeInfo", params = {"baseCode", "type"})
    //@RequestMapping(value = "/RotateNoticeByDate", params = {"baseCode", "type"})
    @ResponseBody
    public ActionResultModel GetRotateNoticeInfo(@RequestParam("baseCode") String baseCode, @RequestParam("type") int type) {
        ActionResultModel model = new ActionResultModel();
        String wareHouse = null;
        try {
            wareHouse = storageWarehouseService.getStorageWarehouse(baseCode).getWarehouseShort();
        } catch (Exception e) {
            model.setMsg("未找到所对应数据");
            return model;
        }
        RotateNotice param = new RotateNotice();
        //设置可传输数据的参数
        param.setAccepteUnit(wareHouse);
        param.setNoticeType(type == 0 ? "入库" : "出库");
        param.setStatus("已完成");
        param.setSendStatus(RotateNoticeService.UN_SEND);

        PageUtil<RotateNotice> pageUtil = new PageUtil<>();
        pageUtil.setEntity(param);
        pageUtil.setPageIndex(1);
        pageUtil.setPageSize(Integer.MAX_VALUE);

        List<RotateNotice> noticeList = rotateNoticeService.ListLimitNotice(pageUtil);
        List<String> noticeIds = new ArrayList<>();
        for (RotateNotice item : noticeList)
            noticeIds.add(item.getId());

        if (noticeIds.size() > 0) {
            List<RotateNotice> data = rotateNoticeService.GetNoticeDetailByids(noticeIds);

            //清除需求之外的属性
            //创建新的list把老的数据放入然后再一个一个的add进新的list
            List<RotateNoticeDto> dataDto = new ArrayList<RotateNoticeDto>(); //新的list

            for (RotateNotice notice : data) {
                RotateNoticeDto rotateNoticeDto = new RotateNoticeDto();

                //在这个循环里对应的值设置进rotateNoticeDto

                notice.setId(null);
                notice.setNoticeType(String.valueOf(type));
                notice.setRotateType(null);
                notice.setCreater(null);
                notice.setCreateTime(null);
                notice.setStatus(null);
                notice.setAnnex(notice.getAnnex() != null ? request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/sysFile/download.shtml?fileId=" + notice.getAnnex() : "");

                List<RotateNoticeDetailDto> detailDtos = new ArrayList<RotateNoticeDetailDto>();//

                for (RotateNoticeDetail rotateNoticeDetail : notice.getNoticeDetail()) {

                    RotateNoticeDetailDto detailDto = new RotateNoticeDetailDto();//创建新的detailDto

                    rotateNoticeDetail.setId(null);
                    rotateNoticeDetail.setNoticeId(notice.getNoticeSerial());
                    rotateNoticeDetail.setSerialNo(0);
                    rotateNoticeDetail.setRemovalUnit(null);
                    rotateNoticeDetail.setImmigrationUnit(null);
                    rotateNoticeDetail.setSchemeId(null);
                    rotateNoticeDetail.setSchemeName(null);

                    //这里做设置值
                    detailDto.setId(rotateNoticeDetail.getId());
                    detailDto.setNoticeid(rotateNoticeDetail.getNoticeId());//通知书编号
                    detailDto.setSerialno(rotateNoticeDetail.getSerialNo());//序号
                    detailDto.setVariety(rotateNoticeDetail.getVariety());//品种
                    detailDto.setCost(rotateNoticeDetail.getCost());//成本
                    detailDto.setPipeattribute(rotateNoticeDetail.getPipeAttribute());//直管单位
                    detailDto.setGrainannual(rotateNoticeDetail.getHarvestYear());//生产年份
                    detailDto.setStoragegraindepot(rotateNoticeDetail.getStorageWarehouse());//存储单位
                    detailDto.setGranarycode(rotateNoticeDetail.getStorehouse());//仓号
                    detailDto.setPlannumber(rotateNoticeDetail.getPlanNumber());//计划数
                    detailDto.setActualnumber(rotateNoticeDetail.getActualNumber());//实际数
                    detailDto.setRemovalunit(rotateNoticeDetail.getRemovalUnit());//移出单位
                    detailDto.setImmigrationunit(rotateNoticeDetail.getImmigrationUnit());//移入单位
                    detailDto.setSchemeid(rotateNoticeDetail.getSchemeId());//方案ID
                    detailDto.setSchemename(rotateNoticeDetail.getSchemeName());//方案名称
                    detailDto.setDealserial(rotateNoticeDetail.getDealSerial());//成交明细号

                    detailDtos.add(detailDto);
                }

                rotateNoticeDto.setNoticeDetailDto(detailDtos);
                rotateNoticeDto.setId(notice.getId());
                rotateNoticeDto.setNoticetype(notice.getNoticeType());//通知书类型
                rotateNoticeDto.setRotatetype(notice.getRotateType());//轮换类型
                rotateNoticeDto.setNoticeserial(notice.getNoticeSerial());//通知书编号
                rotateNoticeDto.setDocumentnumber(notice.getDocumentNumber());//文号
                rotateNoticeDto.setAccepteunit(notice.getAccepteUnit());//接受库点
                rotateNoticeDto.setStoragedate(notice.getStorageDate());//出入库截至日期
                rotateNoticeDto.setCreater(notice.getCreater());//经办人
                rotateNoticeDto.setCreatetime(notice.getCreateTime());//经办时间
                rotateNoticeDto.setStatus(notice.getStatus());//状态
                rotateNoticeDto.setCompletedate(notice.getCompleteDate());//签发日期
                rotateNoticeDto.setCompletehumen(notice.getCompleteHumen());//签发人
                rotateNoticeDto.setGrainannual(notice.getYear());//年份
                rotateNoticeDto.setRemark(notice.getRemark());//备注
                rotateNoticeDto.setAnnex(notice.getAnnex());//附件

                //每次循环就把rotateNoticeDto添加进list
                dataDto.add(rotateNoticeDto);
            }


            //model.setData(data);
            model.setData(dataDto);
            model.setMsg("200");
            model.setSuccess(true);

            Map<String, Object> setting = new HashMap<>();
            setting.put("status", RotateNoticeService.SENDED);
            setting.put("list", noticeIds);
            rotateNoticeService.SendDataOut(setting);
        } else {
            model.setMsg("未找到所对应数据");
            model.setSuccess(false);
        }
        return model;
    }

    @RequestMapping(value = "/RotateNoticeByDate", params = {"baseCode", "type", "queryDate"})
    @ResponseBody
    public ActionResultModel GetRotateNoticeByDate(@RequestParam("baseCode") String baseCode, @RequestParam("type") int type, @RequestParam("queryDate") String queryDate) {
        ActionResultModel model = new ActionResultModel();
        String wareHouse = null;
        try {
            wareHouse = storageWarehouseService.getStorageWarehouse(baseCode).getWarehouseShort();
        } catch (Exception e) {
            model.setMsg("未找到所对应数据");
            return model;
        }
        RotateNotice param = new RotateNotice();
        //设置可传输数据的参数
        param.setAccepteUnit(wareHouse);
        param.setNoticeType(type == 0 ? "入库" : "出库");
        param.setStatus("已完成");
        param.setSendStatus(RotateNoticeService.UN_SEND);
        param.setCreateTime(DateUtil.StringtoDate(queryDate,DateUtil.LONG_DATE_FORMAT));
        PageUtil<RotateNotice> pageUtil = new PageUtil<>();
        pageUtil.setEntity(param);
        pageUtil.setPageIndex(1);
        pageUtil.setPageSize(Integer.MAX_VALUE);


//        List<RotateNotice> noticeList = rotateNoticeService.ListLimitNotice(pageUtil);
        List<RotateNotice> notices = rotateNoticeService.listLimitNoticeByDate(pageUtil);
        List<String> noticeIds = new ArrayList<>();
        for (RotateNotice item : notices) {
            noticeIds.add(item.getId());
        }

        if (BeanUtils.isNotEmpty(notices)) {
            //清除需求之外的属性
            //创建新的list把老的数据放入然后再一个一个的add进新的list
            List<RotateNoticeDto> dataDto1 = new ArrayList<RotateNoticeDto>(); //新的list


            for (RotateNotice notice : notices) {

                RotateNoticeDto rotateNoticeDto = new RotateNoticeDto();
                //在这个循环里对应的值设置进rotateNoticeDto

                notice.setId(null);
                notice.setNoticeType(String.valueOf(type));
                notice.setRotateType(null);
                notice.setCreater(null);
                notice.setCreateTime(null);
                notice.setStatus(null);
                notice.setAnnex(notice.getAnnex() != null ? request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/sysFile/download.shtml?fileId=" + notice.getAnnex() : "");

                List<RotateNoticeDetailDto> detailDtos1 = new ArrayList<RotateNoticeDetailDto>();//

                for (RotateNoticeDetail rotateNoticeDetail : notice.getNoticeDetail()) {

                    RotateNoticeDetailDto detailDto = new RotateNoticeDetailDto();//创建新的detailDto

                    rotateNoticeDetail.setId(null);
                    rotateNoticeDetail.setNoticeId(notice.getNoticeSerial());
                    rotateNoticeDetail.setSerialNo(0);
                    rotateNoticeDetail.setRemovalUnit(null);
                    rotateNoticeDetail.setImmigrationUnit(null);
                    rotateNoticeDetail.setSchemeId(null);
                    rotateNoticeDetail.setSchemeName(null);

                    //这里做设置值
                    detailDto.setId(rotateNoticeDetail.getId());
                    detailDto.setNoticeid(rotateNoticeDetail.getNoticeId());//通知书编号
                    detailDto.setSerialno(rotateNoticeDetail.getSerialNo());//序号
                    detailDto.setVariety(rotateNoticeDetail.getVariety());//品种
                    detailDto.setCost(rotateNoticeDetail.getCost());//成本
                    detailDto.setPipeattribute(rotateNoticeDetail.getPipeAttribute());//直管单位
                    detailDto.setGrainannual(rotateNoticeDetail.getHarvestYear());//生产年份
                    detailDto.setStoragegraindepot(rotateNoticeDetail.getStorageWarehouse());//存储单位
                    detailDto.setGranarycode(rotateNoticeDetail.getStorehouse());//仓号
                    detailDto.setPlannumber(rotateNoticeDetail.getPlanNumber());//计划数
                    detailDto.setActualnumber(rotateNoticeDetail.getActualNumber());//实际数
                    detailDto.setRemovalunit(rotateNoticeDetail.getRemovalUnit());//移出单位
                    detailDto.setImmigrationunit(rotateNoticeDetail.getImmigrationUnit());//移入单位
                    detailDto.setSchemeid(rotateNoticeDetail.getSchemeId());//方案ID
                    detailDto.setSchemename(rotateNoticeDetail.getSchemeName());//方案名称
                    detailDto.setDealserial(rotateNoticeDetail.getDealSerial());//成交明细号

                    detailDtos1.add(detailDto);
                }

                rotateNoticeDto.setNoticeDetailDto(detailDtos1);
                rotateNoticeDto.setId(notice.getId());
                rotateNoticeDto.setNoticetype(notice.getNoticeType());//通知书类型
                rotateNoticeDto.setRotatetype(notice.getRotateType());//轮换类型
                rotateNoticeDto.setNoticeserial(notice.getNoticeSerial());//通知书编号
                rotateNoticeDto.setDocumentnumber(notice.getDocumentNumber());//文号
                rotateNoticeDto.setAccepteunit(notice.getAccepteUnit());//接受库点
                rotateNoticeDto.setStoragedate(notice.getStorageDate());//出入库截至日期
                rotateNoticeDto.setCreater(notice.getCreater());//经办人
                rotateNoticeDto.setCreatetime(notice.getCreateTime());//经办时间
                rotateNoticeDto.setStatus(notice.getStatus());//状态
                rotateNoticeDto.setCompletedate(notice.getCompleteDate());//签发日期
                rotateNoticeDto.setCompletehumen(notice.getCompleteHumen());//签发人
                rotateNoticeDto.setGrainannual(notice.getYear());//年份
                rotateNoticeDto.setRemark(notice.getRemark());//备注
                rotateNoticeDto.setAnnex(notice.getAnnex());//附件

                //每次循环就把rotateNoticeDto添加进list
                dataDto1.add(rotateNoticeDto);
            }
            model.setData(dataDto1);
            //model.setData(notices);
            model.setMsg("200");
            model.setSuccess(true);

            Map<String, Object> setting = new HashMap<>();
            setting.put("status", RotateNoticeService.SENDED);
            setting.put("list", noticeIds);
            rotateNoticeService.SendDataOut(setting);
        } else {
            model.setMsg("未找到所对应数据");
            model.setSuccess(false);
        }
        return model;
    }


    @RequestMapping(value = "/DictInfo", params = "type")
    @ResponseBody
    public ActionResultModel GetDictInfo(@RequestParam("type") String type) {
        ActionResultModel model = new ActionResultModel();
        if (mapper.get(type) != null) {
            List<SysDict> dictList = sysDictService.getSysDictListByType(mapper.get(type));
            Map<String, String> result = new HashMap<>();
            for (SysDict item : dictList) {
                result.put(item.getLabel(), item.getValue());
            }
            model.setSuccess(true);
            ;
            model.setData(result);
            model.setMsg("200");
            return model;
        }
        model.setMsg("未找到所对应数据");
        model.setSuccess(false);
        return model;
    }
    
    @RequestMapping(value = "/UserPush",method=RequestMethod.POST)
    @ResponseBody
    public ActionResultModel UserPush(@RequestParam("ac") String ac,@RequestParam(value="userInfo")String userInfo) {
        ActionResultModel model = new ActionResultModel();
        JSONArray object = JSONArray.fromObject(prop.get("AC_CODE"));
        List acCodeList = JSONArray.toList(object, new String(),new JsonConfig());
        if(acCodeList.contains(ac)) {
            System.out.println("UserPush===="+userInfo);
        	JSONObject _temp = JSONObject.fromObject(userInfo);
        	SysUser user = (SysUser) JSONObject.toBean(_temp,SysUser.class);
        	//oa的用户只有7中 公司加上6个直属库
        	if(user.getCompany()!=null) {

                switch(user.getCompany()) {
                    case "浙江省储备粮管理有限公司":
                        user.setOriginCode("CBL");
                        break;
                    case "中穗库":
                        user.setOriginCode("ZHS");
                        break;
                    case "衢州库":
                        user.setOriginCode("QUZ");
                        break;
                    case "越州库":
                        user.setOriginCode("YUE");
                        break;
                    case "直属库":
                        user.setOriginCode("ZHI");
                        break;
                    case "德清库":
                        user.setOriginCode("DEQ");
                        break;
                    case "舟山库":
                        user.setOriginCode("ZSK");
                        break;
                    default:

                        break;
                }
//        		List<StorageWarehouse> target = storageWarehouseService.list(user.getCompany()).getData();
//        		if(target!=null && target.size()>0)
//        			user.setOriginCode(target.get(0).getWarehouseCode());
        	}
        	user.setPassword("123456");
        	user.setStatus(new BigDecimal(1));
        	try {
        		if(sysUserService.selectById(user.getId())==null) {
        			sysUserService.createSysUser(user);
        		}else {
        			sysUserService.updateByPrimaryKeySelective(user);
        		}
			} catch (Exception e) {
				model.setMsg("System Error,Please contact the administrator");
				model.setSuccess(false);
				return model;
			}
        	model.setMsg("200");
        	model.setSuccess(true);
        }else {
        	model.setMsg("wrong AC code!");
        	model.setSuccess(false);
        }
        
        return model;
    }
    
    @RequestMapping(value = "/UserDel",method=RequestMethod.POST)
    @ResponseBody
    public ActionResultModel UserDel(@RequestParam("ac") String ac,@RequestParam(value="userCode")String userCode) {
        ActionResultModel model = new ActionResultModel();
        JSONArray object = JSONArray.fromObject(prop.get("AC_CODE"));
        List acCodeList = JSONArray.toList(object, new String(),new JsonConfig());
        if(acCodeList.contains(ac)) {
        	sysUserService.deleteById(userCode);
        	model.setMsg(String.format("已删除用户ID为'%s'的内容",userCode));
        	model.setSuccess(true);
        }else {
        	model.setMsg("wrong AC code!");
        	model.setSuccess(false);
        }
        return model;
    }
}
