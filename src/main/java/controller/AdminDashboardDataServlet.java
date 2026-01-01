package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daoimpl.BlogDaoImpl;
import daoimpl.CommentDaoImpl;
import daoimpl.userDaoImpl;

@WebServlet("/AdminDashboardDataServlet")
public class AdminDashboardDataServlet extends HttpServlet {
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        userDaoImpl userDao = new userDaoImpl();
        BlogDaoImpl blogDao = new BlogDaoImpl();
        CommentDaoImpl commentDao = new CommentDaoImpl();

        HttpSession session = request.getSession(false);
       
        
        session.setAttribute("totalUsers", userDao.getTotalUsers());
        session.setAttribute("activeUsers", userDao.getActiveUsers());
        session.setAttribute("blockedUsers", userDao.getBlockedUsers());

        session.setAttribute("totalBlogs", blogDao.getTotalBlogs());
        session.setAttribute("totalComments", commentDao.getTotalComments());
        
        System.out.print( userDao.getTotalUsers() +"" +userDao.getActiveUsers() + ""+ userDao.getBlockedUsers()+ "" +blogDao.getTotalBlogs()+ "" +commentDao.getTotalComments()+ "" );

        RequestDispatcher rd = request.getRequestDispatcher("adminDashboard.jsp");
        rd.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
