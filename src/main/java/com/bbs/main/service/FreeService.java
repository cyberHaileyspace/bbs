package com.bbs.main.service;

import com.bbs.main.mapper.FreeMapper;
import com.bbs.main.vo.FreeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FreeService {


    @Autowired
    private FreeMapper freeMapper;
    
    public List<FreeVO> getposts(){
        return freeMapper.getposts();
    };

    public FreeVO detailPost(int no){
        return freeMapper.detailPost(no);
    }

    public int deletePost(int delPk) {
        return freeMapper.deletePost(delPk);
    }
}
