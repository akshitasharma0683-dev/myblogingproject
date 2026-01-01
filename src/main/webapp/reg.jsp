<!DOCTYPE html>
<html lang="en">
   <head>
      <!-- basic -->
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <!-- mobile metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="viewport" content="initial-scale=1, maximum-scale=1">
      <!-- site metas -->
      <title>Contact</title>
      <meta name="keywords" content="">
      <meta name="description" content="">
      <meta name="author" content="">
      <!-- bootstrap css -->
      <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
      <!-- style css -->
      <link rel="stylesheet" type="text/css" href="css/style.css">
      <!-- Responsive-->
      <link rel="stylesheet" href="css/responsive.css">
      <!-- fevicon -->
      <link rel="icon" href="images/fevicon.png" type="image/gif" />
      <!-- Scrollbar Custom CSS -->
      <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
      <!-- Tweaks for older IEs-->
      <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
      <!-- owl stylesheets --> 
      <link rel="stylesheet" href="css/owl.carousel.min.css">
      <link rel="stylesoeet" href="css/owl.theme.default.min.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
   </head>
   <body>
     <%@ include file="header.jsp" %>
      <!-- contact section start -->
      <div class="contact_section layout_padding">
         <div class="container">
         
            <div class="row">
               <div class="col-md-6">
                  <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                     <ol class="carousel-indicators">
                        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active" style="text-indent: 0; border: none; color: #000; font-size: 18px; text-align: center;">1</li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="1"style="text-indent: 0; border: none; color: #000; font-size: 18px; text-align: center;">2</li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="2"style="text-indent: 0; border: none; color: #000; font-size: 18px; text-align: center;">3</li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="3"style="text-indent: 0; border: none; color: #000; font-size: 18px; text-align: center;">4</li>
                     </ol>
                     <div class="carousel-inner">
                        <div class="carousel-item active">
                           <div class="contact_img"></div>
                        </div>
                        <div class="carousel-item">
                           <div class="contact_img"></div>
                        </div>
                        <div class="carousel-item">
                           <div class="contact_img"></div>
                        </div>
                        <div class="carousel-item">
                           <div class="contact_img"></div>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="col-md-6">
               
                  <div class="mail_section">
                      <div class="row">
                         <h1 style="color: #080c50; font-weight: bold;">New User Registration</h1><br><br>
      
            <form class="form-signin" action="checkUserServlet" method="post" enctype="multipart/form-data">
			<h3>
            <%
            String msg = (String)request.getAttribute("msg");
            if(msg!=null)
            	out.print(msg);
            %>
            </h3>

                   <div class="form-label-group">
                       <input type="text" id="username" class="form-control" placeholder="Username" name="username" required>
                       <br>
                          </div>

              <div class="form-label-group">
                   <input type="password" id="password" class="form-control" placeholder="Password" name="password" required minlength = "4" maxlength = "6">
                   <br>
                </div>

            <div class="form-label-group">
                <input type="email" id="email" class="form-control" placeholder="Email" name="email" required>
                    <br>
              </div>

          <div class="form-label-group">
           <input type="tel" id="contact" class="form-control" placeholder="Contact Number" name="contact" required minlength = "10" maxlength = "10">
           <br>
            </div>
            
             <div class="form-label-group">
				Select Your DP : <input type="file" name="dp" accept="images/*" required>             
			 </div>
            


              <br>

                <button class="btn btn-primary btn-block" type="submit">Register</button>
              <button class="btn btn-lg btn-google btn-block text-uppercase" class="text-success" type="submit"><i class="fab fa-google mr-2"></i> <a href="login.jsp">Back To Login Page</button>
                

              
            </form>
                <br>
    <br>
            
          </div>
        </div>
      </div>
    </div>
  </div>
    </div>
      <!-- contact section end -->
    <%@ include file="footer.jsp" %>
      <!-- copyright section end -->
      <!-- Javascript files-->
      <script src="js/jquery.min.js"></script>
      <script src="js/popper.min.js"></script>
      <script src="js/bootstrap.bundle.min.js"></script>
      <script src="js/jquery-3.0.0.min.js"></script>
      <script src="js/plugin.js"></script>
      <!-- sidebar -->
      <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
      <script src="js/custom.js"></script>
      <!-- javascript --> 
      <script src="js/owl.carousel.js"></script>
      <script src="https:cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>
   </body>
</html>