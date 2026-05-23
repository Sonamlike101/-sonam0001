package com.dormitory.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.DutySchedule;
import com.dormitory.mapper.DutyScheduleMapper;
import com.dormitory.service.DutyScheduleService;
import org.springframework.stereotype.Service;

@Service
public class DutyScheduleServiceImpl extends ServiceImpl<DutyScheduleMapper, DutySchedule> implements DutyScheduleService {
}
