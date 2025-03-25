package com.bbs.main.controller;

import com.bbs.main.service.FreeService;
import com.bbs.main.service.UserService;
import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.FreeVO;
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
            @RequestParam(defaultValue = "new") String option) {

        int offset = page * size;

        if ("like".equals(option)) {
            return freeService.getReplysSortedByLike(post_id, offset, size);
        } else {
            return freeService.getReplysPaged(post_id, offset, size); // 기본: 최신순
        }
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



}
