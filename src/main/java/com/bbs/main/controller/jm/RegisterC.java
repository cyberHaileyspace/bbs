package com.bbs.main.controller.jm;

import com.bbs.main.service.jm.RegisterService;
import com.bbs.main.vo.jm.RegisterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RegisterC {

    @Autowired
    private RegisterService registerService;

    @GetMapping("user-reg")
    public String userreg(RegisterVO registerVO){
        registerService.regUser(registerVO);
        return "jm/register";
    }
}
