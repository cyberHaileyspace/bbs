package com.bbs.main.controller;

import com.bbs.main.service.FreeService;
import com.bbs.main.vo.FreeReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/main/free/reply")
@RestController
public class FreeAPI {
    @Autowired
    private FreeService freeService;

    @GetMapping("/{post_id}")
    public List<FreeReplyVO> list(@PathVariable("post_id") int post_id) {
        List<FreeReplyVO> replies = freeService.getReplys(post_id);
        System.out.println(post_id + ", Replies" + replies);
        return freeService.getReplys(post_id); // 댓글 리스트를 JSON으로 반환
    }

    @PostMapping
    public int add(@RequestBody FreeReplyVO freeReplyVO) {
        return freeService.addReply(freeReplyVO);
    }

    @PutMapping // 경로에 ID 포함
    public int update(@RequestBody FreeReplyVO freeReplyVO) {
      System.out.println(freeReplyVO);
        return freeService.updateReply(freeReplyVO);
    }

    @DeleteMapping("/{r_id}")
    public int delete(@PathVariable("r_id") int r_id) {
        System.out.println(r_id);
        return freeService.deleteReply(r_id);
    }

}
