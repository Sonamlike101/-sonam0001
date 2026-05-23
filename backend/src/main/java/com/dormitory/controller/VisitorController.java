package com.dormitory.controller;

import com.dormitory.entity.Visitor;
import com.dormitory.service.VisitorService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/visitors")
public class VisitorController extends BaseCrudController<Visitor> {

    public VisitorController(VisitorService service) {
        super(service);
    }

    @Override
    protected void setId(Visitor entity, Long id) {
        entity.setVisitorId(id);
    }
}
