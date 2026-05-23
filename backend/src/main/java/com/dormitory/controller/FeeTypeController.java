package com.dormitory.controller;

import com.dormitory.entity.FeeType;
import com.dormitory.service.FeeTypeService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/fees/types")
public class FeeTypeController extends BaseCrudController<FeeType> {

    public FeeTypeController(FeeTypeService service) {
        super(service);
    }

    @Override
    protected void setId(FeeType entity, Long id) {
        entity.setTypeId(id);
    }
}
