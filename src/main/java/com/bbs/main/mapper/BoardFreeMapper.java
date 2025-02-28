package com.bbs.main.mapper;

import com.bbs.main.vo.PostFreeVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface BoardFreeMapper {

    @Select("select * from Free_posts")
    List<PostFreeVO> getposts();
}
