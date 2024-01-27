<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.pinkElephantAdmin.model.Teams, com.pinkElephantAdmin.model.Divisions, java.util.List" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.nio.charset.StandardCharsets" %>

<!DOCTYPE html>
<html>
<head>
    <title>Teams Management</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        $(document).ready(function () {

            // Delete button click event
            $('.deleteBtn').click(function (event) {
                event.preventDefault();
                var row = $(this).closest('tr');
                var teamId = row.data('teamId');

                // Create a form dynamically and append it to the body
                var form = $('<form method="post" action="/PinkElephantAdmin/onDeleteTeam">');
                var input = $('<input type="hidden" name="id" value="' + teamId + '">');
                form.append(input);
                form.appendTo('body');

                // Submit the form
                form.submit();
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Team Name</th>
                    <th>Team Designation</th>
                    <th>Image</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <% List<Teams> teams = (List<Teams>) request.getAttribute("allTeams"); %>
                <% for (Teams team : teams) { %>
                    <tr data-team-id="<%=team.getId()%>">
                        <td><%=team.getName()%></td>
                        <td><%=team.getDesignation()%></td>
                        <td>
                            <!-- View Image Button Triggering Modal -->
                            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#viewImageModal<%=team.getId()%>">View Image</button>

                             <!-- View Image Modal -->
                            <div class="modal fade" id="viewImageModal<%=team.getId()%>" tabindex="-1" role="dialog" aria-labelledby="viewImageModalLabel<%=team.getId()%>" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="viewImageModalLabel<%=team.getId()%>">View Image</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
									<div class="modal-body">
										<%
										if (team.getImage() != null) {
										%>
										<img
											src="data:image/jpeg;base64, <%=new String(Base64.getEncoder().encode(team.getImage()), StandardCharsets.UTF_8)%>"
											class="img-fluid" alt="Team Poster">
										<%
										} else {
										%>
										<!-- Display an empty image or placeholder -->
										<img src="path/to/empty-image.jpg" class="img-fluid"
											alt="Empty Poster">
										<% } %>
									</div>
								</div>
                                </div>
                            </div>

                            <!-- File input for updating image -->
                            <input type="file" name="poster" id="poster<%=team.getId()%>" accept="image/*" style="display: none;">

                            <!-- Display the selected file name (optional) -->
                            <span id="selectedFileName<%=team.getId()%>"></span>
                        </td>
                        <td>
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
