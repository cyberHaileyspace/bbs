package com.bbs.main.controller;

import com.bbs.main.service.TourService;
import com.bbs.main.vo.TourVO;
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
         model.addAttribute("result", tourService.getAttractionDataByLoc(areaCode,sigungu));
         model.addAttribute("content", "wh/tourTest.jsp");
         return "index";
    }
}
