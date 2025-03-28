package com.bbs.main.controller;

import com.bbs.main.service.ToiletService;
import com.bbs.main.service.UserService;
import com.bbs.main.vo.ToiletReplyVO;
import com.bbs.main.vo.UserVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/main/toilet/reply")
@RestController
public class ToiletAPI {
    @Autowired
    private ToiletService toiletService;
    @Autowired
    private UserService userService;
    @Autowired
    private HttpSession session;

    @GetMapping("/{post_id}")
    public List<ToiletReplyVO> list(
            @PathVariable("post_id") int post_id,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size,
            @RequestParam(defaultValue = "new") String option,
            HttpSession session
    ) {
        int offset = page * size;
        UserVO user = (UserVO) session.getAttribute("user");
        String nickname = user != null ? user.getUser_nickname() : null;

        List<ToiletReplyVO> replies;

        if ("like".equals(option)) {
            replies = toiletService.getReplysSortedByLike(post_id, offset, size);
        } else {
            replies = toiletService.getReplysPaged(post_id, offset, size);
        }

        if (nickname != null) {
            for (ToiletReplyVO reply : replies) {
                boolean liked = toiletService.hasUserReplyLiked(reply.getR_id(), nickname);
                reply.setLikedByCurrentUser(liked);
            }
        }

        return replies;
    }

    @PostMapping
    public int add(@RequestBody ToiletReplyVO toiletReplyVO) {
        return toiletService.addReply(toiletReplyVO);
    }

    @PutMapping
    public int update(@RequestBody ToiletReplyVO toiletReplyVO) {
        return toiletService.updateReply(toiletReplyVO);
    }

    @DeleteMapping("/{r_id}")
    public int delete(@PathVariable("r_id") int r_id) {
        return toiletService.deleteReply(r_id);
    }

    @GetMapping("/count/{post_id}")
    public int getReplyCount(@PathVariable int post_id) {
        return toiletService.getTotalReplyCount(post_id);
    }

    @PostMapping("/toggle/{r_id}")
    public Map<String, Object> toggleLike(@PathVariable("r_id") int rId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        if (userService.loginChk(session)) {
            UserVO user = (UserVO) session.getAttribute("user");
            String userNickname = user.getUser_nickname();

            boolean nowReplyLiked = toiletService.toggleReplyLike(rId, userNickname);
            int newReplyLikeCount = toiletService.getReplyLikeCount(rId);

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
