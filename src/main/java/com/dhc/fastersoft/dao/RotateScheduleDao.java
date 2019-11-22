package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.RotateArrive;
import com.dhc.fastersoft.entity.RotateClaim;
import com.dhc.fastersoft.entity.RotateSchedule;
import com.dhc.fastersoft.entity.RotateScheduleDetail;
import com.dhc.fastersoft.entity.RotateScheme;


public interface RotateScheduleDao {
	/**
	 * 保存
	 * @param record
	 * @return
	 */
	int save(RotateSchedule record);
	/**
	 * 更新
	 * @param record
	 * @return
	 */
	int update(RotateSchedule record);
	/**
	 * 根据id删除
	 * @param id
	 * @return
	 */
	int remove(String id);
	/**
	 * 获取单个
	 * @param id 
	 * @return
	 */
	RotateSchedule get(String id);
	/**
	 * 分页时总条数
	 * @param map 查询条件
	 * @return
	 */
	int count(HashMap<String, Object> map);
	/**
	 * 查询列表
	 * @param map 查询条件
	 * @return
	 */
	List<RotateSchedule> list(HashMap<String, Object> map);
	/**
	 * 查询明细列表
	 * @param map 查询条件
	 * @return
	 */
	List<RotateScheduleDetail> listDetail(HashMap<String, String> map);
	/**
	 * 获取最新的上期
	 * @param dealSerial
	 * @return
	 */
	Double getPriorPeriod(String dealSerial);
	/**
	 * 检查是否唯一
	 * @param map
	 * @return
	 */
	int checkPrimaryOfDetail(HashMap<String, String> map);
	/**
	 * 汇总进度
	 * @return
	 */
	List<RotateScheduleDetail> gatherScheduleDetail(HashMap<String, String> map);
	/**
	 * 汇总数量
	 * @return
	 */
	int countGather(HashMap<String, String> map);
	/**
	 * 查看汇总进度明细
	 * @return
	 */
	List<RotateScheduleDetail> viewGatherDetail(HashMap<String, String> map);
	/**
	 * 历史进度
	 * @return
	 */
	List<RotateSchedule> listScheduleHistory(HashMap<String, Object> map);
	/**
	 * 历史数量
	 * @return
	 */
	int countScheduleHistory(HashMap<String, Object> map);
	/**
	 * 查看历史进度明细
	 * @return
	 */
	List<RotateScheduleDetail> listDetailHistory(HashMap<String, String> map);
	
	int updateStatus(HashMap<String, String> map);

}
