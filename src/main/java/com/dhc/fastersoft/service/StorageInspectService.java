package com.dhc.fastersoft.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.StorageInspect;
import com.dhc.fastersoft.utils.LayPage;

@Component
public interface StorageInspectService {

	LayPage<StorageInspect> list(HttpServletRequest request);

	int add(StorageInspect entity);

	int update(StorageInspect entity);

	StorageInspect getById(String id);

	int delete(String id);

}
