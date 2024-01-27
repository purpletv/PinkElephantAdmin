package com.pinkElephantAdmin.daos;

import java.util.List;

import com.pinkElephantAdmin.model.Divisions;
import com.pinkElephantAdmin.model.Films;

public interface FilmsDAO {
	public List<Films> getAllFilms();

	public boolean addNewFilm(Films film);
	
	public void updateFilm(Films film);
	
	public void deleteFilm(long id);

	public long getIdByFilmName(Films film);
}
