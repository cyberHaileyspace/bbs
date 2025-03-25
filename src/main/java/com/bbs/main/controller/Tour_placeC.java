package com.bbs.main.controller;

import com.bbs.main.service.TourService;
import com.bbs.main.vo.TourReplyVO;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/main/locReply")
public class Tour_placeC {

    @Autowired
    private TourService tourService;

    @GetMapping("/{post_id}")
   public List<TourReplyVO> list(@PathVariable("post_id") int post_id){
        List<TourReplyVO> replies = tourService.getComment(post_id);
        System.out.println(replies);
        return tourService.getComment(post_id);
    }
    @PostMapping
    public int add(@RequestBody TourReplyVO tourReplyVO) {
        System.out.println(tourReplyVO);
        return tourService.addComment(tourReplyVO);
    }
    @PutMapping
    public int update(@RequestBody TourReplyVO tourReplyVO){
        System.out.println(tourReplyVO);
        return tourService.updateReply(tourReplyVO);
    }
    @DeleteMapping("/{r_id}")
    public int delete(@PathVariable("r_id") int r_id){
        System.out.println(r_id);
        return tourService.deleteReply(r_id);
    }
}
