package com.dormitory.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.FeeType;
import com.dormitory.mapper.FeeTypeMapper;
import com.dormitory.service.FeeTypeService;
import org.springframework.stereotype.Service;

@Service
public class FeeTypeServiceImpl extends ServiceImpl<FeeTypeMapper, FeeType> implements FeeTypeService {
}
