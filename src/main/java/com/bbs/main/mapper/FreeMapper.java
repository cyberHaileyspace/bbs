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

    @Select("select * FROM Free_Comment where post_id = #{post_id} order by c_id desc")
    List<FreeReplyVO> getReplys(int post_id);

    @Insert("insert into Free_Comment" +
            "(c_context)" +
            "values" +
            "(#{c_context})")
    int addReply(FreeReplyVO freeReplyVO);


}
