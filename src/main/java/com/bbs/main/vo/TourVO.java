package com.bbs.main.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class TourVO {
    private String title;
    private String addr1;
    private String firstImage;
    private String tel;
}
