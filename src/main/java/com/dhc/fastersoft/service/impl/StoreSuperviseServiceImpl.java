package com.dhc.fastersoft.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.StoreSuperviseDao;
import com.dhc.fastersoft.dao.StoreSuperviseItemDao;
import com.dhc.fastersoft.entity.StoreSupervise;
import com.dhc.fastersoft.entity.StoreSuperviseItem;
import com.dhc.fastersoft.service.StoreSuperviseService;
import com.dhc.fastersoft.utils.LayPage;

@Service("storeSuperviseService")
public class StoreSuperviseServiceImpl implements StoreSuperviseService{
	@Autowired
	StoreSuperviseDao dao;
	@Autowired
	StoreSuperviseItemDao idao;

	
	private static SimpleDateFormat FORMAT =  new SimpleDateFormat("yyyy-MM-dd");
	
	@Override
	public ActionResultModel save(StoreSupervise supervise) {
		ActionResultModel result = new ActionResultModel();
		String id = dao.getPrimId();
		supervise.setId(id);
		for (int i = 0; i < supervise.getDetail().size(); i++) {
			supervise.getDetail().get(i).setId(UUID.randomUUID().toString().replace("-", ""));
			supervise.getDetail().get(i).setSuperviseId(id);
		}
		String currSerial = supervise.getSuperviseSerial();//dao.getCurrSerial();//页面上已获取，新增时无需另外取序号，否则对应记录的页面序号和新增后序号不一致
		if (currSerial != null && !currSerial.equals("")) {
			supervise.setSuperviseSerial(currSerial);
		} else {
			result.setMsg("新增失败");
			result.setSuccess(false);
			return result;
		}
		supervise.setSuperviseSerial(currSerial);
		/*System.out.println(this.getClass().getName() + supervise.toString());
		System.out.println(dao.save(supervise));*/
		if (dao.save(supervise) != 0) {
			result.setMsg("新增成功");
			result.setSuccess(true);
		} else {
			result.setMsg("新增失败");
			result.setSuccess(false);
		}
		return result;
	}

	@Override
	public ActionResultModel update(StoreSupervise supervise) {
		// TODO Auto-generated method stub
		ActionResultModel result = new ActionResultModel();
		for (int i = 0; i < supervise.getDetail().size(); i++) {
			supervise.getDetail().get(i).setId(UUID.randomUUID().toString().replace("-", ""));
			supervise.getDetail().get(i).setSuperviseId(supervise.getId());
		}
		if (dao.update(supervise) != 0) {
			result.setMsg("修改成功");
			result.setSuccess(true);
		} else {
			result.setMsg("修改失败");
			result.setSuccess(false);
		}
		return result;
	}

	@Override
	public StoreSupervise get(String id) {
		// TODO Auto-generated method stub
		StoreSupervise s = dao.get(id);
		s.setCreateDateFmt(FORMAT.format(s.getCreateDate()));
		s.setDetail(idao.listBySuperviseId(id));
		/*for (StoreSuperviseItem i : s.getDetail()) {
			System.out.println(i.toString());
		}*/
		return s;
	}

	@Override
	public LayPage<StoreSupervise> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<StoreSupervise> page = new LayPage<>();
        HashMap<String,String> map = QueryUtil.pageQuery(request);
        String superviseSerial = request.getParameter("superviseSerial");
        String superviseYear = request.getParameter("superviseYear");
        String createDate = request.getParameter("createDate");
        
        map.put("superviseSerial", superviseSerial);
        map.put("superviseYear", superviseYear);
        map.put("createDate", createDate);
        
		int count = dao.count(map);
		
		if (count <= 0) {
			return page;
		}
        
        List<StoreSupervise> data = dao.list(map);
        for (int i = 0;i < data.size(); i++) {
        	data.get(i).setCreateDateFmt(FORMAT.format(data.get(i).getCreateDate()));
        }
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	} 
	
	@Override
	public ActionResultModel remove(String id) {
		// TODO Auto-generated method stub
		ActionResultModel result = new ActionResultModel();
		System.out.println("remove" + dao.remove(id));
		if (dao.remove(id) != 0) {
			result.setMsg("删除成功");
			result.setSuccess(true);
		} else {
			result.setMsg("删除失败");
			result.setSuccess(false);
		}
		return result;
	}

	@Override
	public String getCurrSerial() {
		// TODO Auto-generated method stub
		return dao.getCurrSerial();
	}

	@Override
	public List<StoreSuperviseItem> listStoreSuperviseItems(String warehouseName) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		map.put("warehouseName", warehouseName);
		map.put("nowDate", Calendar.getInstance().getTime());
		return idao.listStoreSuperviseItems(map);
	}

	@Override
	public int check(HttpServletRequest request) {
		// TODO Auto-generated method stub
		HashMap<String,String> map = QueryUtil.pageHashMap(request);
		int count=0;
		String superviseYear=request.getParameter("superviseYear");
		if (superviseYear!=""&&superviseYear!=null) {
			map.put("superviseYear", superviseYear);
			count=dao.countCheck(map);
		}
		return count;
	}


	@Override
	public StoreSupervise getMaxSuperiviseYear() {
		StoreSupervise storeSupervise = dao.getMaxSuperiviseYear();
		return storeSupervise;
	}
}
