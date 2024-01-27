<!DOCTYPE html>
<html>

<head>
    <title>Pink Elephant</title>
    
	<link rel="stylesheet" type="text/css" href="./css/home.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- <script src="./js/home.js"></script> -->
 	<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
  	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

    <script>
    function toggleMenu() {
        var menuCard = document.querySelector('.menu-card');
        var overlay = document.querySelector('.overlay');
        menuCard.classList.toggle('open');
        overlay.classList.toggle('open-overlay');
    }

    function closeMenu() {
        var menuCard = document.querySelector('.menu-card');
        var overlay = document.querySelector('.overlay');
        menuCard.classList.remove('open');
        overlay.classList.remove('open-overlay');
    }

    $(document).on('click', '.division-link, .films-link, .socialMedia-link,.awards-link,.teams-link', function (event) {
        event.preventDefault();
        var submenu = $(this).siblings('.sub-menu');
        if (submenu.length > 0) {
            submenu.toggleClass('open-submenu');
        }
    });

        
        $(document).on('click', '.addDiv', function(event) {
    	    event.preventDefault();
    	   console.log("entered add division");
    	   addDiv();
        });
        
        function addDiv(){
        	 $.ajax({
        	      url: "addDiv",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response);closeMenu(); // Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
        
        $(document).on('click', '.updateDiv', function(event) {
    	    event.preventDefault();
    	   console.log("entered update division");
    	   updateDiv();
        });
        
        function updateDiv(){
        	 $.ajax({
        	      url: "updateDiv",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response);closeMenu(); // Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
        
        $(document).on('click', '.addFilm', function(event) {
    	    event.preventDefault();
    	   console.log("entered add Film");
    	   addFilm();
        });
        
        function addFilm(){
        	 $.ajax({
        	      url: "addFilm",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response); 
        	        closeMenu();// Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
        
        $(document).on('click', '.updateFilm', function(event) {
    	    event.preventDefault();
    	   console.log("entered update Film");
    	   updateFilm();
        });
        
        function updateFilm(){
        	 $.ajax({
        	      url: "updateFilm",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response); 
        	        closeMenu();// Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
        
        $(document).on('click', '.newupdateFilm', function(event) {
    	    event.preventDefault();
    	   console.log("entered update Film");
    	   updateFilm();
        });
        
        function updateFilm(){
        	 $.ajax({
        	      url: "newupdateFilm",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response);closeMenu(); // Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
        
        $(document).on('click', '.addMedia', function(event) {
    	    event.preventDefault();
    	   console.log("entered add SocialMedia");
    	   addMedia();
        });
        
        function addMedia(){
        	 $.ajax({
        	      url: "addMedia",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response);closeMenu(); // Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
        
        $(document).on('click', '.updateMedia', function(event) {
    	    event.preventDefault();
    	   console.log("entered add SocialMedia");
    	   updateMedia();
        });
        
        function updateMedia(){
        	 $.ajax({
        	      url: "updateMedia",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response);closeMenu(); // Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
        
        $(document).on('click', '.addAward', function(event) {
    	    event.preventDefault();
    	   console.log("entered add SocialMedia");
    	   addAward();
        });
        
        function addAward(){
        	 $.ajax({
        	      url: "addAward",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response);closeMenu(); // Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
        $(document).on('click', '.updateAward', function(event) {
    	    event.preventDefault();
    	   console.log("entered add SocialMedia");
    	   updateAward();
        });
        
        function updateAward(){
        	 $.ajax({
        	      url: "newupdateAward",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response);closeMenu(); // Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
        $(document).on('click', '.addTeam', function(event) {
    	    event.preventDefault();
    	   console.log("entered add SocialMedia");
    	   addTeam();
        });
        
        function addTeam(){
        	 $.ajax({
        	      url: "addTeam",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response);closeMenu(); // Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
        $(document).on('click', '.updateTeam', function(event) {
    	    event.preventDefault();
    	   console.log("entered add SocialMedia");
    	   updateTeam();
        });
        
        function updateTeam(){
        	 $.ajax({
        	      url: "updateTeam",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response);closeMenu(); // Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
       
        $(document).on('click', '.deleteFilm', function(event) {
    	    event.preventDefault();
    	   console.log("entered deleteFilm");
    	   deleteFilm();
        });
        
        function deleteFilm(){
        	 $.ajax({
        	      url: "deleteFilm",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response);closeMenu(); // Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
        $(document).on('click', '.deleteAward', function(event) {
    	    event.preventDefault();
    	   console.log("entered deleteAward");
    	   deleteAward();
        });
        
        function deleteAward(){
        	 $.ajax({
        	      url: "deleteAward",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response);closeMenu(); // Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
        $(document).on('click', '.deleteTeam', function(event) {
    	    event.preventDefault();
    	   console.log("entered deleteTeam");
    	   deleteTeam();
        });
        
        function deleteTeam(){
        	 $.ajax({
        	      url: "deleteTeam",
        	      method: 'GET',
        	      success: function(response) {
        	        $('#content').html(response);closeMenu(); // Set the response HTML as the inner HTML of the select element
        	      },
        	      error: function(xhr, status, error) {
        	        console.log('AJAX Error: ' + error);
        	      }
        	    });
        }
        
    </script>
</head>

<body>

	<header>
		<div class="header">
			<div class="header-top">
				<!-- Logo on the top left -->
				<img src="./images/pinkelephantlogo.jpeg" alt="logo" class="logo">

				<!-- Menu button on the top right -->
				<button class="menu-button" onclick="toggleMenu()">
					<div class="menu-icon"></div>
					<div class="menu-icon"></div>
				</button>



				<!-- Menu card -->
				<div class="overlay"></div>
				<div class="menu-card">
					<button class="close-button" onclick="closeMenu()">X</button>
					<div class="menu-card-content">
						<!-- Your buttons and content go here -->
						<div class="menu-card-top">

							<ul>

								<li><a href="#" class="division-link">Divisions</a>
									<ul class="sub-menu">
										<li><a href="#" class="addDiv">Add Division</a></li>
										<li><a href="#" class="updateDiv">Update Division</a></li>
										
									</ul></li>
								<li><a href="#" class="films-link">Films</a>
									<ul class="sub-menu">
										<li><a href="#" class="addFilm">Add Film</a></li>									
										<li><a href="#" class="newupdateFilm">Edit Film</a></li>	
										<li><a href="#" class="deleteFilm">Delete Film</a></li>									
									</ul></li>
								<li><a href="#" class="socialMedia-link">Social
										Media</a>
									<ul class="sub-menu">
										<li><a href="#" class="addMedia">Add Social Media</a></li>
										<li><a href="#" class="updateMedia">Update Media</a></li>
									</ul></li>
								<li><a href="#" class="awards-link">Awards</a>
									<ul class="sub-menu">
										<li><a href="#" class="addAward"> Add Award</a></li>
										<li><a href="#" class="updateAward">Update Award</a></li>
										<li><a href="#" class="deleteAward">Delete Award</a></li>		
									</ul></li>
								<li><a href="#" class="teams-link">Team</a>
									<ul class="sub-menu">
										<li><a href="#" class="addTeam">Add Team</a></li>
										<li><a href="#" class="updateTeam">Update Team</a></li>
										<li><a href="#" class="deleteTeam">Delete Team</a></li>		
									</ul></li>
								</li>
								<li><a href="#">Logout</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>



		</div>
	</header>
	<main>
		<div id="content" class="content">
			<div class="aboutus-main">
				<div class="aboutus-content">
					<div class="aboutus-left">
						<div class="aboutus-title">
							<p>About Us</p>
						</div>
						<div class="aboutus-desc">
							<p>We make films and campaigns that we care about. From
								in-house passion projects to high-end commercials with some of
								the best agencies and production companies around. We've built a
								community of established and upcoming talent ready to do their
								best work yet.</p>
						</div>
						<div class="aboutus-viewmorebtn">
							<button class="viewmorebtn">view more</button>
						</div>
					</div>
					<div class="aboutus-right">
						<img alt="pinkelephanticon" src="./images/pereel.png">
					</div>
				</div>
			</div>
		</div>
	</main>
	<br>


<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>