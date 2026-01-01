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
    
    <%
    List<BlogPojo> blogs = (List<BlogPojo>) request.getAttribute("blogs");
    String msg = (String) session.getAttribute("msg");
    if (msg != null) session.removeAttribute("msg");
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
        
    %>

    <!-- WELCOME TEXT -->
    <div class="greeting" style="font-weight:bold; font-size:16px; color:white;">
        WELCOME
    </div>
        <%= "DEBUG USER ID = " + us.getId()%>

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

</div>

          <ul class="admin-menu">
   <a href="manage-users.jsp">Manage Users</a> <br>
<a href="manage-blogs.jsp">Manage Blogs</a><br>
<a href="manage-comments.jsp">View Comments</a><br>
<a href="LogoutServlet">Logout</a>
<br>

        </nav>
      </header>
    </div>
    
   <div class="col-lg-9 col-md-8">

    <div class="container mt-4">

        <h2 class="fw-bold mb-4">Manage Blog</h2>

        <div class="row">
        <form method="GET" action="AdminBlogControllerServlet" class="row g-2 mb-3">
            <input type="hidden" name="action" value="list">

            <div class="col-md-4">
                <input type="text" name="search" placeholder="Search by title..."
                       class="form-control">
            </div>

            <div class="col-md-4">
                <select name="category" class="form-select">
                    <option value="">All Categories</option>
                    <option>Technology</option>
                    <option>Education</option>
                    <option>Travel</option>
                    <option>Food</option>
                    <option>Sports</option>
                </select>
            </div>

            <div class="col-md-2">
                <button class="btn btn-primary w-100">Filter</button>
            </div>
        </form>

<!-- BLOG TABLE -->
<div class="col-12">



<table class="table table-bordered table-hover text-center align-middle">
    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>User ID</th>
            <th>Category</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>
    </thead>

    <tbody>
    <% 
        if (blogs != null && !blogs.isEmpty()) {
            for (BlogPojo b : blogs) {
    %>
        <tr>
            <td><%= b.getId() %></td>
            <td><%= b.getTitle() %></td>
            <td><%= b.getUserId() %></td>
            <td><%= b.getCategory() %></td>
            <td><%= b.getCreatedAt() %></td>

          <td>

    

    <!-- DELETE BLOG BUTTON -->
    <form action="AdminBlogControllerServlet" method="post" style="display:inline-block;"
          onsubmit="return confirm('Are you sure you want to delete this blog?');">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="id" value="<%= b.getId() %>">
        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
    </form>

</td>

        </tr>

    <% 
            }
        } else { 
    %>

        <tr>
            <td colspan="6" class="text-muted">No blogs found</td>
        </tr>

    <% } %>
    </tbody>

</table>

</div>
  
        </div>
<h3> <a href="adminDashboard.jsp">back</a></h3>
    </div>
</div>



    

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
