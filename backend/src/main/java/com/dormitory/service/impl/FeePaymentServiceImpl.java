package com.dormitory.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.FeePayment;
import com.dormitory.mapper.FeePaymentMapper;
import com.dormitory.service.FeePaymentService;
import org.springframework.stereotype.Service;

@Service
public class FeePaymentServiceImpl extends ServiceImpl<FeePaymentMapper, FeePayment> implements FeePaymentService {
}
