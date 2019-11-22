package com.dhc.fastersoft.service;




import java.util.HashMap;
import java.util.List;



import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.RotateClaim;


@Component
public interface RotateClaimService {
	
	int save(RotateClaim record);
	
	int update(RotateClaim record);

	int remove(String id);	
	
	RotateClaim get(String arriveId,String claimMan);
	
	List<RotateClaim> list(HashMap<String, Object> map);
	
	int count(HashMap<String, Object> map);
	
	int saveBatch(List<RotateClaim> list);
	
	Double getTotalAmount(HashMap<String, Object> map);
}
