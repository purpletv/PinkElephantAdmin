<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.pinkElephantAdmin.model.Films,com.pinkElephantAdmin.model.Divisions,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Award</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <link rel="stylesheet" type="text/css" href="./css/toaster.css">
    <!-- Custom Styles -->
    <style>
        body {
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
            $("#createNewAward").submit(function (event) {
                // Prevent the default form submission
                event.preventDefault();

                // Get form data using FormData
                var formData = new FormData(this);

                // Make an AJAX call
                $.ajax({
                    type: "POST",
                    url: "createNewAwardElephant",
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        // Handle the success response
                        console.log(response);

                        // Display a toastr success notification
                        toastr.success('Award added successfully!', 'Success', {
                            closeButton: true,
                        });

                        // Clear the form
                        clearForm();
                    },
                    error: function (error) {
                        // Handle the error response
                        console.log(error);

                        // Display a toastr error notification
                        toastr.error('Failed to add Award.', 'Error', {
                            closeButton: true,
                        });
                    }
                });
            });

            // Clear form function
            function clearForm() {
                document.getElementById("createNewAward").reset();
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

<h3 style="text-align: center;"> Add Award </h3>
<form action="createNewAwardElephant" id="createNewAward" method="post" enctype="multipart/form-data">
    <div class="container">

        <div class="form-group">
            <label for="title">Title:</label>
            <input type="text" class="form-control" id="title" name="title" required>
        </div>

        <div class="form-group">
            <label for="image">Image:</label>
            <input type="file" class="form-control-file" id="image" name="image">
        </div>

        <div class="form-group">
            <label for="description">Award Description:</label>
            <textarea class="form-control" id="description" name="description" rows="5" maxlength="2000" required></textarea>
            <small>Max 2000 characters</small>
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
