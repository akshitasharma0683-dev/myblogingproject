<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pojo.*" %>

<%

user use = (user)session.getAttribute("userobj");
if(use==null)
	response.sendRedirect("login.jsp");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; margin: 0; }
        .page-header nav { background: #0F1C3F; padding: 25px; color: white; height: 100vh; }
        .logo { width: 110px; margin-bottom: 25px; border-radius: 8px; }

        .profile-box { text-align: center; padding: 15px; background: #12224D; border-radius: 10px; margin-bottom: 20px; }
        .profile-pic { width: 80px; height: 80px; border-radius: 8px; object-fit: cover; border: 2px solid #1B2A5A; }

        .admin-menu { list-style: none; padding: 0; }
        .admin-menu li { margin-bottom: 10px; }
        .admin-menu a { color: #eaefff; padding: 10px; display: block; border-radius: 6px; text-decoration: none; background: #0F1C3F; }
        .admin-menu a:hover { background: #1B2A5A; }

        .page-content { padding: 30px; }
        
        .card {
    background: white;
}



.form-label {
    color: #0F1C3F;
    font-size: 14px;
}
        
    </style>
</head>
<body>

<jsp:include page="dashboardmenu.jsp" />

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

        <!-- Main Content -->
        <!-- MAIN CONTENT -->
<div class="col-lg-9 col-md-8 p-4">

    <% if (request.getAttribute("msg") != null) { %>
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <%= request.getAttribute("msg") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <h2 class="fw-bold text-primary mb-4">Edit Profile</h2>

    <div class="card shadow-lg border-0 rounded-4 p-4">

        <!-- Profile Picture Preview -->
        <div class="text-center mb-4">
            <% if (us.getDp() != null && !us.getDp().trim().isEmpty()) { %>
                <img src="<%=request.getContextPath()%>/images/<%=us.getDp()%>"
                     id="previewImage"
                     class="rounded-3 shadow"
                     style="width: 120px; height: 120px; object-fit: cover;">
            <% } else { %>
                <img src="<%=request.getContextPath()%>/images/default-user.png"
                     id="previewImage"
                     class="rounded-3 shadow"
                     style="width: 120px; height: 120px; object-fit: cover;">
            <% } %>
        </div>

        <form action="editProfile" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">

            <input type="hidden" name="oldPic" value="<%= us.getDp() %>">

            <div class="mb-3">
                <label class="form-label fw-semibold">Profile Picture</label>
                <input type="file" class="form-control" name="profilePic" accept="image/png, image/jpeg"
                       onchange="previewFile(event)">
                <small class="text-muted">Supports JPG, PNG (max 2MB)</small>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold">Username</label>
                    <input type="text" class="form-control" name="username"
                           value="<%= us.getUsername() %>" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold">Email</label>
                    <input type="email" class="form-control" name="email"
                           value="<%= us.getEmail() %>" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Contact Number</label>
                <input type="tel" class="form-control" name="contact"
                       id="contact" maxlength="10" value="<%= us.getContact() %>" required>
                <span id="contactError" class="text-danger small" style="display:none;">
                    Mobile number must be exactly 10 digits.
                </span>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 rounded-3 fw-bold">
                Update Profile
            </button>

        </form>
    </div>

</div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const contactField = document.getElementById("contact");
    const contactError = document.getElementById("contactError");

    contactField.addEventListener("input", () => {
        contactField.value = contactField.value.replace(/\D/g, "");
        contactError.style.display = (contactField.value.length !== 10) ? "block" : "none";
    });

    function validateForm() {
        return /^\d{10}$/.test(contactField.value);
    }
</script>
<script>
function previewFile(event) {
    const reader = new FileReader();
    reader.onload = function(){
        document.getElementById("previewImage").src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
}

const contactField = document.getElementById("contact");
const contactError = document.getElementById("contactError");

contactField.addEventListener("input", () => {
    contactField.value = contactField.value.replace(/\D/g, "");
    contactError.style.display = (contactField.value.length !== 10) ? "block" : "none";
});

function validateForm() {
    return /^\d{10}$/.test(contactField.value);
}
</script>

</body>
</html>
