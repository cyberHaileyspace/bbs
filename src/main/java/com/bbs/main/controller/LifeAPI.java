package com.bbs.main.controller;

import com.bbs.main.service.FreeService;
import com.bbs.main.service.LifeService;
import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.LifeReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/main/life/reply")
@RestController
public class LifeAPI {
    @Autowired
    private LifeService lifeService;



    @GetMapping("/{post_id}")
    public List<LifeReplyVO> list(@PathVariable("post_id") int post_id,  @RequestParam(required = false) String token) {
        List<LifeReplyVO> replies = lifeService.getReplys(post_id);
        /*System.out.println(post_id + ", Replies" + replies);*/
        return lifeService.getReplys(post_id); // 댓글 리스트를 JSON으로 반환
    }

    @PostMapping
    public int add(@RequestBody LifeReplyVO lifeReplyVO) {
        return lifeService.addReply(lifeReplyVO);
    }
}
