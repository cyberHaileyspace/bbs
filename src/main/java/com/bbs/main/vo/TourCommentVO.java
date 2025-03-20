package com.bbs.main.vo;

import lombok.Data;
import java.sql.Timestamp;

@Data
public class TourCommentVO {
    private int c_id;          // 댓글 고유 번호
    private int contentid;     // 댓글이 속한 게시글 번호
    private String c_writer;   // 댓글 작성자
    private String c_context;  // 댓글 내용
    private int c_like;        // 좋아요 수
    private String c_date;  // 댓글 작성 시간
    private String c_update; // 댓글 수정 시간
}
