package com.bbs.main.controller;

import com.bbs.main.service.FreeService;
import com.bbs.main.service.LifeService;
import com.bbs.main.service.TourService;
import com.bbs.main.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HC {

    @Autowired
    private LifeService lifeService;

    @Autowired
    private TourService tourService;

    @Autowired
    private FreeService freeService;

//    ,@RequestParam(required = false) String areaCode,
//    @RequestParam(required = false) String sigungu,
//    @RequestParam(required = false) String sort
    @GetMapping("/")
    public String home(Model model, String title) {
        model.addAttribute("life", lifeService.getposts(title));
        model.addAttribute("free", freeService.getposts());
        model.addAttribute("tour", tourService.getAllLocation("1", null, "R"));
        model.addAttribute("content", "wh/main.jsp");
        return "index";
    }

}
