package com.bbs.main.vo;

import lombok.Data;

import java.util.Date;

@Data

public class ToiletVO {
    private String user_nickname;
    private String post_category;
    private String post_menu;
    private int post_id;
    private String post_title;
    private String post_context;
    private String post_image;
    private String post_view;
    private int post_like;
    private Date post_date;
    private Date post_update;
    private int reply_count;
    private Double post_lat;      // 위도
    private Double post_lng;      // 경도
    private String post_address;  // 지번 or 도로명 주소

}