package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daoimpl.BlogDaoImpl;
import daoimpl.userDaoImpl;
import pojo.BlogPojo;
import pojo.user;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        user u = new user();
        u.setUsername(request.getParameter("username"));
        u.setPassword(request.getParameter("password"));

        userDaoImpl dao = new userDaoImpl();
        String target = "";

           user validUser = dao.checkUser(u);

    
           if (validUser != null) {

        	   HttpSession session = request.getSession(false);
        	   if(session!=null)
        	   {
        		   session.invalidate();
        	   }
        	   session = request.getSession(true);
        	   session.setAttribute("userobj", validUser);
        	   
        	   BlogDaoImpl daoimpl = new BlogDaoImpl();
        	   List<BlogPojo> lst = daoimpl.getAllBlogs();
        	   session.setAttribute("allblog", lst);
        	    request.setAttribute("msg", "WELCOME TO OUR BLOG");

        	    if ("BLOCKED".equalsIgnoreCase(validUser.getStatus())) {
        	        request.setAttribute("msg", "Your account has been blocked");
        	        target = "/login.jsp";

        	    } else if ("ADMIN".equalsIgnoreCase(validUser.getRole())) {
        	        target = "/AdminDashboardDataServlet";

        	    } else if ("USER".equalsIgnoreCase(validUser.getRole())) {
        	        target = "/Dashboard.jsp";

        	    } else {
        	        // fallback, if role is something unexpected
        	        target = "/login.jsp";
        	    }



        	    

        	} else {
        	    request.setAttribute("msg", "Invalid username/password");
        	    target = "/login.jsp";
        	}
           
        RequestDispatcher rd = request.getRequestDispatcher(target);
        rd.forward(request, response);
    }
    
}
