package com.bbs.main.controller;

import com.bbs.main.service.LifeService;
import com.bbs.main.service.UserService;
import com.bbs.main.vo.UserVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
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
public class UserC {

    @Autowired
    private UserService userService;
    @Autowired
    private HttpSession httpSession;

    @GetMapping("user")
    public String userpage(Model model) {
        model.addAttribute("content", "life/user.jsp");
        return "index";
    }

    @GetMapping("login")
    public String loginpage(Model model) {
        model.addAttribute("content", "life/login.jsp");
        return "index";
    }

    @GetMapping("update")
    public String updatepage(Model model) {
        model.addAttribute("content", "life/update.jsp");
        return "index";
    }

    @PostMapping("user")
    public String user(UserVO registerVO, Model model, MultipartFile user_file) {
        System.out.println(registerVO);
        System.out.println(user_file.getOriginalFilename());
        userService.regUser(registerVO, user_file);
        model.addAttribute("content", "main.jsp");
        return "index";
    }

    @PostMapping("login")
    public String login(UserVO registerVO, RedirectAttributes redirectAttributes, Model model, HttpSession session) {
        String msg = userService.loginuser(registerVO, session);

        if (msg.equals("로그인 되었습니다.")) {
            /*RegisterVO user = registerMapper.login(registerVO);
            session.setAttribute("user", user);*/
            model.addAttribute("content", "wh/main.jsp");
            return "index";
        } else {
            redirectAttributes.addFlashAttribute("error", "ログイン失敗。IDまたはパスワードを確認してください。");
            return "redirect:/login";
        }
    }

    @GetMapping("pwreset")
    public String pwresetpage(Model model) {
        model.addAttribute("content", "life/pwreset.jsp");
        return "index";
    }

    @PostMapping("pwreset")
    public String pwresetpage(UserVO registerVO, RedirectAttributes redirectAttributes, Model model) {
        String msg = userService.pwreset(registerVO);

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
    public String mypage(Model model, HttpSession session) {
        UserVO user = (UserVO) session.getAttribute("user");
        // 내 글 / 댓글 로드
        if (userService.loginChk(session)) {
            model.addAttribute("freePosts", userService.getMyFreePosts(user.getUser_nickname()));
            model.addAttribute("lifePosts", userService.getMyLifePosts(user.getUser_nickname()));
            model.addAttribute("freePostReplies", userService.getMyFreePostReplies(user.getUser_nickname()));
            model.addAttribute("lifePostReplies", userService.getMyLifePostReplies(user.getUser_nickname()));
            model.addAttribute("content", "life/mypage.jsp");
        } else {
            return "redirect:login";
        }
        return "index";
    }

    @PostMapping("/idcheck")
    public ResponseEntity<Map<String, Boolean>> idcheck(@RequestBody Map<String, String> request) {
        String userId = request.get("user_id");
        boolean exists = userService.idcheck(userId);
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/nickcheck")
    public ResponseEntity<Map<String, Boolean>> nickcheck(@RequestBody Map<String, String> request) {
        String userNick = request.get("user_nick");
        boolean exists = userService.nickcheck(userNick);
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/emailcheck")
    public ResponseEntity<Map<String, Boolean>> emailcheck(@RequestBody Map<String, String> request) {
        String userEmail = request.get("user_email");
        boolean exists = userService.emailcheck(userEmail);
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);
        return ResponseEntity.ok(response);
    }

    @PostMapping("update")
    public String updatepage(UserVO registerVO, RedirectAttributes redirectAttributes, Model model) {
        String msg = userService.updateUser(registerVO);
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

    /*
    public List<Post> getUserPosts(@AuthenticationPrincipal User user) {
        return postService.getPostsByUser(user.getUserId());
    }*/


}
