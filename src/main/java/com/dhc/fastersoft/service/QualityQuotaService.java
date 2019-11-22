package com.dhc.fastersoft.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.QualityQuota;
import com.dhc.fastersoft.utils.LayPage;

@Component
public interface QualityQuotaService {

	LayPage<QualityQuota> list(HttpServletRequest request);

	QualityQuota getByID(String id);

	int remove(String id);

	int add(QualityQuota entity);

	int update(QualityQuota entity);
	
	List<QualityQuota> listQualityQuota();
	
	QualityQuota getQualityQuotaByOther(String grainType,String grade);
	
	QualityQuota getQualityQuotaById(String id);

	int check(HttpServletRequest request, String str);

	
}
