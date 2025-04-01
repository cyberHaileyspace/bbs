package com.bbs.main.controller;

import com.bbs.main.service.*;
import com.bbs.main.vo.FreeVO;
import com.bbs.main.vo.LifeVO;
import com.bbs.main.vo.ToiletVO;
import com.bbs.main.vo.TourVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@RequestMapping("/main")
@Controller
public class MainC {

    @Autowired
    private LifeService lifeService;

    @Autowired
    private UserService userService;

    @Autowired
    private FreeService freeService;

    @Autowired
    private TourService tourService;

    @Autowired
    private ToiletService toiletService;

    @GetMapping
    public String main(Model model) {
        model.addAttribute("content", "tour/main.jsp");
        return "index";
    }

    @GetMapping("/life")
    public String life(Model model) {
        model.addAttribute("content", "life/life.jsp");
        return "index";
    }

    @ResponseBody
    @GetMapping("/life/all")
    public List<LifeVO> lifesearch(@RequestParam(defaultValue = "", required = false) String title) {
        System.out.println(title);
        return lifeService.searchposts(title);
    }

    @GetMapping("/tour")
    public String tour(Model model) {
        model.addAttribute("posts", tourService.getposts());
        model.addAttribute("content", "tour/tour_board.jsp");
        return "index";
    }

    @ResponseBody
    @GetMapping("/tour/all")
    public List<TourVO> getAllTourPosts() {
        return tourService.getposts();
    }

    @GetMapping("/free")
    public String list(Model model) {
        model.addAttribute("content", "free/free_posts.jsp");
        return "index";
    }

    @ResponseBody
    @GetMapping("/free/all")
    public List<FreeVO> freesearch(@RequestParam(defaultValue = "", required = false) String title) {
        System.out.println(title);
        return freeService.searchposts(title);
    }

    @GetMapping("/news")
    public String news(Model model) {
        model.addAttribute("content", "news.jsp");
        return "index";
    }


    @GetMapping("/toilet") // 🚽 추가
    public String toilet(Model model) {

        model.addAttribute("content", "toilet/toilet_posts.jsp");
        return "index";
    }

    @ResponseBody
    @GetMapping("/toilet/all") // 🚽 추가
    public List<ToiletVO> toiletsearch(@RequestParam(defaultValue = "", required = false) String title) {
        System.out.println(title);
        return toiletService.searchposts(title);
    }

}
