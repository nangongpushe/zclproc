package com.dhc.fastersoft.service.store;

import com.dhc.fastersoft.entity.store.StoreFeedBackProblems;
import org.springframework.stereotype.Component;

import java.util.List;


@Component
public interface StoreFeedBackProblemsService {
	
	public int add(StoreFeedBackProblems storeFeedBackProblems);
	public int update(StoreFeedBackProblems storeFeedBackProblems);
	public List<StoreFeedBackProblems> getStoreFeedBackProblemsByID(String serial);
	public int remove(String serial);
}
