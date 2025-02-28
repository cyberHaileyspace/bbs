package com.bbs.main.controller;

import com.bbs.main.service.RegisterService;
import com.bbs.main.vo.RegisterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

@Controller
public class RegisterC {

    @Autowired
    private RegisterService registerService;

    @GetMapping("register")
    public String registerpage(Model model){
        model.addAttribute("content", "jm/register.jsp");
        return "index";
    }

    @GetMapping("login")
    public String loginpage(Model model){
        model.addAttribute("content", "jm/login.jsp");
        return "index";
    }

    @PostMapping("register")
    public String register(RegisterVO registerVO) {
        registerService.regUser(registerVO);
        return "redirect:/register";
    }

    @PostMapping("login")
    public String login(RegisterVO registerVO, RedirectAttributes redirectAttributes) {
        Map<String, Object> user = registerService.loginuser(registerVO);

        if (user != null) {
            return "redirect:/register";
        } else {
            redirectAttributes.addFlashAttribute("error", "ログイン失敗。IDまたはパスワードを確認してください。");
            return "redirect:/login";
        }
    }

    @GetMapping("pwreset")
    public String pwresetpage(Model model) {
        model.addAttribute("content", "jm/pwreset.jsp");
        return "index";
    }

    @PostMapping("pwreset")
    public String pwresetpage(RegisterVO registerVO) {
        registerService.pwreset(registerVO);
        return "redirect:/register";
    }
}
