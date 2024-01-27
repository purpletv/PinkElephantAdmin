<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.pinkElephantAdmin.model.Awards, com.pinkElephantAdmin.model.Divisions, java.util.List" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.nio.charset.StandardCharsets" %>

<!DOCTYPE html>
<html>
<head>
    <title>Awards Management</title>
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
                var awardId = row.data('awardId');

                // Create a form dynamically and append it to the body
                var form = $('<form method="post" action="/PinkElephantAdmin/onDeleteAward">');
                var input = $('<input type="hidden" name="id" value="' + awardId + '">');
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
                    <th>Award Title</th>
                    <th>Award Description</th>
                    <th>Image</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <% List<Awards> awards = (List<Awards>) request.getAttribute("allAwards"); %>
                <% for (Awards award : awards) { %>
                    <tr data-award-id="<%=award.getId()%>">
                        <td><%=award.getTitle()%></td>
                        <td><%=award.getDescription()%></td>
                        <td>
                            <!-- View Image Button Triggering Modal -->
                            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#viewImageModal<%=award.getId()%>">View Image</button>

                             <!-- View Image Modal -->
                            <div class="modal fade" id="viewImageModal<%=award.getId()%>" tabindex="-1" role="dialog" aria-labelledby="viewImageModalLabel<%=award.getId()%>" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="viewImageModalLabel<%=award.getId()%>">View Image</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
									<div class="modal-body">
										<%
										if (award.getImage() != null) {
										%>
										<img
											src="data:image/jpeg;base64, <%=new String(Base64.getEncoder().encode(award.getImage()), StandardCharsets.UTF_8)%>"
											class="img-fluid" alt="Award Poster">
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
                            <input type="file" name="poster" id="poster<%=award.getId()%>" accept="image/*" style="display: none;">

                            <!-- Display the selected file name (optional) -->
                            <span id="selectedFileName<%=award.getId()%>"></span>
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
