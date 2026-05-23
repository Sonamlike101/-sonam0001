package com.dormitory.controller;

import com.dormitory.entity.FeePayment;
import com.dormitory.service.FeePaymentService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/fees/payments")
public class FeePaymentController extends BaseCrudController<FeePayment> {

    public FeePaymentController(FeePaymentService service) {
        super(service);
    }

    @Override
    protected void setId(FeePayment entity, Long id) {
        entity.setPaymentId(id);
    }
}
