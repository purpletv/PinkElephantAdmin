package com.pinkElephantAdmin.daos;

import java.util.List;

import com.pinkElephantAdmin.model.Awards;
import com.pinkElephantAdmin.model.Awards;

public interface AwardsDAO {

	public List<Awards> getAllAwards();

	public boolean addNewAward(Awards award);
	
	public void updateAward(Awards award);
	
	public void deleteAward(long id);

	public long getIdByAwardName(Awards award);

}
