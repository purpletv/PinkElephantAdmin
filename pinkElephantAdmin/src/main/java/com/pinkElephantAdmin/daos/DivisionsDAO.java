package com.pinkElephantAdmin.daos;

import java.util.List;

import com.pinkElephantAdmin.model.Divisions;

public interface DivisionsDAO {
	public List<Divisions> getAllDivisions();

	public boolean addNewDivision(Divisions div);
	
	public void updateDivision(Divisions Div);
	
	public void deleteDivision(long id);

	public long getIdByDivName(Divisions div);
}
