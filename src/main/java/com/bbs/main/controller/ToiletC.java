package com.bbs.main.controller;

import com.bbs.main.service.ToiletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller

@Autowired ToiletService toiletService;
@GetMapping("/")