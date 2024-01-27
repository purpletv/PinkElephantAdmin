<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.pinkElephantAdmin.model.Films,com.pinkElephantAdmin.model.Divisions,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Film</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Custom Styles -->
    <style>
        body {
            background-image: url('./images/addFilm.jpg');
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
            max-width: 800px;
            margin-top: 50px;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 40px;
            border-radius: 10px;
        }

        .form-group label {
            font-weight: bold;
        }
    </style>
    <script>
        $(document).ready(function () {
            // Add change event listener to the dropdown
            $('#dropdownField').change(function () {
                // Get the selected value from the dropdown
                var selectedValue = $(this).val();
                // Set the value of the hidden input field
                $('#div_Id').val(selectedValue);
            });

            // Clear form function
            function clearForm() {
                document.getElementById("createNewFilm").reset();
                // Also reset the hidden input field value
                $('#div_Id').val('');
            }

            // Clear button click event
            $('#clr').click(function (event) {
                event.preventDefault();
                clearForm();
            });
        });
    </script>
</head>
<body>
<form action="createNewFilmElephant" id="createNewFilm" method="post" enctype="multipart/form-data">
    <div class="container">
        <div class="form-group">
             <label for="dropdownField">Select Division:</label>
             <select class="form-control" id="dropdownField" name="dropdownField" required>
                    <%
                    List<Divisions> allDivs = (List<Divisions>) request.getAttribute("allDivs");
                    for (Divisions div : allDivs) {
                    %>
                    <option value="<%=div.getId()%>"><%=div.getDiv_Name()%></option>
                    <%
                    }
                    %>
            </select>
            <!-- Hidden input field to store the selected dropdown value -->
            <input type="hidden" id="div_Id" name="div_Id">
        </div>
    	
        <div class="form-group">
            <label for="filmName">Film Name:</label>
            <input type="text" class="form-control" id="filmName" name="filmName" required>
        </div>

        <div class="form-group">
            <label for="director">Director:</label>
            <input type="text" class="form-control" id="director" name="director" required>
        </div>

        <div class="form-group">
            <label for="description">Film Description:</label>
            <textarea class="form-control" id="description" name="description" rows="5" maxlength="2000" required></textarea>
            <small>Max 2000 characters</small>
        </div>

        <div class="form-group">
            <label for="url">Film Link:</label>
            <input type="text" class="form-control" id="url" name="url" required>
        </div>  

        <div class="form-group">
        <label for="poster">Choose a photo:</label>
    	<input type="file" id="poster" name="poster" accept="image/*">

        </div>

        <div class="form-group">
            <button type="submit" class="btn btn-primary">Create</button>
        </div>
        <div class="form-group">
            <button id="clr" class="btn btn-secondary">Clear</button>
        </div>
    </div>
</form>
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
