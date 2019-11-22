package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.ExportRotateSum;
import com.dhc.fastersoft.entity.RotateConclute;
import com.dhc.fastersoft.entity.RotateConcluteDetail;
import com.dhc.fastersoft.entity.RotateManuDetail;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public interface RotateConcluteDao {

	int save(RotateConclute record);

	int update(RotateConclute record);

	int remove(String id);

	int removeDetail(String id);

	RotateConclute get(String id);

	List<RotateConcluteDetail> getDetailList(String id);

	int count(HashMap<String, Object> map);

	int countRotateSum(HashMap<String, Object> map);
	List<RotateConclute> list(HashMap<String, Object> map);

	List<RotateConclute> listRotateSum(HashMap<String, Object> map);
	List<RotateConcluteDetail> getDealSerialFromConcluteDetail(Map<String, Object> map);
	List<RotateConcluteDetail> listDetail(String id);

	List<RotateConcluteDetail> listDetai2(@Param("id") String id, @Param("warehouseId") String warehouseId);

	List<RotateConcluteDetail> listOutDetail(Map<String,Object> map);

	List<ExportRotateSum> listOutExportDetail(Map<String,Object> map);
	List<RotateConcluteDetail> listDetails(HashMap<String, Object> map);

	List<RotateConcluteDetail> listDetailByCondition(HashMap<String, Object> map);//

	List<RotateConcluteDetail> listDetailByCondition1(HashMap<String, Object> map);

	int countDetailByCondition(HashMap<String, Object> map);

	int countDetailByCondition1(HashMap<String, Object> map);

	List<RotateConcluteDetail> listConcluteDetailByNotice(HashMap<String, String> map);

	int countConcluteDetailByNotice(HashMap<String, String> map);

	String getSchemeDetailIdByDealSerial(String dealSerial);

	int updateStatus(HashMap<String, String> map);

	int getSerialCount(String date);

	int serialConut(String perfix);    // 不确定 getSerialCount是否有其他地方引用

	List<RotateConcluteDetail> listDetailForRefund(HashMap<String, String> map);

	List<RotateConcluteDetail> listDetailForRefundNew(HashMap<String, Object> map);

	int countDetailForRefund(HashMap<String, String> map);

	int countDetailForRefundNew(HashMap<String, Object> map);

	List<RotateConcluteDetail> listDetailJoinScheme(HashMap<String, String> map);

	int countDetailJoinScheme(HashMap<String, String> map);

	List<RotateConcluteDetail> finishRotateConclute(Map<String, Object> map);

	RotateConcluteDetail getRotateConcluteDetailById(String id);

	RotateConcluteDetail getRotateConcluteDetailByDealSerial(String dealSerial);

	String getClientInfoById(String id);

    List<RotateConcluteDetail> outListDetail(HashMap<String, Object> map);

    BigDecimal getSurplusPlanNum(Map<String, Object> param);

    List<RotateManuDetail> outManuListDetail(HashMap<String, Object> map);

	int countConcluteDetailByNoticeMaun(HashMap<String, String> map);

	List<RotateConcluteDetail> listConcluteDetailByNoticeMaun(HashMap<String, String> map);


    List<String> listInDetailSerial(RotateConcluteDetail rotateConcluteDetail);

	RotateConcluteDetail listByDealSerial(String dealSerial);
}