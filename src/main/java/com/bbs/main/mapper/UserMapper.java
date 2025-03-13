package com.bbs.main.mapper;

import com.bbs.main.vo.*;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UserMapper {

    @Insert("insert into User_DB" +
            "(user_id, user_pw, user_name, user_nickname, user_email, user_gender, user_image)" +
            "VALUES" +
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
    int updateUser(UserVO registerVO);

    @Select("select * from free_post_db where user_nickname = #{user_id} order by post_id desc")
    List<FreeVO> getMyFreePosts(String user_id);

    @Select("select * from life_post_db where user_nickname = #{user_id} order by post_id desc")
    List<LifeVO> getMyLifePosts(String user_id);

    @Select("select * from free_reply where r_writer = #{user_nickname}")
    List<FreeReplyVO> getMyFreePostReplies(String user_nickname);

    @Select("select * from free_reply where r_writer = #{user_nickname}")
    List<LifeReplyVO> getMyLifePostReplies(String user_nickname);
}
