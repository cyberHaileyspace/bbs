package com.bbs.main.service;

import com.bbs.main.mapper.TourMapper;
import com.bbs.main.vo.TourVO;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.net.ssl.HttpsURLConnection;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@Service
public class TourService {
    @Value("${appkey}")
    String serviceKey;

    @Autowired
    private TourMapper tourMapper;

    /*
    {
"addr1": "제주특별자치도 제주시 한경면 청수서5길 63",
"addr2": "",
"areacode": "39",
"booktour": "0",
"cat1": "A01",
"cat2": "A0101",
"cat3": "A01010400",
"contentid": "1884191",
"contenttypeid": "12",
"createdtime": "20140113184533",
"firstimage": "http://tong.visitkorea.or.kr/cms/resource/72/3477972_image2_1.jpg",
"firstimage2": "http://tong.visitkorea.or.kr/cms/resource/72/3477972_image3_1.jpg",
"cpyrhtDivCd": "Type3",
"mapx": "126.2507039833",
"mapy": "33.3059197039",
"mlevel": "6",
"modifiedtime": "20250214140439",
"sigungucode": "4",
"tel": "",
"title": "가마오름",
"zipcode": "63006"
}
     */
    public List<TourVO> getAttractionDataByLoc(String areaCode, String sigungu) {
        System.out.print(serviceKey);
        String url = "https://apis.data.go.kr/B551011/KorService1/areaBasedList1?";
        url += "serviceKey=" + serviceKey;
        url += "&numOfRows=1000&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json&listYN=Y&arrange=A&contentTypeId=12";
        url += "&areaCode=" + areaCode;
        if (sigungu != null) {
            url += "&sigunguCode=" + sigungu;
        }
        try {
            URL u = new URL(url);
            HttpsURLConnection huc = (HttpsURLConnection) u.openConnection();
            InputStream is = huc.getInputStream();
            InputStreamReader isr = new InputStreamReader(is, StandardCharsets.UTF_8);
            BufferedReader br = new BufferedReader(isr);

            StringBuilder jsonBuilder = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                jsonBuilder.append(line);
            }
            String json = jsonBuilder.toString();
            System.out.printf(json);
            JsonObject rootObj = JsonParser.parseString(json).getAsJsonObject();
            // 이후 rootObj에서 원하는 데이터를 추출
            // "response" -> "body" -> "items" -> "item" 으로 접근
            JsonElement itemsElement;
            if (sigungu != null) {
                itemsElement = rootObj
                        .getAsJsonObject("response")
                        .getAsJsonObject("body")
                        .getAsJsonObject("items")
                        .get("item");
            } else {
                itemsElement = rootObj
                        .getAsJsonObject("response")
                        .getAsJsonObject("body")
                        .get("items");
            }
            // TourVO 리스트로 변환 (VO 클래스는 아래와 같이 정의된 것으로 가정)
            Gson gson = new Gson();
            Type listType = new TypeToken<List<TourVO>>() {
            }.getType();
            List<TourVO> tourList = gson.fromJson(itemsElement, listType);

            List<TourVO> limitedList = new ArrayList<>();
            int count = 0;
            for (TourVO tour : tourList) {
                if (tour.getFirstimage() == null || tour.getFirstimage().equals("")) {
                    continue;
                }
                if (count >= 8) {
                    break;
                }
                limitedList.add(tour);
                count++;
            }
            return limitedList;
//            Gson gson = new Gson();


//
//            Attraction attraction = gson.fromJson(json, Attraction.class);
//
//            System.out.println("주소: " + attraction.getAddr1());
//            System.out.println("콘텐츠ID: " + attraction.getContentid());
//            System.out.println("대표이미지: " + attraction.getFirstimage());
//            System.out.println("대표이미지(썸네일): " + attraction.getFirstimage2());


        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 내부 DTO 클래스: 한국관광공사 API 응답 구조 (예시)
     * 실제 응답 JSON 구조에 맞게 수정해야 합니다.
     */
    public static class KtoApiResponse {
        public Response response;

        public static class Response {
            public Header header;
            public Body body;
        }

        public static class Header {
            public int resultCode;
            public String resultMsg;
        }

        public static class Body {
            public Items items;
        }

        public static class Items {
            public List<Item> item;
        }

        public static class Item {
            public String firstimage;  // 이미지 URL
            public String title;       // 관광지 이름
            public String addr1;       // 주소
            public String overview;    // 설명
            public String tel;         // 문의 및 안내
            public String restdate;    // 쉬는 날
            public String usetime;     // 이용 시간
        }
    }
}
