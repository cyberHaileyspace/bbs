package com.bbs.main.controller;

import com.bbs.main.service.*;
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

    @Autowired
    private ToiletService toiletService;



    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("free", freeService.getposts());
        model.addAttribute("tour", tourService.getAllLocation("1", null, "O"));
        model.addAttribute("tourPosts", tourService.getposts());
        model.addAttribute("life", lifeService.getposts());
        model.addAttribute("map", toiletService.getposts());
        model.addAttribute("content", "tour/main.jsp");
        return "index";
    }

}
