package com.bbs.main.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.sql.Timestamp;
import java.util.Date;

@Data
public class TourVO {
    private int spot_id;          // 관광지 ID (기본키, 자동 증가)
    private String spot_name;      // 관광지 이름 (API: title)
    private String spot_address;   // 주소 (API: addr1)
    private String spot_desc;      // 설명 (API: overview)
    private String spot_contact;   // 문의 및 안내 (연락처, API: tel)
    private String spot_closed;    // 쉬는 날 (API: restdate)
    private String spot_hours;     // 이용 시간 (API: usetime)
    private String spot_image;     // 이미지 URL (API: firstimage)
    private Date created_at;  // 등록 날짜
}
