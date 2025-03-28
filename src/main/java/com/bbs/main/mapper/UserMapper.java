package com.bbs.main.mapper;

import com.bbs.main.vo.*;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UserMapper {

    @Insert("insert into User_DB" +
            "(user_id, user_pw, user_name, user_nickname, user_email, user_gender, user_image)" +
            "values" +
            "(#{user_id}, #{user_pw}, #{user_name}, #{user_nickname}, #{user_email}, #{user_gender}, #{user_image, jdbcType=NULL})")
    int regUser(UserVO registerVO);

    @Select("select * from User_DB where user_id = #{user_id}")
    UserVO login(UserVO registerVO);

    @Update("update User_DB set user_pw = #{user_pw} where user_id = #{user_id}")
    int pwreset(UserVO registerVO);

    @Select("select count(*) from User_DB where user_id = #{userId}")
    int idcheck(@Param("userId") String userId);

    @Select("select count(*) from User_DB where user_nickname = #{userNick}")
    int nickcheck(@Param("userNick") String userNick);

    @Select("select count(*) from User_DB where user_email = #{userEmail}")
    int emailcheck(@Param("userEmail") String userEmail);

    @Update("update User_DB set user_name = #{user_name}, user_nickname = #{user_nickname}, user_email = #{user_email} where user_id = #{user_id}")
    int updateUser(UserVO userVO);

    @Select("select * from free_post_db where user_nickname = #{user_id} order by post_id desc")
    List<FreeVO> getMyFreePosts(String user_id);

    @Select("select * from life_post_db where user_nickname = #{user_id} order by post_id desc")
    List<LifeVO> getMyLifePosts(String user_id);

    @Select("select * from tour_post_db where user_nickname = #{user_id} order by post_id desc")
    List<LifeVO> getMyTourPosts(String user_id);

    @Select("select r_id, post_id, r_context, r_like, " +
            "to_char(r_date, 'YYYY.MM.DD HH24:MI') as r_date, " +
            "to_char(r_update, 'YYYY.MM.DD HH24:MI') as r_update " +
            "from Free_Reply " +
            "where r_writer = #{user_nickname} " +
            "order by r_id DESC")
    List<FreeReplyVO> getMyFreePostReplies(String user_nickname);

    @Select("select r_id, post_id, r_context, r_like, " +
            "to_char(r_date, 'YYYY.MM.DD HH24:MI') AS r_date, " +
            "to_char(r_update, 'YYYY.MM.DD HH24:MI') AS r_update " +
            "from Life_Reply " +
            "where r_writer = #{user_nickname} " +
            "order by r_id DESC")
    List<LifeReplyVO> getMyLifePostReplies(String user_nickname);

    @Select("select r_id, post_id, r_context, r_like, " +
            "to_char(r_date, 'YYYY.MM.DD HH24:MI') AS r_date, " +
            "to_char(r_update, 'YYYY.MM.DD HH24:MI') AS r_update " +
            "from Tour_Board_Reply " +
            "where r_writer = #{user_nickname} " +
            "order by r_id DESC")
    List<LifeReplyVO> getMyTourPostReplies(String user_nickname);

    @Select("SELECT * FROM User_DB WHERE user_id = #{user_id}")
    UserVO getUserById(String user_id);

    @Update("UPDATE User_DB SET user_image = #{user_image, jdbcType=NULL} WHERE user_id = #{user_id}")
    int updatepfp(UserVO user);

    @Update("UPDATE User_DB SET user_image = NULL WHERE user_id = #{user_id}")
    int deletepfp(UserVO user);

}