<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Division</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Custom Styles -->
    <style>
        body {
            background-image: url('./images/addDiv.jpg');
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
    <script>
        function clear() {
            document.getElementById("createNewCategory").reset();
        }

        $(document).on('click', '#clr', function (event) {
            event.preventDefault();
            clear();
        });
    </script>
</head>
<body>
<form action="createNewDivision" id="createNewDivision" method="post">
    <div class="container">
        <div class="form-group">
            <label for="div_Name">Division Title:</label>
            <input type="text" class="form-control" id="div_Name" name="div_Name" required>
        </div>

        <div class="form-group">
            <label for="description">Division Description:</label>
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
