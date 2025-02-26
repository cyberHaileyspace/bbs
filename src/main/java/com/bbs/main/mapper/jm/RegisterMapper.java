package com.bbs.main.mapper.jm;
import com.bbs.main.vo.jm.RegisterVO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RegisterMapper {

    @Insert("INSERT INTO User_DB (user_id, user_pw, user_name, user_nickname, user_email, user_gender, user_image)" +
            "VALUES ('user2', 'password123', 'Taro', 'taro_nick2', 'taro2@email.com', 'male', 'profile_image.png')")
    void addUser(RegisterVO registerVO);
}
