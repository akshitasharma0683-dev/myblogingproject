package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daoimpl.BlogDaoImpl;
import pojo.BlogPojo;

@WebServlet("/ShowAllBlogServlet")
public class ShowAllBlogServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		BlogDaoImpl daoimpl = new BlogDaoImpl();
		List<BlogPojo>lst = daoimpl.getAllBlogs();
		request.setAttribute("allaccount", lst);
		RequestDispatcher rd = request.getRequestDispatcher("showallblog.jsp");
		rd.forward(request, response);

		
		
		
	}

}
