package com.bbs.main.service;

import com.bbs.main.mapper.UserMapper;
import com.bbs.main.vo.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public boolean loginChk(HttpSession session) {
        UserVO user = (UserVO) session.getAttribute("user");
        return user != null;
    }

    public void regUser(UserVO registerVO, MultipartFile user_file) {
        /* registerMapper.regUser(registerVO); */
        if (user_file.getOriginalFilename().length() != 0) {

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
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        userMapper.regUser(registerVO);
    }

    public String loginuser(UserVO registerVO, HttpSession httpSession) {
        UserVO user = userMapper.login(registerVO);
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

    public String pwreset(UserVO registerVO) {
        int result = userMapper.pwreset(registerVO);
        if (result == 1) {
            return "비밀번호가 변경되었습니다.";
        } else {
            return "아이디가 존재하지 않습니다.";
        }
    }

    public boolean idcheck(String userId) {
        return userMapper.idcheck(userId) > 0;
    }

    public boolean nickcheck(String userNick) {
        return userMapper.nickcheck(userNick) > 0;
    }

    public boolean emailcheck(String userEmail) {
        return userMapper.emailcheck(userEmail) > 0;
    }

    public String updateUser(UserVO registerVO) {
        int result = userMapper.updateUser(registerVO);
        if (result == 1) {
            return "내 정보가 변경되었습니다.";
        } else {
            return "변경할 수 없습니다";
        }
    }

    public List<FreeVO> getMyFreePosts(String user_id) {
        return userMapper.getMyFreePosts(user_id);
    }

    public List<LifeVO> getMyLifePosts(String user_id) {
        return userMapper.getMyLifePosts(user_id);
    }

    public List<FreeReplyVO> getMyFreePostReplies(String user_nickname) {
        return userMapper.getMyFreePostReplies(user_nickname);
    }

    public List<LifeReplyVO> getMyLifePostReplies(String user_nickname) {
        return userMapper.getMyLifePostReplies(user_nickname);
    }
}
