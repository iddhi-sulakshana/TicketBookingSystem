<%@ page import="org.bson.types.ObjectId" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.ticketbookingsystem.*" %>
<% //restrict access through url
    if(session.getAttribute("userID") == null){
        session.setAttribute("error", "Log in timeout");
        response.sendRedirect("./index.jsp");
        return;
    }
    System.out.println(session.getAttribute("userID"));
    System.out.println(session.getAttribute("logRole"));
    ObjectId userId = (ObjectId) session.getAttribute("userID");
    String role = (String) session.getAttribute("logRole");
    if (role == "admin") {
        session.setAttribute("error", "Unauthorized Page");
        response.sendRedirect("index.jsp");
        return;
    }
    User userObj = new User();
    UserStruct user = userObj.getUser(userId);
    userObj.close();
%>
<%@include file="./header.jsp" %>
    <link rel="stylesheet" href="./css/uDashboard.css">
    <script defer src="./js/uDashboard.js"></script>
<%@include file="./nav.jsp" %>
<!-- Section -->
    <section class="container p-lg-2">
        <div class="row">
        <!-- Settings -->
            <div class="col-lg-8 p-3">
                <div class="dcontent p-4 rounded-3">
                <!-- top bar -->
                    <div class="container mt-3">
                        <div class="row justify-content-between">
                            <div class="col-auto">
                                <h1>Welcome <%=user.fullName%></h1>
                            </div>
                            <div class="col-auto">
                                <button class="btn btn-lg btn-outline-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Log out</button>
                            </div>
                        </div>
                    </div>
                    <hr>
                <!-- Settings bar -->
                    <h4 class="text-center mb-4">Settings</h4>
                    <form action="./updateUserServlet" method="post">
                        <div class="form-outline mb-4">
                            <label class="form-label" for="lName">Full name</label>
                            <input type="text" class="form-control" id="lName" name="fullname" placeholder="Enter full name" value="<%=user.fullName%>" disabled required>
                        </div>
                        <div class="form-outline mb-4">
                            <label class="form-label" for="email">Email address</label>
                            <input type="email" id="email" class="form-control" placeholder="Email..." value="<%=user.email%>" readonly disabled required>
                        </div>
                        <div class="form-outline mb-4">
                            <label class="form-label" for="phoneNo">Phone Number</label>
                            <input type="text" id="phoneNo" class="form-control" placeholder="Phone No...." value="<%=user.phone%>" readonly disabled required>
                        </div>
                        <div class="form-outline mb-4">
                            <label class="form-label" for="password">Password</label>
                            <input type="password" id="password" class="form-control" placeholder="Password...." name="password" disabled required=""/>
                        </div>
                        <div class="row gap-2 text-center">
                            <div class="col">
                                <button type="button" id="deleteAcc" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">Delete Account</button>
                            </div>
                            <div class="col">
                                <button type="button" id="editAcc" class="btn btn-outline-warning">Edit Account</button>
                            </div>
                            <div class="col">
                                <button type="submit" disabled id="saveAcc" class="btn btn-outline-success">Save Changes</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        <!-- Tickets -->
            <div class="col-lg-4 p-3">
                <div class="dcontent p-4 rounded-3">
                    <h4 class="text-center mb-4">Tickets</h4>
                    <%
                        Ticket ticketObj = new Ticket();
                        List<TicketStruct> tickets = ticketObj.getUserTickets(user.email, user.phone);
                        System.out.println(tickets);
                        ticketObj.close();
                        if(tickets.isEmpty()){
                    %>
                    <div class="row text-center text-danger">
                        <div class="col">
                            <h3>No Tickets</h3>
                        </div>
                    </div>
                    <div class="row row-cols-1 gap-3">
                        <%
                            } else {
                                for(TicketStruct ticket : tickets){
                                    Movie movieObj = new Movie();
                                    MovieStruct movie = movieObj.getMovie(ticket.TMDBid);
                                    movieObj.close();
                        %>
                        <!-- ticket -->
                        <div class="col">
                            <div class="ticket p-2 px-4">
                                <div class="row text-center">
                                    <div class="col-sm-2 price d-flex justify-content-center align-items-center">
                                        <p>$<%=String.format("%.2f",ticket.price)%></p>
                                    </div>
                                    <div class="col-sm-8 my-3">
                                        <div class="t-title"><%=movie.title%></div>
                                        <div class="t-time"><i class="fa-light fa-calendar-days"></i> <%=ticket.showdate%></div>
                                        <div class="t-time"><i class="fa-light fa-clock"></i> <%=ticket.showtime%></div>
                                        <div class="row mt-2">
                                            <div class="col">
                                                <form method="post" action="./deleteTicketServlet" >
                                                    <button class="btn btn-outline-danger" onclick="cancelBook(this)">Cancel</button>
                                                    <input type="text" value="<%=ticket.ticketId%>" name="ticketId" value="<%=ticket.ticketId%>" hidden>
                                                    <input type="text" value="<%=ticket.transactionId%>" name="transactionId" value="<%=ticket.transactionId%>" hidden>
                                                    <input type="text" value="<%=movie.title%>" name="title" value="<%=movie.title%>" hidden>
                                                    <input type="text" value="<%=user.email%>" name="uemail" value="<%=user.email%>" hidden>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-2 d-grid seat">
                                        <i class="fa-light fa-seat-airline"></i>
                                        <%
                                            for(String seat: ticket.seats){
                                        %>
                                        <div><%=seat%></div>
                                        <%}%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end ticket -->
                        <% }} %>
                    </div>
                </div>
            </div>
        </div>
    </section>
 <!-- Logout modal -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content text-bg-dark">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="logoutModalLabel">Log Out !</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Do you want to Log out?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-warning" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-outline-danger" onclick="location.href= './logoutServlet'">Log out</button>
                </div>
            </div>
        </div>
    </div>
 <!-- delete modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content text-bg-dark">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="deleteModalLabel">Delete !</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Deleting account will remove everything from the system and it will unreversable action do you still want to delete the account?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-success" data-bs-dismiss="modal">Cancel</button>
                    <form action="./deleteUserServlet" method="post">
                        <input type="submit" class="btn btn-outline-danger" value="Delete">
                    </form>
                </div>
            </div>
        </div>
    </div>
<%@include file="./footer.jsp" %>