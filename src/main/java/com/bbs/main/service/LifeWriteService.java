package com.bbs.main.service;

import com.bbs.main.mapper.LifeWriteMapper;
import com.bbs.main.vo.LifeWriteVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
public class LifeWriteService {

    @Autowired
    private LifeWriteMapper lifeWriteMapper;

    public List<LifeWriteVO> getLifeWrite() {
        return lifeWriteMapper.getLifeWrite();
    }

    public void regWrite(LifeWriteVO lifeWriteVO, MultipartFile post_file) {
        if (post_file.getOriginalFilename().length() != 0){
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
            lifeWriteVO.setPost_image(fileName);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        }
        lifeWriteMapper.regWrite(lifeWriteVO);
    }
}
