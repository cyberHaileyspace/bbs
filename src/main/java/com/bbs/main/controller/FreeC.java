package com.bbs.main.controller;

import com.bbs.main.service.RegisterService;
import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.LifeWriteVO;
import com.bbs.main.vo.RegisterVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import com.bbs.main.service.FreeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/main/free")
@Controller
public class FreeC {
    @Autowired
    private FreeService freeService;
    @Autowired
    private RegisterService registerService;
    @Autowired
    private HttpSession session;

    @GetMapping("/reg")
    public String add(Model model) {
        if (registerService.loginChk(session)) {
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
    public String detail(@PathVariable int post_id, Model model, HttpSession session, HttpServletRequest req){
    RegisterVO user = (RegisterVO) session.getAttribute("user");
    String nickname = (user != null) ? user.getUser_nickname() : "";
    System.out.println(nickname);
        model.addAttribute("login_nickname", nickname);
        model.addAttribute("post", freeService.detailPost(post_id));
        model.addAttribute("content", "free/free_detail.jsp");
        return "index";
    }

    @DeleteMapping("/{post_id}")
    public String delete(@PathVariable int post_id) {
        System.out.println("2222");
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
        System.out.println("3333");
        return "redirect:/main/free/" + post_id;
    }



}





