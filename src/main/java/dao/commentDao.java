package dao;


import java.util.List;

import pojo.CommentPojo;

public interface commentDao {
	int addComment(CommentPojo obj);
	public List<CommentPojo> getCommentsByBlogId(int blogId) ;
	boolean deleteComment(CommentPojo obj);
}
