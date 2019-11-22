package com.dhc.fastersoft.service;

import java.util.List;

import com.dhc.fastersoft.entity.StorageGaslog;
import com.dhc.fastersoft.utils.PageUtil;

public interface StorageGaslogService {
	void AddStorageLog(StorageGaslog log);
	List<StorageGaslog> ListLimitLog(PageUtil pageUtil);
	StorageGaslog GetStorageGaslog(String id);
	void UpdateStoragelog(StorageGaslog log);
	void DeleteStoragelog(String id);
	List<StorageGaslog> GetStorageGaslogByIds(List<String> ids);
}
