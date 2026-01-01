package daoimpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import dao.userDao;
import pojo.user;

public class userDaoImpl implements userDao {

	Connection con=null;
	
	public userDaoImpl() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blogingproject?user=root&password=root");
		} 
		catch (Exception e) 
		{
			System.out.println("Error in loading drivers or making connection");
		}
	}
	@Override
	public user checkUser(user u) {
		 user u2 = null;
		try {
			
        PreparedStatement ps = con.prepareStatement("select * from users where username=? and password=?");
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());


            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
    		    u2 = new user();   
                u2.setId(rs.getInt("id"));  

                u2.setUsername(rs.getString("username"));
                u2.setPassword(rs.getString("password"));
                u2.setEmail(rs.getString("email"));
                u2.setContact(rs.getString("contact"));
                u2.setRole(rs.getString("role"));
                u2.setDp(rs.getString("dp"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
		return u2;
	}

	@Override
	public boolean registerUser(user u) {
		try {
      PreparedStatement ps = con.prepareStatement("insert into users(username, password, email, role, contact, dp) values (?,?,?,?,?,?)");

      ps.setString(1, u.getUsername());
      ps.setString(2, u.getPassword());
      ps.setString(3, u.getEmail());
      ps.setString(4, "USER");
      ps.setString(5, u.getContact());
      ps.setString(6, u.getDp());
		int x = ps.executeUpdate();

			if(x>0)
				return true;
			else
				return false;
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
    }
	
    // FETCH USER BY USERNAME (for edit profile)
    @Override
    public user getUser(String username) {
        user u = null;

        try {
            PreparedStatement ps =
                con.prepareStatement("SELECT * FROM users WHERE username=?");
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                u = new user();
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setContact(rs.getString("contact"));
                u.setDp(rs.getString("dp"));
                u.setRole(rs.getString("role"));
                u.setPassword(rs.getString("password"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return u;
    }

    // UPDATE USER PROFILE
    @Override
    public boolean updateUser(user u) {
        try {
            PreparedStatement ps =
                con.prepareStatement(
                    "UPDATE users SET email=?, contact=?, dp=? WHERE username=?"
                );

            ps.setString(1, u.getEmail());
            ps.setString(2, u.getContact());
            ps.setString(3, u.getDp());
            ps.setString(4, u.getUsername());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
    
    public user searchUser(int id)
    {
    	System.out.println("Id = "+id);
    	user u = null;

        try {
            PreparedStatement ps =
                con.prepareStatement("SELECT * FROM users WHERE = ?");
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                u = new user();
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setContact(rs.getString("contact"));
                u.setDp(rs.getString("dp"));
                u.setRole(rs.getString("role"));
                u.setPassword(rs.getString("password"));
            }
            

        } catch (Exception e) {
            e.printStackTrace();
        }

        return u;
    	
    }
    //admin 
    
    public List<user> getAllUsers() {
        List<user> list = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                user u = new user();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));
                u.setContact(rs.getString("contact"));
                u.setDp(rs.getString("dp"));
                u.setStatus(rs.getString("status"));
                list.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    
    public boolean updateStatus(int userId, String status) {
        boolean f = false;
        try {
            PreparedStatement ps = con.prepareStatement(
                "UPDATE users SET status=? WHERE id=?"
            );
            ps.setString(1, status);
            ps.setInt(2, userId);

            f = ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    
    public boolean deleteUser(int userId) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM users WHERE id=?"
            );
            ps.setInt(1, userId);

            int x = ps.executeUpdate();
            if (x>0) {
                return true;

			} else {
		        return false;

			}

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean deleteUserAndDependencies(int userId) {
        boolean status = false;

        try {
            con.setAutoCommit(false);

            // 1. Delete likes made by user
            PreparedStatement ps1 = con.prepareStatement("DELETE FROM likes WHERE user_id = ?");
            ps1.setInt(1, userId);
            ps1.executeUpdate();

            // 2. Delete comments made by user
            PreparedStatement ps2 = con.prepareStatement("DELETE FROM comments WHERE user_id = ?");
            ps2.setInt(1, userId);
            ps2.executeUpdate();

            // 3. Get blog ids of the user
            PreparedStatement ps3 = con.prepareStatement("SELECT id FROM blogs WHERE user_id = ?");
            ps3.setInt(1, userId);
            ResultSet rs = ps3.executeQuery();

            while (rs.next()) {
                int blogId = rs.getInt("id");

                // 4. Delete likes on user's blogs
                PreparedStatement ps4 = con.prepareStatement("DELETE FROM likes WHERE blog_id = ?");
                ps4.setInt(1, blogId);
                ps4.executeUpdate();

                // 5. Delete comments on user's blogs
                PreparedStatement ps5 = con.prepareStatement("DELETE FROM comments WHERE blog_id = ?");
                ps5.setInt(1, blogId);
                ps5.executeUpdate();
            }

            // 6. Delete blogs of the user
            PreparedStatement ps6 = con.prepareStatement("DELETE FROM blogs WHERE user_id = ?");
            ps6.setInt(1, userId);
            ps6.executeUpdate();

            // 7. Delete the user
            PreparedStatement ps7 = con.prepareStatement("DELETE FROM users WHERE id = ?");
            ps7.setInt(1, userId);
            ps7.executeUpdate();

            con.commit();
            status = true;

        } catch (Exception e) {
            try { con.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
        }
        return status;
    }

    //admin dashboard
    
    public int getTotalUsers() {
        try {
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM users");
             ResultSet rs = ps.executeQuery();
             

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
        	e.printStackTrace(); 
        	}
        return 0;
    }
    

    public int getActiveUsers() {
        try 
        {
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM users WHERE status='ACTIVE'");
             ResultSet rs = ps.executeQuery();
             

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    

    public int getBlockedUsers() {
        try {
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM users WHERE status='BLOCKED'");
             ResultSet rs = ps.executeQuery();

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
        	e.printStackTrace(); 
        	}
        return 0;
    }


	}
