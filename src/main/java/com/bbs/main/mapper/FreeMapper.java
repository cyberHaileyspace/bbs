package com.bbs.main.mapper;

import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.FreeVO;
import com.bbs.main.vo.LifeVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface FreeMapper {


    @Insert("insert into FREE_POST_DB" +
            "(user_nickname, post_category, post_menu, post_title, post_context, post_image)" +
            "VALUES" +
            "(#{user_nickname}, #{post_category}, #{post_menu}, #{post_title}, #{post_context}, #{post_image, jdbcType=NULL})")
    int addPost(FreeVO freeVO);

    @Select("SELECT f.*, " +
            "(SELECT COUNT(*) FROM Free_Reply r WHERE r.post_id = f.post_id) AS comment_count " +
            "FROM Free_post_DB f " +
            "ORDER BY f.post_id DESC")
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

    @Update("UPDATE Free_POST_DB SET post_like = post_like + 1 WHERE post_id = #{post_id}")
    void incrementLike(int post_id);

    @Select("SELECT post_like FROM Free_POST_DB WHERE post_id = #{post_id}")
    int getLikeCount(int post_id);


    @Select("SELECT * FROM Free_POST_DB ORDER BY post_id DESC")
    List<FreeVO> getSortsNew();  // 최신순

    @Select("SELECT * FROM Free_POST_DB ORDER BY post_like DESC")
    List<FreeVO> getSortsLike();  // 추천순

    @Select("SELECT * FROM Free_POST_DB ORDER BY post_view DESC")
    List<FreeVO> getSortsView();  // 조회순

    @Select("select * from Free_POST_DB where post_title like '%'||#{title}||'%' order by post_id desc")
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

    @Update("UPDATE Free_Reply SET r_like = r_like + 1 WHERE r_id = #{r_id}")
    void incrementReplyLike(int r_id);

    @Select("SELECT r_like FROM Free_Reply WHERE r_id = #{r_id}")
    int getReplyLikeCount(int r_id);

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

}
