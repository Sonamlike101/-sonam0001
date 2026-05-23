package com.dormitory.controller;

import com.dormitory.entity.DormBuilding;
import com.dormitory.service.DormBuildingService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/buildings")
public class DormBuildingController extends BaseCrudController<DormBuilding> {

    public DormBuildingController(DormBuildingService service) {
        super(service);
    }

    @Override
    protected void setId(DormBuilding entity, Long id) {
        entity.setBuildingId(id);
    }
}
