package com.dhc.fastersoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.MapKey;
import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.QualityThird;
import com.dhc.fastersoft.utils.LayPage;

@Component
public interface QualityThirdService {

	LayPage<QualityThird> list(HttpServletRequest request);

	QualityThird getByID(String id);

	int remove(String id);

	int update(QualityThird entity);

	int add(QualityThird entity);

	List query(HttpServletRequest request);

	int countSampleNo(String str);

	Map<String,QualityThird> queryBySampleNo(List<String> sampleNoList);
}
