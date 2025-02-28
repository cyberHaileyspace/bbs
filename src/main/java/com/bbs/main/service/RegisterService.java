package com.bbs.main.service;


import com.bbs.main.mapper.RegisterMapper;
import com.bbs.main.vo.RegisterVO;
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

    public Map<String, Object> loginuser(RegisterVO registerVO) {
        return registerMapper.login(registerVO.getUser_id(), registerVO.getUser_pw());
    }

    public void pwreset(RegisterVO registerVO) {
        registerMapper.pwreset(registerVO);
    }
}
