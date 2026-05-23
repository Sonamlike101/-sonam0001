package com.dormitory.controller;

import com.dormitory.entity.RepairOrder;
import com.dormitory.service.RepairOrderService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/repairs/orders")
public class RepairOrderController extends BaseCrudController<RepairOrder> {

    public RepairOrderController(RepairOrderService service) {
        super(service);
    }

    @Override
    protected void setId(RepairOrder entity, Long id) {
        entity.setOrderId(id);
    }
}
