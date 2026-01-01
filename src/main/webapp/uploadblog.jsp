<%@page import="pojo.user"%>
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
      position: sticky;
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
    
    .upload-container {
            background: #ffffff;
            width: 60%;
            margin: 50px auto;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0px 4px 12px rgba(0,0,0,0.1);
        }

        .upload-container h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: bold;
            color: #333;
        }

        label {
            font-weight: bold;
            color: #444;
            margin-top: 10px;
        }

        input, select, textarea {
            margin-top: 8px;
        }

        .btn-publish {
            width: 100%;
            background: #007bff;
            border-radius: 30px;
            padding: 12px;
            margin-top: 20px;
            font-size: 18px;
            color: white;
            border: none;
        }

        .btn-publish:hover {
            background: #005dc1;
        }
        
        .card {
    background: #fff;
    border-radius: 15px;
}

.form-label {
    color: #0F1C3F;
    font-size: 15px;
}

.page-content {
    padding: 20px;
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
 <li><a href="LogoutServlet" align = "center">Logout</a></li></ul>

        </nav>
      </header>
    </div>

    <!-- MAIN CONTENT -->
    <!-- MAIN CONTENT -->
<div class="col-lg-9 col-md-8 p-4">

    <section class="page-content">

        <h2 class="fw-bold text-primary mb-4">Create a New Blog</h2>

        <div class="card shadow-lg border-0 p-4 rounded-4">

            <form action="UpoladBlogServlet" method="post" enctype="multipart/form-data">

              

                <div class="mb-3">
                    <label class="form-label fw-semibold">Blog Title</label>
                    <input type="text" 
                           class="form-control form-control-lg" 
                           name="title" 
                           placeholder="Enter blog title" 
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Category</label>
                    <select class="form-control form-control-lg" name="category" required>
                        <option value="">-- Select Category --</option>
                        <option value="Technology">Technology</option>
                        <option value="Education">Education</option>
                        <option value="Lifestyle">Lifestyle</option>
                        <option value="Travel">Travel</option>
                        <option value="Fashion">Fashion</option>
                   <option value="Beauty">Beauty</option>
                   <option value="Parenting">Parenting</option>
                   <option value="Entrepreneurship">Entrepreneurship</option>
                        
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Content</label>
                    <textarea class="form-control" 
                              name="content" 
                              rows="8" 
                              placeholder="Write your blog..." 
                              required></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Upload Header Image</label>
                    <input type="file" 
                           class="form-control" 
                           name="image" 
                           accept="image/*" 
                           required
                           onchange="previewFile(event)">
                </div>

                <button type="submit" 
                        class="btn btn-primary w-100 py-2 fw-bold rounded-3">
                    Publish Blog
                </button>

            </form>

        </div>

    </section>

</div>

</div>

<!-- SVG ICON -->
<svg style="display:none;">
  <symbol id="users" viewBox="0 0 16 16">
    <path d="M8,0a8,8,0,1,0,8,8A8,8,0,0,0,8,0Z"/>
  </symbol>
</svg>

<script>
  function likeBlog(button) {
    const likeSpan = button.querySelector('.like-count');
    let count = parseInt(likeSpan.innerText);
    count++;
    likeSpan.innerText = count;
  }

  function commentBlog() {
    const comment = prompt("Write your comment:");
    if(comment) {
      alert("Your comment: " + comment);
    }
  }
</script>

<li><a href="uploadblog.jsp" align="center">Create Blog</a></li>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
