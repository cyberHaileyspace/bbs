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
        model.addAttribute("content", "wh/tourTest.jsp");
        return "index";
    }

    @GetMapping("/board_free")
    public String board_free() {
        return "board_free";
    }




}
