package com.bbs.main.mapper;

import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.FreeVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface FreeMapper {

    @Insert("insert into FREE_POST_DB" +
            "(user_nickname, post_category, post_menu, post_title, post_context, post_image)" +
            "VALUES" +
            "(#{user_nickname}, #{post_category}, #{post_menu}, #{post_title}, #{post_context}, #{post_image, jdbcType=NULL})")
    int addPost(FreeVO freeVO);

    @Select("SELECT f.*, (SELECT COUNT(*) FROM Free_Reply r WHERE r.post_id = f.post_id) AS reply_count FROM Free_post_DB f ORDER BY f.post_id DESC")
    List<FreeVO> getposts();

    @Select("select * from Free_post_DB where post_id = #{post_id}")
    FreeVO detailPost(int post_id);

    @Delete("delete Free_post_DB where post_id = #{post_id}")
    int deletePost(int post_id);

    @Update("UPDATE FREE_POST_DB " +
            "SET post_category = #{post_category}, post_menu = #{post_menu}, post_title = #{post_title}, " +
            "post_context = #{post_context}, post_image = #{post_image, jdbcType=NULL}" +
            "WHERE post_id = #{post_id}")
    int updatePost(FreeVO freeVO);

    @Select("SELECT r_id, post_id, r_writer, r_context, r_like, " +
            "TO_CHAR(r_date, 'YYYY.MM.DD HH24:MI') AS r_date, " +
            "TO_CHAR(r_update, 'YYYY.MM.DD HH24:MI') AS r_update " +
            "FROM Free_Reply " +
            "WHERE post_id = #{post_id} " +
            "ORDER BY r_id DESC")
    List<FreeReplyVO> getReplys(int post_id);

    @Insert("INSERT INTO Free_Reply (post_id, r_writer, r_context) " +
            "VALUES (#{post_id}, #{r_writer}, #{r_context})")
    int addReply(FreeReplyVO freeReplyVO);


    @Update("UPDATE Free_Reply set r_context = #{r_context} where r_id = #{r_id}")
    int updateReply(FreeReplyVO freeReplyVO);

    @Delete("DELETE FREE_REPLY WHERE R_ID = #{r_id}")
    int deleteReply(int r_id);

    @Select("SELECT * FROM Free_POST_DB ORDER BY post_id DESC")
    List<FreeVO> getSortsNew();  // 최신순

    @Select("SELECT * FROM Free_POST_DB ORDER BY post_like DESC")
    List<FreeVO> getSortsLike();  // 추천순

    @Select("SELECT * FROM Free_POST_DB ORDER BY post_view DESC")
    List<FreeVO> getSortsView();  // 조회순

    @Select("SELECT f.*, (SELECT COUNT(*) FROM Free_Reply r WHERE r.post_id = f.post_id) AS reply_count " +
            "FROM Free_post_DB f ORDER BY reply_count DESC")
    List<FreeVO> getSortsReply(); // 댓글순

    @Select("select f.*, (SELECT COUNT(*) FROM Free_Reply r WHERE r.post_id = f.post_id) AS reply_count FROM Free_post_DB f where post_title like '%'||#{title}||'%' order by post_id desc")
    List<FreeVO> searchposts(String title);

    @Select("SELECT r_id, post_id, r_writer, r_context, r_like, " +
            "TO_CHAR(r_date, 'YYYY.MM.DD HH24:MI') AS r_date, " +
            "TO_CHAR(r_update, 'YYYY.MM.DD HH24:MI') AS r_update " +
            "FROM Free_Reply " +
            "WHERE post_id = #{post_id} " +
            "ORDER BY r_id DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{size} ROWS ONLY")
    List<FreeReplyVO> getPagedReplies(@Param("post_id") int post_id,
                                      @Param("offset") int offset,
                                      @Param("size") int size);

    @Select("SELECT COUNT(*) FROM Free_Reply WHERE post_id = #{post_id}")
    int countByPostId(@Param("post_id") int post_id);

    @Update("update Free_POST_DB set post_view = post_view + 1 where post_id = #{post_id}")
    int getCount(int postId);

    @Select("SELECT r_id, post_id, r_writer, r_context, r_like, " +
            "TO_CHAR(r_date, 'YYYY.MM.DD HH24:MI') AS r_date, " +
            "TO_CHAR(r_update, 'YYYY.MM.DD HH24:MI') AS r_update " +
            "FROM Free_Reply " +
            "WHERE post_id = #{post_id} " +
            "ORDER BY r_like DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{size} ROWS ONLY")

    List<FreeReplyVO> getPagedRepliesSortedByLike(@Param("post_id") int postId,
                                                  @Param("offset") int offset,
                                                  @Param("size") int size);

    // 게시글 추천수 관리

    @Update("UPDATE Free_POST_DB SET post_like = post_like + 1 WHERE post_id = #{post_id}")
    void incrementLike(int post_id);

    @Update("UPDATE Free_POST_DB SET post_like = post_like - 1 WHERE post_id = #{post_id}")
    void updateUnlike(int post_id);

    @Select("SELECT post_like FROM Free_POST_DB WHERE post_id = #{post_id}")
    int getLikeCount(int post_id);

    @Select("SELECT COUNT(*) FROM free_post_like WHERE l_user_nickname = #{userNickname} AND l_post_id = #{postId}")
    int existsLike(@Param("userNickname") String userNickname, @Param("postId") int postId);

    @Delete("DELETE FROM free_post_like WHERE l_user_nickname = #{userNickname} AND l_post_id = #{postId}")
    void deleteLike(@Param("userNickname") String userId, @Param("postId") int postId);

    @Insert("INSERT INTO free_post_like (l_id, l_user_nickname, l_post_id) " +
            "VALUES (free_post_like_seq.nextval, #{userNickname}, #{postId})")
    void insertLike(@Param("userNickname") String userNickname, @Param("postId") int postId);

    // 댓글 추천수 관리

    @Update("UPDATE Free_Reply SET r_like = r_like + 1 WHERE r_id = #{r_id}")
    void incrementReplyLike(int r_id);

    @Update("UPDATE Free_Reply SET r_like = r_like - 1 WHERE r_id = #{r_id}")
    void updateReplyUnlike(int r_id);

    @Select("SELECT r_like FROM Free_Reply WHERE r_id = #{r_id}")
    int getReplyLikeCount(int r_id);

    @Select("SELECT COUNT(*) FROM free_reply_like WHERE l_user_nickname = #{userNickname} AND l_reply_id = #{replyId}")
    int existsReplyLike(@Param("userNickname") String userNickname, @Param("replyId") int replyId);

    @Delete("DELETE FROM free_reply_like WHERE l_user_nickname = #{userNickname} AND l_reply_id = #{replyId}")
    void deleteReplyLike(@Param("userNickname") String userId, @Param("replyId") int replyId);

    @Insert("INSERT INTO free_reply_like (l_id, l_user_nickname, l_reply_id) " +
            "VALUES (free_reply_like_seq.nextval, #{userNickname}, #{replyId})")
    void insertReplyLike(@Param("userNickname") String userNickname, @Param("replyId") int replyId);
}