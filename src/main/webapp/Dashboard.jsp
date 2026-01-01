<%@page import="daoimpl.userDaoImpl"%>
<%@page import="pojo.*"%>

<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%

user use = (user)session.getAttribute("userobj");
if(use==null)
	response.sendRedirect("login.jsp");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Dashboard & Blogs</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      background: #f4f4f4;
    }

    /* Sidebar */
    .page-header nav {
      background: #0F1C3F; /* Dark Sapphire */
      padding: 25px;
      color: white;
      height: 100vh;

      top: 0;
    
    }

    .logo {
      width: 110px;
      margin-bottom: 25px;
      border-radius: 8px;
    }

    /* Profile block */
.profile-box {
    text-align: center;
    padding: 15px;
    background: #12224D;
    border-radius: 10px;
    margin-bottom: 20px;
}
.profile-box .profile-pic {
    width: 80px;
    height: 80px;
    border-radius: 8px;  /* NOT circular */
    object-fit: cover;
    border: 2px solid #1B2A5A;
}


    .profile-box img {
      width: 70px;
      height: 70px;
      border-radius: 50%;
      object-fit: cover;
      border: 2px solid #1B2A5A;
    }

}

.profile-box .greeting {
    font-size: 16px;
    font-weight: bold;
    color: white;
}

    .profile-box .notifications svg {
      width: 18px;
      height: 18px;
      fill: #d7ddff;
    }

    /* Admin Menu */
    .admin-menu {
      list-style: none;
      padding: 0;
    }

    .admin-menu li {
      margin-bottom: 10px;
    }

    .admin-menu a {
      color: #eaefff;
      text-decoration: none;
      padding: 10px;
      display: block;
      border-radius: 6px;
      transition: 0.3s;
      font-size: 15px;
      background: #0F1C3F;
    }

    .admin-menu a:hover {
      background: #1B2A5A; /* Lighter sapphire hover */
    }

    .menu-heading h3 {
      color: #c7d1ff;
      font-size: 18px;
    }

    /* Main content / blog */
    .page-content {
      padding: 30px;
    }

    .blog-card {
      background: #fff;
      border-radius: 10px;
      padding: 20px;
      margin-bottom: 20px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    .blog-title {
      font-size: 24px;
      font-weight: bold;
      color: #0F1C3F; /* Dark Sapphire */
      margin-bottom: 10px;
    }

    .blogger-name {
      font-size: 14px;
      color: #555;
      margin-bottom: 15px;
    }

    .blog-content {
      font-size: 16px;
      line-height: 1.6;
      color: #333;
      margin-bottom: 15px;
    }

    .blog-actions button {
      margin-right: 10px;
    }

    .like-count {
      font-weight: bold;
      margin-left: 5px;
      color: #0F1C3F;
    }
  </style>
</head>
<body>

<jsp:include page="dashboardmenu.jsp"></jsp:include>

<div class="container-fluid">
  <div class="row">

    <!-- SIDEBAR -->
    <div class="col-lg-3 col-md-4 p-0">
      <header class="page-header">
        <nav>
          <a href="#"><img class="logo" src="profile_4520807.png" alt=""></a>

<div class="profile-box">

    <% 
        user us  = (user) session.getAttribute("userobj");
        if(us!=null)
        {
    %>

    <!-- WELCOME TEXT -->
    <div class="greeting" style="font-weight:bold; font-size:16px; color:white;">
        WELCOME
    </div>
      <!--   <%= "DEBUG USER ID = " + us.getId()%>

    <!-- USER DP -->
    <% if (us.getDp() != null && !us.getDp().trim().isEmpty()) { %>
        <img src="<%=request.getContextPath()%>/images/<%=us.getDp()%>" class="profile-pic">
    <% } else { %>
        <img src="<%=request.getContextPath()%>/images/default-user.png" class="profile-pic">
    <% } %>

    <!-- USERNAME -->
    <div class="greeting" style="font-weight:bold; color:white; margin-top:8px;">
        <%= us.getUsername() %>
    </div>
    <%
        }
    %>

</div>

         <ul class="admin-menu">
    <li><a href="editprofile.jsp" align="center">Edit Profile</a></li>
    <li><a href="uploadblog.jsp" align="center">Post Blog</a></li>
    <li><a href="showallblog.jsp" align="center">All Blogs</a></li>
    <li><a href="Editblog.jsp" align="center">Update Blog</a></li>
 <li><a href="LogoutServlet" align = "center">Logout</a></li></ul>

        </nav>
      </header>
    </div>
    
  <!-- MAIN CONTENT -->
<div class="col-lg-9 col-md-8">
  <section class="page-content">

    <h2 class="fw-bold mb-4">User Dashboard</h2>

    <!-- SUCCESS / ERROR MESSAGE -->
    <% if (request.getAttribute("msg") != null) { %>
        <div class="alert alert-info">
            <%= request.getAttribute("msg") %>
        </div>
    <% } %>

    <h3 class="mb-3">Latest Blog Posts</h3>

    <div class="row">
      <%
        List<BlogPojo> lst = (List<BlogPojo>) session.getAttribute("allblog");
        user u = (user) session.getAttribute("userobj");

        for (BlogPojo b : lst) { 
      %>

      <!-- Modern Blog Card -->
      <div class="col-lg-6 mb-4">
        <div class="card shadow-sm border-0 rounded-3">

          <% if (b.getImage() != null && !b.getImage().trim().equals("")) { %>
              <img src="<%= request.getContextPath() %>/images/<%= b.getImage() %>" 
                   class="card-img-top" 
                   style="height: 220px; object-fit: cover;">
          <% } %>

          <div class="card-body">
            <h5 class="fw-bold text-primary"><%= b.getTitle() %></h5>

            <p class="text-muted small mb-1">Category: <b><%= b.getCategory() %></b></p>
            <p class="text-muted small mb-1">Posted by User ID: <%= b.getUserId() %></p>
            <p class="text-muted small">Created: <%= b.getCreatedAt() %></p>

            <p class="mt-2" style="max-height: 80px; overflow: hidden; text-overflow: ellipsis;">
              <%= b.getContent() %>
            </p>
            <!-- Like + Comment Buttons -->
            <form action="LikeCommentServlet" method="get" class="mt-2">

              <input type="hidden" name="blogId" value="<%= b.getId() %>">
              <input type="hidden" name="userId" value="<%= u.getId() %>">

              <div class="input-group mb-2">
                <input type="text" name="comment" class="form-control">
                <button class="btn btn-primary" name="action" value="comment">Comment</button>
              </div>

              <!-- Like Button -->
              <button type="submit" name="action" value="like" class="btn btn-outline-primary btn-sm">
                👍 Like
              </button>

              <span class="ms-2 fw-bold text-primary">
                <%= new daoimpl.LikeDaoImpl().countLikes(b.getId()) %> Likes
              </span>

            </form>

            <!-- COMMENTS SECTION -->
            <%
              List<CommentPojo> cmList = (List<CommentPojo>) session.getAttribute("comments");
              if (cmList != null) {
            %>

              <div class="mt-3 p-2 bg-light rounded">
                <h6 class="fw-bold">Comments:</h6>

                <% for (CommentPojo c : cmList) {
                      if (c.getBlog_id() == b.getId()) {

                          userDaoImpl daoimpl = new userDaoImpl();
                          user uu = daoimpl.searchUser(c.getUser_id());
                %>

                  <div class="border-bottom pb-2 mb-2">
                    <b><%= uu != null ? uu.getUsername() : "User" %>:</b>
                    <%= c.getComment() %><br>
                    <small class="text-muted"><%= c.getCreated_at() %></small>
<% if (u.getId() == c.getUser_id()) { %>
<form action="LikeCommentServlet" method="get" class="mt-1">
    <input type="hidden" name="action" value="deleteComment">
    <input type="hidden" name="commentId" value="<%= c.getId() %>">
    <input type="hidden" name="blogId" value="<%= c.getBlog_id() %>">
    <input type="hidden" name="userId" value="<%= u.getId() %>">  <!-- ✅ REQUIRED -->

    <button type="submit" class="btn btn-danger btn-sm"
            onclick="return confirm('Delete this comment?');">
        Delete
    </button>
</form>
<% } %>


                  </div>

                <% } } %>
              </div>

            <% } %>

          </div> <!-- card-body -->

        </div>
      </div>

      <% } %>
    </div>
  </section>
</div>

  </div>
</div>
 
        
     




<li><a href="uploadblog.jsp" align="center">Create Blog</a></li>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
