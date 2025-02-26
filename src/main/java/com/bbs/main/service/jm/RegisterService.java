package com.bbs.main.service.jm;


import com.bbs.main.mapper.jm.RegisterMapper;
import com.bbs.main.vo.jm.RegisterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegisterService {

    @Autowired
    private RegisterMapper registerMapper;


    public void regUser(RegisterVO registerVO) {
            registerMapper.addUser(registerVO);
    }
}
