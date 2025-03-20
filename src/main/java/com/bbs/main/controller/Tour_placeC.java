package com.bbs.main.controller;

import com.bbs.main.service.TourService;
import com.bbs.main.vo.TourCommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/tour")
public class Tour_placeC {

    @Autowired
    private TourService tourService;

//    // 상세페이지 (댓글 포함)
//    @GetMapping("/getLoc")
//    public String getLoc(Model model, @RequestParam String contentid) {
//        model.addAttribute("common", tourService.getDetailCommon(contentid));
//        model.addAttribute("intro", tourService.getDetailIntro(contentid));
//        // 댓글 목록도 함께 모델에 추가
//        List<TourCommentVO> commentList = tourService.getComment(Integer.parseInt(contentid));
//        model.addAttribute("content", "wh/tour_place.jsp");
//        model.addAttribute("commentList", commentList);
//        System.out.println(commentList);
//        return "index";
//    }

    // 댓글 작성 처리 (동기식)
    @PostMapping("/comment")
    public String addComment(TourCommentVO comment) {
        System.out.println(comment);
        // comment VO에는 contentid, c_writer, c_context가 담겨있어야 함.
        tourService.addComment(comment);
        // 댓글 작성 후 상세 페이지로 리다이렉트 (GET 요청)
        return "redirect:/main/tour/getLoc?contentid=" + comment.getContentid();
    }

    // 댓글 삭제 처리 (동기식)
    @PostMapping("/comment/delete")
    public String deleteComment(@RequestParam int c_id, @RequestParam int contentid) {
        tourService.removeComment(c_id);
        return "redirect:/main/tour/getLoc?contentid=" + contentid;
    }
}
