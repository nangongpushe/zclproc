package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dhc.fastersoft.entity.QualityResultFile;
import com.dhc.fastersoft.entity.ResultDataTemp;
import com.dhc.fastersoft.utils.LayPage;
import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.QualityResult;

import javax.servlet.http.HttpServletRequest;

public interface QualityResultMapper {
    int insert(QualityResult record);

    int insertSelective(QualityResult record);

    int count(HashMap<String, Object> map);

    List<QualityResult> list(HashMap<String, Object> map);

    int resultFileCount(HashMap<String, Object> map);

    List<QualityResultFile> resultFileList(HashMap<String, Object> map);


    QualityResultFile getResultFileById(@Param("id") String id);

    List<QualityResult> list1(HashMap<String, Object> map);

    QualityResult getById(@Param("id") String id);

    int delete(@Param("id") String id);

    int add(QualityResult entity);

    int update(QualityResult entity);

    @MapKey("sampleNo")
    Map<String, QualityResult> queryBySampleNo(List<String> sampleNoList);

    List<QualityResult> getResultBySampleNo(Map<String, Object> param);

    List<QualityResult> selectQualityResultlist(HashMap<String, Object> map);

    int selectQualityResultcount(HashMap<String, Object> map);

    List<QualityResult> exportAlllist(HashMap<String, Object> map);

    int countSampleNo(HashMap<String, String> map);

    void saveFileHistory(QualityResultFile qrf);

    void saveTempResult(Map<String, Object> map);

    List<ResultDataTemp> tempResultlist(Map<String, Object> map);

    ResultDataTemp getTempResultById(@Param("id") String id);


    void updateTempResult(ResultDataTemp rdt);


    List<QualityResult> getResultByReportSerial(Map<String, Object> param);

    int delImportData(@Param("ids") List<String> ids);

    int countImportData(Map<String, Object> params);

    int delImportFile(String id);
}