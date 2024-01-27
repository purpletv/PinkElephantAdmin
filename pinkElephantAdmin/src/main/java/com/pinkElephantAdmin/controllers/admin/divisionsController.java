package com.pinkElephantAdmin.controllers.admin;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinkElephantAdmin.daos.DivisionsDAO;
import com.pinkElephantAdmin.model.Divisions;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

@Controller
public class divisionsController {
	private static final Logger logger = LoggerFactory.getLogger(divisionsController.class);
	private final DivisionsDAO divDAO;

	@Autowired
	divisionsController(DivisionsDAO divDAO) {
		this.divDAO = divDAO;
	}

	@RequestMapping(value = "/addDiv", method = RequestMethod.GET)
	public String getAddDivPage(Model model) {
		logger.info("pinkElephantAdmin:homePageController:calling the add div view page");
		// call the view
		return "addDivision";
	}

	@RequestMapping(value = "/createNewDivision", method = RequestMethod.POST)
	public String createProductNew(@Validated Divisions div, Model model) {
		divDAO.addNewDivision(div);
		return "addedDivision";

	}

	@GetMapping("/backToAddNewDivision")
	public String addNewCategorytInMasterEntry(Model model) {
		System.out.println("enter backToAddNewDivision controller");

		return "addDivision";
	}

	@GetMapping("/updateDiv")
	public String updateDiv(Model model) {
		System.out.println("enter update DIvision controller");
		List<Divisions> allDivs = this.divDAO.getAllDivisions();
		model.addAttribute("allDivs", allDivs);
		return "updateDivision";
	}

	@RequestMapping(value = "/updateDivision", method = RequestMethod.POST)
	public String updateDivision(@Validated Divisions div, Model model) {
		System.out.println("enter update DIvision controller");
		List<Divisions> allDivs = this.divDAO.getAllDivisions();
		model.addAttribute("allDivs", allDivs);
		return "updateDivision";
	}

	@RequestMapping(value = "/confirmUpdateDiv", method = RequestMethod.POST)
	public String confirmUpdateDiv(@Validated Divisions div, Model model) {
		System.out.println("enter confirm update DIvision controller");
		long id = divDAO.getIdByDivName(div);
		div.setId(id);
		divDAO.updateDivision(div);
		List<Divisions> allDivs = this.divDAO.getAllDivisions();
		model.addAttribute("allDivs", allDivs);
		return "updateDivision";
	}

	@RequestMapping(value = "/deleteDiv", method = RequestMethod.POST)
	public String deleteDiv(@Validated Divisions div, Model model) {
		System.out.println("enter delete DIvision controller");
		long id = divDAO.getIdByDivName(div);
		div.setId(id);
		divDAO.deleteDivision(id);
		List<Divisions> allDivs = this.divDAO.getAllDivisions();
		model.addAttribute("allDivs", allDivs);
		return "updateDivision";
	}

	@RequestMapping(value = "/getDivisions", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<List<Divisions>> getDivsions(@Validated Divisions div, Model model) {
		System.out.println("enter delete DIvision controller");
		List<Divisions> allDivs = this.divDAO.getAllDivisions();
		return new ResponseEntity<>(allDivs, HttpStatus.OK);
	}
}
