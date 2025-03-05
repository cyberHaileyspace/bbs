package com.bbs.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HC {

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("content", "wh/main.jsp");
        return "index";
    }

    @GetMapping("/boardFree")
    String all(Model model) {
        System.out.println(11);
        model.addAttribute("content", "board_free/board_free.jsp");
        return "index";
    }

}
