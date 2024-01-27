package com.pinkElephantAdmin.daos.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.pinkElephantAdmin.daos.TeamsDAO;
import com.pinkElephantAdmin.model.Awards;
import com.pinkElephantAdmin.model.Teams;

@Component
public class TeamsDAOImpl implements TeamsDAO {

	JdbcTemplate jdbcTemplate;
	
	@Autowired
	public TeamsDAOImpl(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	


	@Override
	public List<Teams> getAllTeams() {
		String sql = "SELECT * FROM Teams";
        return jdbcTemplate.query(sql, new RowMapper<Teams>() {
            @Override
            public Teams mapRow(ResultSet rs, int rowNum) throws SQLException {
            	Teams team = new Teams();
            	team.setId(rs.getLong("id"));
            	team.setName(rs.getString("name"));
            	team.setImage(rs.getBytes("image"));
            	team.setDesignation(rs.getString("designation"));
                
                
                return team;
            }
        });
	}


	@Override
	public boolean addNewTeam(Teams team) {
		if(team.getId()== Long.MIN_VALUE) {
			 long generatedId = getGeneratedIdFromSequence();
			 team.setId(generatedId);
		}
		String sql = "INSERT INTO teams  VALUES (?,?, ?,?)";

	    try {
	        int rowsAffected = jdbcTemplate.update(sql,team.getId(),team.getName(),team.getImage(),team.getDesignation());
	        return rowsAffected > 0;
	    } catch (Exception e) {
	    	e.printStackTrace();
	        return false;
	    }
		
	}
	
	private long getGeneratedIdFromSequence() {
	    String sequenceQuery = "SELECT nextval('teams_seq')";

	    try {
	        return jdbcTemplate.queryForObject(sequenceQuery, Long.class);
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle the exception or return an appropriate default value
	        throw new RuntimeException("Error generating ID from sequence", e);
	    }
	}


	@Override
	public void updateTeam(Teams team) {
		String sql = "UPDATE Teams SET Name=?, Image=? , Designation=?  WHERE id=?";

	    try {
	        jdbcTemplate.update(sql, team.getName(),team.getImage(),team.getDesignation(), team.getId());
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle the exception or throw a custom exception
	        throw new RuntimeException("Error updating Division", e);
	    }
		
	}


	@Override
	public void deleteTeam(long id) {
		String sql = "DELETE FROM Teams WHERE id=?";

	    try {
	        jdbcTemplate.update(sql, id);
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle the exception or throw a custom exception
	        throw new RuntimeException("Error deleting Team", e);
	    }
		
	}


	@Override
	public long getIdByTeamName(Teams team) {
		String query = "SELECT id FROM Teams WHERE Name = ?";

	    try {
	        return jdbcTemplate.queryForObject(query, Long.class,team.getName());
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle the exception or return an appropriate default value
	        throw new RuntimeException("Error getting ID by Team Name", e);
	    }
	}

}
