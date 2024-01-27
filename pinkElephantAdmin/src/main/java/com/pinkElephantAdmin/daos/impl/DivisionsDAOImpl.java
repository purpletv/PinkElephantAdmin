package com.pinkElephantAdmin.daos.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.jdbc.core.RowMapper;

import com.pinkElephantAdmin.daos.DivisionsDAO;
import com.pinkElephantAdmin.model.Divisions;


@Component
public class DivisionsDAOImpl implements DivisionsDAO{
			
		JdbcTemplate jdbcTemplate;
		
		@Autowired
		public DivisionsDAOImpl(DataSource dataSource) {
			jdbcTemplate = new JdbcTemplate(dataSource);
		}
		
		@Override
		public boolean addNewDivision(Divisions div) {
			if(div.getId()== Long.MIN_VALUE) {
				 long generatedId = getGeneratedIdFromSequence();
			        div.setId(generatedId);
			}
			String sql = "INSERT INTO divisions  VALUES (?,?, ?)";

		    try {
		        int rowsAffected = jdbcTemplate.update(sql,div.getId(), div.getDiv_Name(), div.getDescription());
		        return rowsAffected > 0;
		    } catch (Exception e) {
		    	e.printStackTrace();
		        return false;
		    }
			
		}
		
		private long getGeneratedIdFromSequence() {
		    String sequenceQuery = "SELECT nextval('divisions_seq')";

		    try {
		        return jdbcTemplate.queryForObject(sequenceQuery, Long.class);
		    } catch (Exception e) {
		        e.printStackTrace();
		        // Handle the exception or return an appropriate default value
		        throw new RuntimeException("Error generating ID from sequence", e);
		    }
		}

		@Override
		public List<Divisions> getAllDivisions() {
			String sql = "SELECT * FROM Divisions";
	        return jdbcTemplate.query(sql, new RowMapper<Divisions>() {
	            @Override
	            public Divisions mapRow(ResultSet rs, int rowNum) throws SQLException {
	            	Divisions div = new Divisions();
	                div.setId(rs.getLong("id"));
	                div.setDiv_Name(rs.getString("div_name"));
	                div.setDescription(rs.getString("description"));
	                return div;
	            }
	        });
			
		}

		@Override
		public void updateDivision(Divisions div) {
			
			String sql = "UPDATE Divisions SET div_name=?, description=? WHERE id=?";

		    try {
		        jdbcTemplate.update(sql, div.getDiv_Name(), div.getDescription(), div.getId());
		    } catch (Exception e) {
		        e.printStackTrace();
		        // Handle the exception or throw a custom exception
		        throw new RuntimeException("Error updating Division", e);
		    }
		}

		@Override
		public void deleteDivision(long id) {
			String sql = "DELETE FROM Divisions WHERE id=?";

		    try {
		        jdbcTemplate.update(sql, id);
		    } catch (Exception e) {
		        e.printStackTrace();
		        // Handle the exception or throw a custom exception
		        throw new RuntimeException("Error deleting Division", e);
		    }
			
		}

		@Override
		public long getIdByDivName(Divisions div) {
			String query = "SELECT id FROM Divisions WHERE div_name = ?";

		    try {
		        return jdbcTemplate.queryForObject(query, Long.class, div.getDiv_Name());
		    } catch (Exception e) {
		        e.printStackTrace();
		        // Handle the exception or return an appropriate default value
		        throw new RuntimeException("Error getting ID by Division Name", e);
		    }
		}

		
	}

