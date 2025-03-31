package com.bbs.main.mapper;

import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.LifeVO;
import com.bbs.main.vo.ToiletReplyVO;
import com.bbs.main.vo.ToiletVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ToiletMapper {

    @Insert("INSERT INTO TOILET_POST_DB " +
            "(user_nickname, post_category, post_menu, post_title, post_context, post_image, " +
            "post_lat, post_lng, post_address) " +
            "VALUES (" +
            "#{user_nickname}, #{post_category}, #{post_menu}, #{post_title}, #{post_context}, " +
            "#{post_image, jdbcType=NULL}, " +
            "#{post_lat, jdbcType=DOUBLE}, #{post_lng, jdbcType=DOUBLE}, #{post_address, jdbcType=VARCHAR})")
    int addPost(ToiletVO freeVO);



    @Select("SELECT f.*, (SELECT COUNT(*) FROM TOILET_REPLY r WHERE r.post_id = f.post_id) AS reply_count FROM TOILET_POST_DB f ORDER BY f.post_id DESC")
    List<ToiletVO> getposts();

    @Select("select * from TOILET_POST_DB where post_id = #{post_id}")
    ToiletVO detailPost(int post_id);

    @Delete("delete TOILET_POST_DB where post_id = #{post_id}")
    int deletePost(int post_id);

    @Update("UPDATE TOILET_POST_DB " +
            "SET post_category = #{post_category}, " +
            "post_menu = #{post_menu}, " +
            "post_title = #{post_title}, " +
            "post_context = #{post_context}, " +
            "post_image = #{post_image, jdbcType=NULL}, " +
            "post_lat = #{post_lat, jdbcType=DOUBLE}, " +
            "post_lng = #{post_lng, jdbcType=DOUBLE}, " +
            "post_address = #{post_address, jdbcType=VARCHAR} " +
            "WHERE post_id = #{post_id}")
    int updatePost(ToiletVO freeVO);


    @Select("SELECT r_id, post_id, r_writer, r_context, r_like, " +
            "TO_CHAR(r_date, 'YYYY.MM.DD HH24:MI') AS r_date, " +
            "TO_CHAR(r_update, 'YYYY.MM.DD HH24:MI') AS r_update " +
            "FROM TOILET_REPLY " +
            "WHERE post_id = #{post_id} " +
            "ORDER BY r_id DESC")
    List<FreeReplyVO> getReplys(int post_id);

    @Insert("INSERT INTO TOILET_REPLY (post_id, r_writer, r_context) " +
            "VALUES (#{post_id}, #{r_writer}, #{r_context})")
    int addReply(ToiletReplyVO freeReplyVO);

    @Update("UPDATE TOILET_REPLY set r_context = #{r_context} where r_id = #{r_id}")
    int updateReply(ToiletReplyVO freeReplyVO);

    @Delete("DELETE TOILET_REPLY WHERE R_ID = #{r_id}")
    int deleteReply(int r_id);

    @Select("SELECT * FROM TOILET_POST_DB ORDER BY post_id DESC")
    List<ToiletVO> getSortsNew();

    @Select("SELECT * FROM TOILET_POST_DB ORDER BY post_like DESC")
    List<ToiletVO> getSortsLike();

    @Select("SELECT * FROM TOILET_POST_DB ORDER BY post_view DESC")
    List<ToiletVO> getSortsView();

    @Select("SELECT f.*, (SELECT COUNT(*) FROM TOILET_REPLY r WHERE r.post_id = f.post_id) AS reply_count " +
            "FROM TOILET_POST_DB f ORDER BY reply_count DESC")
    List<ToiletVO> getSortsReply();

    @Select("select f.*, (SELECT COUNT(*) FROM TOILET_REPLY r WHERE r.post_id = f.post_id) AS reply_count FROM TOILET_POST_DB f where post_title like '%'||#{title}||'%' order by post_id desc")
    List<ToiletVO> searchposts(String title);

    @Select("SELECT r_id, post_id, r_writer, r_context, r_like, " +
            "TO_CHAR(r_date, 'YYYY.MM.DD HH24:MI') AS r_date, " +
            "TO_CHAR(r_update, 'YYYY.MM.DD HH24:MI') AS r_update " +
            "FROM TOILET_REPLY " +
            "WHERE post_id = #{post_id} " +
            "ORDER BY r_id DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{size} ROWS ONLY")
    List<ToiletReplyVO> getPagedReplies(@Param("post_id") int post_id,
                                      @Param("offset") int offset,
                                      @Param("size") int size);

    @Select("SELECT COUNT(*) FROM TOILET_REPLY WHERE post_id = #{post_id}")
    int countByPostId(@Param("post_id") int post_id);

    @Update("update TOILET_POST_DB set post_view = post_view + 1 where post_id = #{post_id}")
    int getCount(int postId);

    @Select("SELECT r_id, post_id, r_writer, r_context, r_like, " +
            "TO_CHAR(r_date, 'YYYY.MM.DD HH24:MI') AS r_date, " +
            "TO_CHAR(r_update, 'YYYY.MM.DD HH24:MI') AS r_update " +
            "FROM TOILET_REPLY " +
            "WHERE post_id = #{post_id} " +
            "ORDER BY r_like DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{size} ROWS ONLY")
    List<ToiletReplyVO> getPagedRepliesSortedByLike(@Param("post_id") int postId,
                                                  @Param("offset") int offset,
                                                  @Param("size") int size);

    @Update("UPDATE TOILET_POST_DB SET post_like = post_like + 1 WHERE post_id = #{post_id}")
    void incrementLike(int post_id);

    @Update("UPDATE TOILET_POST_DB SET post_like = post_like - 1 WHERE post_id = #{post_id}")
    void updateUnlike(int post_id);

    @Select("SELECT post_like FROM TOILET_POST_DB WHERE post_id = #{post_id}")
    int getLikeCount(int post_id);

    @Select("SELECT COUNT(*) FROM toilet_post_like WHERE l_user_nickname = #{userNickname} AND l_post_id = #{postId}")
    int existsLike(@Param("userNickname") String userNickname, @Param("postId") int postId);

    @Delete("DELETE FROM toilet_post_like WHERE l_user_nickname = #{userNickname} AND l_post_id = #{postId}")
    void deleteLike(@Param("userNickname") String userId, @Param("postId") int postId);

    @Insert("INSERT INTO toilet_post_like (l_id, l_user_nickname, l_post_id) " +
            "VALUES (toilet_post_like_seq.nextval, #{userNickname}, #{postId})")
    void insertLike(@Param("userNickname") String userNickname, @Param("postId") int postId);

    @Update("UPDATE TOILET_REPLY SET r_like = r_like + 1 WHERE r_id = #{r_id}")
    void incrementReplyLike(int r_id);

    @Update("UPDATE TOILET_REPLY SET r_like = r_like - 1 WHERE r_id = #{r_id}")
    void updateReplyUnlike(int r_id);

    @Select("SELECT r_like FROM TOILET_REPLY WHERE r_id = #{r_id}")
    int getReplyLikeCount(int r_id);

    @Select("SELECT COUNT(*) FROM toilet_reply_like WHERE l_user_nickname = #{userNickname} AND l_reply_id = #{replyId}")
    int existsReplyLike(@Param("userNickname") String userNickname, @Param("replyId") int replyId);

    @Delete("DELETE FROM toilet_reply_like WHERE l_user_nickname = #{userNickname} AND l_reply_id = #{replyId}")
    void deleteReplyLike(@Param("userNickname") String userId, @Param("replyId") int replyId);

    @Insert("INSERT INTO toilet_reply_like (l_id, l_user_nickname, l_reply_id) " +
            "VALUES (toilet_reply_like_seq.nextval, #{userNickname}, #{replyId})")
    void insertReplyLike(@Param("userNickname") String userNickname, @Param("replyId") int replyId);

    @Select("SELECT * FROM TOILET_POST_DB ORDER BY post_date DESC")
    List<ToiletVO> getAll(String category);

    @Select("SELECT * FROM TOILET_POST_DB where post_category = 'office' ORDER BY post_date DESC")
    List<ToiletVO> getOffice(String category);

    @Select("SELECT * FROM TOILET_POST_DB where post_category = 'hospital' ORDER BY post_date DESC")
    List<ToiletVO> getHospital(String category);

    @Select("SELECT * FROM TOILET_POST_DB where post_category = 'toilet' ORDER BY post_date DESC")
    List<ToiletVO> getToilet(String category);

    @Select("SELECT * FROM TOILET_POST_DB where post_category = 'etc' ORDER BY post_date DESC")
    List<ToiletVO> getETC(String category);
}
