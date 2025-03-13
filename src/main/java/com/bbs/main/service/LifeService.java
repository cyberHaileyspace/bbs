package com.bbs.main.service;

import com.bbs.main.mapper.LifeMapper;
import com.bbs.main.vo.LifeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
public class LifeService {

    @Autowired
    private LifeMapper lifeMapper;

    public List<LifeVO> getLifeWrite() {
        return lifeMapper.getLifeWrite();
    }

    public void regPost(LifeVO lifeVO, MultipartFile post_file) {
        if (post_file.getOriginalFilename().length() != 0) {
            String originName = post_file.getOriginalFilename();
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
                post_file.transferTo(saveFile);
                lifeVO.setPost_image(fileName);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        lifeMapper.regPost(lifeVO);
    }

    public LifeVO getPost(int no) {
        return lifeMapper.getPost(no);
    }

    public int getCount(int no) {
        return lifeMapper.getCount(no);
    }

    public int deletePost(int no) {
        return lifeMapper.deletePost(no);
    }

    public void updatePost(LifeVO lifeVO, MultipartFile post_file) {
        if (post_file.getOriginalFilename().length() != 0) {
            String originName = post_file.getOriginalFilename();
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
                post_file.transferTo(saveFile);
                lifeVO.setPost_image(fileName);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        lifeMapper.updatePost(lifeVO);
    }
}
