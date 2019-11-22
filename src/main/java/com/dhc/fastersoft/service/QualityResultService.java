package com.dhc.fastersoft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.QualityResultFile;
import com.dhc.fastersoft.entity.ResultDataTemp;
import com.dhc.fastersoft.utils.LayEntity;
import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.QualityResult;
import com.dhc.fastersoft.entity.StorageStoreHouse;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.web.multipart.MultipartFile;

@Component
public interface QualityResultService {

	List query(HttpServletRequest request);

	LayPage<QualityResult> list(HttpServletRequest request);

	LayPage<ResultDataTemp> tempResultlist(HttpServletRequest request);
	QualityResult getByID(String id);

	int remove(String id);

	int add(QualityResult entity);

	int update(QualityResult entity);

	List<StorageStoreHouse> getStoreEncode();

	List<QualityResult> getResultBySampleNo(Map<String,Object> param);

	LayPage<QualityResult> selectQualityResult(HashMap<String, Object> map);

	List<QualityResult> exportAlllist(HttpServletRequest request);
	int countSampleNo(String str);

	Map<String,QualityResult> queryBySampleNo(List<String> sampleNoList);
	LayEntity addResultfileAndTempResult(MultipartFile file, HttpServletRequest request);
	void saveFileHistory(QualityResultFile qrf);
	void saveTempResult(Map<String,Object> map);
	void updateTempQualityResult(ResultDataTemp rdt);
	ActionResultModel importResult (HttpServletRequest request);

	ResultDataTemp getTempResultByID(String id);

	QualityResultFile getResultFileById(String id);
	LayPage<QualityResultFile> resultFileList(HttpServletRequest request);

	/**
	 * 根据ID删除导入数据
	 * @param ids
	 * @return
	 */
	int delImportData(List<String> ids);

	int countImportData(Map<String,Object> params);

	int delImportFile(String id);

    void sendMessage(String resultId, String operateType) throws Exception;
}
