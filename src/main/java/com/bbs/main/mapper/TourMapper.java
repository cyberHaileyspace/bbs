package com.bbs.main.mapper;

import com.bbs.main.vo.LifeVO;
import com.bbs.main.vo.TourVO;
import com.bbs.main.vo.TourReplyVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface TourMapper {

    // 댓글 목록 조회
    @Select("SELECT * FROM tourlist_reply WHERE contentid = #{contentid} order by r_date desc")
    List<TourReplyVO> getComment(int contentid);
    // 댓글 삽입
    @Insert("INSERT INTO tourlist_reply(contentid, r_writer, r_context, r_date) VALUES(#{contentid}, #{r_writer}, #{r_context}, sysdate)")
    int insertComment(TourReplyVO comment);
    @Update("update tourlist_reply set r_context = #{r_context, jdbcType=VARCHAR} where r_id = #{r_id}")
    int updateReply(TourReplyVO tourReplyVO);
    // 댓글 삭제
    @Delete("DELETE FROM tourlist_reply WHERE r_id = #{r_id}")
    int deleteReply(int r_id);


    @Insert("insert into TOUR_POST_DB" +
            "(user_nickname, post_menu, post_title, post_context, post_image)" +
            "VALUES" +
            "(#{user_nickname}, #{post_menu}, #{post_title}, #{post_context}, #{post_image, jdbcType=NULL})")
    int addPost(TourVO tourVO);

    @Select("select * from TOUR_POST_DB order by post_id desc")
    List<TourVO> getposts();

    @Select("select * from TOUR_POST_DB where post_id = #{post_id}")
    TourVO detailPost(int post_id);

    @Delete("delete TOUR_POST_DB where post_id = #{post_id}")
    int deletePost(int post_id);

    @Update("UPDATE TOUR_POST_DB " +
            "SET post_menu = #{post_menu}, post_title = #{post_title}, " +
            "post_context = #{post_context}, post_image = #{post_image, jdbcType=NULL}" +
            "WHERE post_id = #{post_id}")
    int updatePost(TourVO tourVO);

    @Select("select * from Life_post_DB order by post_id desc")
    TourVO getpost(int post_id);

    @Update("update Tour_Post_DB set post_view = post_view + 1 where post_id = #{post_id}")
    int getCount(int postId);
}
