package com.bbs.main.mapper;

import com.bbs.main.vo.TourVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface TourMapper {

    @Select("SELECT * FROM tour_table") // 여기에 실제 테이블명 적어야 함
    List<TourVO> getTourList();
}
