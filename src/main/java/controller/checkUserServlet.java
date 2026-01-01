package controller;

import java.io.FileOutputStream;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import daoimpl.userDaoImpl;
import pojo.user;

@WebServlet("/checkUserServlet")
@MultipartConfig

public class checkUserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    
    	user validUser = new user();
    	validUser.setUsername(request.getParameter("username"));
    	validUser.setPassword(request.getParameter("password"));
    	validUser.setEmail(request.getParameter("email"));
    	validUser.setRole("USER");
    	validUser.setContact(request.getParameter("contact"));
    	
		Part filepart = request.getPart("dp");
		validUser.setDp(filepart.getSubmittedFileName());

    	
    	userDaoImpl dao = new userDaoImpl();
    	String target = "";

		FileOutputStream serverfile = new FileOutputStream
	            ("C:\\Users\\aksha\\eclipse-workspace\\myblogingproject\\src\\main\\webapp\\images\\"+
						filepart.getSubmittedFileName());
				
				InputStream is = filepart.getInputStream();
				
				byte b[] = new byte[is.available()];
				
				is.read(b);
				serverfile.write(b);
				
				is.close();
				serverfile.close();
				

    	
    	if (dao.registerUser(validUser))
    	{
    		request.setAttribute("msg", "User Registered Seccessfully, can login here");
    		target = "/login.jsp";
    	}
    	else {
    		
    		request.setAttribute("msg", "user could not be registered");
    	    target = "/reg.jsp";
    	}
    	
    	RequestDispatcher rd = getServletContext().getRequestDispatcher(target);
    	rd.forward(request, response);

    	
    }
}
