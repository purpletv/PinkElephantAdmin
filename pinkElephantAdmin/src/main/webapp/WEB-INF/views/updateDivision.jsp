<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.pinkElephantAdmin.model.Divisions,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Division</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Custom Styles -->
    <style>
        body {
            background-image: url('./images/manageDiv.jpg');
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
            document.getElementById("manageDivisionForm").reset();
        }

        function confirmAction(action, div_Name) {
        	var confirmation = confirm("Do you want to continue?");
            if (confirmation) {
                // User clicked 'OK'
                var description = document.getElementById("description").value;

                if (action === 'update') {
                    $.ajax({
                        url: "confirmUpdateDiv",
                        method: 'POST', // Change to POST
                        data: { div_Name: div_Name, description: description },
                        success: function (response) {
                            $('#content').html(response);
                        },
                        error: function (xhr, status, error) {
                            console.log('AJAX Error: ' + error);
                        }
                    });
                } else if (action === 'delete') {
                    $.ajax({
                        url: "deleteDiv",
                        method: 'POST', // Change to POST
                        data: { div_Name: div_Name, description: description },
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
            var div_Name = selectedOption.textContent;
            confirmAction('update', div_Name);
        });

        $(document).on('click', '#deleteBtn', function (event) {
            event.preventDefault();
            var dropdown = document.getElementById("dropdownField");
            var selectedOption = dropdown.options[dropdown.selectedIndex];
            var div_Name = selectedOption.textContent;
            confirmAction('delete', div_Name);
        });


        $(document).on('click', '#clearBtn', function (event) {
            event.preventDefault();
            clearForm();
        });
        
        function updateDescription() {
        	var dropdown = document.getElementById("dropdownField");
            var selectedOption = dropdown.options[dropdown.selectedIndex];
            var descriptionTextarea = document.getElementById("description");
            var div_NameInput = document.getElementById("div_Name");

            // Set the value of the description textarea to the selected option's value attribute
            descriptionTextarea.value = selectedOption.value;

            // Set the value of the div_Name input to the selected option's text content
            div_NameInput.value = selectedOption.textContent;
        }
        
        $(document).on('change', '#dropdownField', function () {
            updateDescription(); // Call updateDescription when the dropdown changes
        });
        
    </script>
</head>
<body>
<form action="manageDivision" id="manageDivisionForm" method="post">
    <div class="container">
        <div class="form-group">
            <label for="dropdownField">Select Division:</label>
             <select class="form-control" id="dropdownField" name="dropdownField" required>
					<%
					List<Divisions> allDivs = (List<Divisions>) request.getAttribute("allDivs");
					for (Divisions div : allDivs) {
					%>
					<option value="<%=div.getDescription()%>"><%=div.getDiv_Name()%></option>
					<%
					}
					%>
			</select>
			<input type="hidden" id="div_Name" name="div_Name">
		</div>

        <div class="form-group">
            <label for="description">Division Description:</label>
            <textarea class="form-control max-width-2000" id="description" name="description" rows="5" maxlength="2000" required></textarea>
            <small>Max 2000 characters</small>
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
