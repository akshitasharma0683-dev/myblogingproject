package dao;

import pojo.LikePojo;

public interface LikeDao {

    boolean addLike(LikePojo obj);      // insert like
    boolean removeLike(int blogId, int userId); // remove like
    boolean isLiked(int blogId, int userId);    // check if liked already
    int countLikes(int blogId);                // total likes
}
