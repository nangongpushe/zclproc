package com.dhc.fastersoft.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.entity.system.SysUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.StorageOilcanDao;
import com.dhc.fastersoft.dao.StorageOilcanRepairDao;
import com.dhc.fastersoft.entity.StorageOilcan;
import com.dhc.fastersoft.service.StorageOilcanService;
import com.dhc.fastersoft.utils.LayPage;

@Service("storageOilcanService")
public class StorageOilcanServiceImpl implements StorageOilcanService {
	
	@Autowired
	StorageOilcanDao dao;
	@Autowired
	StorageOilcanRepairDao repairDao;
	@Autowired
	StorageWarehouseDao warehouseDao;

	@Override
	public ActionResultModel save(StorageOilcan oilcan) {
		// TODO Auto-generated method stub
		ActionResultModel result = new ActionResultModel();
		
		/**判断当前库点下仓房编号是否唯一*/
		String oilcanSerial = oilcan.getOilcanSerial();
		String warehouse = oilcan.getWarehouse();
		if (dao.getBySerialAndWarehouse(oilcanSerial, warehouse).size() == 0) {
			oilcan.setId(dao.getPrimId());
			if (dao.save(oilcan) == 1) {
				result.setMsg("新增成功");
				result.setSuccess(true);
			} else {
				result.setMsg("新增失败");
				result.setSuccess(false);
			}
		} else {
			result.setMsg("油罐编号在此库点下不唯一，请更换");
			result.setSuccess(false);
		}
		
		return result;
	}

	@Override
	public ActionResultModel update(StorageOilcan oilcan) {
		// TODO Auto-generated method stub
		ActionResultModel result = new ActionResultModel();
		//System.out.println("id = " + oilcan.getId());
		String oilcanSerial = oilcan.getOilcanSerial();
		String warehouse = oilcan.getWarehouse();
		
		List<StorageOilcan> list = dao.getBySerialAndWarehouse(oilcanSerial, warehouse);
		if (list.size() == 0 || 
				(list.size() == 1 && list.get(0).getId().equals(oilcan.getId()))) {
			if (dao.update(oilcan) == 1) {
				result.setMsg("修改成功");
				result.setSuccess(true);
			} else {
				result.setMsg("修改失败");
				result.setSuccess(false);
			}
		} else {
			result.setMsg("油罐编号在此库点下不唯一，请更换");
			result.setSuccess(false);
		}
		return result;
	}

	@Override
	public LayPage<StorageOilcan> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<StorageOilcan> page = new LayPage<>();
        HashMap<String, String> map = QueryUtil.pageQuery(request);
        
        String storehouseId = request.getParameter("storehouseId");
        map.put("storehouseId", storehouseId);
		
        String warehouse = request.getParameter("warehouse");
        String oilcanSerial = request.getParameter("oilcanSerial");
        String oilcanType = request.getParameter("oilcanType");
        String oilcanStatus = request.getParameter("oilcanStatus");
        String designedCapacity = request.getParameter("designedCapacity");
        String authorizedCapacity = request.getParameter("authorizedCapacity");
        String designedOilLine = request.getParameter("designedOilLine");
        String authorizedOilLine = request.getParameter("authorizedOilLine");
        String deliverDate = request.getParameter("deliverDate");
        String minCapacity = request.getParameter("minCapacity");
        String maxCapacity = request.getParameter("maxCapacity");
        String isStop = request.getParameter("isStop");
        map.put("isStop",isStop);
        map.put("warehouse", warehouse);
        map.put("oilcanSerial", oilcanSerial);
        map.put("oilcanType", oilcanType);
        map.put("oilcanStatus", oilcanStatus);
        map.put("designedCapacity", designedCapacity);
        map.put("authorizedCapacity", authorizedCapacity);
        map.put("designedOilLine", designedOilLine);
        map.put("authorizedOilLine", authorizedOilLine);
        map.put("deliverDate", deliverDate);
        map.put("minCapacity", minCapacity);
        map.put("maxCapacity", maxCapacity);

		SysUser user = TokenManager.getToken();
		List kudianCodes = warehouseDao.listKudianCode();
		boolean isKudian = kudianCodes.contains(user.getOriginCode());//是否库点用户
		if((user.getOriginCode() != null && user.getOriginCode().equals("CBL")) || //判断是否是公司用户，如果是，便可以看到所有的库点信息
				user.getAccount().equals("admin")){
			map.put("warehouseCode", "");
		}else{ //只能看自己
			map.put("warehouseCode", user.getOriginCode());
		}
        
        int count = dao.count(map);
		
		if (count <= 0) {
			return page;
		}
        
        List<StorageOilcan> data = dao.list(map);
        
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}

	@Override
	public StorageOilcan get(String id) {
		// TODO Auto-generated method stub
		return dao.get(id);
	}

	@Override
	public ActionResultModel remove(String id) {
		// TODO Auto-generated method stub
		ActionResultModel result = new ActionResultModel();
		
		/*int repairNum = repairDao.countByOilcanId(id);*/
		StorageOilcan storageOilcan = dao.get(id);
		Integer monthBzwflag = dao.selectMonthBzw(storageOilcan);
		Integer monthSwtzflag = dao.selectMonthSwtz(storageOilcan);
		Integer planDetallflag = dao.selectPlanDetall(storageOilcan);
		Integer qualitySampleflag = dao.selectQualitySample(storageOilcan);
		if (monthBzwflag == 0 && monthSwtzflag == 0 && planDetallflag == 0 && qualitySampleflag == 0) {
			dao.remove(id);
			result.setSuccess(true);
			result.setMsg("删除仓房信息成功");
		} else {
			if (monthBzwflag>0){
				result.setSuccess(false);
				result.setMsg("包装物库存月报表中存在此仓房,不能删除");
			}

			if (monthSwtzflag>0){
				result.setSuccess(false);
				result.setMsg("粮油库存实物台账中存在此仓房,不能删除");
			}
			if (planDetallflag>0){
				result.setSuccess(false);
				result.setMsg("轮换计划详情中存在此仓房,不能删除");
			}
			if (qualitySampleflag>0){
				result.setSuccess(false);
				result.setMsg("样品信息中存在此仓房,不能删除");
			}


		}
		/*if (repairNum == repairDao.removeByOilcanId(id) && dao.remove(id) == 1) {
			result.setMsg("删除成功");
			result.setSuccess(true);
		} else {
			result.setMsg("删除失败");
			result.setSuccess(false);
		}*/
		return result;
	}
	
	@Override
	public LayPage<StorageOilcan> list(String warehouse) {
		// TODO Auto-generated method stub
		LayPage<StorageOilcan> page = new LayPage<>();
        HashMap<String, String> map = new HashMap<>();
        map.put("warehouse", warehouse);
        
        int count = dao.count(map);
		
		if (count <= 0) {
			return page;
		}
        
        List<StorageOilcan> data = dao.list(map);
        
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}

	@Override
	public int getcountByWarehouseId(String warehouseId) {
		Map<String ,String> tempMap = new HashMap<>();
		tempMap.put("warehouseId",warehouseId);
		return dao.count(tempMap);
	}
}
