package com.bbs.main.controller;

import com.bbs.main.service.TourService;
import com.bbs.main.vo.TourCommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController  // JSON 응답을 주기 위해 사용 (기존 @Controller 대신)
@RequestMapping("/tour/comment")
public class Tour_placeC {

    @Autowired
    private TourService tourService;

    // 댓글 작성 (비동기)
    @PostMapping("/add")
    public ResponseEntity<?> addComment(@RequestBody TourCommentVO comment) {
        tourService.addComment(comment);
        return ResponseEntity.ok().body("success");
    }

    // 댓글 삭제 (비동기)
    @DeleteMapping("/{c_id}")
    public ResponseEntity<?> deleteComment(@PathVariable int c_id) {
        tourService.removeComment(c_id);
        return ResponseEntity.ok().body("success");
    }

    // 댓글 수정 (비동기)
    @PutMapping("/update")
    public ResponseEntity<?> updateComment(@RequestBody TourCommentVO comment) {
        tourService.updateComment(comment);
        return ResponseEntity.ok().body("success");
    }

    // 댓글 목록 조회 (비동기)
    @GetMapping("/list")
    public ResponseEntity<List<TourCommentVO>> getComments(@RequestParam int contentid) {
        List<TourCommentVO> commentList = tourService.getComment(contentid);
        return ResponseEntity.ok(commentList);
    }
}
