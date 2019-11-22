package com.dhc.fastersoft.service;

import com.dhc.fastersoft.entity.RotateTakeTotal;

import java.util.List;

public interface RotateTakeTotalService {

    List<RotateTakeTotal> listRotateTakeTotal();

    List<RotateTakeTotal> limitByParams(RotateTakeTotal rotateTakeTotal);

}
