package com.bbs.main.mapper;

import com.bbs.main.vo.FreeVO;
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

    @Select("select * from Life_Post_DB order by post_id desc")
    List<LifeVO> getposts();

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
    List<LifeVO> getSortsLike();  // 좋아요순

    @Select("SELECT * FROM Life_Post_DB ORDER BY post_view DESC")
    List<LifeVO> getSortsView();  // 조회순

    @Update("update Life_Post_DB set post_like = post_like + 1 where post_id = #{post_id}")
    int getCountLike(int no);

    @Select("select * from Life_post_DB where post_id = #{post_id}")
    LifeVO detailPost(int post_id);

    @Update("UPDATE LIFE_POST_DB " +
            "SET post_category = #{post_category}, post_menu = #{post_menu}, post_title = #{post_title}, " +
            "post_context = #{post_context}, post_image = #{post_image, jdbcType=NULL}" +
            "WHERE post_id = #{post_id}")
    int updatePost(LifeVO lifeVO);
}
