package com.pinkElephantAdmin.controllers.admin;

import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.pinkElephantAdmin.daos.DivisionsDAO;
import com.pinkElephantAdmin.daos.FilmsDAO;
import com.pinkElephantAdmin.model.Divisions;
import com.pinkElephantAdmin.model.Films;


@Controller
public class filmsController {
	private static final Logger logger = LoggerFactory.getLogger(filmsController.class);
	
	@Autowired
	private  FilmsDAO filmDAO;
	@Autowired
	private  DivisionsDAO divDAO;
	
	
	
	@RequestMapping(value = "/addFilm", method = RequestMethod.GET)
	public String getAddFilm(Model model) {
		logger.info("pinkElephantAdmin:filmController:calling the add film view page");
		List<Divisions> allDivs=this.divDAO.getAllDivisions();
		model.addAttribute("allDivs", allDivs);
		return "addFilm";
	}
	
	@RequestMapping(value = "/createNewFilmElephant", method = RequestMethod.POST)
	@ResponseBody
	public String createFilmNew(@RequestParam("url") String url,@RequestParam("description") String description,@RequestParam("director") String director,@RequestParam("filmName") String filmName,@RequestParam("div_Id") String id,@RequestParam("poster") MultipartFile file, Model model) {
		Films film = new Films();
		long ids= Long.parseLong("4");
		film.setUrl(url);
		film.setDescription(description);
		film.setDirector(director);
		film.setFilm_Name(filmName);
		film.setDiv_Id(ids);
		  if (!file.isEmpty()) {
	            try {
	                byte[] imageData = file.getBytes();
	                film.setPoster(imageData);
	            } catch (Exception e) {
	                logger.error("Error uploading image: " + e.getMessage());
	                // Handle the error, redirect to an error page, or show an error message
	            }
	        }

	        filmDAO.addNewFilm(film);

	        // Retrieve the list of divisions
	        List<Divisions> allDivs = this.divDAO.getAllDivisions();
	        model.addAttribute("allDivs", allDivs);

	        // Clear the form after successful submission
	        film = new Films();
	        model.addAttribute("film", film);

		return "addedFilm";

	}
	
	@GetMapping("/backToAddNewFilm")
	public String addNewFilm(Model model) {
		System.out.println("enter backToAddNewFilm controller");
		
		return "addFilm";
	}
	
	
	@RequestMapping(value = "/deleteFilm", method = RequestMethod.GET)
	public String deleteFilm(Model model) {
		System.out.println("enter delete Film controller");
		List<Films> allFilms=this.filmDAO.getAllFilms();
		List<Divisions> allDivs=this.divDAO.getAllDivisions();
		Map<Long,String> extMap= new HashMap<>();
		for (Divisions division : allDivs) {
			extMap.put(division.getId(),division.getDiv_Name());
		}
		model.addAttribute("map",extMap);
		model.addAttribute("allFilms", allFilms);
		return "deleteFilm";
	}
	
	@RequestMapping(value = "/onDeleteFilm", method = RequestMethod.POST)
	public String deleteFilm(@Validated Films film,Model model) {
		System.out.println("enter delete Film controller");
		filmDAO.deleteFilm(film.getId());
		List<Films> allFilms=this.filmDAO.getAllFilms();
		model.addAttribute("allFilms", allFilms);
		List<Divisions> allDivs=this.divDAO.getAllDivisions();
		Map<Long,String> extMap= new HashMap<>();
		for (Divisions division : allDivs) {
			extMap.put(division.getId(),division.getDiv_Name());
		}
		model.addAttribute("map",extMap);
		return "deleteFilm";
	}
	
	
	@GetMapping("/newupdateFilm")
	public String newupdateFilm(Model model) {
		System.out.println("enter update Film controller");
		return "newupdateFilm";
	}
	
	 @PostMapping("/getFilmData")
	    @ResponseBody
	    public ResponseEntity<List<Films>> getFilmData() {
	        System.out.println("Entering getFilmData controller");

	        try {
	            List<Films> allFilms = this.filmDAO.getAllFilms();
	            for (Films film : allFilms) {
	        	 if (film.getPoster() != null) {
	        	        byte[] posterBytes = film.getPoster();
	        	        String base64Poster = Base64.getEncoder().encodeToString(posterBytes);
	        	        film.setBase64Poster(base64Poster);
	        	    } else {
	        	        film.setBase64Poster(""); // Set an empty string or handle it as appropriate
	        	    }
	            }
	            return new ResponseEntity<>(allFilms, HttpStatus.OK);
	        } catch (Exception e) {
	            // Handle exception if necessary
	            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    }


	@RequestMapping(value = "/newupdatingFilmData", method = RequestMethod.POST)
    	public String newupdatingFilmData(@RequestParam("id") String id,
    		@RequestParam("div_Id") String div_Id_S,
    			@RequestParam("filmName") String filmName,
    			@RequestParam("director") String director,
    			@RequestParam("description") String description,
    	        @RequestParam("url") String url,	        
    	        @RequestParam(name = "poster",required = false) MultipartFile file,
    	    @RequestParam(name = "oldposter",required = false) String base64poster,// Change the parameter name to match FormData
    	        Model model) {
    	    try {
    	        Films film = new Films();
    	        long div_Id = Long.parseLong(div_Id_S);
    	        film.setUrl(url);
    	        film.setDescription(description);
    	        film.setDirector(director);
    	        film.setFilm_Name(filmName);
    	        film.setDiv_Id(div_Id);
    	    if (!file.isEmpty()) {
	            byte[] imageData = file.getBytes();
	            film.setPoster(imageData);
	        }
    	    else {
    		byte[] oldPosterData = Base64.getDecoder().decode(base64poster);
                film.setPoster(oldPosterData);
    	    }
    	        
		film.setId(Long.parseLong(id));
    
    	        
    
    	        // Rest of your code...
    
    	        filmDAO.updateFilm(film);
    	        return "newupdateFilm";
    	    } catch (Exception e) {
    	        e.printStackTrace(); // Add this line for debugging
    	        return "errorPage"; // Handle the exception gracefully
    	    }
    	}

	

}
