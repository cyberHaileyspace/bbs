package com.bbs.main.vo;

import lombok.Data;
import java.sql.Timestamp;

@Data
public class TourReplyVO {
    private int r_id;          // 댓글 고유 번호
    private String post_id;
    private String r_writer;   // 댓글 작성자
    private String r_context;  // 댓글 내용
    private int r_like;        // 좋아요 수
    private Timestamp r_date;  // 댓글 작성 시간
    private String r_update; // 댓글 수정 시간
    private int contentid;     // 댓글이 속한 게시글 번호
}
