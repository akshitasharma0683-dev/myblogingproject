package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import daoimpl.userDaoImpl;

@WebServlet("/EditDeleteBlockServlet")
public class EditDeleteBlockServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sid = request.getParameter("id");
        String action = request.getParameter("action");

        // Validate parameters
        if (sid == null || action == null) {
            request.setAttribute("msg", "Invalid request!");
            request.getRequestDispatcher("manage-users.jsp").forward(request, response);
            return;
        }

        int id = Integer.parseInt(sid);
        userDaoImpl dao = new userDaoImpl();
        String msg = "";
     
        System.out.print("action is " + action+ "useris " +id);
        
        switch (action) {

           

            case "delete":
                if (dao.deleteUserAndDependencies(id)) {
                    msg = "User deleted successfully!";
                } else {
                    msg = "Failed to delete user.";
                }
                break;

            case "block":
                if (dao.updateStatus(id, "BLOCKED")) {
                    msg = "User has been BLOCKED.";
                } else {
                    msg = "Unable to block user.";
                }
                break;

            case "unblock":
                if (dao.updateStatus(id, "ACTIVE")) {
                    msg = "User has been UNBLOCKED.";
                } else {
                    msg = "Unable to unblock user.";
                }
                break;

            default:
                msg = "Unknown action!";
        }

        // Send message to JSP
        request.setAttribute("msg", msg);

        // Forward back to manage-users.jsp
        request.getRequestDispatcher("manage-users.jsp").forward(request, response);
    }
}
