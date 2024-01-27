package com.pinkElephantAdmin.controllers.admin;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinkElephantAdmin.daos.DivisionsDAO;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;


@Controller
public class homePageController {
	private static final Logger logger = LoggerFactory.getLogger(homePageController.class);
	private final DivisionsDAO divDAO;
	
	@Autowired
	homePageController(DivisionsDAO divDAO) {
		this.divDAO = divDAO;
	}
	
	// url mapping for home page
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String getHomePage(Model model) {
	logger.info("pinkElephantAdmin:homePageController:calling the home view page");
		// call the view
		return "home";
	}
	
	
}
