package com.bbs.main.mapper;

import com.bbs.main.vo.RegisterVO;
import org.apache.ibatis.annotations.*;

import java.util.Map;

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
}
