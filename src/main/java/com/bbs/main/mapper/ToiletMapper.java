package com.bbs.main.mapper;

import com.bbs.main.vo.ToiletVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ToiletMapper {
    // 반환자료형
    // 결과 여러개 -> List
    // 하나의 결과 -> dto, vo, pojo, bean
    // 수정, 삭제, 생성 -> int or void
    List<ToiletVO> getProducts();

    int addProduct(ToiletVO toiletVO);

    int delProduct(int delPk);

    int upProduct(ToiletVO productVO);

    @Select("select * from product_test2 where p_no = #{no}")
    ToiletVO getProduct(int no);
}
