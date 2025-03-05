package com.bbs.main.controller;

import com.bbs.main.service.TourService;
import com.bbs.main.vo.TourVO;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping("/tour")
@Controller
public class TourC {

    private TourService tourService;

    public TourC(TourService tourService) {
        this.tourService = tourService;
    }

    @GetMapping("/life")
    public String life() {
        return "life";
    }


    @GetMapping("/board_free")
    public String board_free() {
        return "board_free";
    }


    @GetMapping("/tour")
    public String getTourList(Model model) {
        List<TourVO> tourList = tourService.getTourList();
        model.addAttribute("tour", tourList);
        return "wh/tour"; // tourList.jsp 또는 tourList.html로 연결
    }
}
