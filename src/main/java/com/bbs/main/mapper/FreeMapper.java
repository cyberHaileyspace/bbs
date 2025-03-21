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

    @Select("select * from Free_post_DB order by post_id desc")
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

}
