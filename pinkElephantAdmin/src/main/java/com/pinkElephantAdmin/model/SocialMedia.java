package com.pinkElephantAdmin.model;

public class SocialMedia {
	public long id= Long.MIN_VALUE;
	public String social_media_name;
	public String social_media_link;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getSocial_media_name() {
		return social_media_name;
	}
	public void setSocial_media_name(String social_media_name) {
		this.social_media_name = social_media_name;
	}
	public String getSocial_media_link() {
		return social_media_link;
	}
	public void setSocial_media_link(String social_media_link) {
		this.social_media_link = social_media_link;
	}
	
	
}
