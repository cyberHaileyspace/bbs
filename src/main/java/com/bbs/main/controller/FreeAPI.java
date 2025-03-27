package com.bbs.main.controller;

import com.bbs.main.service.FreeService;
import com.bbs.main.service.UserService;
import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.FreeVO;
import com.bbs.main.vo.UserVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/main/free/reply")
@RestController
public class FreeAPI {
    @Autowired
    private FreeService freeService;
    @Autowired
    private UserService userService;
    @Autowired
    private HttpSession session;

    @GetMapping("/{post_id}")
    public List<FreeReplyVO> list(
            @PathVariable("post_id") int post_id,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size,
            @RequestParam(defaultValue = "new") String option,
            HttpSession session
    ) {
        int offset = page * size;
        UserVO user = (UserVO) session.getAttribute("user");
        String nickname = user != null ? user.getUser_nickname() : null;

        List<FreeReplyVO> replies;

        if ("like".equals(option)) {
            replies = freeService.getReplysSortedByLike(post_id, offset, size);
        } else {
            replies = freeService.getReplysPaged(post_id, offset, size);
        }

        if (nickname != null) {
            for (FreeReplyVO reply : replies) {
                boolean liked = freeService.hasUserReplyLiked(reply.getR_id(), nickname); // r_id는 int 타입 추천
                reply.setLikedByCurrentUser(liked);
            }
        }

        return replies;
    }



    @PostMapping
    public int add(@RequestBody FreeReplyVO freeReplyVO) {
        return freeService.addReply(freeReplyVO);
    }

    @PutMapping // 경로에 ID 포함
    public int update(@RequestBody FreeReplyVO freeReplyVO) {
        System.out.println(freeReplyVO);
        return freeService.updateReply(freeReplyVO);
    }

    @DeleteMapping("/{r_id}")
    public int delete(@PathVariable("r_id") int r_id) {
        System.out.println(r_id);
        return freeService.deleteReply(r_id);
    }

    @GetMapping("/count/{post_id}")
    @ResponseBody
    public int getReplyCount(@PathVariable int post_id) {
        return freeService.getTotalReplyCount(post_id); // DB에서 count(*) 해주는 메서드
    }

    @PostMapping("/like/{post_id}")
    @ResponseBody // JSON 응답을 위한 애너테이션
    public Map<String, Object> freeReplylike(@PathVariable("post_id") int no, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        if (userService.loginChk(session)) {
            freeService.updateReplyLike(no); // 추천수 업데이트
            int newReplyLikeCount = freeService.
                    getReplyLikeCount(no); // 새로운 추천수 가져오기
            response.put("success", true);
            response.put("newReplyLikeCount", newReplyLikeCount);
        } else {
            response.put("success", false);
        }
        return response; // JSON 형태로 반환
    }

    @PostMapping("/unlike/{post_id}")
    @ResponseBody // JSON 응답을 위한 애너테이션
    public Map<String, Object> freeReplyUnlike(@PathVariable("post_id") int no, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        if (userService.loginChk(session)) {
            freeService.updateReplyUnlike(no); // 추천 취소 기능: 추천수를 감소시키는 로직
            int newReplyLikeCount = freeService.getReplyLikeCount(no); // 새로운 추천수 가져오기
            response.put("success", true);
            response.put("newReplyLikeCount", newReplyLikeCount);
        } else {
            response.put("success", false);
        }

        return response; // JSON 형태로 반환
    }


    @PostMapping("/toggle/{r_id}")
    @ResponseBody
    public Map<String, Object> toggleLike(@PathVariable("r_id") int rId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        if (userService.loginChk(session)) {
            // 현재 로그인한 유저 정보 가져오기 (예: UserVO를 사용)
            UserVO user = (UserVO) session.getAttribute("user");
            String userNickname = user.getUser_nickname();  // 또는 user.getUser_nickname() 등

            // freeService에서 토글 메서드를 구현해, 현재 추천 상태를 확인하고 토글 처리
            // 토글 후 현재 추천 상태(true: 추천한 상태, false: 추천하지 않은 상태)를 반환하도록 함
            boolean nowReplyLiked = freeService.toggleReplyLike(rId, userNickname);

            // 변경된 추천 수 조회
            int newReplyLikeCount = freeService.getReplyLikeCount(rId);

            response.put("success", true);
            response.put("nowReplyLiked", nowReplyLiked);
            response.put("newReplyLikeCount", newReplyLikeCount);
        } else {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
        }

        return response;
    }



}
