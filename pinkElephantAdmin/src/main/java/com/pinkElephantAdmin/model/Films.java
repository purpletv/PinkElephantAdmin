package com.pinkElephantAdmin.model;

public class Films {
	public long  id = Long.MIN_VALUE;
	public byte[] poster;
	public Long div_Id;
	public String film_Name;
	public String director;
	public String description;
	public String url;
	private String base64Poster;

	public String getBase64Poster() {
		return base64Poster;
	}

	public void setBase64Poster(String base64Poster) {
		this.base64Poster = base64Poster;
	}

	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public byte[] getPoster() {
		return poster;
	}
	public void setPoster(byte[] poster) {
		this.poster = poster;
	}
	
	public Long getDiv_Id() {
		return div_Id;
	}
	public void setDiv_Id(Long div_Id) {
		this.div_Id = div_Id;
	}
	
	public String getFilm_Name() {
		return film_Name;
	}
	public void setFilm_Name(String film_Name) {
		this.film_Name = film_Name;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

}