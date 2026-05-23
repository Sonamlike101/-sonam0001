package com.dormitory.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.RepairProcess;
import com.dormitory.mapper.RepairProcessMapper;
import com.dormitory.service.RepairProcessService;
import org.springframework.stereotype.Service;

@Service
public class RepairProcessServiceImpl extends ServiceImpl<RepairProcessMapper, RepairProcess> implements RepairProcessService {
}
