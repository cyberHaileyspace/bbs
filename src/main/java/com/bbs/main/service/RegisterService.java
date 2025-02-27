package com.bbs.main.service;


import com.bbs.main.mapper.RegisterMapper;
import com.bbs.main.vo.RegisterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegisterService {

    @Autowired
    private RegisterMapper registerMapper;

    public void regUser(RegisterVO registerVO) {
            registerMapper.regUser(registerVO);
    }
}
