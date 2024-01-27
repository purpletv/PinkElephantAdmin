<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px; /* Adjust as needed */
        }

        th,
        td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 12px; /* Increased padding for better spacing */
        }

        tbody tr {
            cursor: pointer;
            transition: background-color 0.3s; /* Smoother transition effect on hover */
        }

        tbody tr:hover {
            background-color: #f8f9fa; /* Bootstrap default hover color */
        }

        .modal-body {
            padding: 20px; /* Increased padding for better spacing */
        }
    </style>
    <title>Films Table</title>
</head>

<body>

    <table id="filmTable" class="table table-bordered table-hover">
        <thead class="thead-dark"> <!-- Bootstrap dark theme for the header -->
            <tr>
                <th>ID</th>
                <th>Film Name</th>
                <th>Director</th>
                <th>Description</th>
                <th>Division</th>
                <!-- Add more columns as needed -->
            </tr>
        </thead>
        <tbody>
            <!-- Table body will be populated dynamically -->
        </tbody>
    </table>

    <!-- Bootstrap Modal -->
    <div class="modal fade" id="filmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Bootstrap grid system to divide modal into two columns -->
                    <div class="row">
                        <!-- Left column for poster and input field -->
                        <div class="col-md-6">
                            <img id="posterImage" src="" alt="Poster" class="img-fluid"> <!-- Bootstrap img-fluid for responsive images -->
                            <input type="file" id="posterInput" accept="image/*">
                        </div>
                        <!-- Right column for other form fields -->
                        <div class="col-md-6">
                            <!-- Editable form -->
                            <form id="editForm">
                                <div class="form-group">
                                    <input type="hidden" class="form-control" id="id">
                                </div>
                                <!-- Add Bootstrap form-control class for styling -->
                                <div class="form-group">
                                    <label for="filmName">Film Name:</label>
                                    <input type="text" class="form-control" id="filmName">
                                </div>
                                <div class="form-group">
                                    <label for="director">Director:</label>
                                    <input type="text" class="form-control" id="director">
                                </div>
                                <div class="form-group">
                                    <label for="description">Description:</label>
                                    <textarea class="form-control" id="description" rows="3"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="url">url:</label>
                                    <input type="text" class="form-control" id="url">
                                </div>
                                <div class="form-group">
                                    <label for="division">Division:</label>
                                    <select class="form-control" id="division"></select>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="saveChanges">Save Changes</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div><script>
	var divisionsData;
    $(document).ready(function () {
        var filmData;

        // Make AJAX call to get film data
        $.ajax({
            url: '/PinkElephantAdmin/getFilmData',
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                filmData = data;
                populateTable(data);
            },
            error: function (xhr, status, error) {
                console.error('Error fetching film data:', error);
                console.log(xhr.responseText);
            }
        });

        // Make AJAX call to get divisions data
        $.ajax({
            url: '/PinkElephantAdmin/getDivisions',
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                divisionsData = data;
                populateDivisionDropdown(data);
            },
            error: function (xhr, status, error) {
                console.error('Error fetching divisions data:', error);
                console.log(xhr.responseText);
            }
        });

        function populateTable(data) {
            // Clear existing table rows
            $('#filmTable tbody').empty();

            // Iterate over each film in the JSON data and append a row to the table
            $.each(data, function (index, film) {
                // Look up the division name based on div_Id
                var divisionName = getDivisionName(film.div_Id);

                var row = '<tr data-id="' + film.id + '">' +
                    '<td>' + film.id + '</td>' +
                    '<td>' + film.film_Name + '</td>' +
                    '<td>' + film.director + '</td>' +
                    '<td>' + film.description + '</td>' +
                    '<td>' + divisionName + '</td>' + '</tr>';

                $('#filmTable tbody').append(row);
            });

            // Attach click event to table rows
            $('#filmTable tbody tr').on('click', function () {
                var id = $(this).data('id');
                rowClick(id);
            });
        }	
        function populateDivisionDropdown(data, filmDivId) {
            // Clear existing options in the division dropdown
            $('#division').empty();

            // Iterate over each division in the JSON data and append an option to the dropdown
            $.each(data, function (index, division) {
                var option = '<option value="' + division.id + '">' + division.div_Name + '</option>';
                $('#division').append(option);
            });

            // Set default value based on filmDivId
            if (filmDivId) {
                $('#division').val(filmDivId);
            }
        }


        function rowClick(id) {
            var film = filmData.find(f => f.id === id);

            // Populate modal with film data
            $('#modalTitle').text(film.film_Name);
            $('#filmName').val(film.film_Name);
            $('#director').val(film.director);
            $('#description').val(film.description);
            $('#url').val(film.url);
            $('#id').val(film.id);

            // Set division dropdown value based on div_id
            populateDivisionDropdown(divisionsData, film.div_Id);

            $('#editedPoster').val(film.editedBase64Poster || ''); // Display edited poster if available

            // Set poster image source directly with Base64 data
            if (film.base64Poster && film.base64Poster.trim() !== '') {
                var posterImage = $('#posterImage');
                posterImage.attr('src', 'data:image/png;base64,' + film.base64Poster);
            }

            // Show the modal
            $('#filmModal').modal('show');
        }

        // Handle Save Changes button click
      $('#saveChanges').on('click', function () {
    // Retrieve edited values from the form
    $('#filmModal').modal('hide');
     var editedFilm;
    var formData = new FormData();
    formData.append('div_Id', $('#division').val());
    formData.append('filmName', $('#filmName').val());
    formData.append('director', $('#director').val());
    formData.append('description', $('#description').val());
    formData.append('url', $('#url').val());
    formData.append('id', $('#id').val());
    //formData.append('poster', $('#posterInput')[0].files[0]);
    var newPosterFile = $('#posterInput')[0].files[0];
    if (newPosterFile) {
        formData.append('poster', newPosterFile);
    }
    else{
    	
    	console.log('in ekse');
    	attachImageToInput('posterImage', 'posterInput');
    	var base64Poster = $('#posterImage').attr('src').split(',')[1];
    	//console.log(base64Poster);
    	newPosterFile = $('#posterInput')[0].files[0];
    	// Append the Base64 data to the form data
    	formData.append('poster', newPosterFile);
    }

    $.ajax({
        url: '/PinkElephantAdmin/newupdatingFilmData',
        type: 'POST',
        data: formData, // Use the 'data' property for FormData
        processData: false, // Ensure that processData is set to false
        contentType: false,
        success: function (response) {
            // Handle successful response
             
            console.log('Success:', response);
            $('#content').html(response)
                //else{console.log("edited film is empty");}
        },
        error: function (xhr, status, error) {
            // Handle error response
            console.error('Error:', error);
            console.log(xhr.responseText);
        }
    });
   
    // Update the data in filmData array
   // var editedFilm = filmData.find(f => f.id === $('#id').val());
   

    // Close the modal
   
});

        // Function to update the table row with edited values
        function updateTableRow(editedFilm) {
        	if (editedFilm) {
                var row = '<td>' + editedFilm.id + '</td>' +
                    '<td>' + editedFilm.film_Name + '</td>' +
                    '<td>' + editedFilm.director + '</td>' +
                    '<td>' + editedFilm.description + '</td>';

                $('#filmTable tbody tr[data-id="' + editedFilm.id + '"]').html(row);
            } else {
                console.error('Error: editedFilm is empty');
            }
        }

        // Function to handle "Edit Poster" button click
        $('#editPosterBtn').on('click', function () {
            // Trigger the file input click event
            $('#posterInput').click();
        });

        // Function to handle file input change
        $('#posterInput').on('change', function () {
            // Read the selected file and update the poster image
            var fileInput = this;
            if (fileInput.files && fileInput.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#posterImage').attr('src', e.target.result);
                };
                reader.readAsDataURL(fileInput.files[0]);

                // Optional: You can also update the edited poster field with the Base64 data
                // This value can be used when saving changes
                var editedBase64Poster = reader.result.split(',')[1];
                $('#editedPoster').val(editedBase64Poster);
            }
        });
    });
    function attachImageToInput(imgElementId, fileInputElementId) {
        // Step 1: Get the image source
        const imgElement = document.getElementById(imgElementId);
        const imgSrc = imgElement.src;

        // Step 2: Convert image source to base64
        const base64String = imgSrc.split(',')[1];

        // Step 3: Create a File object from base64
        const fileName = 'image.jpg'; // You can set the desired file name
        const file = base64ToFile(base64String, fileName);

        // Step 4: Create a FileList object
        const fileList = new DataTransfer();
        fileList.items.add(file);

        // Step 5: Set FileList object as the value of the file input
        const fileInputElement = document.getElementById(fileInputElementId);
        fileInputElement.files = fileList.files;
    }

    function base64ToFile(base64String, fileName) {
        const base64Data = base64String.replace(/^data:image\/\w+;base64,/, '');
        const binaryData = atob(base64Data);
        const byteArray = new Uint8Array(binaryData.length);

        for (let i = 0; i < binaryData.length; i++) {
            byteArray[i] = binaryData.charCodeAt(i);
        }

        const blob = new Blob([byteArray], { type: 'image/jpeg' });
        const file = new File([blob], fileName, { type: blob.type });

        return file;
    }
    function getDivisionName(divisionId) {
        var division = divisionsData.find(d => d.id === divisionId);
        console.log(division.div_Name);
        return division ? division.div_Name : 'Unknown Division';
    }

    // Example usage
    

</script>

</body>

</html>
	