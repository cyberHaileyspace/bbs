package com.bbs.main.service;

import com.bbs.main.mapper.ToiletMapper;
import com.bbs.main.vo.FreeReplyVO;
import com.bbs.main.vo.ToiletReplyVO;
import com.bbs.main.vo.ToiletVO;
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
public class ToiletService {

    @Autowired
    private ToiletMapper toiletMapper;
    @Autowired
    private HttpSession session;

    public int getLikeCount(int no) {
        return toiletMapper.getLikeCount(no);
    }

    public List<ToiletVO> getposts() {
        return toiletMapper.getposts();
    }

    public ToiletVO detailPost(int post_id) {
        return toiletMapper.detailPost(post_id);
    }

    public int deletePost(int post_id) {
        return toiletMapper.deletePost(post_id);
    }

    public void addPost(ToiletVO toiletVO, MultipartFile post_file) {
        if (post_file.getOriginalFilename().length() != 0) {
            String originName = post_file.getOriginalFilename();
            String fileExtension = originName.substring(originName.lastIndexOf("."), originName.length());
            String uploadFolder = "/Users/kimsuhyeon/Desktop/final_img";
            UUID uuid = UUID.randomUUID();
            String[] uuids = uuid.toString().split("-");
            String fileName = uuids[0] + fileExtension;
            File saveFile = new File(uploadFolder + "/" + fileName);
            try {
                post_file.transferTo(saveFile);
                toiletVO.setPost_image(fileName);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        toiletMapper.addPost(toiletVO);
    }

    public void updatePost(ToiletVO toiletVO, MultipartFile post_file) {
        ToiletVO existingPost = toiletMapper.detailPost(toiletVO.getPost_id());
        if (existingPost == null) {
            throw new IllegalArgumentException("해당 게시글이 존재하지 않습니다: ID=" + toiletVO.getPost_id());
        }

        String uploadFolder = "/Users/kimsuhyeon/Desktop/final_img";

        if (post_file != null && !post_file.isEmpty()) {
            String originName = post_file.getOriginalFilename();
            String fileExtension = originName.substring(originName.lastIndexOf("."));
            UUID uuid = UUID.randomUUID();
            String fileName = uuid.toString().split("-")[0] + fileExtension;
            File saveFile = new File(uploadFolder + "/" + fileName);
            try {
                post_file.transferTo(saveFile);
                if (existingPost.getPost_image() != null) {
                    File oldFile = new File(uploadFolder + "/" + existingPost.getPost_image());
                    if (oldFile.exists()) oldFile.delete();
                }
                toiletVO.setPost_image(fileName);
            } catch (IOException e) {
                throw new RuntimeException("파일 저장 실패", e);
            }
        } else {
            toiletVO.setPost_image(existingPost.getPost_image());
        }
        toiletMapper.updatePost(toiletVO);
    }

    public List<FreeReplyVO> getReplys(int post_id) {
        return toiletMapper.getReplys(post_id);
    }

    public int addReply(ToiletReplyVO freeReplyVO) {
        return toiletMapper.addReply(freeReplyVO);
    }

    public int updateReply(ToiletReplyVO freeReplyVO) {
        int result = toiletMapper.updateReply(freeReplyVO);
        System.out.println("updateReply 실행 결과: " + result);
        return result;
    }

    public int deleteReply(int r_id) {
        return toiletMapper.deleteReply(r_id);
    }

    public List<ToiletVO> getsorts(String option) {
        switch (option) {
            case "new": return toiletMapper.getSortsNew();
            case "like": return toiletMapper.getSortsLike();
            case "view": return toiletMapper.getSortsView();
            case "reply": return toiletMapper.getSortsReply();
            default: return new ArrayList<>();
        }
    }

    public List<ToiletVO> searchposts(String title) {
        return toiletMapper.searchposts(title);
    }

    public List<ToiletReplyVO> getReplysPaged(int postId, int offset, int size) {
        List<ToiletReplyVO> replies = toiletMapper.getPagedReplies(postId, offset, size);
        UserVO user = (UserVO) session.getAttribute("user");
        String nickname = user != null ? user.getUser_nickname() : null;

        for (ToiletReplyVO reply : replies) {
            boolean liked = false;
            if (nickname != null) {
                liked = toiletMapper.existsReplyLike(nickname, reply.getR_id()) > 0;
            }
            reply.setLikedByCurrentUser(liked);
        }
        return replies;
    }


    public int getTotalReplyCount(int post_id) {
        return toiletMapper.countByPostId(post_id);
    }

    public int getCount(int postId) {
        return toiletMapper.getCount(postId);
    }

    public int getReplyLikeCount(int no) {
        return toiletMapper.getReplyLikeCount(no);
    }

    public List<ToiletReplyVO> getReplysSortedByLike(int postId, int offset, int size) {
        return toiletMapper.getPagedRepliesSortedByLike(postId, offset, size);
    }

    @Transactional
    public void updateLike(int no) {
        toiletMapper.incrementLike(no);
    }

    public void updateUnlike(int no) {
        toiletMapper.updateUnlike(no);
    }

    public boolean toggleLike(int postId, String userNickname) {
        int count = toiletMapper.existsLike(userNickname, postId);
        if (count > 0) {
            toiletMapper.deleteLike(userNickname, postId);
            updateUnlike(postId);
            return false;
        } else {
            toiletMapper.insertLike(userNickname, postId);
            updateLike(postId);
            return true;
        }
    }

    public boolean hasUserLiked(int postId, String nickname) {
        return toiletMapper.existsLike(nickname, postId) > 0;
    }

    @Transactional
    public void updateReplyLike(int no) {
        toiletMapper.incrementReplyLike(no);
    }

    public void updateReplyUnlike(int no) {
        toiletMapper.updateReplyUnlike(no);
    }

    public boolean toggleReplyLike(int rId, String userNickname) {
        int count = toiletMapper.existsReplyLike(userNickname, rId);
        if (count > 0) {
            toiletMapper.deleteReplyLike(userNickname, rId);
            updateReplyUnlike(rId);
            return false;
        } else {
            toiletMapper.insertReplyLike(userNickname, rId);
            updateReplyLike(rId);
            return true;
        }
    }

    public boolean hasUserReplyLiked(int rId, String nickname) {
        return toiletMapper.existsReplyLike(nickname, rId) > 0;
    }
}
