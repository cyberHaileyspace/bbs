package com.bbs.main.mapper;

import com.bbs.main.vo.RegisterVO;
import org.apache.ibatis.annotations.*;

import java.util.Map;

@Mapper
public interface RegisterMapper {

    @Insert("insert into User_DB" +
            "(user_id, user_pw, user_name, user_nickname, user_email, user_gender, user_image, user_date)" +
            "VALUES" +
            "(#{user_id}, #{user_pw}, #{user_name}, #{user_nickname}, #{user_email}, #{user_gender}, #{user_image}, sysdate)")
    void regUser(RegisterVO registerVO);

    @Select("select * from User_DB where user_id = #{user_id} and user_pw = #{user_pw}")
    Map<String, Object> login(@Param("user_id") String user_id, @Param("user_pw") String user_pw);

    @Update("update User_DB set user_pw = #{user_pw} where user_id = #{user_id}")
    void pwreset(RegisterVO registerVO);
}
