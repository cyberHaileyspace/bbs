package com.bbs.main.vo;

import lombok.Data;

import java.util.Date;

@Data
public class PostFreeVO {

    private String p_no;
    private String p_id;
    private String p_name;
    private String p_begin;
    private String p_title;
    private String p_img;
    private String p_text;
    private Date p_date;
}
