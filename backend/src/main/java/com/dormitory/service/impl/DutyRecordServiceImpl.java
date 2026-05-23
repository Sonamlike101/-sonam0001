package com.dormitory.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.DutyRecord;
import com.dormitory.mapper.DutyRecordMapper;
import com.dormitory.service.DutyRecordService;
import org.springframework.stereotype.Service;

@Service
public class DutyRecordServiceImpl extends ServiceImpl<DutyRecordMapper, DutyRecord> implements DutyRecordService {
}
