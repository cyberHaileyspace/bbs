package com.bbs.main.controller;

import com.bbs.main.service.LifeService;
import com.bbs.main.vo.LifeReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/main/tour/reply")
@RestController
public class Tour_boardAPI {
//    @Autowired
//    private LifeService lifeService;
//
//    @GetMapping("/{post_id}")
//    public List<LifeReplyVO> list(@PathVariable("post_id") int post_id/*,  @RequestParam(required = false) String token*/) {
//        List<LifeReplyVO> replies = lifeService.getReplys(post_id);
//        System.out.println(post_id + ", Replies" + replies);
//        return lifeService.getReplys(post_id); // 댓글 리스트를 JSON으로 반환
//    }
//
//    @PostMapping
//    public int add(@RequestBody LifeReplyVO lifeReplyVO) {
//        return lifeService.addReply(lifeReplyVO);
//    }
//
//    @PutMapping // 경로에 ID 포함
//    public int update(@RequestBody LifeReplyVO lifeReplyVO) {
//        System.out.println(lifeReplyVO);
//        return lifeService.updateReply(lifeReplyVO);
//    }
//
//    @DeleteMapping("/{r_id}")
//    public int delete(@PathVariable("r_id") int r_id) {
//        System.out.println(r_id);
//        return lifeService.deleteReply(r_id);
//    }
}
