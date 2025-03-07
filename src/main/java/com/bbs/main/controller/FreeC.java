package com.bbs.main.controller;

import com.bbs.main.vo.LifeWriteVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import com.bbs.main.service.FreeService;
import com.bbs.main.vo.FreeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RequestMapping("/main/free")
@Controller
public class FreeC {
    @Autowired
    private FreeService freeService;

//    @PostMapping
//    public String add(LifeWriteVO lifeWriteVO, Model model, MultipartFile post_file, HttpSession session) {
//        if (registerService.loginChk(session)) {
//            lifeWriteService.regWrite(lifeWriteVO, post_file);
//            return "redirect:life";
//        }
//        return "redirect:/login";
//    }

    @GetMapping("/{no}")
    public String detail(@PathVariable int no, Model model) {
        System.out.println(no);
        model.addAttribute("post", freeService.detailPost(no));
        model.addAttribute("content", "free/free_detail.jsp");
        return "index";
    }

    @DeleteMapping("/{delPk}")
    public String delete(@PathVariable int delPk) {
        /*System.out.println("2222");*/
        freeService.deletePost(delPk);
        return "redirect:/main/free";
    }

}





