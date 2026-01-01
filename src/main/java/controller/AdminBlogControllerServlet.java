package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import daoimpl.BlogDaoImpl;

@WebServlet("/AdminBlogControllerServlet")
public class AdminBlogControllerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sid = request.getParameter("id");
        BlogDaoImpl dao = new BlogDaoImpl();
        String msg = "";

        if (sid == null) {
            msg = "Invalid blog ID!";
        } else {
            int id = Integer.parseInt(sid);
            boolean deleted = dao.deleteBlog(id);

            msg = deleted ? "Blog deleted successfully!" : "Failed to delete blog!";
        }

        request.setAttribute("msg", msg);
        request.setAttribute("blogs", dao.getAllBlogs());
        request.getRequestDispatcher("manage-blogs.jsp").forward(request, response);
    }
}
