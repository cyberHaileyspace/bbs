package com.bbs.main.service;

import com.bbs.main.mapper.TourMapper;
import com.bbs.main.vo.TourVO;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class TourServiceImpl implements TourService {

    private final TourMapper tourMapper;

    public TourServiceImpl(TourMapper tourMapper) {
        this.tourMapper = tourMapper;
    }

    @Override
    public List<TourVO> getTourList() {
        return tourMapper.getTourList();
    }
}
