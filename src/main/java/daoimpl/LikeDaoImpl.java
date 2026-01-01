package daoimpl;

import java.sql.*;
import dao.LikeDao;
import pojo.LikePojo;

public class LikeDaoImpl implements LikeDao {

    Connection con;

    public LikeDaoImpl() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/blogingproject?user=root&password=root"
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean addLike(LikePojo obj) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO likes (blog_id, user_id) VALUES (?, ?)"
            );
            ps.setInt(1, obj.getBlog_id());
            ps.setInt(2, obj.getUser_id());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            // Unique constraint violation means user already liked → ignore
            return false;
        }
    }

    @Override
    public boolean removeLike(int blogId, int userId) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM likes WHERE blog_id = ? AND user_id = ?"
            );
            ps.setInt(1, blogId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean isLiked(int blogId, int userId) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT id FROM likes WHERE blog_id = ? AND user_id = ?"
            );
            ps.setInt(1, blogId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public int countLikes(int blogId) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) FROM likes WHERE blog_id = ?"
            );
            ps.setInt(1, blogId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
