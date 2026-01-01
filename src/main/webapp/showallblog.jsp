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
    <li><a href="editprofile.jsp" align="center">Edit Profile</a></li>
    <li><a href="uploadblog.jsp" align="center">Post Blog</a></li>
    <li><a href="showallblog.jsp" align="center">All Blogs</a></li>
    <li><a href="Editblog.jsp" align="center">Update Blog</a></li>
    <li><a href="LogoutServlet" align="center">Logout</a></li>
</ul>

        </nav>
      </header>
    </div>
    
    <!-- MAIN CONTENT -->
    <div class="col-lg-9 col-md-8">
      <section class="page-content">
        <h2 class="mb-4 fw-bold">Dashboard & Blogs</h2>
 <!-- MAIN CONTENT -->
    <div class="col-lg-9 col-md-8">
      <div class="container mt-4">
        <h2 class="text-center mb-4">All Blog Posts</h2>
        
        

        <%

        List<BlogPojo>lst =(List<BlogPojo>) session.getAttribute("allblog");
        user u = (user)session.getAttribute("userobj");
        	for(int i=0; i<lst.size(); i++) 
              {
                BlogPojo b = lst.get(i);
        		
        		%>

        <div class="blog-card">
            <h4><%= b.getTitle() %></h4>

           <div class="field-box"><span>Blog ID:</span> <%=b.getId()%></div>
            <div class="field-box"><span>User ID:</span> <%=b.getUserId()%></div> 
            
            <div class="field-box"><span>Category:</span> <%= b.getCategory() %></div>
            <div class="field-box"> <%= b.getContent() %>

            <div  field-image" align = "center">
              <% if(b.getImage() != null && !b.getImage().trim().equals("")) { %>
<img src="<%= request.getContextPath() %>/images/<%= b.getImage() %>" alt="Blog Image" class="img-fluid">
              <% } else { %>
                No Image
              <% } %>
           
          
            <div ><span>Created At:</span> <%= b.getCreatedAt() %></div>
            <!-- <div class="field-box" align = "right"><span>Updated At:</span> <%=b.getUpdatedAt() %></div> -->
             </div>
            
    <form action="LikeCommentServlet" method="get">
    <input type="hidden" name="blogId" value= "<%=b.getId()%>">
	<input type="hidden" name="userId" value="<%=us.getId()%>">	
    <input type="text" name="comment" placeholder="Write a comment" >

    <!-- Comment button -->
    <button type="submit" name="action" value="comment">Comment</button>
    

    <!-- Like button -->
       <input type="hidden" name="action" value="like">
    <input type="hidden" name="blogId" value="<%= b.getId() %>">

    <button type="submit" style="background:none; border:none;">
        <img src="images/like.png" width="32" height="32">
    </button>

    <span style="font-weight:bold;">
        <%= new daoimpl.LikeDaoImpl().countLikes(b.getId()) %> Likes
    </span>
    <!-- displaying button -->

    <% 
    List<CommentPojo> cmList = (List<CommentPojo>) session.getAttribute("comments");
    if (cmList != null) {
%>

<div style="margin-top:10px; padding:10px; background:#f4f4f4;">
    <h4>Comments:</h4>

    <%
       for (CommentPojo c : cmList) {
        if (c.getBlog_id() == b.getId()) { 

        	userDaoImpl daoimpl = new userDaoImpl();
        	user uu = daoimpl.searchUser(c.getUser_id());
    %>

	
        <div style="margin-bottom:8px; padding:5px; border-bottom:1px solid #ccc;">
        <%
        if(uu!=null)
        {
        	%>
        
            <b>User <%= uu.getUsername() %>:</b>
            <%
        }
            %>
            <%= c.getComment() %>
            <br>
            <small><%= c.getCreated_at() %></small>

            <%
                user sessionUser = (user) session.getAttribute("userobj");

                // Show delete button only for the owner of the comment
                if (sessionUser != null && sessionUser.getId() == c.getUser_id()) {
            %>

            <!-- DELETE FORM -->
                <input type="hidden" name="action" value="deleteComment">
                <input type="hidden" name="commentId" value="<%= c.getId() %>">
                <input type="hidden" name="userId" value="<%= sessionUser.getId() %>">
                <input type="hidden" name="blogId" value="<%= c.getBlog_id() %>">

                <button type="submit"
                        style="background:red; color:white; border:none; padding:3px 8px; cursor:pointer;"
                        onclick="return confirm('Delete this comment?');">
                    Delete
                </button>
            

            <% } %>
        </div>

    <%
           }
       }
    %>
</div>



<% } %>
    

</form>

			</div>
        </div>
        <%
         
          }
        %>

      </div>
    </div>

     
  </div>
</div>
 
        
     




<li><a href="uploadblog.jsp" align="center">Create Blog</a></li>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
