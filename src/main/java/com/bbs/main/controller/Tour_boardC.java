package com.bbs.main.controller;

import com.bbs.main.service.TourService;
import com.bbs.main.service.UserService;
import com.bbs.main.vo.FreeVO;
import com.bbs.main.vo.UserVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RequestMapping("/main/tourBoard")
@Controller
public class Tour_boardC {
    @Autowired
    private TourService tourService;
    @Autowired
    private UserService userService;
    @Autowired
    private HttpSession session;

//    @GetMapping("/reg")
//    public String add(Model model) {
//        if (userService.loginChk(session)) {
//            model.addAttribute("content", "free/free_reg.jsp");
//            return "index";
//        }
//        return "redirect:/login";
//
//    }
//
//    @PostMapping
//    public String add(FreeVO freeVO, MultipartFile post_file) {
//        freeService.addPost(freeVO, post_file);
//        return "redirect:/main/free";
//
//    }
//
//    @GetMapping("/{post_id}")
//    public String detail(@PathVariable int post_id, Model model, HttpSession session, HttpServletRequest req) {
//        UserVO user = (UserVO) session.getAttribute("user");
//        String nickname = (user != null) ? user.getUser_nickname() : "";
//        System.out.println(nickname);
//        model.addAttribute("login_nickname", nickname);
//        model.addAttribute("post", freeService.detailPost(post_id));
//        model.addAttribute("content", "free/free_detail.jsp");
//        return "index";
//    }
//
//    @DeleteMapping("/{post_id}")
//    public String delete(@PathVariable int post_id) {
//        freeService.deletePost(post_id);
//        return "redirect:/main/free";
//    }
//
//    @GetMapping("/update/{post_id}")
//    public String update(@PathVariable int post_id, Model model) {
//        model.addAttribute("post", freeService.detailPost(post_id));
//        model.addAttribute("content", "free/free_update.jsp");
//        return "index";
//    }
//
//    @PostMapping("/update")
//    public String update(int post_id, FreeVO freeVO, MultipartFile post_file) {
//        System.out.println(post_id + "post no : " + freeVO.getPost_id());
//        freeService.updatePost(freeVO, post_file);
//        return "redirect:/main/free/" + post_id;
//    }





}
