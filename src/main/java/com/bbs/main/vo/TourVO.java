package com.bbs.main.vo;

import lombok.Data;

import java.util.Date;

@Data
public class TourVO {
    private String user_nickname;
    private String post_category;
    private String post_menu;
    private int post_id;
    private String post_title;
    private String post_context;
    private String post_image;
    private int post_view;
    private int post_like;
    private Date post_date;
    private Date post_update;
}
