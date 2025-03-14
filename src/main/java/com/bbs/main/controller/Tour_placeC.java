package com.bbs.main.controller;

import com.bbs.main.service.TourService;
import com.bbs.main.vo.TourCommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

//@RequestMapping("/main/tour")
@RestController
public class Tour_placeC {

    @Autowired
    private TourService tourService;

//    @GetMapping("/getLoc/comment")
//    public List<TourCommentVO> getTourComment(@RequestParam int contentid) {
//        System.out.println(contentid);
//        return TourService.getComment(contentid);
//
//    }







}
