package com.pinkElephantAdmin.model;

public class Teams {
	public long id=Long.MIN_VALUE;
	public String name ;
	public byte[] image;
	public String designation;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public byte[] getImage() {
		return image;
	}
	public void setImage(byte[] image) {
		this.image = image;
	}
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	
}
