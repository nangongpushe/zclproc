package com.dhc.fastersoft.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageEnergyDao;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.dao.system.SysRoleDao;
import com.dhc.fastersoft.dao.system.SysUserDao;
import com.dhc.fastersoft.entity.StorageEnergy;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageEnergyService;
import com.dhc.fastersoft.utils.ExcelUtils;
import com.dhc.fastersoft.utils.LayPage;

@Service("StorageEnergyService")
public class StorageEnergyServiceImpl implements StorageEnergyService{
   @Autowired  StorageEnergyDao storageEnergyDao;
   @Autowired
	SysUserDao sysUserDao;
	@Autowired
	SysRoleDao sysRoleDao;
	@Autowired
	StorageWarehouseDao storageWarehouseDao;
   @Override
	public int add(StorageEnergy torageEnergy) {
		// TODO Auto-generated method stub
		return storageEnergyDao.add(torageEnergy);
	}
   
   @Override
	public int update(StorageEnergy torageEnergy) {
		// TODO Auto-generated method stub
		return storageEnergyDao.update(torageEnergy);
	}
   
   @Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return storageEnergyDao.remove(id);
	}
   
   @Override
	public StorageEnergy getStorageEnergyById(String id) {
		// TODO Auto-generated method stub
		return storageEnergyDao.getStorageEnergyById(id);
	}
   
   @Override
	public LayPage<StorageEnergy> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
	   LayPage<StorageEnergy> page=new LayPage<>();
       HashMap<String,String> maps = QueryUtil.pageQuery(request);
       maps.put("warehouseName", request.getParameter("warehouseName"));
     
		//现获取用户的权限
		
		 HashMap<String,Object> map = new HashMap<String, Object>();			
  	   map.put("warehouseType", "");
  	   map.put("warehouseShort",  TokenManager.getToken().getShortName());
		       int i= storageWarehouseDao.check(map);
		    
		       if (i>0) {
		    	   maps.put("warehouseName", TokenManager.getToken().getShortName());
		       }
		maps.put("workType", request.getParameter("workType"));
		maps.put("workTime", request.getParameter("month"));
	
		String workTime = request.getParameter("workTime");
		List<StorageEnergy> data;
		int count ;
	    if (workTime.equals("")) {
	    	//月统计
	    	
	    	count= storageEnergyDao.getRecordCount1(maps);  

	        if (count<=0) {
	 			return page;
	 		}
	        
	 	    data= storageEnergyDao.pageQuery1(maps);
	       
		}else{
			maps.put("workTime", workTime);
			 count = storageEnergyDao.getRecordCount(maps);  

	        if (count<=0) {
	 			return page;
	 		}
	        data= storageEnergyDao.pageQuery(maps);
	       
		}
	    page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}
   
  
   @Override
	public List importStorageEnergys(MultipartFile file) {
		List result = new ArrayList();
		
		try {
			ExcelUtils excelUtils = new ExcelUtils(file.getInputStream());
			excelUtils.setNotNullArray(new int[]{0,1,2,3});
//			excelUtils.setLengthArray(new String[]{"2=10","3=10"});
//			excelUtils.setTypeArray(new String[]{"1=int","3=int"});
			
			List<String> errorList = excelUtils.checkExcelData();
			if(errorList.size() > 0) {
				return errorList;
			} else {
//				User user=(User) WebUtils.getSessionAttribute(request, "user");
//				List list = routeDao.getRouteIdList();
//				HashMap<String,String> map = new HashMap<String,String>();
//				Iterator it = list.iterator();
//				while(it.hasNext()){
//					Route route = (Route)it.next();
//					map.put(route.getRouteid(), route.getRouteName());
//				}
//				List<String> financeRouteIds = financeRouteDao.getRouteIdList();
//				int iAdds = 0;   // 新增数量
//				int iEdits = 0;  // 修改数量
//				int iFails = 0;  // 跳过数量(ROUTE表中没有的)
//				String fails = ""; // 跳过的RouteId
//				<option value="通风">通风</option>
//						<option value="气调">气调</option>
//						<option value="熏蒸">熏蒸</option>
//						<option value="控温">控温</option>
//						<option value="出入库">出入库</option>
//						<option value="中转">中转</option>

				String[] arrayType = new String[]{"通风","气调","熏蒸","控温","出入库","中转"};
				String[][] array = excelUtils.getArray();
				List<StorageEnergy>  list=new ArrayList<>();
				for(int i=1;i<array.length;i++){

					int k = 0;
					StorageEnergy storageEnergy = new StorageEnergy();
					storageEnergy.setId(UUID.randomUUID().toString().replace("-", ""));
					storageEnergy.setWarehouseName(array[i][k++]);
					storageEnergy.setWorkType(array[i][k++]);
					storageEnergy.setWorkTime(array[i][k++]);
					storageEnergy.setEnergy(Double.valueOf(array[i][k++]));
					//类型是否一致
					int  isFlag=0;
					for (int j = 0; j < arrayType.length; j++) {
						if(arrayType[j].equals(storageEnergy.getWorkType())){
							isFlag=1;
						}
					}
					if(isFlag==0){
						//不存在
						result.add("导入失败！类型"+storageEnergy.getWorkType()+"不存在");
						return result;
					}

					list.add(storageEnergy);

				}

				for (StorageEnergy storageEnergy:list){
					StorageEnergy storageEnergy1 = storageEnergyDao.getStorageEnergy(storageEnergy);
					if (storageEnergy1!=null) {
						storageEnergy.setId(storageEnergy1.getId());
						storageEnergyDao.update(storageEnergy);
					}else{
						storageEnergyDao.add(storageEnergy);
					}
				}
			}
				
				result.add("导入成功");
			
		} catch (Exception e) {
			result.add("导入失败！");
			e.printStackTrace();
		}
		return result;
	}

}
