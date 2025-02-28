package com.bbs.main.controller;

import com.bbs.main.service.BoardFreeService;
import com.bbs.main.vo.PostFreeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController

public class BoardFreeC {

    @Autowired
    private BoardFreeService boardFreeService;

    @GetMapping("/all")
    public List<PostFreeVO> posts() {
        return boardFreeService.getposts();
    }
    @GetMapping("/{p_no}")
    public String getpost() {

 return "aa";
    }






}
