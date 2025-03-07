package com.bbs.main.service;


import com.bbs.main.controller.RegisterC;
import com.bbs.main.mapper.RegisterMapper;
import com.bbs.main.vo.RegisterVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Service
public class RegisterService {

    @Autowired
    private RegisterMapper registerMapper;

    public boolean loginChk(HttpSession session) {
        RegisterVO user = (RegisterVO) session.getAttribute("user");
        return user != null;
    }

    public void regUser(RegisterVO registerVO, MultipartFile user_file) {
        /* registerMapper.regUser(registerVO); */
        String originName = user_file.getOriginalFilename();
        String fileExtension = originName.substring(originName.lastIndexOf("."), originName.length());
        System.out.println(fileExtension);
        String uploadFolder = "C:\\Users\\soldesk\\Desktop\\uploadFolder";
        UUID uuid = UUID.randomUUID();
        System.out.println(uuid);
        String[] uuids = uuid.toString().split("-");
        System.out.println(uuids[0]);
        String fileName = uuids[0] + fileExtension;
        File saveFile = new File(uploadFolder + "\\" + fileName);
        try {
            user_file.transferTo(saveFile);
            registerVO.setUser_image(fileName);
            registerMapper.regUser(registerVO);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
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

    public boolean idcheck(String userId) {
        return registerMapper.idcheck(userId) > 0;
    }

    public boolean nickcheck(String userNick) {
        return registerMapper.nickcheck(userNick) > 0;
    }

    public boolean emailcheck(String userEmail) {
        return registerMapper.emailcheck(userEmail) > 0;
    }

    public String updateUser(RegisterVO registerVO) {
        int result = registerMapper.updateUser(registerVO);
        if (result == 1) {
            return "내 정보가 변경되었습니다.";
        } else {
            return "변경할 수 없습니다";
        }
    }
}
