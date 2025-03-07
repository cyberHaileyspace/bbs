package com.bbs.main.mapper;

import com.bbs.main.vo.LifeWriteVO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface LifeWriteMapper {

    @Insert("insert into LIFE_POST_DB" +
            "(user_nickname, post_category, post_menu, post_title, post_context, post_image)" +
            "VALUES" +
            "(#{user_nickname}, #{post_category}, #{post_menu}, #{post_title}, #{post_context}, #{post_image, jdbcType=NULL})")
    int regWrite(LifeWriteVO lifeWriteVO);

    @Select("select * from Life_Post_DB order by post_id desc")
    List<LifeWriteVO> getLifeWrite();

    @Select("select * from Life_Post_DB where post_id = #{no}")
    LifeWriteVO getWrite(int no);
}
