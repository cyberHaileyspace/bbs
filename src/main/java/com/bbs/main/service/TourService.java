package com.bbs.main.service;

import com.bbs.main.mapper.TourMapper;
import com.bbs.main.vo.TourVO;
import com.bbs.main.vo.TourReplyVO;
import com.bbs.main.vo.Tour_API_VO;
import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.net.ssl.HttpsURLConnection;
import java.io.*;
import java.lang.reflect.Type;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
public class TourService {
    @Value("${appkey}")
    String serviceKey;

    @Autowired
    private TourMapper tourMapper;

    // 댓글 추가, 삭제 등 다른 비즈니스 로직 메서드도 추가할 수 있습니다.

    public List<Tour_API_VO> getAllLocation(String areaCode, String sigungu, String sort) {
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
            List<Tour_API_VO> tourList = new ArrayList<>();
            // itemsElement가 배열인지 객체인지 확인 후 처리
            if (itemsElement.isJsonArray()) {
                Type listType = new TypeToken<List<Tour_API_VO>>() {}.getType();
                tourList = gson.fromJson(itemsElement, listType);
            } else if (itemsElement.isJsonObject()) {
                Tour_API_VO tour = gson.fromJson(itemsElement.getAsJsonObject(), Tour_API_VO.class);
                tourList.add(tour);
            } else {
                throw new RuntimeException("예상치 못한 item 형식: " + itemsElement);
            }

            List<Tour_API_VO> limitedList = new ArrayList<>();
            for (Tour_API_VO tour : tourList) {
                if (tour.getFirstimage() != null && !tour.getFirstimage().trim().isEmpty()) {
                    limitedList.add(tour);
                }
            }
            return limitedList;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Tour_API_VO getDetailCommon(String contentid) {
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
            Tour_API_VO detail;
            if (itemElement.isJsonArray()) {
                // 배열인 경우, 첫 번째 요소를 상세 데이터로 사용
                detail = gson.fromJson(itemElement.getAsJsonArray().get(0), Tour_API_VO.class);
            } else if (itemElement.isJsonObject()) {
                // 단일 객체인 경우
                detail = gson.fromJson(itemElement.getAsJsonObject(), Tour_API_VO.class);
            } else {
                throw new RuntimeException("예상치 못한 item 형식: " + itemElement);
            }
            return detail;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Tour_API_VO getDetailIntro(String contentid) {
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
            Tour_API_VO detail;
            if (itemElement.isJsonArray()) {
                // 배열인 경우, 첫 번째 요소를 상세 데이터로 사용
                detail = gson.fromJson(itemElement.getAsJsonArray().get(0), Tour_API_VO.class);
            } else if (itemElement.isJsonObject()) {
                // 단일 객체인 경우
                detail = gson.fromJson(itemElement.getAsJsonObject(), Tour_API_VO.class);
            } else {
                throw new RuntimeException("예상치 못한 item 형식: " + itemElement);
            }
            return detail;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Tour_API_VO getDetailInfo(String contentid) {
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
            Tour_API_VO detail;
            if (itemElement.isJsonArray()) {
                // 배열인 경우, 첫 번째 요소를 상세 데이터로 사용
                detail = gson.fromJson(itemElement.getAsJsonArray().get(0), Tour_API_VO.class);
            } else if (itemElement.isJsonObject()) {
                // 단일 객체인 경우
                detail = gson.fromJson(itemElement.getAsJsonObject(), Tour_API_VO.class);
            } else {
                throw new RuntimeException("예상치 못한 item 형식: " + itemElement);
            }
            return detail;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Tour_API_VO getDetailImage(String contentid) {
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
            Tour_API_VO detail;
            if (itemElement.isJsonArray()) {
                // 배열인 경우, 첫 번째 요소를 상세 데이터로 사용
                detail = gson.fromJson(itemElement.getAsJsonArray().get(0), Tour_API_VO.class);
            } else if (itemElement.isJsonObject()) {
                // 단일 객체인 경우
                detail = gson.fromJson(itemElement.getAsJsonObject(), Tour_API_VO.class);
            } else {
                throw new RuntimeException("예상치 못한 item 형식: " + itemElement);
            }
            return detail;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<TourReplyVO> getComment(int post_id) {
        return tourMapper.getComment(post_id);
    }
    public int addComment(TourReplyVO comment) {
        return tourMapper.insertComment(comment);
    }
    public int updateReply(TourReplyVO tourReplyVO) {
        return tourMapper.updateReply(tourReplyVO);
    }
    public int deleteReply(int r_id) {
        return tourMapper.deleteReply(r_id);
    }

    public List<TourVO> getposts() {
        return tourMapper.getposts();
    }

    public TourVO detailPost(int post_id) {
        return tourMapper.detailPost(post_id);
    }

    public int deletePost(int post_id) {
        return tourMapper.deletePost(post_id);
    }

    public void addPost(TourVO tourVO, MultipartFile post_file) {
        if (post_file.getOriginalFilename().length() != 0) {
            String originName = post_file.getOriginalFilename();
            String fileExtension = originName.substring(originName.lastIndexOf("."), originName.length());
            System.out.println(fileExtension);
            String uploadFolder = "/Users/kimsuhyeon/Desktop/final_img";
            UUID uuid = UUID.randomUUID();
            System.out.println(uuid);
            String[] uuids = uuid.toString().split("-");
            System.out.println(uuids[0]);
            String fileName = uuids[0] + fileExtension;
            File saveFile = new File(uploadFolder + "/" + fileName);
            try {
                post_file.transferTo(saveFile);
                tourVO.setPost_image(fileName);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        tourMapper.addPost(tourVO);
    }

    public void updatePost(TourVO tourVO, MultipartFile post_file) {
        // 기존 게시글 조회
        TourVO existingPost = tourMapper.detailPost(tourVO.getPost_id());

        // 기존 게시글이 존재하는지 확인
        if (existingPost == null) {
            throw new IllegalArgumentException("해당 게시글이 존재하지 않습니다: ID=" + tourVO.getPost_id());
        }

        String uploadFolder = "/Users/kimsuhyeon/Desktop/final_img";

        if (post_file != null && !post_file.isEmpty()) {
            String originName = post_file.getOriginalFilename();
            String fileExtension = originName.substring(originName.lastIndexOf("."));
            UUID uuid = UUID.randomUUID();
            String fileName = uuid.toString().split("-")[0] + fileExtension;
            File saveFile = new File(uploadFolder + "/" + fileName);
            try {
                // 새 파일 저장
                post_file.transferTo(saveFile);
                // 기존 이미지 삭제
                if (existingPost.getPost_image() != null) {
                    File oldFile = new File(uploadFolder + "/" + existingPost.getPost_image());
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }
                // 새 이미지 이름 업데이트
                tourVO.setPost_image(fileName);
            } catch (IOException e) {
                throw new RuntimeException("파일 저장 실패", e);
            }
        } else {
            // 이미지 수정 안 할 경우 기존 이미지 유지
            tourVO.setPost_image(existingPost.getPost_image());
        }
        // DB 업데이트 실행
        tourMapper.updatePost(tourVO);
    }






}
