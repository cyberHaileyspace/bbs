package com.bbs.main.controller;

import com.bbs.main.service.TourService;
import com.bbs.main.vo.TourCommentVO;
import com.bbs.main.vo.TourVO;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/main/tour")
public class TourC {


    @Autowired
    private TourService tourService;

    @GetMapping("/loc")
    public String getAttractionDataByLoc(@RequestParam(required = false) String areaCode,
                                         @RequestParam(required = false) String sigungu,
                                         @RequestParam(required = false) String sort,
                                         @RequestParam(required = false, defaultValue = "1") int pageNo,
                                         Model model) {
        List<TourVO> tourList = tourService.getAllLocation(areaCode, sigungu, sort);
        model.addAttribute("result", tourList);
        // 추가로 페이징 관련 정보(예: totalPages, currentPage 등)를 model에 담아 JSP에서 사용할 수 있게 함.
        model.addAttribute("areaCode", areaCode);
        model.addAttribute("sigungu", sigungu);
        model.addAttribute("sort", sort);
        model.addAttribute("pageNo", pageNo);
        model.addAttribute("content", "wh/tour.jsp");
        return "index";
    }


    @GetMapping("/getLoc")
    public String getLoc(Model model, String contentid) {
        model.addAttribute("common", tourService.getDetailCommon(contentid));
        model.addAttribute("intro", tourService.getDetailIntro(contentid));
        List<TourCommentVO> commentList = tourService.getComment(Integer.parseInt(contentid));
        model.addAttribute("content", "wh/tour_place.jsp");
        model.addAttribute("commentList", commentList);
        return "index";
    }

}
