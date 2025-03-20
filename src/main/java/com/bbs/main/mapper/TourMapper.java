package com.bbs.main.mapper;

import com.bbs.main.vo.TourCommentVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface TourMapper {

    // 댓글 목록 조회
    @Select("SELECT * FROM tourlist_reply WHERE contentid = #{contentid} order by c_date desc")
    List<TourCommentVO> getComment(int contentid);

    // 댓글 삽입
    @Insert("INSERT INTO tourlist_reply(contentid, c_writer, c_context, c_date) VALUES(#{contentid}, #{c_writer}, #{c_context}, sysdate)")
    void insertComment(TourCommentVO comment);

    // 댓글 삭제
    @Delete("DELETE FROM tourlist_reply WHERE c_id = #{c_id}")
    void deleteComment(int c_id);

    // 댓글 수정
    @Update("UPDATE tourlist_reply SET c_context = #{c_context}, c_update = NOW() WHERE c_id = #{c_id}")
    void updateComment(TourCommentVO comment);

}
