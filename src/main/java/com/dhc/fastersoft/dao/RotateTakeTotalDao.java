package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.RotateTakeTotal;

import java.util.List;

public interface RotateTakeTotalDao {

    List<RotateTakeTotal> listRotateTakeTotal();

    List<RotateTakeTotal> limitByParams(RotateTakeTotal rotateTakeTotal);
}
