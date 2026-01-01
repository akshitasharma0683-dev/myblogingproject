package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import daoimpl.CommentDaoImpl;

@WebServlet("/CommentControllerServlet")
public class CommentControllerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sid = request.getParameter("id");
        String action = request.getParameter("action");

        if (sid == null || action == null) {
            request.setAttribute("msg", "Invalid request!");
            request.getRequestDispatcher("manage-comments.jsp").forward(request, response);
            return;
        }

        int commentId = Integer.parseInt(sid);
        CommentDaoImpl dao = new CommentDaoImpl();
        String msg = "";

        switch (action) {

            case "delete":
                if (dao.deleteCommentByAdmin(commentId)) {
                    msg = "Comment deleted successfully!";
                } else {
                    msg = "Failed to delete comment!";
                }
                break;

            default:
                msg = "Unknown action!";
        }

        request.setAttribute("msg", msg);

        // Refresh comments list
        request.setAttribute("comments", dao.getAllComments());

        request.getRequestDispatcher("manage-comments.jsp").forward(request, response);
    }
}
