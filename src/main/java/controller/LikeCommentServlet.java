package controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daoimpl.CommentDaoImpl;
import daoimpl.LikeDaoImpl;
import pojo.CommentPojo;
import pojo.LikePojo;
import pojo.user;

@WebServlet("/LikeCommentServlet")
public class LikeCommentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        CommentDaoImpl cdao = new CommentDaoImpl();
        LikeDaoImpl likeDao = new LikeDaoImpl();

        // ================= COMMENT =================
        if ("comment".equalsIgnoreCase(action)) {

            int blogId = Integer.parseInt(request.getParameter("blogId"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            String commentText = request.getParameter("comment");

            CommentPojo c = new CommentPojo();
            c.setBlog_id(blogId);
            c.setUser_id(userId);
            c.setComment(commentText);
            c.setCreated_at(new Timestamp(System.currentTimeMillis()));

            cdao.addComment(c);
            session.setAttribute("comments", cdao.getCommentsByBlogId(blogId));
        }

        // ================= DELETE COMMENT =================
        else if ("deleteComment".equalsIgnoreCase(action)) {

            String commentIdStr = request.getParameter("commentId");
            String blogIdStr = request.getParameter("blogId");
            String userIdStr = request.getParameter("userId");
 
            // SAFETY CHECK
            if (commentIdStr != null && blogIdStr != null && userIdStr != null) {

                int commentId = Integer.parseInt(commentIdStr);
                int blogId = Integer.parseInt(blogIdStr);
                int userId = Integer.parseInt(userIdStr);

                CommentPojo c = new CommentPojo();
                c.setId(commentId);
                c.setUser_id(userId);

                cdao.deleteComment(c);
                session.setAttribute("comments", cdao.getCommentsByBlogId(blogId));
            }
        }

        // ================= LIKE =================
        else if ("like".equalsIgnoreCase(action)) {

            String blogIdStr = request.getParameter("blogId");
            String userIdStr = request.getParameter("userId");

            if (blogIdStr != null && userIdStr != null) {

                int blogId = Integer.parseInt(blogIdStr);
                int userId = Integer.parseInt(userIdStr);

                if (likeDao.isLiked(blogId, userId)) {
                    likeDao.removeLike(blogId, userId);
                } else {
                    LikePojo lp = new LikePojo();
                    lp.setBlog_id(blogId);
                    lp.setUser_id(userId);
                    likeDao.addLike(lp);
                }
            }
        }

        request.getRequestDispatcher("Dashboard.jsp").forward(request, response);
    }
}

    
