package com.bbs.main.controller;

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
public class LifeC {

    @Autowired
    private LifeWriteService lifeWriteService;

    @Autowired
    private UserService userService;

    @GetMapping("/write")
    public String write(Model model) {
        model.addAttribute("content", "jm/writelife.jsp");
        return "index";
    }

    @PostMapping("/writereg")
    public String register(LifeWriteVO lifeWriteVO, Model model, MultipartFile post_file, HttpSession session) {
        if (userService.loginChk(session)) {
            lifeWriteService.regWrite(lifeWriteVO, post_file);
            return "redirect:life";
        }
        return "redirect:/login";
    }

    @GetMapping("/postlife")
    public String detail(int no, Model model) {
        model.addAttribute("post", lifeWriteService.getWrite(no));
        model.addAttribute("content", "jm/lifedetail.jsp");
        return "index";
    }
}
