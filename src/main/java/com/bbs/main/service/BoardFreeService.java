package com.bbs.board.free.service;

import com.bbs.board.free.mapper.BoardFreeMapper;
import com.bbs.board.free.vo.PostFreeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardFreeService {


    @Autowired
    private BoardFreeMapper boardFreeMapper;
    
    public List<PostFreeVO> getposts(){
        return boardFreeMapper.getposts();
    };
}
