package com.bbs.main.mapper;

import com.bbs.main.vo.RegisterVO;
import org.apache.ibatis.annotations.*;

@Mapper
public interface RegisterMapper {

    @Insert("insert into User_DB" +
            "(user_id, user_pw, user_name, user_nickname, user_email, user_gender, user_image)" +
            "VALUES" +
            "(#{user_id}, #{user_pw}, #{user_name}, #{user_nickname}, #{user_email}, #{user_gender}, #{user_image})")
    int regUser(RegisterVO registerVO);

    @Select("select * from User_DB where user_id = #{user_id}")
    RegisterVO login(RegisterVO registerVO);

    @Update("update User_DB set user_pw = #{user_pw} where user_id = #{user_id}")
    int pwreset(RegisterVO registerVO);

    @Select("select count(*) from User_DB where user_id = #{userId}")
    int idcheck(@Param("userId") String userId);

    @Select("select count(*) from User_DB where user_nickname = #{userNick}")
    int nickcheck(@Param("userNick") String userNick);

    @Select("select count(*) from User_DB where user_email = #{userEmail}")
    int emailcheck(@Param("userEmail") String userEmail);
}
