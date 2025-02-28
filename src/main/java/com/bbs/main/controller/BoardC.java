package com.bbs.board.free.controller;

import ch.qos.logback.core.model.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BoardC {
    @GetMapping("/boardfree/all")
    String all(Model model) {
        System.out.println(11);
        return "baord_free/board_free";
    }
}
