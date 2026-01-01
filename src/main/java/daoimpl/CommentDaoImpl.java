package daoimpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.commentDao;
import pojo.CommentPojo;


public class CommentDaoImpl implements commentDao{
	
	private Connection  con;
	
	public CommentDaoImpl() {
		 try {
	            Class.forName("com.mysql.cj.jdbc.Driver");

	            con = DriverManager.getConnection(
	                    "jdbc:mysql://localhost:3306/blogingproject",
	                    "root",
	                    "root"
	            );

	            System.out.println("DB Connected Successfully!");

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	}

	@Override
	public int addComment(CommentPojo obj) {
	    try {
	        String sql = "INSERT INTO comments (blog_id, user_id, comment, created_at) VALUES (?, ?, ?, ?)";
	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setInt(1, obj.getBlog_id());
	        ps.setInt(2, obj.getUser_id());
	        ps.setString(3, obj.getComment());
	        ps.setTimestamp(4, obj.getCreated_at());

	        int x = ps.executeUpdate();
	        return x > 0 ? 1 : 0;

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return 0;
	}


	@Override
	public boolean deleteComment(CommentPojo obj) {
	    try {
	        PreparedStatement ps = con.prepareStatement(
	            "DELETE FROM comments WHERE id = ? AND user_id = ?"
	        );

	        ps.setInt(1, obj.getId());
	        ps.setInt(2, obj.getUser_id());

	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return false;
	}

	
	@Override
	public List<CommentPojo> getCommentsByBlogId(int blogId) {

	    List<CommentPojo> list = new ArrayList();

	    try {
	        PreparedStatement ps = con.prepareStatement(
	            "SELECT * FROM comments WHERE blog_id = ? ORDER BY created_at DESC"
	        );
	        ps.setInt(1, blogId);

	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            CommentPojo c = new CommentPojo();
	            c.setId(rs.getInt("id"));
	            c.setBlog_id(rs.getInt("blog_id"));
	            c.setUser_id(rs.getInt("user_id"));
	            c.setComment(rs.getString("comment"));
	            c.setCreated_at(rs.getTimestamp("created_at"));

	            list.add(c);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

	
	// admin dashboard to show comments there 
	public int getTotalComments() {
	
		try {
	        PreparedStatement ps = con.prepareStatement(
	            "SELECT COUNT(*) FROM comments"
	        );
	       
	         ResultSet rs = ps.executeQuery();
	        		 {

	             if (rs.next())
	            
	            	 return rs.getInt(1);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return 0;
	}
	
	public List<CommentPojo> getAllComments() {
	    List<CommentPojo> list = new ArrayList<>();
	    try {
	        String sql = "SELECT * FROM comments ORDER BY created_at DESC";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            CommentPojo c = new CommentPojo();
	            c.setId(rs.getInt("id"));
	            c.setBlog_id(rs.getInt("blog_id"));
	            c.setUser_id(rs.getInt("user_id"));
	            c.setComment(rs.getString("comment"));
	            c.setCreated_at(rs.getTimestamp("created_at"));
	            list.add(c);
	        }
	    } catch (Exception e) { e.printStackTrace(); }

	    return list;
	}

	public boolean deleteCommentByAdmin(int id) {
	    try {
	        String sql = "DELETE FROM comments WHERE id=?";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, id);
	        return ps.executeUpdate() > 0;
	    } catch (Exception e) { e.printStackTrace(); }
	    return false;
	}

}
