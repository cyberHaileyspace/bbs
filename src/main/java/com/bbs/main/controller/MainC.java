package com.bbs.main.controller;

import com.bbs.main.service.FreeService;
import com.bbs.main.service.LifeWriteService;
import com.bbs.main.service.UserService;
import com.bbs.main.vo.LifeWriteVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

@RequestMapping("/main")
@Controller
public class MainC {

    @Autowired
    private LifeWriteService lifeWriteService;

    @Autowired
    private UserService userService;

    @Autowired
    private FreeService freeService;

    @GetMapping
    public String main(Model model) {
        model.addAttribute("content", "wh/main.jsp");
        return "index";
    }

    @GetMapping("/life")
    public String life(Model model) {
        model.addAttribute("content", "life/life.jsp");
        model.addAttribute("lifewrite", lifeWriteService.getLifeWrite());
        return "index";
    }

    @GetMapping("/tour")
    public String tour(Model model) {
        model.addAttribute("content", "wh/tour.jsp");
        return "index";
    }

    @GetMapping("/free")
    public String list(Model model) {
        System.out.println("1111");
        model.addAttribute("posts", freeService.getposts());
        model.addAttribute("content", "free/free_posts.jsp");
        return "index";
    }


}
