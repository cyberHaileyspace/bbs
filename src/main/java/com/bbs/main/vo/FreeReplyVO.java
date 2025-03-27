package com.bbs.main.vo;

import lombok.Data;

import java.util.Date;

@Data
public class FreeReplyVO {
   private int r_id;
   private String post_id;
   private String r_writer;
   private String r_context;
   private String r_like;
   private String r_date;
   private String r_update;
   // ⭐ 현재 로그인한 사용자가 이 댓글에 추천을 눌렀는지 여부
   private boolean likedByCurrentUser;

}
