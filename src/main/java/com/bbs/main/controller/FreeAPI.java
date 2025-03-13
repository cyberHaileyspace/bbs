package com.bbs.main.controller;

import com.bbs.main.service.FreeService;
import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.FreeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

import java.util.List;

@RequestMapping("/main/free")
@RestController
public class FreeAPI {
    @Autowired
    private FreeService freeService;


    @GetMapping("/ReplyPost/{postId}")
    public List<FreeReplyVO> list(@PathVariable("postId") int postId) {
        System.out.println(postId);
        return freeService.getReplys(postId); // 댓글 리스트를 JSON으로 반환
    }
}
