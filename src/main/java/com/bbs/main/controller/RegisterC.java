package com.bbs.main.controller;

import com.bbs.main.service.RegisterService;
import com.bbs.main.vo.RegisterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class RegisterC {

    @Autowired
    private RegisterService registerService;

    @GetMapping("register")
    public String registerpage(Model model){
        model.addAttribute("content", "jm/register.jsp");
        return "index";
    }

    @GetMapping("login")
    public String loginpage(Model model){
        model.addAttribute("content", "jm/login.jsp");
        return "index";
    }

    @PostMapping("register")
    public String register(RegisterVO registerVO) {
        registerService.regUser(registerVO);
        return "redirect:/regpage";
    }
}
