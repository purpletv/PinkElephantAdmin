<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Social Media</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     <script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <link rel="stylesheet" type="text/css" href="./css/toaster.css">

    <!-- Custom Styles -->
    <style>
        body {
           /*  background-image: url('./images/addDiv.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat; */
            height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            max-width: 800px; /* Increase the max-width for a larger form */
            margin-top: 50px;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 40px;
            border-radius: 10px;
        }

        .form-group label {
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">
  $(document).ready(function () {
        $("#createNewSocialMedia").submit(function (event) {
            // Prevent the default form submission
            event.preventDefault();

            // Get form data
            var formData = $(this).serialize();

            // Make an AJAX call
            $.ajax({
                type: "POST",
                url: "createNewSocialMedia",
                data: formData,
                success: function (response) {
                    // Handle the success response
                    console.log(response);

                    // Display a toastr success notification
                    toastr.success('Social Media created successfully!', 'Success', {
                        closeButton: true,  // Optional: Show close button
                    });

                    // Clear the form
                    clearForm();
                },
                error: function (error) {
                    // Handle the error response
                    console.log(error);

                    // Display a toastr error notification
                    toastr.error('Failed to create Social Media.', 'Error', {
                        closeButton: true,  // Optional: Show close button
                    });
                }
            });
        });

        function clearForm() {
            document.getElementById("createNewSocialMedia").reset();
        }

        $(document).on('click', '#clr', function (event) {
            event.preventDefault();
            clearForm();
        });
    });
</script></head>
<body>
<form action="createNewSocialMedia" id="createNewSocialMedia" method="post">
    <div class="container">
        <div class="form-group">
            <label for="social_media_name">Social Media Platform</label>
            <input type="text" class="form-control" id="social_media_name" name="social_media_name" required>
        </div>

        <div class="form-group">
            <label for="social_media_link">URL</label>
            <textarea class="form-control" id="social_media_link" name="social_media_link" rows="3" maxlength="500" required></textarea>
            <!-- <small>Max 2000 characters</small> -->
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
