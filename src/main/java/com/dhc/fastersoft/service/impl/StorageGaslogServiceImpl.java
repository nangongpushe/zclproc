package com.dhc.fastersoft.service.impl;

import java.util.List;
import java.util.UUID;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.dao.StorageGaslogTempDao;
import com.dhc.fastersoft.entity.StorageGaslogTemp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.StorageGaslogDao;
import com.dhc.fastersoft.entity.StorageGaslog;
import com.dhc.fastersoft.service.StorageGaslogService;
import com.dhc.fastersoft.utils.PageUtil;

@Service("StorageGaslogService")
public class StorageGaslogServiceImpl implements StorageGaslogService {
	
	@Autowired
	private StorageGaslogDao storageGaslogDao;

	@Autowired
	private StorageGaslogTempDao storageGaslogTempDao;

	@Override
	public void AddStorageLog(StorageGaslog log) {

		String PrimId =UUID.randomUUID().toString().replace("-", "");
		List<StorageGaslogTemp> storageGaslogTemps = log.getStorageGaslogTemp();
		if (storageGaslogTemps!=null)
		for (StorageGaslogTemp storageGaslogTemp:storageGaslogTemps) {
			storageGaslogTemp.setId(UUID.randomUUID().toString().replace("-", ""));
			storageGaslogTemp.setP_id(PrimId);//主表id赋予子表p_id
			storageGaslogTempDao.save(storageGaslogTemp);
		}
		log.setId(PrimId);
		/*log.setId(UUID.randomUUID().toString().replace("-", ""));*/
		storageGaslogDao.AddStorageLog(log);
	}

	@Override
	public List<StorageGaslog> ListLimitLog(PageUtil pageUtil) {
		pageUtil.setTotalCount(storageGaslogDao.GetTotalCount(pageUtil));
		return storageGaslogDao.ListLimitLog(pageUtil);
	}

	@Override
	public StorageGaslog GetStorageGaslog(String id) {
		return storageGaslogDao.GetStorageGaslog(id);
	}

	@Override
	public void UpdateStoragelog(StorageGaslog log) {

		List<StorageGaslogTemp> storageGaslogTemps = log.getStorageGaslogTemp();
		storageGaslogTempDao.remove(log.getId());
		if (storageGaslogTemps!=null)
			for (StorageGaslogTemp storageGaslogTemp:storageGaslogTemps) {
				storageGaslogTemp.setId(UUID.randomUUID().toString().replace("-", ""));
				storageGaslogTemp.setP_id(log.getId());//主表id赋予子表p_id
				storageGaslogTempDao.save(storageGaslogTemp);
			}

		storageGaslogDao.UpdateStoragelog(log);
	}

	@Override
	public void DeleteStoragelog(String id) {
		storageGaslogTempDao.remove(id);
		storageGaslogDao.DeleteStoragelog(id);
	}

	@Override
	public List<StorageGaslog> GetStorageGaslogByIds(List<String> ids) {
		return storageGaslogDao.GetStorageGaslogByIds(ids);
	}

}
