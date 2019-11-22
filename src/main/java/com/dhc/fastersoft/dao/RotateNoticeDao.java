package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.RotateNotice;
import com.dhc.fastersoft.utils.PageUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface RotateNoticeDao {
	RotateNotice GetNoticeDetail(String nId);
	void SaveNotice(RotateNotice notice);
	List<RotateNotice> ListLimitNotice(PageUtil<RotateNotice> pageUtil);
	int GetTotalCount(PageUtil<RotateNotice> pageUtil);
	void UpdateNotice(RotateNotice notice);
	List<RotateNotice> GetNoticeDetailByids(List<String> ids);
	void SendDataOut(Map<String,Object> ids);
	int getRownum(Map<String,Object> data);
	RotateNotice GetNoticeByDealSerial(HashMap<String, Object> map);
	Integer getRotateNoticeCount(Map<String,Object> map);
	/**
	 * 根据日期将所有未下发的数据和指定创建日期及以后的所有数据下发
	 * @param pageUtil
	 * @return
	 */
	List<RotateNotice> listLimitNoticeByDate(PageUtil<RotateNotice> pageUtil);

	List<String> findOutNoticeSerial();

    List<String> findInNoticeSerial();

    List<String> findMoveNoticeSerial();
}
