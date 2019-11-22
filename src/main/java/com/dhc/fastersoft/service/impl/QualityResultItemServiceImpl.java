package com.dhc.fastersoft.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.QualityResultItemMapper;
import com.dhc.fastersoft.entity.QualityResultItem;
import com.dhc.fastersoft.service.QualityResultItemService;
import com.dhc.fastersoft.utils.LayPage;

@Service("QualityResultItemService")
public class QualityResultItemServiceImpl implements QualityResultItemService{
	@Autowired
	public QualityResultItemMapper dao;
	@Override
	public int deleteItem(String id) {
		// TODO Auto-generated method stub
		return dao.delete(id);
	}

	@Override
	public int add(QualityResultItem qtiItem) {
		// TODO Auto-generated method stub
		return dao.add(qtiItem);
	}

	@Override
	public List<QualityResultItem> getByID(String id) {
		// TODO Auto-generated method stub
		return dao.getById(id);
	}

	@Override
	public LayPage<QualityResultItem> listCon(String ids) {
		// TODO Auto-generated method stub
		LayPage<QualityResultItem> page=new LayPage<>();
        HashMap<String,String> map = new HashMap<String, String>();
        String id[]=ids.split("-");
        String one=id[0];
        String two=id[1];
        map.put("one", one);
        map.put("two", two);
        int count=dao.count(map);
        if (count<=0) {
			return page;
		}
        List<QualityResultItem> data=dao.listCon(map);
        page.setCount(30);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}

	@Override
	public int update(QualityResultItem qtiItem) {
		// TODO Auto-generated method stub
		return dao.update(qtiItem);
	}

	@Override
	public int count(String id) {
		// TODO Auto-generated method stub
		return dao.countNum(id);
	}

	@Override
	public int countItemName(QualityResultItem qtiItem) {
		// TODO Auto-generated method stub
		return dao.countItemName(qtiItem);
	}

	@Override
	public List<QualityResultItem> queryByResultId(List<String> resultIds) {
		return dao.queryByResultId(resultIds);
	}

}
