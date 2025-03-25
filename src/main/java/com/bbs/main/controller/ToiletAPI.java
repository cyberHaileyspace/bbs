package com.bbs.main.controller;
import com.bbs.main.service.ToiletService;
import com.bbs.main.vo.ToiletVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/main/toilet")
@RestController     // @Controller + @ResponseBody
public class ToiletAPI {

    // rest API 더 예쁘게
    // Get     /products
    // Get     /products/{id}
    // Post    /products
    // Put     /products/{id}
    // DELETE  /products/{id}
    @Autowired
    private ToiletService toiletService;

    @GetMapping("/all")
    public List<ToiletVO> list(){
        return toiletService.getProducts();
    }

    @GetMapping("/{no}")
    public void detail(@PathVariable int no){
        System.out.println(no);
    }

    @DeleteMapping("/{no}")
    public int delete(@PathVariable int no){
        System.out.println(no);
        return toiletService.delProduct(no);
    }

    @PutMapping()
    public int update(@RequestBody ToiletVO toiletVO) {
        System.out.println(toiletVO);
        return toiletService.upProduct(toiletVO);
    }
}