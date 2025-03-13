package com.bbs.main.controller;

import com.bbs.main.service.LifeService;
import com.bbs.main.service.UserService;
import com.bbs.main.vo.FreeVO;
import com.bbs.main.vo.LifeVO;
import com.bbs.main.vo.UserVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@RequestMapping("/main/life")
@Controller
public class LifeC {

    @Autowired
    private LifeService lifeService;

    @Autowired
    private UserService userService;

    @GetMapping("/logincheck")
    public ResponseEntity<?> logincheck(HttpSession session) {
        boolean logincheck = userService.loginChk(session);
        return ResponseEntity.ok().body(Collections.singletonMap("logincheck", logincheck));
    }

    @GetMapping("/reg")
    /*public ResponseEntity<?> write(HttpSession session) {
        boolean logincheck = userService.loginChk(session);
        return ResponseEntity.ok().body(Collections.singletonMap("logincheck", logincheck));
    }*/
    public String reg(Model model, HttpSession session) {
        if (userService.loginChk(session)) {
            model.addAttribute("content", "life/lifereg.jsp");
            return "index";
        }
        return "redirect:/login";

    }

    @PostMapping("/reg")
    public String register(LifeVO lifeVO, MultipartFile post_file, HttpSession session) {
        /*if (userService.loginChk(session)) {*/
        lifeService.regPost(lifeVO, post_file);
        return "redirect:/main/life";
        /*}
        return "redirect:/login";*/
    }

    @GetMapping("/{no}")
    public String detail(@PathVariable int no, String token, Model model, HttpSession session) {

        String sessionKey = "view_token_" + no;
        String lastToken = (String) session.getAttribute(sessionKey);

        if (lastToken == null || !lastToken.equals(token)) {
            lifeService.getCount(no);  // 조회수 증가
            session.setAttribute(sessionKey, token);  // 새로운 토큰 저장
        }

        UserVO user = (UserVO) session.getAttribute("user");
        String nickname = (user != null) ? user.getUser_nickname() : "";
        model.addAttribute("login_nickname", nickname);
        model.addAttribute("post", lifeService.getPost(no));
        model.addAttribute("content", "life/lifedetail.jsp");
        return "index";
    }

    /*@DeleteMapping("/{no}")
    public String delete(@PathVariable int no, HttpSession session) {
        if (userService.loginChk(session)) {
            lifeService.deletePost(no);
            return "redirect:/main/life";
        }
        return "redirect:/login";
    }*/

    @DeleteMapping("/{no}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> delete(@PathVariable int no, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        if (userService.loginChk(session)) {
            lifeService.deletePost(no);
            response.put("success", true);
            response.put("redirectUrl", "/main/life");
        } else {
            response.put("success", false);
            response.put("redirectUrl", "/login");
        }
        return ResponseEntity.ok(response);
    }

    @GetMapping("/update/{post_id}")
    public String update(Model model) {
        model.addAttribute("content", "life/lifeupdate.jsp");
        return "index";
    }

    @PostMapping("/update")
    public String update(int post_id, LifeVO lifeVO, MultipartFile post_file) {
        System.out.println(post_id + "post no : " + lifeVO.getPost_id());
        lifeService.updatePost(lifeVO, post_file);
        return "redirect:/main/life/" + post_id;
    }

    @GetMapping("/option")
    @ResponseBody  // JSON 반환
    public List<LifeVO> getsorts(@RequestParam("option") String option) {
        return lifeService.getsorts(option);
    }

    @GetMapping("/like/{post_id}")
    public String lifelike(@PathVariable("post_id") int no, Model model, HttpSession session) {
        if (userService.loginChk(session)) {
            lifeService.getCountLike(no);
            model.addAttribute("content", "life/lifedetail.jsp");
            return "index";
        }
        return "redirect:/login";
    }
}
