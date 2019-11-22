package com.dhc.fastersoft.service;

import com.dhc.fastersoft.entity.RotateNotice;
import com.dhc.fastersoft.utils.PageUtil;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public interface RotateNoticeService {
	
	int SENDED = 1;
	int UN_SEND = 0;
	
	RotateNotice GetNoticeDetail(String nId);
	void SaveNotic(RotateNotice notice);
	List<RotateNotice> ListLimitNotice(PageUtil<RotateNotice> pageUtil);
	int GetTotalCount(PageUtil<RotateNotice> pageUtil);
	void UpdateNotice(RotateNotice notice);
	List<RotateNotice> GetNoticeDetailByids(List<String> ids);
	void SendDataOut(Map<String,Object> ids);
	int getRownum(Map<String,Object> data);
	RotateNotice GetNoticeByDealSerial(HashMap<String, Object> map);

	/**
	 * 判断通知书编号是否存在
	 * @return
	 */
	boolean rotateNotifIsExistence(Map<String,Object> map) throws Exception;

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
