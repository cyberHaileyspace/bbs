package com.bbs.main.controller;

import com.bbs.main.service.RegisterService;
import com.bbs.main.vo.RegisterVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
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

    @GetMapping("update")
    public String updatepage(Model model) {
        model.addAttribute("content", "jm/update.jsp");
        return "index";
    }

    @PostMapping("register")
    public String register(RegisterVO registerVO, Model model, MultipartFile user_file) {
        System.out.println(registerVO);
        System.out.println(user_file.getOriginalFilename());
        registerService.regUser(registerVO, user_file);
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
            model.addAttribute("content", "index.jsp");
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

    @PostMapping("/idcheck")
    public ResponseEntity<Map<String, Boolean>> idcheck(@RequestBody Map<String, String> request) {
        String userId = request.get("user_id");
        boolean exists = registerService.idcheck(userId);
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/nickcheck")
    public ResponseEntity<Map<String, Boolean>> nickcheck(@RequestBody Map<String, String> request) {
        String userNick = request.get("user_nick");
        boolean exists = registerService.nickcheck(userNick);
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/emailcheck")
    public ResponseEntity<Map<String, Boolean>> emailcheck(@RequestBody Map<String, String> request) {
        String userEmail = request.get("user_email");
        boolean exists = registerService.emailcheck(userEmail);
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);
        return ResponseEntity.ok(response);
    }

    @PostMapping("update")
    public String updatepage(RegisterVO registerVO, RedirectAttributes redirectAttributes, Model model) {
        String msg = registerService.updateUser(registerVO);
        System.out.println(111);
        if (msg.equals("내 정보가 변경되었습니다.")) {
            /*RegisterVO user = registerMapper.login(registerVO);
            session.setAttribute("user", user);*/
            model.addAttribute("content", "index.jsp");
            return "redirect:/update";
        } else {
            redirectAttributes.addFlashAttribute("error", "IDを確認してください。");
            return "redirect:/login";
        }
    }

}
