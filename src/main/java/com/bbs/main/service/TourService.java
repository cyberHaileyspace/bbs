package com.bbs.main.service;

import com.bbs.main.mapper.TourMapper;
import com.bbs.main.vo.TourCommentVO;
import com.bbs.main.vo.TourVO;
import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

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

    public List<TourCommentVO> getComment(int post_id) {
        return tourMapper.getComment(post_id);
    }

    public int addComment(TourCommentVO comment) {
       return tourMapper.insertComment(comment);

    }

    public int updateReply(TourCommentVO tourCommentVO) {
       return tourMapper.updateReply(tourCommentVO);
    }

    public int deleteReply(int r_id) {
       return tourMapper.deleteReply(r_id);
    }


    // 댓글 추가, 삭제 등 다른 비즈니스 로직 메서드도 추가할 수 있습니다.

    public List<TourVO> getAllLocation(String areaCode, String sigungu, String sort) {
        String url = "https://apis.data.go.kr/B551011/KorService1/areaBasedList1?";
        url += "serviceKey=" + serviceKey;
        url += "&numOfRows=300&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json&listYN=Y&contentTypeId=12";
        url += "&areaCode=" + areaCode;
//        System.out.print(sort + ">>>>>>>>>>>>>>>>>>>>>>>>>");
        if (sort == "" || sort == null) {
            sort = "O";
        }
        url += "&arrange=" + sort;
        if (sigungu != null) {
            url += "&sigunguCode=" + sigungu;
        }
        try {
            URL u = new URL(url);
            HttpsURLConnection huc = (HttpsURLConnection) u.openConnection();
            InputStream is = huc.getInputStream();
            InputStreamReader isr = new InputStreamReader(is, StandardCharsets.UTF_8);
            BufferedReader br = new BufferedReader(isr);

            JsonReader reader = new JsonReader(isr);
            reader.setLenient(true); // lenient 모드 활성화
            JsonObject rootObj = JsonParser.parseReader(reader).getAsJsonObject()
                    .getAsJsonObject("response")
                    .getAsJsonObject("body");
            // 이후 rootObj에서 원하는 데이터를 추출
            // "response" -> "body" -> "items" -> "item" 으로 접근
            JsonElement itemsElement;
            if (sigungu != null) {
                itemsElement = rootObj.getAsJsonObject("items").get("item");
            } else {
                itemsElement = rootObj.get("items")
                        .getAsJsonObject().get("item");
            }
            // TourVO 리스트로 변환 (VO 클래스는 아래와 같이 정의된 것으로 가정)
            Gson gson = new Gson();
            List<TourVO> tourList = new ArrayList<>();
            // itemsElement가 배열인지 객체인지 확인 후 처리
            if (itemsElement.isJsonArray()) {
                Type listType = new TypeToken<List<TourVO>>() {}.getType();
                tourList = gson.fromJson(itemsElement, listType);
            } else if (itemsElement.isJsonObject()) {
                TourVO tour = gson.fromJson(itemsElement.getAsJsonObject(), TourVO.class);
                tourList.add(tour);
            } else {
                throw new RuntimeException("예상치 못한 item 형식: " + itemsElement);
            }

            List<TourVO> limitedList = new ArrayList<>();
            for (TourVO tour : tourList) {
                if (tour.getFirstimage() != null && !tour.getFirstimage().trim().isEmpty()) {
                    limitedList.add(tour);
                }
            }
            return limitedList;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public TourVO getDetailCommon(String contentid) {
        String url = "https://apis.data.go.kr/B551011/KorService1/detailCommon1?";
        url += "serviceKey=" + serviceKey;
        url += "&MobileOS=ETC&MobileApp=AppTest&_type=json&contentTypeId=12&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&numOfRows=1&pageNo=1";
        url += "&contentId=" + contentid;
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
            System.out.println(json);
            JsonObject rootObj = JsonParser.parseString(json).getAsJsonObject();
            JsonObject responseObj = rootObj.getAsJsonObject("response");
            JsonObject bodyObj = responseObj.getAsJsonObject("body");
            JsonObject itemObj = bodyObj.getAsJsonObject("items");
            JsonArray itemElement = itemObj.getAsJsonArray("item");
            Gson gson = new Gson();
            TourVO detail;
            if (itemElement.isJsonArray()) {
                // 배열인 경우, 첫 번째 요소를 상세 데이터로 사용
                detail = gson.fromJson(itemElement.getAsJsonArray().get(0), TourVO.class);
            } else if (itemElement.isJsonObject()) {
                // 단일 객체인 경우
                detail = gson.fromJson(itemElement.getAsJsonObject(), TourVO.class);
            } else {
                throw new RuntimeException("예상치 못한 item 형식: " + itemElement);
            }
            return detail;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public TourVO getDetailIntro(String contentid) {
        String url = "https://apis.data.go.kr/B551011/KorService1/detailIntro1?";
        url += "serviceKey=" + serviceKey;
        url += "&MobileOS=ETC&MobileApp=AppTest&_type=json&contentTypeId=12&numOfRows=10&pageNo=1";
        url += "&contentId=" + contentid;
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
            System.out.println(json);
            JsonObject rootObj = JsonParser.parseString(json).getAsJsonObject();
            JsonObject responseObj = rootObj.getAsJsonObject("response");
            JsonObject bodyObj = responseObj.getAsJsonObject("body");
            JsonObject itemObj = bodyObj.getAsJsonObject("items");
            JsonArray itemElement = itemObj.getAsJsonArray("item");
            Gson gson = new Gson();
            TourVO detail;
            if (itemElement.isJsonArray()) {
                // 배열인 경우, 첫 번째 요소를 상세 데이터로 사용
                detail = gson.fromJson(itemElement.getAsJsonArray().get(0), TourVO.class);
            } else if (itemElement.isJsonObject()) {
                // 단일 객체인 경우
                detail = gson.fromJson(itemElement.getAsJsonObject(), TourVO.class);
            } else {
                throw new RuntimeException("예상치 못한 item 형식: " + itemElement);
            }
            return detail;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public TourVO getDetailInfo(String contentid) {
        String url = "https://apis.data.go.kr/B551011/KorService1/detailInfo1?";
        url += "serviceKey=" + serviceKey;
        url += "&MobileOS=ETC&MobileApp=AppTest&_type=json&contentTypeId=12&numOfRows=10&pageNo=1";
        url += "&contentId=" + contentid;
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
            System.out.println(json);
            JsonObject rootObj = JsonParser.parseString(json).getAsJsonObject();
            JsonObject responseObj = rootObj.getAsJsonObject("response");
            JsonObject bodyObj = responseObj.getAsJsonObject("body");
            JsonObject itemObj = bodyObj.getAsJsonObject("items");
            JsonArray itemElement = itemObj.getAsJsonArray("item");
            Gson gson = new Gson();
            TourVO detail;
            if (itemElement.isJsonArray()) {
                // 배열인 경우, 첫 번째 요소를 상세 데이터로 사용
                detail = gson.fromJson(itemElement.getAsJsonArray().get(0), TourVO.class);
            } else if (itemElement.isJsonObject()) {
                // 단일 객체인 경우
                detail = gson.fromJson(itemElement.getAsJsonObject(), TourVO.class);
            } else {
                throw new RuntimeException("예상치 못한 item 형식: " + itemElement);
            }
            return detail;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public TourVO getDetailImage(String contentid) {
        String url = "https://apis.data.go.kr/B551011/KorService1/detailImage1?";
        url += "serviceKey=" + serviceKey;
        url += "&MobileOS=ETC&MobileApp=AppTest&_type=json&imageYN=Y&subImageYN=Y&numOfRows=10&pageNo=1";
        url += "&contentId=" + contentid;
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
            System.out.println(json);
            JsonObject rootObj = JsonParser.parseString(json).getAsJsonObject();
            JsonObject responseObj = rootObj.getAsJsonObject("response");
            JsonObject bodyObj = responseObj.getAsJsonObject("body");
            JsonObject itemObj = bodyObj.getAsJsonObject("items");
            JsonArray itemElement = itemObj.getAsJsonArray("item");
            Gson gson = new Gson();
            TourVO detail;
            if (itemElement.isJsonArray()) {
                // 배열인 경우, 첫 번째 요소를 상세 데이터로 사용
                detail = gson.fromJson(itemElement.getAsJsonArray().get(0), TourVO.class);
            } else if (itemElement.isJsonObject()) {
                // 단일 객체인 경우
                detail = gson.fromJson(itemElement.getAsJsonObject(), TourVO.class);
            } else {
                throw new RuntimeException("예상치 못한 item 형식: " + itemElement);
            }
            return detail;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 내부 DTO 클래스: 한국관광공사 API 응답 구조 (예시)
     * 실제 응답 JSON 구조에 맞게 수정해야 합니다.
     */
//    public static class KtoApiResponse {
//        public Response response;
//
//        public static class Response {
//            public Header header;
//            public Body body;
//        }
//
//        public static class Header {
//            public int resultCode;
//            public String resultMsg;
//        }
//
//        public static class Body {
//            public Items items;
//        }
//
//        public static class Items {
//            public List<Item> item;
//        }
//
//        public static class Item {
//            public String firstimage;  // 이미지 URL
//            public String title;       // 관광지 이름
//            public String addr1;       // 주소
//            public String overview;    // 설명
//            public String tel;         // 문의 및 안내
//            public String restdate;    // 쉬는 날
//            public String usetime;     // 이용 시간
//            public String originimgurl;// 상세이미지
//            public String infocenter;  // 연락처
//        }
//    }
}
