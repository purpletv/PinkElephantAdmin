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

import com.pinkElephantAdmin.daos.SocialMediaDAO;
import com.pinkElephantAdmin.daos.SocialMediaDAO;
import com.pinkElephantAdmin.model.SocialMedia;


@Component
public class SocialMediaDAOImpl implements SocialMediaDAO{
			
		JdbcTemplate jdbcTemplate;
		
		@Autowired
		public SocialMediaDAOImpl(DataSource dataSource) {
			jdbcTemplate = new JdbcTemplate(dataSource);
		}
		
		@Override
		public boolean addNewSocialMedia(SocialMedia sm) {
			if(sm.getId()== Long.MIN_VALUE) {
				 long generatedId = getGeneratedIdFromSequence();
			        sm.setId(generatedId);
			}
			String sql = "INSERT INTO SocialMedia  VALUES (?,?, ?)";

		    try {
		        int rowsAffected = jdbcTemplate.update(sql,sm.getId(), sm.getSocial_media_name(), sm.getSocial_media_link());
		        return rowsAffected > 0;
		    } catch (Exception e) {
		    	e.printStackTrace();
		        return false;
		    }
			
		}
		
		private long getGeneratedIdFromSequence() {
		    String sequenceQuery = "SELECT nextval('SocialMedia_seq')";

		    try {
		        return jdbcTemplate.queryForObject(sequenceQuery, Long.class);
		    } catch (Exception e) {
		        e.printStackTrace();
		        // Handle the exception or return an appropriate default value
		        throw new RuntimeException("Error generating ID from sequence", e);
		    }
		}

		@Override
		public List<SocialMedia> getAllSocialMedia() {
			String sql = "SELECT * FROM SocialMedia";
	        return jdbcTemplate.query(sql, new RowMapper<SocialMedia>() {
	            @Override
	            public SocialMedia mapRow(ResultSet rs, int rowNum) throws SQLException {
	            	SocialMedia sm = new SocialMedia();
	                sm.setId(rs.getLong("id"));
	                sm.setSocial_media_name(rs.getString("social_media_name"));
	                sm.setSocial_media_link(rs.getString("social_media_link"));
	                return sm;
	            }
	        });
			
		}

		@Override
		public void updateSocialMedia(SocialMedia sm) {
			
			String sql = "UPDATE SocialMedia SET social_media_name=?, social_media_link=? WHERE id=?";

		    try {
		        jdbcTemplate.update(sql, sm.getSocial_media_name(), sm.getSocial_media_link(), sm.getId());
		    } catch (Exception e) {
		        e.printStackTrace();
		        // Handle the exception or throw a custom exception
		        throw new RuntimeException("Error updating SocialMedia", e);
		    }
		}

		@Override
		public void deleteSocialMedia(long id) {
			String sql = "DELETE FROM SocialMedia WHERE id=?";

		    try {
		        jdbcTemplate.update(sql, id);
		    } catch (Exception e) {
		        e.printStackTrace();
		        // Handle the exception or throw a custom exception
		        throw new RuntimeException("Error deleting SocialMedia", e);
		    }
			
		}

		@Override
		public long getIdBySMName(SocialMedia sm) {
			String query = "SELECT id FROM SocialMedia WHERE social_media_name = ?";

		    try {
		        return jdbcTemplate.queryForObject(query, Long.class, sm.getSocial_media_name());
		    } catch (Exception e) {
		        e.printStackTrace();
		        // Handle the exception or return an appropriate default value
		        throw new RuntimeException("Error getting ID by SocialMedia Platform", e);
		    }
		}

		
	}


