package dao;
import java.util.*;

import pojo.user;

public interface userDao {

    public user checkUser(user u);

    public boolean registerUser(user u);

	boolean updateUser(user u);

	user getUser(String username);
	
	// for admin management 
	List<user> getAllUsers();
	boolean deleteUser(int userId);
	boolean updateStatus(int userId, String status);
     boolean deleteUserAndDependencies(int userId);
}