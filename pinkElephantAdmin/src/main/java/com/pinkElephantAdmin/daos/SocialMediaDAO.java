package com.pinkElephantAdmin.daos;

import java.util.List;


import com.pinkElephantAdmin.model.SocialMedia;

public interface SocialMediaDAO {
	public List<SocialMedia> getAllSocialMedia();

	public boolean addNewSocialMedia(SocialMedia sm);
	
	public void updateSocialMedia(SocialMedia Div);
	
	public void deleteSocialMedia(long id);

	public long getIdBySMName(SocialMedia sm);
}
