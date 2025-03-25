package com.bbs.main.service;

import com.bbs.main.mapper.ToiletMapper;
import com.bbs.main.vo.ToiletVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ToiletService {

    @Autowired
    private ToiletMapper toiletMapper;

    public List<ToiletVO> getProducts() {
        return toiletMapper.getProducts();
    }

    public int addProduct(ToiletVO toiletVO) {
        return toiletMapper.addProduct(toiletVO);

    }

    public int delProduct(int delPK) {
        return toiletMapper.delProduct(delPK);
    }

    public int upProduct(ToiletVO toiletVO) {
        return toiletMapper.upProduct(toiletVO);

    }

    public ToiletVO getProduct(int no) {
        return toiletMapper.getProduct(no);
    }
}
