package com.dormitory.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.FeeBill;
import com.dormitory.mapper.FeeBillMapper;
import com.dormitory.service.FeeBillService;
import org.springframework.stereotype.Service;

@Service
public class FeeBillServiceImpl extends ServiceImpl<FeeBillMapper, FeeBill> implements FeeBillService {
}
