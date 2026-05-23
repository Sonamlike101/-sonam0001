package com.dormitory.controller;

import com.dormitory.common.Result;
import com.dormitory.entity.Bed;
import com.dormitory.service.BedService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/beds")
public class BedController extends BaseCrudController<Bed> {

    private final BedService bedService;

    public BedController(BedService service) {
        super(service);
        this.bedService = service;
    }

    @Override
    protected void setId(Bed entity, Long id) {
        entity.setBedId(id);
    }

    @GetMapping("/details")
    public Result<List<Map<String, Object>>> details() {
        return Result.success(bedService.listBedDetails());
    }
}
