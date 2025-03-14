package com.bbs.main.service;

import com.bbs.main.mapper.FreeMapper;
import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.FreeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
public class FreeService {

    @Autowired
    private FreeMapper freeMapper;

    public List<FreeVO> getposts() {
        return freeMapper.getposts();
    }

    public FreeVO detailPost(int post_id) {
        return freeMapper.detailPost(post_id);
    }

    public int deletePost(int post_id) {
        return freeMapper.deletePost(post_id);
    }

    public void addPost(FreeVO freeVO, MultipartFile post_file) {
        if (post_file.getOriginalFilename().length() != 0) {
            String originName = post_file.getOriginalFilename();
            String fileExtension = originName.substring(originName.lastIndexOf("."), originName.length());
            System.out.println(fileExtension);
            String uploadFolder = "/Users/kimsuhyeon/Desktop/final_img";
            UUID uuid = UUID.randomUUID();
            System.out.println(uuid);
            String[] uuids = uuid.toString().split("-");
            System.out.println(uuids[0]);
            String fileName = uuids[0] + fileExtension;
            File saveFile = new File(uploadFolder + "/" + fileName);
            try {
                post_file.transferTo(saveFile);
                freeVO.setPost_image(fileName);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        freeMapper.addPost(freeVO);
    }

    public void updatePost(FreeVO freeVO, MultipartFile post_file) {
        // 기존 게시글 조회
        FreeVO existingPost = freeMapper.detailPost(freeVO.getPost_id());

        // 기존 게시글이 존재하는지 확인
        if (existingPost == null) {
            throw new IllegalArgumentException("해당 게시글이 존재하지 않습니다: ID=" + freeVO.getPost_id());
        }

        String uploadFolder = "/Users/kimsuhyeon/Desktop/final_img";

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
                freeVO.setPost_image(fileName);
            } catch (IOException e) {
                throw new RuntimeException("파일 저장 실패", e);
            }
        } else {
            // 이미지 수정 안 할 경우 기존 이미지 유지
            freeVO.setPost_image(existingPost.getPost_image());
        }
        // DB 업데이트 실행
        freeMapper.updatePost(freeVO);
    }

    public List<FreeReplyVO> getReplys(int post_id) {
        return freeMapper.getReplys(post_id);
    }

    public int addReply(FreeReplyVO freeReplyVO) {
        return freeMapper.addReply(freeReplyVO);
    }
}
