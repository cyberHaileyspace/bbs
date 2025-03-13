package com.bbs.main.controller;

import com.bbs.main.service.TourService;
import com.bbs.main.vo.TourVO;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/tour")
public class TourC {

    @Autowired
    private TourService tourService;

    @PostMapping("/loc")
    public String getAttractionDataByLoc(@RequestParam String areaCode, @RequestParam String sigungu, Model model) {
        List<TourVO> tourList =  tourService.getAllLocation(areaCode,sigungu);
//        String tourJson = new Gson().toJson(tourList);
//        model.addAttribute("resultJson", tourJson);  // json
         model.addAttribute("result", tourList); // java
         model.addAttribute("content", "wh/tour.jsp");
         return "index";
    }

    @GetMapping("/getLoc")
    public String getLoc(Model model, String contentid) {
        model.addAttribute("common", tourService.getDetailCommon(contentid));
        model.addAttribute("intro", tourService.getDetailIntro(contentid));

        model.addAttribute("content", "wh/tour_place.jsp");
        return "index";
    }

}
