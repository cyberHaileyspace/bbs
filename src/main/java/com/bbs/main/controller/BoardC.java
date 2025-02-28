package com.bbs.main.controller;

import ch.qos.logback.core.model.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BoardC {
    @GetMapping("/boardfree")
    String all(Model model) {
        System.out.println(11);
        return "board_free/board_free";
    }
}
