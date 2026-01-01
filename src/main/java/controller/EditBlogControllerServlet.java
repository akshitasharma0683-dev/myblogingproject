package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import daoimpl.BlogDaoImpl;
import pojo.BlogPojo;
import pojo.user;

@WebServlet("/EditBlogControllerServlet")
public class EditBlogControllerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        user u = (user) session.getAttribute("userobj");

        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        BlogDaoImpl dao = new BlogDaoImpl();

        // ------------------ LOAD EDIT PAGE --------------------
        if ("edit".equalsIgnoreCase(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            BlogPojo blog = dao.getBlogById(id);

            // prevent editing others' blogs
            if (blog == null || blog.getUserId() != u.getId()) {
                request.setAttribute("msg", "You are not allowed to edit this blog!");
                request.getRequestDispatcher("Dashboard.jsp").forward(request, response);
                return;
            }

            request.setAttribute("blog", blog);
            request.getRequestDispatcher("editblog.jsp").forward(request, response);
        }

        // ------------------ DELETE BLOG --------------------
        else if ("delete".equalsIgnoreCase(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            BlogPojo blog = dao.getBlogById(id);

            if (blog != null && blog.getUserId() == u.getId()) {
                boolean deleted = dao.deleteBlog(id, u.getId());
                if (deleted) {
                    session.setAttribute("msg", "Blog deleted successfully!");
                } else {
                    session.setAttribute("msg", "Failed to delete blog!");
                }
            } else {
                session.setAttribute("msg", "Unauthorized action!");
            }

            response.sendRedirect("Dashboard.jsp");
        }
    }

    
    // ------------------ UPDATE BLOG --------------------
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        user u = (user) session.getAttribute("userobj");

        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("update".equalsIgnoreCase(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String category = request.getParameter("category");
            String content = request.getParameter("content");

            BlogDaoImpl dao = new BlogDaoImpl();
            BlogPojo blog = dao.getBlogById(id);

            // prevent updating others' blogs
            if (blog == null || blog.getUserId() != u.getId()) {
                session.setAttribute("msg", "Unauthorized action!");
                response.sendRedirect("Dashboard.jsp");
                return;
            }

            blog.setTitle(title);
            blog.setCategory(category);
            blog.setContent(content);

            boolean updated = dao.updateBlog(blog);

            if (updated) {
                session.setAttribute("msg", "Blog updated successfully!");
            } else {
                session.setAttribute("msg", "Failed to update blog!");
            }

            response.sendRedirect("Dashboard.jsp");
        }
    }
}
