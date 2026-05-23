package com.dormitory.controller;

import com.dormitory.entity.OperationLog;
import com.dormitory.service.OperationLogService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/logs")
public class OperationLogController extends BaseCrudController<OperationLog> {

    public OperationLogController(OperationLogService service) {
        super(service);
    }

    @Override
    protected void setId(OperationLog entity, Long id) {
        entity.setLogId(id);
    }
}
