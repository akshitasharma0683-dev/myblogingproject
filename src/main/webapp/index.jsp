<!DOCTYPE html>
<%@page import="pojo.*"%>
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
      <title>Bloscot</title>
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
      <%@
       include file="header.jsp"
      %>
      
         <!-- banner section start --> 
         <div class="container-fluid">
            <div class="banner_section layout_padding">
               <h3 class="banner_taital">welcome </h2>
               <div id="my_slider" class="carousel slide" data-ride="carousel">
                  <div class="carousel-inner">
                     <div class="carousel-item active">
                        <div class="image_main">
                           <div class="container">
                              <img src="images/heroimage1.jpg" class="image_1">
                           </div>
                        </div>
                     </div>
                     <div class="carousel-item">
                        <div class="image_main">
                           <div class="container">
                              <img src="images/heroimage2.jpg" class="image_1">
                              <div class="contact_bt"><a href="contact.html">Contact Us</a></div>
                           </div>
                        </div>
                     </div>
                     <div class="carousel-item">
                        <div class="image_main">
                           <div class="container">
                              <img src="images/heroimage4.jpg" class="image_1">
                              <div class="contact_bt"><a href="contact.html">Contact Us</a></div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <a class="carousel-control-prev" href="#my_slider" role="button" data-slide="prev">
                  <i class="fa fa-angle-left"></i>
                  </a>
                  <a class="carousel-control-next" href="#my_slider" role="button" data-slide="next">
                  <i class="fa fa-angle-right"></i>
                  </a>
               </div>
            </div>
         </div>
         <!-- banner section end --> 
         
         
      </div>
     <br>
      
      
      <!-- recent section start --> 
      <div class="about_section layout_padding">
         <div class="container">
            <div class="row">
               <div class="col-lg-8 col-sm-12">
                  <div class="about_img"><img src="images/img-10.png"></div>
                  <div class="like_icon"><img src="images/like-icon.png"></div>
                 
               </div>
               <div class="col-lg-4 col-sm-12">
                  <div class="newsletter_main">
                     <h1 class="recent_taital">Recent post</h1>
                     <div class="recent_box">
                        <div class="recent_left">
                           <div class="image_6"><img src="images/img-6.png"></div>
                        </div>
                        <div class="recent_right">
                           <h3 class="consectetur_text">    <a href="login.jsp">
                           Consectetur adipiscing</a></h3>
                           <p class="dolor_text">ipsum dolor sit amet, consectetur adipiscing </p>
                        </div>
                     </div>
                     <div class="recent_box">
                        <div class="recent_left">
                           <div class="image_6"><img src="images/img-7.png"></div>
                        </div>
                        <div class="recent_right">
                           <h3 class="consectetur_text">    <a href="login.jsp">
                           Consectetur adipiscing</a></h3>
                           <p class="dolor_text">ipsum dolor sit amet, consectetur adipiscing </p>
                        </div>
                     </div>
                  </div>
               </div>
            </div>

         </div>
      </div>
      <!-- recent section end --> 
   
     
                     <%@ include file="cart.jsp" %>
      
      
      
    
     
     <%@ include file="footer.jsp" %>
      
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