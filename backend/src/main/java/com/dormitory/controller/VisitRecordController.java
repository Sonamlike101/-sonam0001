package com.dormitory.controller;

import com.dormitory.entity.VisitRecord;
import com.dormitory.service.VisitRecordService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/visits")
public class VisitRecordController extends BaseCrudController<VisitRecord> {

    public VisitRecordController(VisitRecordService service) {
        super(service);
    }

    @Override
    protected void setId(VisitRecord entity, Long id) {
        entity.setVisitId(id);
    }
}
