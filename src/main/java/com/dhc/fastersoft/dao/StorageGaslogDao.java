package com.dhc.fastersoft.dao;

import java.util.List;

import com.dhc.fastersoft.entity.StorageGaslog;
import com.dhc.fastersoft.utils.PageUtil;

public interface StorageGaslogDao {
	void AddStorageLog(StorageGaslog log);
	List<StorageGaslog> ListLimitLog(PageUtil pageUtil);
	int GetTotalCount(PageUtil pageUtil);
	StorageGaslog GetStorageGaslog(String id);
	void UpdateStoragelog(StorageGaslog log);
	void DeleteStoragelog(String id);
	List<StorageGaslog> GetStorageGaslogByIds(List<String> ids);
}
