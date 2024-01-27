package com.pinkElephantAdmin.model;

public class Awards {
	public long id= Long.MIN_VALUE;
	public byte[] image;
	public String description;
	public String title;
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
	public byte[] getImage() {
		return image;
	}
	public void setImage(byte[] image) {
		this.image = image;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
}
