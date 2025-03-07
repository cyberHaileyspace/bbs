package com.bbs.main.mapper;

import com.bbs.main.vo.FreeVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface FreeMapper {

    @Select("select * from Free_post_DB order by post_id desc")
    List<FreeVO> getposts();

    @Select("select * from Free_post_DB where post_id = #{no}")
    FreeVO detailPost(int no);

    @Delete("delete Free_post_DB where post_id = #{delPk}")
    int deletePost(int delPk);
}
