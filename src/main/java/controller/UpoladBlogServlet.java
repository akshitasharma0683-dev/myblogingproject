package controller;

import daoimpl.BlogDaoImpl;
import pojo.BlogPojo;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.sql.Timestamp;

@WebServlet("/UpoladBlogServlet")
@MultipartConfig
public class UpoladBlogServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // ---------- GET SIMPLE FORM FIELDS ----------
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String content = request.getParameter("content");

        // ---------- GET IMAGE ----------
        Part imagePart = request.getPart("image");
        String imageFileName = null;

        if (imagePart != null && imagePart.getSize() > 0) {

            // Create unique name
            imageFileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();

            // Folder where image will be stored
            String savePath =
                    "C:\\Users\\aksha\\eclipse-workspace\\myblogingproject\\src\\main\\webapp\\images\\";

            File folder = new File(savePath);
            if (!folder.exists()) folder.mkdirs();

            // Save file
            File savedFile = new File(folder, imageFileName);
            Files.copy(imagePart.getInputStream(), savedFile.toPath());
        }

        // ---------- PREPARE POJO ----------
        BlogPojo blog = new BlogPojo();

        blog.setUserId(1); // TEMPORARY — since no session  
        blog.setTitle(title);
        blog.setCategory(category);
        blog.setContent(content);
        blog.setImage(imageFileName);

        Timestamp now = new Timestamp(System.currentTimeMillis());
        blog.setCreatedAt(now);
        blog.setUpdatedAt(now);

        // ---------- SAVE TO DB ----------
        BlogDaoImpl dao = new BlogDaoImpl();
        int result = dao.addBlog(blog);

        // ---------- RESPONSE ----------
        if (result > 0) {
            response.sendRedirect("showallblog.jsp");
        } else {
            response.getWriter().println("❌ Error inserting blog");
        }
    }
}
