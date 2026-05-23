package com.dormitory.controller;

import com.dormitory.entity.StudentBed;
import com.dormitory.service.StudentBedService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/check-ins")
public class StudentBedController extends BaseCrudController<StudentBed> {

    public StudentBedController(StudentBedService service) {
        super(service);
    }

    @Override
    protected void setId(StudentBed entity, Long id) {
        entity.setCheckInId(id);
    }
}
