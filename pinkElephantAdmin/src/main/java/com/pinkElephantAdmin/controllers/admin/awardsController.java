package com.pinkElephantAdmin.controllers.admin;

import java.util.Base64;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinkElephantAdmin.daos.AwardsDAO;
import com.pinkElephantAdmin.daos.DivisionsDAO;
import com.pinkElephantAdmin.model.Awards;
import com.pinkElephantAdmin.model.Divisions;

@Controller
public class awardsController {
	private static final Logger logger = LoggerFactory.getLogger(awardsController.class);

	@Autowired
	private AwardsDAO awardDAO;
	@Autowired
	private DivisionsDAO divDAO;

	@RequestMapping(value = "/addAward", method = RequestMethod.GET)
	public String getAddAward(Model model) {
		logger.info("pinkElephantAdmin:awardController:calling the add award view page");
		List<Divisions> allDivs = this.divDAO.getAllDivisions();
		model.addAttribute("allDivs", allDivs);
		return "addAward";
	}

	@RequestMapping(value = "/createNewAwardElephant", method = RequestMethod.POST)
	public String createAwardNew(@RequestParam("description") String description,
			@RequestParam("title") String awardTitle, @RequestParam("image") MultipartFile file, Model model) {
		Awards award = new Awards();

		award.setDescription(description);

		award.setTitle(awardTitle);

		if (!file.isEmpty()) {
			try {
				byte[] imageData = file.getBytes();
				award.setImage(imageData);
			} catch (Exception e) {
				logger.error("Error uploading image: " + e.getMessage());
				// Handle the error, redirect to an error page, or show an error message
			}
		}

		awardDAO.addNewAward(award);

		// Clear the form after successful submission
		award = new Awards();
		model.addAttribute("award", award);

		return "addedDivision";

	}

	@GetMapping("/backToAddNewAward")
	public String addNewAward(Model model) {
		System.out.println("enter backToAddNewAward controller");

		return "addAward";
	}

	@RequestMapping(value = "/deleteAward", method = RequestMethod.GET)
	public String deleteAward(Model model) {
		System.out.println("enter delete Award controller");
		List<Awards> allAwards = this.awardDAO.getAllAwards();
		model.addAttribute("allAwards", allAwards);
		return "deleteAward";
	}

	@RequestMapping(value = "/onDeleteAward", method = RequestMethod.POST)
	public String deleteAward(@Validated Awards award, Model model) {
		System.out.println("enter delete Award controller");
		awardDAO.deleteAward(award.getId());
		List<Awards> allAwards = this.awardDAO.getAllAwards();
		model.addAttribute("allAwards", allAwards);
		return "deleteAward";
	}

	@GetMapping("/newupdateAward")
	public String newupdateAward(Model model) {
		System.out.println("enter update Award controller");
		return "updateAward";
	}

	@PostMapping("/getAwardData")
	@ResponseBody
	public ResponseEntity<List<Awards>> getAwardData() {
		System.out.println("Entering getAwardData controller");
		try {
			List<Awards> allAwards = this.awardDAO.getAllAwards();
			for (Awards award : allAwards) {
				if (award.getImage() != null) {
					byte[] posterBytes = award.getImage();
					String base64Poster = Base64.getEncoder().encodeToString(posterBytes);
					award.setBase64Poster(base64Poster);
				} else {
					award.setBase64Poster(""); // Set an empty string or handle it as appropriate
				}
			}
			return new ResponseEntity<>(allAwards, HttpStatus.OK);
		} catch (Exception e) {
			// Handle exception if necessary
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@RequestMapping(value = "/updatingAwardData", method = RequestMethod.POST)
	public String updateAwards(@RequestParam("awardTitle") String awardTitle,
			@RequestParam("description") String description, @RequestParam("poster") MultipartFile file, // Change the
																											// parameter
																											// name to
																											// match
																											// FormData
			Model model) {
		try {
			Awards award = new Awards();

			award.setDescription(description);

			award.setTitle(awardTitle);

			if (!file.isEmpty()) {
				byte[] imageData = file.getBytes();
				award.setImage(imageData);
			}

			// Rest of your code...

			System.out.println("enter update Award controller");
			List<Awards> allAwards = this.awardDAO.getAllAwards();
			model.addAttribute("allAwards", allAwards);

			return "updateAward";
		} catch (Exception e) {
			e.printStackTrace(); // Add this line for debugging
			return "errorPage"; // Handle the exception gracefully
		}
	}

	@RequestMapping(value = "/newupdatingAwardData", method = RequestMethod.POST)
	public String newupdatingAwardData(@RequestParam("id") String id,

			@RequestParam("awardTitle") String awardTitle,

			@RequestParam("description") String description,

			@RequestParam("poster") MultipartFile file, // Change the parameter name to match FormData
			Model model) {
		try {
			Awards award = new Awards();

			award.setDescription(description);

			award.setTitle(awardTitle);

			award.setId(Long.parseLong(id));

			if (!file.isEmpty()) {
				byte[] imageData = file.getBytes();
				award.setImage(imageData);
			}

			// Rest of your code...

			awardDAO.updateAward(award);
			return "updateAward";
		} catch (Exception e) {
			e.printStackTrace(); // Add this line for debugging
			return "errorPage"; // Handle the exception gracefully
		}
	}

}
