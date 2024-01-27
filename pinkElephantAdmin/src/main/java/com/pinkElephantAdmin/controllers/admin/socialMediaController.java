package com.pinkElephantAdmin.controllers.admin;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinkElephantAdmin.daos.SocialMediaDAO;
import com.pinkElephantAdmin.model.SocialMedia;


@Controller
public class socialMediaController {
	private static final Logger logger = LoggerFactory.getLogger(socialMediaController.class);
	private final SocialMediaDAO smDAO;
	
	@Autowired
	socialMediaController(SocialMediaDAO smDAO) {
		this.smDAO = smDAO;
	}
	
	@RequestMapping(value = "/addMedia", method = RequestMethod.GET)
	public String getAddSMPage(Model model) {
	logger.info("pinkElephantAdmin:homePageController:calling the add div view page");
		// call the view
		return "addMedia";
	}
	
	@RequestMapping(value = "/createNewSocialMedia", method = RequestMethod.POST)
	@ResponseBody
	public String createProductNew(@Validated SocialMedia div, Model model) {
		smDAO.addNewSocialMedia(div);
		return "addedMedia";

	}
	
	@GetMapping("/backToAddNewSocialMedia")
	public String addNewCategorytInMasterEntry(Model model) {
		System.out.println("enter backToAddNewSocialMedia controller");
		
		return "addMedia";
	}
	
	
	@GetMapping("/updateMedia")
	public String updateMedia(Model model) {
		System.out.println("enter update SocialMedia controller");
		List<SocialMedia> allSMs=this.smDAO.getAllSocialMedia();
		model.addAttribute("allSMs", allSMs);
		return "updateMedia";
	}
	@RequestMapping(value = "/updateSocialMedia", method = RequestMethod.POST)
	public String updateSocialMedia(@Validated SocialMedia div,Model model) {
		System.out.println("enter update SocialMedia controller");
		List<SocialMedia> allSMs=this.smDAO.getAllSocialMedia();
		model.addAttribute("allSMs", allSMs);
		return "updateMedia";
	}
	
	@RequestMapping(value = "/confirmUpdateMedia", method = RequestMethod.POST)
	public String confirmUpdateMedia(@Validated SocialMedia sm,Model model) {
		System.out.println("enter confirm update SocialMedia controller");
		long id=smDAO.getIdBySMName(sm);
		sm.setId(id);
		smDAO.updateSocialMedia(sm);
		List<SocialMedia> allSMs=this.smDAO.getAllSocialMedia();
		model.addAttribute("allSMs", allSMs);
		return "updateMedia";
	}
	
	
	@RequestMapping(value = "/deleteMedia", method = RequestMethod.POST)
	public String deleteSM(@Validated SocialMedia sm,Model model) {
		System.out.println("enter delete SocialMedia controller");
		long id=smDAO.getIdBySMName(sm);
		sm.setId(id);
		smDAO.deleteSocialMedia(id);
		List<SocialMedia> allSMs=this.smDAO.getAllSocialMedia();
		model.addAttribute("allSMs", allSMs);
		return "updateSocialMedia";
	}
}
