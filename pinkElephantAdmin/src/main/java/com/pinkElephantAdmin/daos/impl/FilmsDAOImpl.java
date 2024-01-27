package com.pinkElephantAdmin.daos.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.pinkElephantAdmin.daos.FilmsDAO;
import com.pinkElephantAdmin.model.Films;

@Component
public class FilmsDAOImpl implements FilmsDAO {

	JdbcTemplate jdbcTemplate;
	
	@Autowired
	public FilmsDAOImpl(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}
	


	@Override
	public List<Films> getAllFilms() {
		String sql = "SELECT * FROM Films";
        return jdbcTemplate.query(sql, new RowMapper<Films>() {
            @Override
            public Films mapRow(ResultSet rs, int rowNum) throws SQLException {
            	Films film = new Films();
                film.setId(rs.getLong("id"));
                film.setFilm_Name(rs.getString("film_Name"));
                film.setDirector(rs.getString("director"));
                film.setUrl(rs.getString("url"));
                film.setDescription(rs.getString("description"));
                film.setDiv_Id(rs.getLong("div_id"));
                film.setPoster(rs.getBytes("poster"));
                return film;
            }
        });
	}


	@Override
	public boolean addNewFilm(Films film) {
		if(film.getId()== Long.MIN_VALUE) {
			 long generatedId = getGeneratedIdFromSequence();
			 film.setId(generatedId);
		}
		String sql = "INSERT INTO films  VALUES (?,?, ?,?,?,?,?)";

	    try {
	        int rowsAffected = jdbcTemplate.update(sql,film.getId(),film.getDiv_Id(),film.getPoster(),film.getFilm_Name(),film.getDirector(),
	        		film.getDescription(),film.getUrl());
	        return rowsAffected > 0;
	    } catch (Exception e) {
	    	e.printStackTrace();
	        return false;
	    }
		
	}
	
	private long getGeneratedIdFromSequence() {
	    String sequenceQuery = "SELECT nextval('films_seq')";

	    try {
	        return jdbcTemplate.queryForObject(sequenceQuery, Long.class);
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle the exception or return an appropriate default value
	        throw new RuntimeException("Error generating ID from sequence", e);
	    }
	}


	@Override
	public void updateFilm(Films film) {
		String sql = "UPDATE Films SET Film_Name=?, description=? , director=? ,poster=?,div_id=?,url=? WHERE id=?";

	    try {
	        jdbcTemplate.update(sql, film.getFilm_Name(),film.getDescription(),film.getDirector(),film.getPoster(), film.getDiv_Id(), film.getUrl(), film.getId());
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle the exception or throw a custom exception
	        throw new RuntimeException("Error updating Division", e);
	    }
		
	}


	@Override
	public void deleteFilm(long id) {
		String sql = "DELETE FROM Films WHERE id=?";

	    try {
	        jdbcTemplate.update(sql, id);
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle the exception or throw a custom exception
	        throw new RuntimeException("Error deleting Division", e);
	    }
		
	}


	@Override
	public long getIdByFilmName(Films film) {
		String query = "SELECT id FROM Films WHERE film_Name = ?";

	    try {
	        return jdbcTemplate.queryForObject(query, Long.class,film.getFilm_Name());
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle the exception or return an appropriate default value
	        throw new RuntimeException("Error getting ID by Division Name", e);
	    }
	}

}
