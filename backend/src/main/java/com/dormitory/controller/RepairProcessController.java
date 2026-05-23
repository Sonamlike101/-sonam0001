package com.dormitory.controller;

import com.dormitory.entity.RepairProcess;
import com.dormitory.service.RepairProcessService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/repairs/processes")
public class RepairProcessController extends BaseCrudController<RepairProcess> {

    public RepairProcessController(RepairProcessService service) {
        super(service);
    }

    @Override
    protected void setId(RepairProcess entity, Long id) {
        entity.setProcessId(id);
    }
}
