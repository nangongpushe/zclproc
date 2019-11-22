package com.dhc.fastersoft.service.impl;



import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.RotateArriveDao;
import com.dhc.fastersoft.entity.RotateArrive;
import com.dhc.fastersoft.entity.RotateArriveAudit;
import com.dhc.fastersoft.entity.RotateArriveDepartment;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.RotateArriveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;
@Service("rotateArriveService")
public class RotateArriveServiceImpl implements RotateArriveService {
	
	@Autowired
	private RotateArriveDao arriveDao;

	@Override
	public int save(RotateArrive record) {
		// TODO Auto-generated method stub
		record.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		SysUser user = TokenManager.getToken();
		record.setReporter(user.getName());
		record.setReportDate(new Date());
		record.setReportDept(user.getDepartment());
		record.setReporterId(user.getId());
		record.setBalance(record.getArriveAmount());
		return arriveDao.save(record);
	}

	@Override
	public int update(RotateArrive record) {
		// TODO Auto-generated method stub
		record.setModifier(TokenManager.getToken().getName());
		record.setModifyDate(new Date());
		record.setBalance(record.getArriveAmount());
		return arriveDao.update(record);
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return arriveDao.remove(id);
	}

	@Override
	public RotateArrive get(String id) {
		// TODO Auto-generated method stub
		
		return arriveDao.get(id);
	}

	@Override
	public List<RotateArrive> list(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		List<RotateArrive> list=arriveDao.list(map);
		return list;
	}

	@Override
	public int updateStatus(String id, String status) {
		// TODO Auto-generated method stub
		HashMap<String, String> map=new HashMap<>();
		map.put("id", id);
		map.put("status", status);
		return arriveDao.updateStatus(map);
	}

	@Override
	public int count(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return arriveDao.count(map);
	}

	@Override
	public int updateClaimStatus(String id, String claimStatus) {
		// TODO Auto-generated method stub
		HashMap<String, String> map=new HashMap<>();
		map.put("id", id);
		map.put("claimStatus", claimStatus);
		return arriveDao.updateClaimStatus(map);
	}

	@Override
	public int updateBalance(String id, double balance) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map=new HashMap<>();
		map.put("id", id);
		map.put("balance", balance);
		return arriveDao.updateBalance(map);
	}

	@Override
	public int saveAudit(RotateArriveAudit audit) {
		// TODO Auto-generated method stub
		return arriveDao.saveAudit(audit);
	}

	@Override
	public int updateAudit(RotateArriveAudit audit) {
		// TODO Auto-generated method stub
		return arriveDao.updateAudit(audit);
	}

	@Override
	public List<RotateArriveAudit> listAudit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return arriveDao.listAudit(map);
	}

	@Override
	public int isExistAudit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return arriveDao.isExistAudit(map);
	}

	@Override
	public int removeAudit(String arriveId) {
		// TODO Auto-generated method stub
		return arriveDao.removeAudit(arriveId);
	}

	@Override
	public RotateArriveAudit getAudit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return arriveDao.getAudit(map);
	}

	@Override
	public int saveDepartment(List<RotateArriveDepartment> arriveDepartments) {
		// TODO Auto-generated method stub
		return arriveDao.saveDepartment(arriveDepartments);
	}

	@Override
	public int removeDepartment(String arriveId) {
		// TODO Auto-generated method stub
		return arriveDao.removeDepartment(arriveId);
	}

	@Override
	public List<RotateArriveDepartment> listDepartment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return arriveDao.listDepartment(map);
	}

	@Override
	public void reUpdateStatus(RotateArrive rotateArrive) {
		arriveDao.update(rotateArrive);
		arriveDao.removeAudit(rotateArrive.getId());
	}


}
