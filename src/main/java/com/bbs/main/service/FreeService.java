package com.bbs.main.service;

import com.bbs.main.mapper.FreeMapper;
import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.FreeVO;
import com.bbs.main.vo.UserVO;
import jakarta.servlet.http.HttpSession;
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
    @Autowired
    private HttpSession session;


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


    public List<FreeReplyVO> getReplysPaged(int postId, int offset, int size) {
        List<FreeReplyVO> replies = freeMapper.getPagedReplies(postId, offset, size);
        UserVO user = (UserVO) session.getAttribute("user");
        String nickname = user != null ? user.getUser_nickname() : null;

        for (FreeReplyVO reply : replies) {
            boolean liked = false;
            if (nickname != null) {
                liked = freeMapper.existsReplyLike(nickname, reply.getR_id()) > 0;
            }
            reply.setLikedByCurrentUser(liked);
        }

        return replies;
    }


    public int getTotalReplyCount(int post_id) {
        return freeMapper.countByPostId(post_id);
    }

    public int getCount(int postId) {
        return freeMapper.getCount(postId);
    }

    public int getReplyLikeCount(int no) {
        return freeMapper.getReplyLikeCount(no);
    }

    public List<FreeReplyVO> getReplysSortedByLike(int postId, int offset, int size) {
        return freeMapper.getPagedRepliesSortedByLike(postId, offset, size);
    }

    @Transactional
    public void updateLike(int no) {
        freeMapper.incrementLike(no);
    }

    public void updateUnlike(int no) { freeMapper.updateUnlike(no);

    }
    public boolean toggleLike(int postId, String userNickname) {
        // 현재 해당 유저가 이 게시글에 추천 기록이 있는지 확인합니다.
        int count = freeMapper.existsLike(userNickname, postId);
        if (count > 0) {
            // 이미 추천한 상태라면, 추천 기록을 삭제(좋아요 취소)
            freeMapper.deleteLike(userNickname, postId);
            // 게시글의 추천 수를 감소시킵니다.
            updateUnlike(postId);  // 내부적으로 freeMapper.updateUnlike(no)를 호출
            return false; // 추천 취소 상태 반환
        } else {
            // 추천한 기록이 없다면, 추천 기록을 추가
            freeMapper.insertLike(userNickname, postId);
            // 게시글의 추천 수를 증가시킵니다.
            updateLike(postId);  // 내부적으로 freeMapper.incrementLike(no)를 호출
            return true; // 추천된 상태 반환
        }
    }

    public boolean hasUserLiked(int postId, String nickname) {
        System.out.println(postId);
        System.out.println(nickname);
        return freeMapper.existsLike(nickname, postId) > 0;
    }


    @Transactional
    public void updateReplyLike(int no) {
        freeMapper.incrementReplyLike(no);
    }

    public void updateReplyUnlike(int no) {
        freeMapper.updateReplyUnlike(no);
    }

    public boolean toggleReplyLike(int rId, String userNickname) {
        // 현재 해당 유저가 이 게시글에 추천 기록이 있는지 확인합니다.
        int count = freeMapper.existsReplyLike(userNickname, rId);
        if (count > 0) {
            // 이미 추천한 상태라면, 추천 기록을 삭제(좋아요 취소)
            freeMapper.deleteReplyLike(userNickname, rId);
            // 게시글의 추천 수를 감소시킵니다.
            updateReplyUnlike(rId);  // 내부적으로 freeMapper.updateUnlike(no)를 호출
            return false; // 추천 취소 상태 반환
        } else {
            // 추천한 기록이 없다면, 추천 기록을 추가
            freeMapper.insertReplyLike(userNickname, rId);
            // 게시글의 추천 수를 증가시킵니다.
            updateReplyLike(rId);  // 내부적으로 freeMapper.incrementLike(no)를 호출
            return true; // 추천된 상태 반환
        }
    }

    public boolean
    hasUserReplyLiked(int rId, String nickname) {
        System.out.println(rId);
        System.out.println(nickname);
        return freeMapper.existsReplyLike(nickname, rId) > 0;
    }
}