package com.bbs.main.controller;

import com.bbs.main.service.LifeWriteService;
import com.bbs.main.service.RegisterService;
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
    private RegisterService registerService;

    @GetMapping
    public String main(Model model) {
        model.addAttribute("content", "wh/main.jsp");
        return "index";
    }

    @GetMapping("/life")
    public String life(Model model) {
        model.addAttribute("content", "jm/life.jsp");
        model.addAttribute("lifewrite", lifeWriteService.getLifeWrite());
        return "index";
    }

    @GetMapping("/write")
    public String write(Model model) {
        model.addAttribute("content", "jm/writelife.jsp");
        return "index";
    }

    @PostMapping("/writereg")
    public String writereg(LifeWriteVO lifeWriteVO, Model model, MultipartFile post_file, HttpSession session) {
        if (registerService.loginChk(session)) {
            lifeWriteService.regWrite(lifeWriteVO, post_file);
            return "redirect:life";
        }
        return "redirect:/login";
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
