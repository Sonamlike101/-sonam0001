package com.dormitory.controller;

import com.dormitory.entity.FeeBill;
import com.dormitory.service.FeeBillService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/fees/bills")
public class FeeBillController extends BaseCrudController<FeeBill> {

    public FeeBillController(FeeBillService service) {
        super(service);
    }

    @Override
    protected void setId(FeeBill entity, Long id) {
        entity.setBillId(id);
    }
}
