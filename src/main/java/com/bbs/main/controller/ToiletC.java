package com.bbs.main.controller;

import com.bbs.main.service.ToiletService;
import com.bbs.main.service.UserService;
import com.bbs.main.vo.LifeVO;
import com.bbs.main.vo.ToiletVO;
import com.bbs.main.vo.UserVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/main/toilet")
@Controller
public class ToiletC {
    @Autowired
    private ToiletService toiletService;
    @Autowired
    private UserService userService;
    @Autowired
    private HttpSession session;

    @GetMapping("/reg")
    public String add(Model model) {
        if (userService.loginChk(session)) {
            model.addAttribute("content", "toilet/toilet_reg.jsp");
            return "index";
        }
        return "redirect:/login";
    }

    @PostMapping
    public String add(ToiletVO toiletVO, MultipartFile post_file) {
        toiletService.addPost(toiletVO, post_file);
        return "redirect:/main/toilet";
    }

    @GetMapping("/{post_id}")
    public String detail(@PathVariable int post_id, String token, Model model, HttpSession session, HttpServletRequest req) {
        String sessionKey = "view_token_" + post_id;
        String lastToken = (String) session.getAttribute(sessionKey);
        if (lastToken == null || !lastToken.equals(token)) {
            toiletService.getCount(post_id);
            session.setAttribute(sessionKey, token);
        }
        UserVO user = (UserVO) session.getAttribute("user");
        String nickname = (user != null) ? user.getUser_nickname() : "";
        model.addAttribute("login_nickname", nickname);
        ToiletVO post = toiletService.detailPost(post_id);
        model.addAttribute("post", post);

        boolean isLiked = false;
        if (user != null) {
            isLiked = toiletService.hasUserLiked(post_id, nickname);
        }
        model.addAttribute("isLiked", isLiked);

        model.addAttribute("content", "toilet/toilet_detail.jsp");
        return "index";
    }

    @DeleteMapping("/{no}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteToiletPost(@PathVariable int no, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        if (userService.loginChk(session)) {
            toiletService.deletePost(no);
            response.put("success", true);
            response.put("redirectUrl", "/main/toilet");
        } else {
            response.put("success", false);
            response.put("redirectUrl", "/login");
        }
        return ResponseEntity.ok(response);
    }


    @GetMapping("/update/{post_id}")
    public String update(@PathVariable int post_id, Model model) {
        model.addAttribute("post", toiletService.detailPost(post_id));
        model.addAttribute("content", "toilet/toilet_update.jsp");
        return "index";
    }

    @PostMapping("/update")
    public String update(int post_id, ToiletVO toiletVO, MultipartFile post_file) {
        toiletService.updatePost(toiletVO, post_file);
        return "redirect:/main/toilet/" + post_id;
    }

    @GetMapping("/option")
    @ResponseBody
    public List<ToiletVO> getsorts(@RequestParam("option") String option) {
        return toiletService.getsorts(option);
    }

    @PostMapping("/toggle/{post_id}")
    @ResponseBody
    public Map<String, Object> toggleLike(@PathVariable("post_id") int postId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        if (userService.loginChk(session)) {
            UserVO user = (UserVO) session.getAttribute("user");
            String userNickname = user.getUser_nickname();
            boolean nowLiked = toiletService.toggleLike(postId, userNickname);
            int newLikeCount = toiletService.getLikeCount(postId);
            response.put("success", true);
            response.put("nowLiked", nowLiked);
            response.put("newLikeCount", newLikeCount);
        } else {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
        }
        return response;
    }

    @GetMapping("/category")
    @ResponseBody
    public List<ToiletVO> getcategory(@RequestParam("category") String category) {
        return toiletService.getcategory(category);
    }

}