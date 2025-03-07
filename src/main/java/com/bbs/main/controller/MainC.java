package com.bbs.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/main")
@Controller
public class MainC {

    @GetMapping
    public String main(Model model) {
        model.addAttribute("content", "wh/main.jsp");
        return "index";
    }
    @GetMapping("/life")
    public String life(Model model) {
        return "life";
    }

    @GetMapping("/tour")
    public String tour(Model model) {
        model.addAttribute("content", "wh/tour.jsp");
        return "index";
    }

    @GetMapping("/free")
    String all(Model model) {
        System.out.println(11);
        model.addAttribute("content", "free/free_posts.jsp");
        return "index";
    }



}
