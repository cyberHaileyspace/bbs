package com.bbs.main.service;

import com.bbs.main.mapper.FreeMapper;
import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.FreeVO;
import com.bbs.main.vo.LifeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
public class FreeService {

    @Autowired
    private FreeMapper freeMapper;


    @Transactional
    public void updateLike(int no) {
        freeMapper.incrementLike(no);
    }

    public void updateUnlike(int no) { freeMapper.updateUnlike(no);

    }

    public int getLikeCount(int no) {
        return freeMapper.getLikeCount(no);
    }

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

    public int updateReply(FreeReplyVO freeReplyVO) {
        int result = freeMapper.updateReply(freeReplyVO);
        System.out.println("updateReply 실행 결과: " + result);
        return result;
    }

    public int deleteReply(int r_id) {
        return freeMapper.deleteReply(r_id);
    }

    public List<FreeVO> getsorts(String option) {
        switch (option) {
            case "new":
                return freeMapper.getSortsNew();
            case "like":
                return freeMapper.getSortsLike();
            case "view":
                return freeMapper.getSortsView();
            case "reply":
                return freeMapper.getSortsReply();
            default:
                return new ArrayList<>();
        }
    }

    public List<FreeVO> searchposts(String title) {
        return freeMapper.searchposts(title);
    }

    public List<FreeReplyVO> getReplysPaged(int post_id, int offset, int size) {
        List<FreeReplyVO> replies =  freeMapper.getPagedReplies(post_id, offset, size);
        return replies;
    }

    public int getTotalReplyCount(int post_id) {
        return freeMapper.countByPostId(post_id);
    }

    public int getCount(int postId) {
        return freeMapper.getCount(postId);
    }

    @Transactional
    public void updateReplyLike(int no) {
        freeMapper.incrementReplyLike(no);
    }

    public void updateReplyUnlike(int no) {
        freeMapper.updateReplyUnlike(no);
    }

    public int getReplyLikeCount(int no) {
        return freeMapper.getReplyLikeCount(no);
    }



    public List<FreeReplyVO> getReplysSortedByLike(int postId, int offset, int size) {
        return freeMapper.getPagedRepliesSortedByLike(postId, offset, size);
    }


}
