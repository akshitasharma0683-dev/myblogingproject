package daoimpl;

import dao.blogdao;
import pojo.BlogPojo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDaoImpl implements blogdao {

    private Connection conn;

    // -------------------- Constructor --------------------
    public BlogDaoImpl() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/blogingproject",
                    "root",
                    "root"
            );

            System.out.println("DB Connected Successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // -------------------- Add Blog --------------------
    @Override
    public int addBlog(BlogPojo blog) {

        String query =
                "INSERT INTO blogs(id, user_id, title, category, content, image, created_at, updated_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            
            ps.setInt(1, blog.getId());
            ps.setInt(2, blog.getUserId());
            ps.setString(3, blog.getTitle());
            ps.setString(4, blog.getCategory());
            ps.setString(5, blog.getContent());
            ps.setString(6, blog.getImage());  // ⭐ store image filename
            ps.setTimestamp(7, blog.getCreatedAt());
            ps.setTimestamp(8, blog.getUpdatedAt());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);  // return new blog id
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    // -------------------- Update Blog --------------------
    @Override
    public boolean updateBlog(BlogPojo blog) {
        String sql = "UPDATE blogs SET title=?, category=?, content=?, image=?, updated_at=? WHERE id=? AND user_id=?";
        
        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getCategory());
            ps.setString(3, blog.getContent());
            ps.setString(4, blog.getImage());  // optional: can be null
            ps.setTimestamp(5, blog.getUpdatedAt());
            ps.setInt(6, blog.getId());
            ps.setInt(7, blog.getUserId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    
    @Override
    public String getUsernameById(int userId) {
        String sql = "SELECT username FROM users WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("username");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }



    // -------------------- Delete Blog --------------------
    @Override
    public boolean deleteBlog(int blogId, int userId) {
        String sql = "DELETE FROM blogs WHERE id=? AND user_id=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, blogId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // -------------------- GET ALL BLOGS --------------------
    @Override
    public List<BlogPojo> getAllBlogs() {
        List<BlogPojo> list = new ArrayList<>();
        String sql = "SELECT * FROM blogs";

        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                BlogPojo blog = new BlogPojo();

                blog.setId(rs.getInt("id"));
                blog.setUserId(rs.getInt("user_id"));
                blog.setTitle(rs.getString("title"));
                blog.setCategory(rs.getString("category"));
                blog.setContent(rs.getString("content"));
                blog.setImage(rs.getString("image"));   // ⭐ image filename
                blog.setCreatedAt(rs.getTimestamp("created_at"));
                blog.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(blog);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public List<BlogPojo> getBlogsByUserId(int userId) {
        List<BlogPojo> list = new ArrayList<>();
        String sql = "SELECT * FROM blogs WHERE user_id = ?";
try {
             PreparedStatement ps = conn.prepareStatement(sql); {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BlogPojo blog = new BlogPojo();
                blog.setId(rs.getInt("id"));
                blog.setUserId(rs.getInt("user_id"));
                blog.setTitle(rs.getString("title"));
                blog.setCategory(rs.getString("category"));
                blog.setContent(rs.getString("content"));
                blog.setImage(rs.getString("image"));
                blog.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(blog);
            }
        }
}catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }



    @Override
    public List<BlogPojo> getBlogsByUser(int userId) {
        List<BlogPojo> list = new ArrayList<>();
        String sql = "SELECT * FROM blogs WHERE user_id=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BlogPojo blog = new BlogPojo();

                blog.setId(rs.getInt("id"));
                blog.setUserId(rs.getInt("user_id"));
                blog.setTitle(rs.getString("title"));
                blog.setCategory(rs.getString("category"));
                blog.setContent(rs.getString("content"));
                blog.setImage(rs.getString("image"));
                blog.setCreatedAt(rs.getTimestamp("created_at"));
                blog.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(blog);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean deleteBlog(int id) {
        String sql = "DELETE FROM blogs WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

	@Override
	public BlogPojo getBlogById(int blogId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public int getTotalBlogs() {
	    try {
	         PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM blogs");
	         ResultSet rs = ps.executeQuery();
	         

	        if (rs.next()) return rs.getInt(1);

	    } catch (Exception e) {
	    	
	    	e.printStackTrace(); 
	    
	    }
	    return 0;
	}


}
