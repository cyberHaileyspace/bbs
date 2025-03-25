package com.bbs.main.mapper;

import com.bbs.main.vo.LifeReplyVO;
import com.bbs.main.vo.LifeVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface LifeMapper {

    @Insert("insert into LIFE_POST_DB" +
            "(user_nickname, post_category, post_menu, post_title, post_context, post_image)" +
            "VALUES" +
            "(#{user_nickname}, #{post_category}, #{post_menu}, #{post_title}, #{post_context}, #{post_image, jdbcType=NULL})")
    int regPost(LifeVO lifeVO);

    @Select("select * from Life_post_DB order by post_id desc")
    List<LifeVO> getposts();

    @Select("select * from Life_Post_DB where post_title like '%'||#{title}||'%' order by post_id desc")
    List<LifeVO> searchposts(String title);

    @Select("select * from Life_Post_DB where post_id = #{no}")
    LifeVO getPost(int no);

    @Update("update Life_Post_DB set post_view = post_view + 1 where post_id = #{post_id}")
    int getCount(int no);

    @Delete("delete Life_Post_DB where post_id = #{no}")
    int deletePost(int no);

    /*@Update("update Life_Post_DB set post_category = #{post_category}, post_menu = #{post_menu}, post_title = #{post_title}, post_context = #{post_context}, post_image = #{post_image, jdbcType=NULL}, post_update = sysdate where post_id = #{post_id}")
    int updatePost(LifeVO lifeVO);*/

    @Select("SELECT * FROM Life_Post_DB ORDER BY post_id DESC")
    List<LifeVO> getSortsNew();  // 최신순

    @Select("SELECT * FROM Life_Post_DB ORDER BY post_like DESC")
    List<LifeVO> getSortsLike();  // 추천순

    @Select("SELECT * FROM Life_Post_DB ORDER BY post_view DESC")
    List<LifeVO> getSortsView();  // 조회순

    @Update("UPDATE Life_Post_DB SET post_like = post_like + 1 WHERE post_id = #{post_id}")
    void incrementLike(int post_id);

    @Select("SELECT post_like FROM Life_Post_DB WHERE post_id = #{post_id}")
    int getLikeCount(int post_id);

    @Select("select * from Life_post_DB where post_id = #{post_id}")
    LifeVO detailPost(int post_id);

    @Update("UPDATE LIFE_POST_DB " +
            "SET post_category = #{post_category}, post_menu = #{post_menu}, post_title = #{post_title}, " +
            "post_context = #{post_context}, post_image = #{post_image, jdbcType=NULL}" +
            "WHERE post_id = #{post_id}")
    int updatePost(LifeVO lifeVO);

    @Select("SELECT r_id, post_id, r_writer, r_context, r_like, " +
            "TO_CHAR(r_date, 'YYYY.MM.DD HH24:MI') AS r_date, " +
            "TO_CHAR(r_update, 'YYYY.MM.DD HH24:MI') AS r_update " +
            "FROM Life_Reply " +
            "WHERE post_id = #{post_id} " +
            "ORDER BY r_id DESC")
    List<LifeReplyVO> getReplys(int post_id);

    @Insert("INSERT INTO Life_Reply (post_id, r_writer, r_context) " +
            "VALUES (#{post_id}, #{r_writer}, #{r_context})")
    int addReply(LifeReplyVO lifeReplyVO);

    @Update("UPDATE Life_Reply set r_context = #{r_context} where r_id = #{r_id}")
    int updateReply(LifeReplyVO lifeReplyVO);

    @Delete("DELETE LIFE_REPLY WHERE R_ID = #{r_id}")
    int deleteReply(int r_id);

    @Select("SELECT * FROM Life_Post_DB ORDER BY post_date DESC")
    List<LifeVO> getAll(String category);

    @Select("SELECT * FROM Life_Post_DB where post_category = '生活情報' ORDER BY post_date DESC")
    List<LifeVO> getLife(String category);

    @Select("SELECT * FROM Life_Post_DB where post_category = '健康情報' ORDER BY post_date DESC")
    List<LifeVO> getHealth(String category);

    @Select("SELECT * FROM Life_Post_DB where post_category = '質問' ORDER BY post_date DESC")
    List<LifeVO> getQNA(String category);

    @Select("SELECT * FROM Life_Post_DB where post_category = 'レビュー' ORDER BY post_date DESC")
    List<LifeVO> getAft(String category);
}


