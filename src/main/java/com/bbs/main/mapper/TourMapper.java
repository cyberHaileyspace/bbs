package com.bbs.main.mapper;

import com.bbs.main.vo.TourVO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import java.util.List;

@Mapper
public interface TourMapper {

    // 지역(예: spot_name에 지역명이 포함된 경우) 기반 DB 조회
    @Select("""
        SELECT spot_id,
               spot_name,
               spot_address,
               spot_desc,
               spot_contact,
               spot_closed,
               spot_hours,
               spot_image,
               created_at
          FROM Tourist_Spot_DB
         WHERE spot_name LIKE '%' || #{region} || '%'
    """)
    List<TourVO> getTourDataByRegion(@Param("region") String region);

    // API로 받아온 데이터를 DB에 저장 (spot_id, created_at은 DB에서 자동 처리)
    @Insert("""
        INSERT INTO Tourist_Spot_DB 
            (spot_name, spot_address, spot_desc, spot_contact, spot_closed, spot_hours, spot_image)
        VALUES 
            (#{spot_name}, #{spot_address}, #{spot_desc}, #{spot_contact}, #{spot_closed}, #{spot_hours}, #{spot_image})
    """)
    int insertTourData(TourVO vo);
}
