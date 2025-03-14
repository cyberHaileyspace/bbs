package com.bbs.main.vo;

import lombok.Data;

import java.util.Date;

@Data
public class LifeReplyVO {
   private String r_id;
   private String post_id;
   private String r_writer;
   private String r_context;
   private String r_like;
   private Date r_date;
   private Date r_update;
}
