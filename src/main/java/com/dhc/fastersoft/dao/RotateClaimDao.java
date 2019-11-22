package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.shiro.crypto.hash.Hash;

import com.dhc.fastersoft.entity.RotateArrive;
import com.dhc.fastersoft.entity.RotateClaim;


public interface RotateClaimDao {
	/**
	 * 保存
	 * @param record
	 * @return
	 */
	int save(RotateClaim record);
	/**
	 * 更新
	 * @param record
	 * @return
	 */
	int update(RotateClaim record);
	/**
	 * 根据id删除
	 * @param id
	 * @return
	 */
	int remove(String id);
	/**
	 * 获取单个
	 * @param map,key=>arriveId(到货单ID)、claimMan(认领人)
	 * @return
	 */
	RotateClaim get(HashMap<String, String> map);
	/**
	 * 分页时总条数
	 * @param map
	 * @return
	 */
	int count(HashMap<String, Object> map);
	/**
	 * 列表
	 * @param map
	 * @return
	 */
	List<RotateClaim> list(HashMap<String, Object> map);
	/**
	 * 批量保存
	 * @param record
	 * @return
	 */
	int saveBatch(List<RotateClaim> list);
	
	Double getTotalAmount(HashMap<String, Object> map);

}
