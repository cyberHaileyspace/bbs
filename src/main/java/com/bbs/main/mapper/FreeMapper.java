package com.bbs.main.mapper;

import com.bbs.main.vo.FreeVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface FreeMapper {

    @Select("select * from Free_posts")
    List<FreeVO> getposts();

    @Select("select * from Free_posts where p_no = #{no}")
    FreeVO detailPost(int no);

    @Delete("delete Free_posts where p_no = #{delPk}")
    int deletePost(int delPk);
}
