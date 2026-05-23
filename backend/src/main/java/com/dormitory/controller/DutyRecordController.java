package com.dormitory.controller;

import com.dormitory.entity.DutyRecord;
import com.dormitory.service.DutyRecordService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/duties/records")
public class DutyRecordController extends BaseCrudController<DutyRecord> {

    public DutyRecordController(DutyRecordService service) {
        super(service);
    }

    @Override
    protected void setId(DutyRecord entity, Long id) {
        entity.setRecordId(id);
    }
}
