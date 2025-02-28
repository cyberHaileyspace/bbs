package com.bbs.main.controller;

import com.bbs.main.service.BoardFreeService;
import com.bbs.main.vo.PostFreeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController

public class BoardFreeAPI {

    @Autowired
    private BoardFreeService boardFreeService;

    @GetMapping("/board-json")
    public List<PostFreeVO> posts() {
        return boardFreeService.getposts();
    }






}
