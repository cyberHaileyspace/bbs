package com.bbs.main.controller;

import com.bbs.main.service.TourService;
import com.bbs.main.service.UserService;
import com.bbs.main.vo.TourVO;
import com.bbs.main.vo.UserVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;

@RequestMapping("/main/tourBoard")
@Controller
public class Tour_boardC {
    @Autowired
    private TourService tourService;
    @Autowired
    private UserService userService;
    @Autowired
    private HttpSession session;

    @GetMapping("/reg")
    public String add(Model model) {
        if (userService.loginChk(session)) {
            model.addAttribute("content", "tour/tour_reg.jsp");
            return "index";
        }
        return "redirect:/login";

    }

    @PostMapping
    public String add(TourVO tourVO, MultipartFile post_file) {
        tourService.addPost(tourVO, post_file);
        return "redirect:/main/tour";

    }

    @GetMapping("/{post_id}")
    public String detail(@PathVariable int post_id, Model model, HttpSession session, String token) {

        String sessionKey = "view_token_" + post_id;
        String lastToken = (String) session.getAttribute(sessionKey);

        if (lastToken == null || !lastToken.equals(token)) {
            tourService.getCount(post_id);  // 조회수 증가
            session.setAttribute(sessionKey, token);  // 새로운 토큰 저장
        }

        UserVO user = (UserVO) session.getAttribute("user");
        String nickname = (user != null) ? user.getUser_nickname() : "";
        System.out.println(nickname);
        model.addAttribute("login_nickname", nickname);
        model.addAttribute("user", user);
        model.addAttribute("post", tourService.detailPost(post_id));
        model.addAttribute("content", "tour/tour_detail.jsp");
        return "index";
    }

    @DeleteMapping("/{post_id}")
    public String delete(@PathVariable int post_id) {
        tourService.deletePost(post_id);
        return "redirect:/main/tour";
    }

    @GetMapping("/update/{post_id}")
    public String update(@PathVariable int post_id, Model model) {
        model.addAttribute("post", tourService.detailPost(post_id));
        model.addAttribute("content", "tour/tour_update.jsp");
        return "index";
    }

    @PostMapping("/update")
    public String update(int post_id, TourVO tourVO, MultipartFile post_file) {
        System.out.println(post_id + "post no : " + tourVO.getPost_id());
        tourService.updatePost(tourVO, post_file);
        return "redirect:/main/tourBoard/" + post_id;
    }

    @PostMapping("/like/{post_id}")
    @ResponseBody // JSON 응답을 위한 애너테이션
    public Map<String, Object> tourlike(@PathVariable int post_id, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        if (userService.loginChk(session)) {
            tourService.updateLike(post_id); // 추천수 업데이트
            int newLikeCount = tourService.getLikeCount(post_id); // 새로운 추천수 가져오기
            response.put("success", true);
            response.put("newLikeCount", newLikeCount);
        } else {
            response.put("success", false);
        }

        return response; // JSON 형태로 반환
    }





}
