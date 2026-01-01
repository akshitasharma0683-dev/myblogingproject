package controller;
import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;


import dao.userDao;
import daoimpl.userDaoImpl;
import pojo.user;

@WebServlet("/editProfile")
@MultipartConfig
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

    	
        HttpSession session = req.getSession(false);
        user userObj = (user) session.getAttribute("userobj");

        if (userObj == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String contact = req.getParameter("contact");
        String oldPic = req.getParameter("oldPic");

        Part filePart = req.getPart("profilePic");

        String newFileName = oldPic;  // default value

        // IMAGE UPLOAD LOGIC
        if (filePart != null && filePart.getSize() > 0) {

            String uploadPath = req.getServletContext().getRealPath("uploads");

            String newName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            File fileSaveDir = new File(uploadPath);

            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdir();
            }

            filePart.write(uploadPath + File.separator + newName);
            newFileName = newName;

            // Delete old image
            if (!oldPic.equals("default.png")) {
                File oldFile = new File(uploadPath + File.separator + oldPic);
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }
        }

        // DATABASE UPDATE VIA DAO
        try {
            userDao userDao = new userDaoImpl();

            // Prepare updated user object
            userObj.setUsername(username); // You might want to ignore if username shouldn't be changed
            userObj.setEmail(email);
            userObj.setContact(contact);
            userObj.setDp(newFileName);

            boolean updated = userDao.updateUser(userObj);

            if (updated) {
                session.setAttribute("user", userObj);
                session.setAttribute("msg", "Profile updated successfully!");
            } else {
                session.setAttribute("msg", "Failed to update profile!");
            }

            resp.sendRedirect("Dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Error occurred while updating profile.");
            resp.sendRedirect("editprofile.jsp");
        }
    }
}
