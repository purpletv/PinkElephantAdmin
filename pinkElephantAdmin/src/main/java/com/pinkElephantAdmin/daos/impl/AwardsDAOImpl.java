package com.pinkElephantAdmin.daos.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.pinkElephantAdmin.daos.AwardsDAO;
import com.pinkElephantAdmin.daos.DivisionsDAO;
import com.pinkElephantAdmin.daos.AwardsDAO;
import com.pinkElephantAdmin.model.Divisions;
import com.pinkElephantAdmin.model.Films;
import com.pinkElephantAdmin.model.Awards;

@Component
public class AwardsDAOImpl implements AwardsDAO {

	JdbcTemplate jdbcTemplate;
	
	@Autowired
	public AwardsDAOImpl(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	


	@Override
	public List<Awards> getAllAwards() {
		String sql = "SELECT * FROM Awards";
        return jdbcTemplate.query(sql, new RowMapper<Awards>() {
            @Override
            public Awards mapRow(ResultSet rs, int rowNum) throws SQLException {
            	Awards award = new Awards();
                award.setId(rs.getLong("id"));
                award.setTitle(rs.getString("title"));
                award.setDescription(rs.getString("description"));
                
                award.setImage(rs.getBytes("image"));
                return award;
            }
        });
	}


	@Override
	public boolean addNewAward(Awards award) {
		if(award.getId()== Long.MIN_VALUE) {
			 long generatedId = getGeneratedIdFromSequence();
			 award.setId(generatedId);
		}
		String sql = "INSERT INTO awards  VALUES (?,?, ?,?)";

	    try {
	        int rowsAffected = jdbcTemplate.update(sql,award.getId(),award.getImage(),award.getDescription(),award.getTitle());
	        return rowsAffected > 0;
	    } catch (Exception e) {
	    	e.printStackTrace();
	        return false;
	    }
		
	}
	
	private long getGeneratedIdFromSequence() {
	    String sequenceQuery = "SELECT nextval('awards_seq')";

	    try {
	        return jdbcTemplate.queryForObject(sequenceQuery, Long.class);
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle the exception or return an appropriate default value
	        throw new RuntimeException("Error generating ID from sequence", e);
	    }
	}


	@Override
	public void updateAward(Awards award) {
		String sql = "UPDATE Awards SET Title=?, description=? , Image=?  WHERE id=?";

	    try {
	        jdbcTemplate.update(sql, award.getTitle(),award.getDescription(),award.getImage(), award.getId());
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle the exception or throw a custom exception
	        throw new RuntimeException("Error updating Division", e);
	    }
		
	}


	@Override
	public void deleteAward(long id) {
		String sql = "DELETE FROM Awards WHERE id=?";

	    try {
	        jdbcTemplate.update(sql, id);
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle the exception or throw a custom exception
	        throw new RuntimeException("Error deleting Award", e);
	    }
		
	}


	@Override
	public long getIdByAwardName(Awards award) {
		String query = "SELECT id FROM Awards WHERE Title = ?";

	    try {
	        return jdbcTemplate.queryForObject(query, Long.class,award.getTitle());
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle the exception or return an appropriate default value
	        throw new RuntimeException("Error getting ID by Awards Name", e);
	    }
	}

}
