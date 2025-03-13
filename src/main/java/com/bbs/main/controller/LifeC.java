package com.bbs.main.controller;

import com.bbs.main.service.LifeService;
import com.bbs.main.service.UserService;
import com.bbs.main.vo.LifeVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collections;
import java.util.Map;
import java.util.HashMap;

@RequestMapping("/main/life")
@Controller
public class LifeC {

    @Autowired
    private LifeService lifeService;

    @Autowired
    private UserService userService;

    @GetMapping("/logincheck")
    public ResponseEntity<?> logincheck(HttpSession session) {
        boolean logincheck = userService.loginChk(session);
        return ResponseEntity.ok().body(Collections.singletonMap("logincheck", logincheck));
    }

    @GetMapping("/reg")
    /*public ResponseEntity<?> write(HttpSession session) {
        boolean logincheck = userService.loginChk(session);
        return ResponseEntity.ok().body(Collections.singletonMap("logincheck", logincheck));
    }*/
    public String reg(Model model, HttpSession session) {
        if (userService.loginChk(session)) {
            model.addAttribute("content", "life/lifereg.jsp");
            return "index";
        }
        return "redirect:/login";

    }

    @PostMapping("/reg")
    public String register(LifeVO lifeVO, MultipartFile post_file, HttpSession session) {
        /*if (userService.loginChk(session)) {*/
        lifeService.regPost(lifeVO, post_file);
        return "redirect:/main/life";
        /*}
        return "redirect:/login";*/
    }

    @GetMapping("/{no}")
    public String detail(@PathVariable int no, String token, Model model, HttpSession session) {
        String sessionKey = "view_token_" + no;
        String lastToken = (String) session.getAttribute(sessionKey);

        if (lastToken == null || !lastToken.equals(token)) {
            lifeService.getCount(no);  // 조회수 증가
            session.setAttribute(sessionKey, token);  // 새로운 토큰 저장
        }

        model.addAttribute("post", lifeService.getPost(no));
        model.addAttribute("content", "life/lifedetail.jsp");
        return "index";
    }

    /*@DeleteMapping("/{no}")
    public String delete(@PathVariable int no, HttpSession session) {
        System.out.println("2222");
        if (userService.loginChk(session)) {
            lifeService.deletePost(no);
            return "redirect:/main/life";
        }
        return "redirect:/login";
    }*/

    @DeleteMapping("/{no}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> delete(@PathVariable int no, HttpSession session) {
        System.out.println("2222");
        Map<String, Object> response = new HashMap<>();
        if (userService.loginChk(session)) {
            lifeService.deletePost(no);
            response.put("success", true);
            response.put("redirectUrl", "/main/life");
        } else {
            response.put("success", false);
            response.put("redirectUrl", "/login");
        }
        return ResponseEntity.ok(response);
    }

    @GetMapping("/update/{post_id}")
    public String update(Model model) {
        model.addAttribute("content", "life/updatepost.jsp");
        return "index";
    }

    @PostMapping("/update")
    public String update(LifeVO lifeVO, Model model, MultipartFile post_file, HttpSession session) {
        if (userService.loginChk(session)) {
            lifeService.updatePost(lifeVO, post_file);
            return "redirect:/main/life";
        }
        return "redirect:/login";
    }

}
