package com.dhc.fastersoft.dao;


import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.StorageEnergy;


public interface StorageEnergyDao {
	public List pageQuery(HashMap maps);
	public List pageQuery1(HashMap maps);
	public int add(StorageEnergy torageEnergy);
	public int update(StorageEnergy torageEnergy);
	public int getRecordCount(HashMap maps);	
	public int getRecordCount1(HashMap maps);	
	
	public StorageEnergy getStorageEnergyById(String id);
	public StorageEnergy getStorageEnergy(StorageEnergy torageEnergy);
	
	public int remove(String id);
}