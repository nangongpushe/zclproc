package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.dao.RotateTakeTotalDao;
import com.dhc.fastersoft.entity.RotateTakeTotal;
import com.dhc.fastersoft.service.RotateTakeTotalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("rotateTakeTotalService")
public class RotateTakeTotalServiceImpl implements RotateTakeTotalService {

    @Autowired
    private RotateTakeTotalDao rotateTakeTotalDao;

    @Override
    public List<RotateTakeTotal> listRotateTakeTotal() {
        return rotateTakeTotalDao.listRotateTakeTotal();
    }

    @Override
    public List<RotateTakeTotal> limitByParams(RotateTakeTotal rotateTakeTotal) {
        return rotateTakeTotalDao.limitByParams(rotateTakeTotal);
    }
}
