package com.dormitory.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.Bed;
import com.dormitory.mapper.BedMapper;
import com.dormitory.service.BedService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class BedServiceImpl extends ServiceImpl<BedMapper, Bed> implements BedService {

    @Override
    public List<Map<String, Object>> listBedDetails() {
        return baseMapper.selectBedDetails();
    }
}
