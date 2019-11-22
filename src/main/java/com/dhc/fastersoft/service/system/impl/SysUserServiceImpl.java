package com.dhc.fastersoft.service.system.impl;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.system.SysUserDao;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("sysUserService")
public class SysUserServiceImpl implements SysUserService{
	
	@Autowired
	private SysUserDao sysUserDao;

	@Override
	public SysUser login(String account, String password) {
		// TODO Auto-generated method stub
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("account", account);
		map.put("password", password);
		SysUser user = sysUserDao.login(map);
		return user;
	}

	@Override
	public int updateByPrimaryKeySelective(SysUser sysUser) {
		return sysUserDao.updateByPrimaryKeySelective(sysUser);
	}

	@Override
	public int createSysUser(SysUser sysUser) {
		
		return sysUserDao.insert(sysUser);
	}

	@Override
	public LayPage<SysUser> pageList(HttpServletRequest request) {
		LayPage<SysUser> page = new LayPage<SysUser>();

        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        
        String name = request.getParameter("key[name]");
        map.put("name", name);
        String name1 = request.getParameter("name1");
        if (name1!=null) {
        	 map.put("name", name1);
		}
       
        map.put("company", request.getParameter("company"));
		map.put("originCode",request.getParameter("originCode"));
		int count = sysUserDao.getRecordCount(map);    //总记录数
		page.setCode(0);
		page.setCount(count);
        if (count<=0) {
        	page.setMsg("没有查询到数据");
			return page;
		}
        page.setData(sysUserDao.pageQuery(map));
        String  ku="CBL,ZHI,YUE,ZHS,ZSK,DEQ,QUZ";
		for (SysUser sysUser:page.getData()) {
			if (sysUser.getOriginCode() == null) {
				sysUser.setOriginCode("");
			}

			boolean status = ku.contains(sysUser.getOriginCode());
			if (!status) {
				sysUser.setIsEdit("N");
			} else {
				sysUser.setIsEdit("Y");

			}
		}
        page.setMsg("succes");
		return page;
	}
	@Override
	public List<SysUser> getList() {
		// TODO Auto-generated method stub
		HashMap<String, String> map =new HashMap<String, String>();
		return sysUserDao.pageQuery(map);
	}

	@Override
	public void saveUserRole(String roleid, String userId) {
		HashMap<String,String> map = new HashMap<String, String>();
		map.put("roleid", roleid);
		map.put("userId", userId);
		map.put("id", StringUtils.createUUID());
		sysUserDao.saveUserRole(map);
		
	}

	@Override
	public void deleteById(String id) {
		
		sysUserDao.deleteByPrimaryKey(id);
	}

	@Override
	public SysUser selectByAccount(String account) {
		// TODO Auto-generated method stub
		return sysUserDao.selectByAccount(account);
	}
	@Override
	public SysUser selectByCompany(String reportWarehouse) {
		// TODO Auto-generated method stub
		return sysUserDao.selectByCompany(reportWarehouse);
	}
	
	@Override
	public String getUserPosition() {
		// TODO Auto-generated method stub
		//现获取用户的权限
		SysUser sysUser = sysUserDao.selectByPrimaryKey(TokenManager.getSysUserId());
		String type="";
		if (sysUser.getPosition()!=null) {
			if (sysUser.getPosition().equals("代储企业经办人")) {
				//代储企业默认只能看到自己维护的企业信息
				type="3";
				
			}else if (sysUser.getPosition().equals("仓储部经办人")) {
				//上级单位可查看所有代储企业信息 比如6个库与最高级别的公司
				 if (StringUtils.equals(sysUser.getOriginCode().toUpperCase(),"CBL")) {
					 type="1";
					
				}else{
					//去分片监管查库看监管的企业  通过企业编号唯一去查找
					type="2";
				}
				
			}else{
				type="0";
			}
		}else{
			type="0";
		}
		return type;
	}
	
	@Override
	public SysUser selectByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return sysUserDao.selectByPrimaryKey(id);
	}

 
	@Override
	public void deleteUserRole(String userId) {
		// TODO Auto-generated method stub
		sysUserDao.deleteUserRole(userId);
	}

	@Override
	public SysUser selectById(String id) {
		// TODO Auto-generated method stub
		return sysUserDao.selectByPrimaryKey(id);
	}

	@Override
	public List<SysUser> distinctList() {
		// TODO Auto-generated method stub
		HashMap<String, String> map =new HashMap<String, String>();
		return sysUserDao.distinctList(map);
	}
	@Override
	public List<SysUser> getListByRoleName(String roleName) {
		// TODO Auto-generated method stub
		return sysUserDao.getListByRoleName(roleName);
	}

    @Override
    public List<SysUser> getListByStoreHouseAndType(HashMap<String, String> map) {
    	// TODO Auto-generated method stub
    	return sysUserDao.getListByStoreHouseAndType(map);
    }

	@Override
	public SysUser getUserByPosition(String position) {
		return sysUserDao.getUserByPosition(position);
	}


	@Override
	public List<SysUser> getUserIds(HashMap<String, String> map) {
		return sysUserDao.getUserIds(map);
	}

	@Override
	public List<SysUser> getUserByExample(Map<String, Object> param) {
		return sysUserDao.getUserByExample(param);
	}


}
