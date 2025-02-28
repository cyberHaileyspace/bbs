package com.bbs.main.controller;

import com.bbs.main.service.RegisterService;
import com.bbs.main.vo.RegisterVO;
import jakarta.servlet.http.HttpSession;
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
    @Autowired
    private HttpSession httpSession;

    @GetMapping("register")
    public String registerpage(Model model) {
        model.addAttribute("content", "jm/register.jsp");
        return "index";
    }

    @GetMapping("login")
    public String loginpage(Model model) {
        model.addAttribute("content", "jm/login.jsp");
        return "index";
    }

    @PostMapping("register")
    public String register(RegisterVO registerVO, Model model) {
        System.out.println(registerVO);
        registerService.regUser(registerVO);
        model.addAttribute("content", "main.jsp");
        return "index";
    }

    @PostMapping("login")
    public String login(RegisterVO registerVO, RedirectAttributes redirectAttributes, Model model, HttpSession session) {
        String msg = registerService.loginuser(registerVO, session);

        if (msg.equals("로그인 되었습니다.")) {
            /*RegisterVO user = registerMapper.login(registerVO);
            session.setAttribute("user", user);*/
            model.addAttribute("content", "main.jsp");
            return "index";
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
    public String pwresetpage(RegisterVO registerVO, RedirectAttributes redirectAttributes, Model model) {
        String msg = registerService.pwreset(registerVO);

        if (msg.equals("비밀번호가 변경되었습니다.")) {
            /*RegisterVO user = registerMapper.login(registerVO);
            session.setAttribute("user", user);*/
            model.addAttribute("contentlogin", "index.jsp");
            return "redirect:/login";
        } else {
            redirectAttributes.addFlashAttribute("error", "IDを確認してください。");
            return "redirect:/login";
        }
    }

    @GetMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();  // 세션 무효화 (로그아웃 처리)
        return "redirect:/";  // 홈 페이지로 리다이렉트
    }

    @GetMapping("mypage")
    public String mypage(Model model) {
        model.addAttribute("content", "jm/mypage.jsp");
        return "index";
    }
}
