package com.dhc.fastersoft.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.dhc.fastersoft.entity.StorageEnergy;
import com.dhc.fastersoft.utils.LayPage;

@Component
public interface StorageEnergyService {
	public LayPage<StorageEnergy> list(HttpServletRequest request);
	public int add(StorageEnergy torageEnergy);
	public int update(StorageEnergy torageEnergy);
	public List importStorageEnergys(MultipartFile file);
	
	public StorageEnergy getStorageEnergyById(String id);
	public int remove(String id);
}
