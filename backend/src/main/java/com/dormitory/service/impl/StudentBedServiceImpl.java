package com.dormitory.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.StudentBed;
import com.dormitory.mapper.StudentBedMapper;
import com.dormitory.service.StudentBedService;
import org.springframework.stereotype.Service;

@Service
public class StudentBedServiceImpl extends ServiceImpl<StudentBedMapper, StudentBed> implements StudentBedService {
}
