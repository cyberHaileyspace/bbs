package com.bbs.main.controller;

import com.bbs.main.service.FreeService;
import com.bbs.main.vo.FreeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequestMapping("/free")
@RestController
public class FreeAPI {
    @Autowired
    private FreeService boardFreeService;

    @GetMapping("/all")
    public List<FreeVO> posts() {
        return boardFreeService.getposts();
    }
}
