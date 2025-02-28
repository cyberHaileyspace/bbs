package com.bbs.main.service;


import com.bbs.main.mapper.RegisterMapper;
import com.bbs.main.vo.RegisterVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class RegisterService {

    @Autowired
    private RegisterMapper registerMapper;

    public void regUser(RegisterVO registerVO) {
     registerMapper.regUser(registerVO);
    }

    public String loginuser(RegisterVO registerVO, HttpSession httpSession) {
        RegisterVO user = registerMapper.login(registerVO);
        if (user != null) {
            if (registerVO.getUser_pw().equals(user.getUser_pw())) {
                httpSession.setAttribute("user", user);
                return "로그인 되었습니다.";
            } else {
                return "비밀번호가 일치하지 않습니다.";
            }
        } else {
            return "아이디가 일치하지 않습니다.";
        }
    }

    public String pwreset(RegisterVO registerVO) {
        int result = registerMapper.pwreset(registerVO);
        if (result == 1) {
                return "비밀번호가 변경되었습니다.";
            } else {
                return "아이디가 존재하지 않습니다.";
            }
        }
        }
