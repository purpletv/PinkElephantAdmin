<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.pinkElephantAdmin.model.Teams,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Team</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <link rel="stylesheet" type="text/css" href="path/to/toastr.css">

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
            $("#createNewTeam").submit(function (event) {
                // Prevent the default form submission
                event.preventDefault();

                // Get form data using FormData
                var formData = new FormData(this);

                // Make an AJAX call
                $.ajax({
                    type: "POST",
                    url: "createNewTeam",
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        // Handle the success response
                        console.log(response);

                        // Display a toastr success notification
                        toastr.success('Team created successfully!', 'Success', {
                            closeButton: true,
                        });

                        // Clear the form
                        clearForm();
                    },
                    error: function (error) {
                        // Handle the error response
                        console.log(error);

                        // Display a toastr error notification
                        toastr.error('Failed to create Team.', 'Error', {
                            closeButton: true,
                        });
                    }
                });
            });

            // Clear form function
            function clearForm() {
                document.getElementById("createNewTeam").reset();
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
<form action="createNewTeam" id="createNewTeam" method="post" enctype="multipart/form-data">
    <div class="container">
       
        <div class="form-group">
            <label for="title">Name:</label>
            <input type="text" class="form-control" id="title" name="title" required>
        </div>

       <div class="form-group">
            <label for="image">Image:</label>
            <input type="file" class="form-control-file" id="image" name="image">
        </div>

        <div class="form-group">
            <label for="designation">Designation:</label>
            <textarea class="form-control" id="designation" name="designation" rows="5" maxlength="200" required></textarea>          
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
