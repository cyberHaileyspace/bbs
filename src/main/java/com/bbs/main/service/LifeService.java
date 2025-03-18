package com.bbs.main.service;

import com.bbs.main.mapper.LifeMapper;
import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.FreeVO;
import com.bbs.main.vo.LifeReplyVO;
import com.bbs.main.vo.LifeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
public class LifeService {

    @Autowired
    private LifeMapper lifeMapper;

    public List<LifeVO> getposts() {
        return lifeMapper.getposts();
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
        // 기존 게시글 조회
        LifeVO existingPost = lifeMapper.detailPost(lifeVO.getPost_id());

        // 기존 게시글이 존재하는지 확인
        if (existingPost == null) {
            throw new IllegalArgumentException("해당 게시글이 존재하지 않습니다: ID=" + lifeVO.getPost_id());
        }

        String uploadFolder = "C:\\Users\\soldesk\\Desktop\\uploadFolder";

        if (post_file != null && !post_file.isEmpty()) {
            String originName = post_file.getOriginalFilename();
            String fileExtension = originName.substring(originName.lastIndexOf("."));
            UUID uuid = UUID.randomUUID();
            String fileName = uuid.toString().split("-")[0] + fileExtension;
            File saveFile = new File(uploadFolder + "/" + fileName);
            try {
                // 새 파일 저장
                post_file.transferTo(saveFile);
                // 기존 이미지 삭제
                if (existingPost.getPost_image() != null) {
                    File oldFile = new File(uploadFolder + "/" + existingPost.getPost_image());
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }
                // 새 이미지 이름 업데이트
                lifeVO.setPost_image(fileName);
            } catch (IOException e) {
                throw new RuntimeException("파일 저장 실패", e);
            }
        } else {
            // 이미지 수정 안 할 경우 기존 이미지 유지
            lifeVO.setPost_image(existingPost.getPost_image());
        }
        // DB 업데이트 실행
        lifeMapper.updatePost(lifeVO);
    }

    public List<LifeVO> getsorts(String option) {
        switch (option) {
            case "new":
                return lifeMapper.getSortsNew();
            case "like":
                return lifeMapper.getSortsLike();
            case "view":
                return lifeMapper.getSortsView();
            default:
                return new ArrayList<>();
        }
    }

    public int getCountLike(int no) {
        return lifeMapper.getCountLike(no);
    }

    public List<LifeReplyVO> getReplys(int post_id) {
        return lifeMapper.getReplys(post_id);
    }

    public int addReply(LifeReplyVO lifeReplyVO) {
        return lifeMapper.addReply(lifeReplyVO);
    }

    public List<LifeVO> getcategory(String category) {
        switch (category) {
            case "전체":
                return lifeMapper.getAll(category);
            case "생활 정보":
                return lifeMapper.getLife(category);
            case "건강 정보":
                return lifeMapper.getHealth(category);
            case "질문":
                return lifeMapper.getQNA(category);
            case "후기":
                return lifeMapper.getAft(category);
            default:
                return new ArrayList<>();
        }
    }
}
