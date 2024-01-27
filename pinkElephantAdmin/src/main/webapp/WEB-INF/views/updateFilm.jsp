<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.pinkElephantAdmin.model.Films, com.pinkElephantAdmin.model.Divisions, java.util.List" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.nio.charset.StandardCharsets" %>

<!DOCTYPE html>
<html>
<head>
    <title>Films Management</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        $(document).ready(function () {
            // Update button click event
            $('.updateBtn').click(function (event) {
                event.preventDefault();
                var row = $(this).closest('tr');
                var filmId = row.data('filmId');

                // You can perform update actions here or redirect to an update page
                console.log('Update Film ID:', filmId);
            });

            // Delete button click event
            $('.deleteBtn').click(function (event) {
                event.preventDefault();
                var row = $(this).closest('tr');
                var filmId = row.data('filmId');

                // You can perform delete actions here or show a confirmation modal
                console.log('Delete Film ID:', filmId);
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Select Division</th>
                    <th>Film Name</th>
                    <th>Director</th>
                    <th>Film Description</th>
                    <th>Film Link</th>
                    <th>Poster</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% List<Films> films = (List<Films>) request.getAttribute("allFilms"); %>
                <% for (Films film : films) { %>
                    <tr data-film-id="<%=film.getId()%>">
                        <td><%=film.getDiv_Id()%></td>
                        <td><%=film.getFilm_Name()%></td>
                        <td><%=film.getDirector()%></td>
                        <td><%=film.getDescription()%></td>
                        <td><%=film.getUrl()%></td>
                        <td>
                            <!-- View Image Button Triggering Modal -->
                            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#viewImageModal<%=film.getId()%>">View Image</button>

                            <!-- View Image Modal -->
                            <div class="modal fade" id="viewImageModal<%=film.getId()%>" tabindex="-1" role="dialog" aria-labelledby="viewImageModalLabel<%=film.getId()%>" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="viewImageModalLabel<%=film.getId()%>">View Image</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <img src="data:image/jpeg;base64, <%=new String(Base64.getEncoder().encode(film.getPoster()), StandardCharsets.UTF_8)%>" class="img-fluid" alt="Film Poster">
                                        </div>
                                        <div class="modal-footer">
                                            <!-- Update Image Button -->
                                            <button type="button" class="btn btn-primary" id="updateImageBtn<%=film.getId()%>">Update Image</button>
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- File input for updating image -->
                            <input type="file" name="poster" id="poster<%=film.getId()%>" accept="image/*" style="display: none;">

                            <!-- Display the selected file name (optional) -->
                            <span id="selectedFileName<%=film.getId()%>"></span>
                        </td>
                        <td>
                            <!-- Update Button -->
                            <button class="btn btn-primary updateBtn">Update</button>

                            <!-- Delete Button -->
                            <button class="btn btn-danger deleteBtn">Delete</button>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
