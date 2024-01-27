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
<!-- Popper.js and Bootstrap Bundle -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>


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
            width: 80%;
            margin-top: 20px; /* Adjust as needed */
        }

        th,
        td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        tbody tr {
            cursor: pointer;
        }

        tbody tr:hover {
            background-color: #f5f5f5;
        }
    </style>
    <title>Awards Table</title>
</head>

<body>

    <table id="awardTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Description</th>
                <!-- Add more columns as needed -->
            </tr>
        </thead>
        <tbody>
            <!-- Table body will be populated dynamically -->
        </tbody>
    </table>

    <!-- Bootstrap Modal -->
  <!-- Bootstrap Modal -->
<div class="modal fade" id="awardModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
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
                        <img id="posterImage" src="" alt="Poster" style="max-width: 100%; height: auto;">
                        <input type="file" id="posterInput" accept="image/*">
                    </div>
                    <!-- Right column for other form fields -->
                    <div class="col-md-6">
                        <!-- Editable form -->
                        <form id="editForm">
                            <div class="form-group">
                                <input type="hidden" class="form-control" id="id">
                            </div>
                            <div class="form-group">
                                <label for="awardTitle">Award Title:</label>
                                <input type="text" class="form-control" id="awardTitle">
                            </div>
                   			    <input type="hidden" class="form-control" id="id">
                            <div class="form-group">
                                <label for="description">Description:</label>
                                <textarea class="form-control" id="description" rows="3"></textarea>
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
</div>
<script>
    $(document).ready(function () {
        var awardData;
        getAwardDataAjax();

        // Make AJAX call to get award data
       

      
       

     


      
        // Handle Save Changes button click
      $('#saveChanges').on('click', function () {
    // Retrieve edited values from the form
    var formData = new FormData();
   
    formData.append('awardTitle', $('#awardTitle').val());
    formData.append('description', $('#description').val());
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
        url: '/PinkElephantAdmin/newupdatingAwardData',
        type: 'POST',
        data: formData, // Use the 'data' property for FormData
        processData: false, // Ensure that processData is set to false
        contentType: false,
        success: function (response) {
            // Handle successful response
             getAwardDataAjax();
            console.log('Success:', response);
        },
        error: function (xhr, status, error) {
            // Handle error response
            console.error('Error:', error);
            console.log(xhr.responseText);
        }
    });
    $('#awardModal').modal('hide');
    // Update the data in awardData array
    var editedAward = awardData.find(f => f.id === $('#id').val());
    editedAward.title = $('#awardTitle').val();
    editedAward.description = $('#description').val();

    // Update the table row
    updateTableRow(editedAward);

    // Close the modal
   
});

        // Function to update the table row with edited values
        function updateTableRow(editedAward) {
            var row = '<td>' + editedAward.id + '</td>' +
                '<td>' + editedAward.title + '</td>' +
                '<td>' + editedAward.description + '</td>';

            $('#awardTable tbody tr[data-id="' + editedAward.id + '"]').html(row);
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
    function getAwardDataAjax(){
 	   $.ajax({
            url: '/PinkElephantAdmin/getAwardData',
            type: 'POST',
            dataType: 'json',
            success: function (data) {
            	console.log('askhsay'+data);
                awardData = data;
                populateTable(data);
            },
            error: function (xhr, status, error) {
                console.error('Error fetching award data:', error);
                console.log(xhr.responseText);
            }
        });
    }
    function populateTable(data) {
        // Clear existing table rows
        $('#awardTable tbody').empty();
			
        // Iterate over each award in the JSON data and append a row to the table
        $.each(data, function (index, award) {
        	  console.log(award.title);
            var row = '<tr data-id="' + award.id + '">' +
                '<td>' + award.id + '</td>' +
                '<td>' + award.title + '</td>' +
                '<td>' + award.description + '</td>' +'</tr>'; 
            
            $('#awardTable tbody').append(row);
        });

        // Attach click event to table rows
        $('#awardTable tbody tr').on('click', function () {
            var id = $(this).data('id');
            rowClick(id);
        });
    }
    function rowClick(id) {
        var award = awardData.find(f => f.id === id);

        // Populate modal with award data
        $('#modalTitle').text(award.title);
        $('#awardTitle').val(award.title);
        $('#description').val(award.description);
        $('#id').val(award.id);
       


        $('#editedPoster').val(award.editedBase64Poster || ''); // Display edited poster if available

        // Set poster image source directly with Base64 data
        if (award.base64Poster && award.base64Poster.trim() !== '') {
            var posterImage = $('#posterImage');
            posterImage.attr('src', 'data:image/png;base64,' + award.base64Poster);
        }

        // Show the modal
        $('#awardModal').modal('show');
    }


</script>

</body>

</html>
	