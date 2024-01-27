package com.pinkElephantAdmin.model;

public class Divisions {
	
	public long id = Long.MIN_VALUE;
	public String div_Name;
	public String description;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	
	
	public String getDiv_Name() {
		return div_Name;
	}
	public void setDiv_Name(String div_Name) {
		this.div_Name = div_Name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}		
}
