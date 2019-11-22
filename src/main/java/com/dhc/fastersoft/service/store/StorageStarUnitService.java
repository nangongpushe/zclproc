package com.dhc.fastersoft.service.store;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.entity.store.StorageStarUnit;
import com.dhc.fastersoft.utils.LayPage;

@Component
public interface StorageStarUnitService {
	public int add(StorageStarUnit storageStarUnit);
	public int update(StorageStarUnit storageStarUnit);
	public StorageStarUnit getStorageStarUnitByID(String id);
	public LayPage<StorageStarUnit> list(HttpServletRequest request);
	public List<StorageStarUnit> exportxls(HttpServletRequest request);

	public int remove(String id);
	
}
