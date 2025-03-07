package com.bbs.main.controller;

import com.bbs.main.service.LifeWriteService;
import com.bbs.main.service.UserService;
import com.bbs.main.vo.LifeWriteVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RequestMapping("/main/life")
@Controller
public class LifeC {

    @Autowired
    private LifeWriteService lifeWriteService;

    @Autowired
    private UserService userService;

    @GetMapping("/write")
    public String write(Model model) {
        model.addAttribute("content", "life/writelife.jsp");
        return "index";
    }

    @PostMapping("/reg")
    public String register(LifeWriteVO lifeWriteVO, Model model, MultipartFile post_file, HttpSession session) {
        if (userService.loginChk(session)) {
            lifeWriteService.regWrite(lifeWriteVO, post_file);
            return "redirect:/main/life";
        }
        return "redirect:/login";
    }

    @GetMapping("/{no}")
    public String detail(@PathVariable int no, Model model) {
        model.addAttribute("post", lifeWriteService.getWrite(no));
        model.addAttribute("content", "life/lifedetail.jsp");
        return "index";
    }

    @DeleteMapping("/{delPk}")
    public String delete(@PathVariable int delPk) {
        /*System.out.println("2222");*/
        lifeWriteService.deletePost(delPk);
        return "redirect:/main/life";
    }
}
