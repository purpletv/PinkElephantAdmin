<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.pinkElephantAdmin.model.SocialMedia,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Media</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Custom Styles -->
    <style>
        body {
            background-image: social_media_link('./images/manageDiv.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            max-width: 1000px; /* Increase the max-width for a larger form */
            margin-top: 50px;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 40px;
            border-radius: 10px;
        }

        .form-group label {
            font-weight: bold;
        }

        .max-width-2000 {
            max-width: 2000px;
            width: 100%;
        }
    </style>
    <script>
        function clearForm() {
            document.getElementById("manageSocialMediaForm").reset();
        }

        function confirmAction(action, social_media_name) {
        	var confirmation = confirm("Do you want to continue?");
            if (confirmation) {
                // User clicked 'OK'
                var social_media_link = document.getElementById("social_media_link").value;

                if (action === 'update') {
                    $.ajax({
                    	url: "confirmUpdateMedia",
                        method: 'POST', // Change to POST
                        data: { social_media_name: social_media_name, social_media_link: social_media_link },
                        success: function (response) {
                            $('#content').html(response);
                        },
                        error: function (xhr, status, error) {
                            console.log('AJAX Error: ' + error);
                        }
                    });
                } else if (action === 'delete') {
                    $.ajax({
                    	url: "deleteMedia",
                        method: 'POST', // Change to POST
                        data: { social_media_name: social_media_name, social_media_link: social_media_link },
                        success: function (response) {
                            $('#content').html(response);
                        },
                        error: function (xhr, status, error) {
                            console.log('AJAX Error: ' + error);
                        }
                    });
                }
                // Add more actions as needed
            } else {
                // User clicked 'Cancel'
                alert("Operation canceled.");
            }
        }


        $(document).on('click', '#updateBtn', function (event) {
            event.preventDefault();
            var dropdown = document.getElementById("dropdownField");
            var selectedOption = dropdown.options[dropdown.selectedIndex];
            var social_media_name = selectedOption.textContent;
            confirmAction('update', social_media_name);
        });

        $(document).on('click', '#deleteBtn', function (event) {
            event.preventDefault();
            var dropdown = document.getElementById("dropdownField");
            var selectedOption = dropdown.options[dropdown.selectedIndex];
            var social_media_name = selectedOption.textContent;  // <-- corrected variable name
            confirmAction('delete', social_media_name);
        });


        $(document).on('click', '#clearBtn', function (event) {
            event.preventDefault();
            clearForm();
        });
        
        function updateUrl() {
        	var dropdown = document.getElementById("dropdownField");
            var selectedOption = dropdown.options[dropdown.selectedIndex];
            var plaformTextarea = document.getElementById("social_media_link");
            var plaformInput = document.getElementById("social_media_name");

            // Set the value of the description textarea to the selected option's value attribute
            plaformTextarea.value = selectedOption.value;

            // Set the value of the div_Name input to the selected option's text content
            plaformInput.value = selectedOption.textContent;
        }
        
        $(document).on('change', '#dropdownField', function () {
            updateUrl(); // Call updateDescription when the dropdown changes
        });
        
    </script>
</head>
<body>
<form action="manageSocialMedia" id="manageSocialMediaForm" method="post">
    <div class="container">
        <div class="form-group">
            <label for="dropdownField">Select Platform:</label>
             <select class="form-control" id="dropdownField" name="dropdownField" required>
					<%
					List<SocialMedia> allSMs = (List<SocialMedia>) request.getAttribute("allSMs");
					for (SocialMedia sm : allSMs) {
					%>
					<option value="<%= sm.getSocial_media_link() %>"><%= sm.getSocial_media_name() %></option>
					<%
					}
					%>
			</select>
			<input type="hidden" id="social_media_name" name="plaform">
		</div>

        <div class="form-group">
            <label for="social_media_link">Social Media Link:</label>
            <input type="text" class="form-control max-width-2000" id="social_media_link" name="social_media_link" maxlength="500" required>
        </div>

        <div class="form-group">
            <button type="button" id="updateBtn" class="btn btn-primary">Update</button>
            <button type="button" id="deleteBtn" class="btn btn-danger">Delete</button>
            <button type="button" id="clearBtn" class="btn btn-secondary">Clear</button>
        </div>
    </div>
</form>
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
