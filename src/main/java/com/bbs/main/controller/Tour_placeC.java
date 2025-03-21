package com.bbs.main.controller;

import com.bbs.main.service.TourService;
import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.TourCommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/main/tour/reply")
public class Tour_placeC {

    @Autowired
    private TourService tourService;

    @GetMapping("/{post_id}")
   public List<TourCommentVO> list(@PathVariable("post_id") int post_id){
        List<TourCommentVO> replies = tourService.getComment(post_id);
        System.out.println(replies);
        return tourService.getComment(post_id);
    }

    @PostMapping
    public int add(@RequestBody TourCommentVO tourCommentVO){
        System.out.println(tourCommentVO);
        return tourService.addComment(tourCommentVO);
    }

    @PutMapping
    public int update(@RequestBody TourCommentVO tourCommentVO){
        System.out.println(tourCommentVO);
        return tourService.updateReply(tourCommentVO);
    }

    @DeleteMapping("/{r_id}")
    public int delete(@PathVariable("r_id") int r_id){
        System.out.println(r_id);
        return tourService.deleteReply(r_id);
    }




}
