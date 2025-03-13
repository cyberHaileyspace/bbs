package com.bbs.main.vo;

import lombok.Data;

import java.util.Date;

@Data
public class FreeReplyVO {
   private String c_id;
   private String post_id;
   private String c_writer;
   private String c_context;
   private String c_like;
   private Date c_date;
   private Date c_update;
}
