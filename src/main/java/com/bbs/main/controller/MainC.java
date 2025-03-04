package com.bbs.main.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/main")
@RestController
public class MainC {

    @GetMapping
    public String main(Model model) {
        model.addAttribute("content", "wh/main.jsp");
        return "index";
    }
    @GetMapping("/life")
    public String life() {
        return "life";
    }

    @GetMapping("/tour")
    public String tour() {
        return "tour";
    }

    @GetMapping("/board_free")
    public String board_free() {
        return "board_free";
    }




}
