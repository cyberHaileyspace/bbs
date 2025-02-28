package com.bbs.main.service;

import com.bbs.main.mapper.BoardFreeMapper;
import com.bbs.main.vo.PostFreeVO;
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
