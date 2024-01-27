package com.pinkElephantAdmin.daos;

import java.util.List;

import com.pinkElephantAdmin.model.Teams;


public interface TeamsDAO {

	public List<Teams> getAllTeams();

	public boolean addNewTeam(Teams team);
	
	public void updateTeam(Teams team);
	
	public void deleteTeam(long id);

	public long getIdByTeamName(Teams team);

}
