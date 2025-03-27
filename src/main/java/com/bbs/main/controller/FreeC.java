package com.bbs.main.controller;

import com.bbs.main.service.UserService;
import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.FreeVO;
import com.bbs.main.vo.LifeVO;
import com.bbs.main.vo.UserVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import com.bbs.main.service.FreeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/main/free")
@Controller
public class FreeC {
    @Autowired
    private FreeService freeService;
    @Autowired
    private UserService userService;
    @Autowired
    private HttpSession session;

    @GetMapping("/reg")
    public String add(Model model) {
        if (userService.loginChk(session)) {
            model.addAttribute("content", "free/free_reg.jsp");
            return "index";
        }
        return "redirect:/login";

    }

    @PostMapping
    public String add(FreeVO freeVO, MultipartFile post_file) {
        freeService.addPost(freeVO, post_file);
        return "redirect:/main/free";

    }

    @GetMapping("/{post_id}")
    public String detail(@PathVariable int post_id, String token, Model model, HttpSession session, HttpServletRequest req) {
        String sessionKey = "view_token_" + post_id;
        String lastToken = (String) session.getAttribute(sessionKey);
        if (lastToken == null || !lastToken.equals(token)) {
            freeService.getCount(post_id);  // 조회수 증가
            session.setAttribute(sessionKey, token);
        }
        UserVO user = (UserVO) session.getAttribute("user");
        String nickname = (user != null) ? user.getUser_nickname() : "";
        model.addAttribute("login_nickname", nickname);
        FreeVO post =  freeService.detailPost(post_id);
        model.addAttribute("post", post);

        // 추천 상태 조회 (현재 로그인한 유저가 이 게시글에 추천을 눌렀는지 확인)
        boolean isLiked = false;
        if (user != null) {
            isLiked = freeService.hasUserLiked(post_id, nickname);
            System.out.println(isLiked);
        }
        model.addAttribute("isLiked", isLiked);

        model.addAttribute("content", "free/free_detail.jsp");
        return "index";
    }


    @DeleteMapping("/{post_id}")
    public String delete(@PathVariable int post_id) {
        freeService.deletePost(post_id);
        return "redirect:/main/free";
    }

    @GetMapping("/update/{post_id}")
    public String update(@PathVariable int post_id, Model model) {
        model.addAttribute("post", freeService.detailPost(post_id));
        model.addAttribute("content", "free/free_update.jsp");
        return "index";
    }

    @PostMapping("/update")
    public String update(int post_id, FreeVO freeVO, MultipartFile post_file) {
        System.out.println(post_id + "post no : " + freeVO.getPost_id());
        freeService.updatePost(freeVO, post_file);
        return "redirect:/main/free/" + post_id;
    }


    @GetMapping("/option")
    @ResponseBody
    public List<FreeVO> getsorts(@RequestParam("option") String option) {
        return freeService.getsorts(option);
    }

    @PostMapping("/like/{post_id}")
    @ResponseBody // JSON 응답을 위한 애너테이션
    public Map<String, Object> freelike(@PathVariable("post_id") int no, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        if (userService.loginChk(session)) {
            freeService.updateLike(no); // 추천수 업데이트
            int newLikeCount = freeService.
                    getLikeCount(no); // 새로운 추천수 가져오기
            response.put("success", true);
            response.put("newLikeCount", newLikeCount);
        } else {
            response.put("success", false);
        }

        return response; // JSON 형태로 반환
    }

    @PostMapping("/unlike/{post_id}")
    @ResponseBody // JSON 응답을 위한 애너테이션
    public Map<String, Object> freeUnlike(@PathVariable("post_id") int no, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        if (userService.loginChk(session)) {
            freeService.updateUnlike(no); // 언라이크 기능: 추천수를 감소시키는 로직
            int newLikeCount = freeService.getLikeCount(no); // 새로운 추천수 가져오기
            response.put("success", true);
            response.put("newLikeCount", newLikeCount);
        } else {
            response.put("success", false);
        }

        return response; // JSON 형태로 반환
    }

    @PostMapping("/toggle/{post_id}")
    @ResponseBody
    public Map<String, Object> toggleLike(@PathVariable("post_id") int postId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        if (userService.loginChk(session)) {
            // 현재 로그인한 유저 정보 가져오기 (예: UserVO를 사용)
            UserVO user = (UserVO) session.getAttribute("user");
            String userNickname = user.getUser_nickname();  // 또는 user.getUser_nickname() 등

            // freeService에서 토글 메서드를 구현해, 현재 추천 상태를 확인하고 토글 처리
            // 토글 후 현재 추천 상태(true: 추천한 상태, false: 추천하지 않은 상태)를 반환하도록 함
            boolean nowLiked = freeService.toggleLike(postId, userNickname);

            // 변경된 추천 수 조회
            int newLikeCount = freeService.getLikeCount(postId);

            response.put("success", true);
            response.put("nowLiked", nowLiked);
            response.put("newLikeCount", newLikeCount);
        } else {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
        }

        return response;
    }


}





