package com.bbs.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import com.bbs.main.service.BoardFreeService;
import com.bbs.main.vo.PostFreeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
@RequestMapping("boardFree")
@Controller
public class BoardFreeC {
    @Autowired
    private BoardFreeService boardFreeService;

    @GetMapping("/detail")
    public String detailPost(PostFreeVO postFreeVO, Model model) {
        System.out.println("11222");
       PostFreeVO newPost = boardFreeService.detailPost(postFreeVO);
        model.addAttribute("post", newPost);
        model.addAttribute("content", "board_free/board_free_detail.jsp");
        System.out.println(postFreeVO);
        return "index";
    }

}





