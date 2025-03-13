package com.bbs.main.controller;

import com.bbs.main.service.TourService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("getTour")
@RestController
public class Tour_placeC {

    @Autowired
    TourService tourService;






}
