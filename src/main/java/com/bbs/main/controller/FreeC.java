package com.bbs.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import com.bbs.main.service.FreeService;
import com.bbs.main.vo.FreeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/free")
@Controller
public class FreeC {
    @Autowired
    private FreeService freeService;

    @GetMapping
    public String list(Model model) {
        System.out.println("1111");
        model.addAttribute("posts", freeService.getposts());
        model.addAttribute("content", "free/free_posts.jsp");
        return "index";
    }


    @GetMapping("/{no}")
    public String detail(@PathVariable int no, Model model) {
        System.out.println(no);
        model.addAttribute("post", freeService.detailPost(no));
        model.addAttribute("content", "free/free_detail.jsp");
        return "index";
    }

    @DeleteMapping("/{delPk}")
    public String delete(@PathVariable int delPk) {
        System.out.println("2222");
        freeService.deletePost(delPk);
        return "redirect:/free";
    }

}





