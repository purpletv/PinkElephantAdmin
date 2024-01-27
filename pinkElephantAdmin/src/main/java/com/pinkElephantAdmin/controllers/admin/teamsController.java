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

import com.pinkElephantAdmin.daos.TeamsDAO;
import com.pinkElephantAdmin.model.Teams;

@Controller
public class teamsController {
	private static final Logger logger = LoggerFactory.getLogger(teamsController.class);

	@Autowired
	private TeamsDAO teamDAO;

	@RequestMapping(value = "/addTeam", method = RequestMethod.GET)
	public String getAddTeam(Model model) {
		logger.info("pinkElephantAdmin:teamController:calling the add Team view page");

		return "addTeam";
	}

	@RequestMapping(value = "/createNewTeam", method = RequestMethod.POST)
	@ResponseBody
	public String createTeamNew(@RequestParam("designation") String designation,
			@RequestParam("title") String title, @RequestParam("image") MultipartFile file, Model model) {

		Teams team = new Teams();

		team.setDesignation(designation);

		team.setName(title);

		if (!file.isEmpty()) {
			try {
				byte[] imageData = file.getBytes();
				team.setImage(imageData);
			} catch (Exception e) {
				logger.error("Error uploading image: " + e.getMessage());
				// Handle the error, redirect to an error page, or show an error message
			}
		}
		
		teamDAO.addNewTeam(team);

		return "addedTeam";

	}

	@GetMapping("/backToAddNewTeam")
	public String addNewTeam(Model model) {
		System.out.println("enter backToAddNewTeam controller");

		return "addTeam";
	}

	@RequestMapping(value = "/deleteTeam", method = RequestMethod.GET)
	public String deleteTeam(Model model) {
		System.out.println("enter delete Team controller");
		List<Teams> allTeams = this.teamDAO.getAllTeams();
		model.addAttribute("allTeams", allTeams);
		return "deleteTeam";
	}

	@RequestMapping(value = "/onDeleteTeam", method = RequestMethod.POST)
	public String deleteTeam(@Validated Teams team, Model model) {
		System.out.println("enter delete Team controller");
		teamDAO.deleteTeam(team.getId());
		List<Teams> allTeams = this.teamDAO.getAllTeams();
		model.addAttribute("allTeams", allTeams);
		return "deleteTeam";
	}

	@GetMapping("/updateTeam")
	public String updateTeam(Model model) {
		System.out.println("enter update DIvision controller");
		return "updateTeam";
	}
	
	@RequestMapping(value = "/UpdateTeamRecord", method = RequestMethod.POST)
	public String confirmUpdateDiv(@Validated Teams team, Model model) {
		System.out.println("enter confirm update teams controller");
		teamDAO.updateTeam(team);
		return "updateTeam";
	}

	@PostMapping("/getTeamData")
	@ResponseBody
	public ResponseEntity<List<Teams>> getTeamData() {
		System.out.println("Entering getAwardData controller");
		try {
			List<Teams> allTeams = this.teamDAO.getAllTeams();
			for (Teams award : allTeams) {
				if (award.getImage() != null) {
					byte[] posterBytes = award.getImage();
					String base64Poster = Base64.getEncoder().encodeToString(posterBytes);
					award.setBase64Poster(base64Poster);
				} else {
					award.setBase64Poster(""); // Set an empty string or handle it as appropriate
				}
			}
			return new ResponseEntity<>(allTeams, HttpStatus.OK);
		} catch (Exception e) {
			// Handle exception if necessary
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PostMapping("/newupdatingTeamData")
	@ResponseBody
	public ResponseEntity<String> newupdatingTeamData(@RequestParam("id") String id,
			@RequestParam("teamName") String teamName, @RequestParam("designation") String designation,
			@RequestParam("poster") MultipartFile file, Model model) {
		try {
			Teams team = new Teams();

			team.setId(Long.parseLong(id));
			team.setName(teamName);
			team.setDesignation(designation);

			if (!file.isEmpty()) {
				byte[] imageData = file.getBytes();
				team.setImage(imageData);
			}

			teamDAO.updateTeam(team);

			return new ResponseEntity<>("Team data updated successfully", HttpStatus.OK);
		} catch (Exception e) {
			logger.error("Error updating team data: " + e.getMessage());
			return new ResponseEntity<>("Failed to update team data", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
