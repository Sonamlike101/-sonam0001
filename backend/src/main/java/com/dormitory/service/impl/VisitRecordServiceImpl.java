package com.dormitory.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.VisitRecord;
import com.dormitory.mapper.VisitRecordMapper;
import com.dormitory.service.VisitRecordService;
import org.springframework.stereotype.Service;

@Service
public class VisitRecordServiceImpl extends ServiceImpl<VisitRecordMapper, VisitRecord> implements VisitRecordService {
}
