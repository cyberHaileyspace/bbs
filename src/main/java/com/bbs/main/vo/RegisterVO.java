package com.bbs.main.vo;

import lombok.Data;

import java.util.Date;

@Data
public class RegisterVO {
    private String user_id;
    private String user_pw;
    private String user_name;
    private String user_nickname;
    private String user_email;
    private String user_gender;
    private String user_image;
    private Date user_date;
}