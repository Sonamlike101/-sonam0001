package com.dormitory.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.DormBuilding;
import com.dormitory.mapper.DormBuildingMapper;
import com.dormitory.service.DormBuildingService;
import org.springframework.stereotype.Service;

@Service
public class DormBuildingServiceImpl extends ServiceImpl<DormBuildingMapper, DormBuilding> implements DormBuildingService {
}
