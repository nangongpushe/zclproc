package com.dhc.fastersoft.service;




import java.util.List;

import com.dhc.fastersoft.entity.DurablesOptions;


public interface DurablesOptionsService {
	public int add(DurablesOptions durablesOptions);
	public int update(DurablesOptions durablesOptions);
	public List<DurablesOptions> getDurablesOptionsByID(String id);
	public int remove(String id);

}
