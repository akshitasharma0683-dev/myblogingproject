package dao;

import java.util.List;
import pojo.*;

public interface blogdao {

    int addBlog(BlogPojo blog);                    // insert a blog and return generated blogId

    boolean updateBlog(BlogPojo blog);             // update existing blog

    boolean deleteBlog(int blogId, int userId);    // delete blog only if user is owner

    BlogPojo getBlogById(int blogId);              // get 1 blog

    List<BlogPojo> getAllBlogs();                  // get all blogs for home page

    List<BlogPojo> getBlogsByUser(int userId);     // get blogs posted by a specific user

	String getUsernameById(int userId);

	List<BlogPojo> getBlogsByUserId(int userId);
}
