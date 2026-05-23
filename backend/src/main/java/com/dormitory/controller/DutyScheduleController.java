package com.dormitory.controller;

import com.dormitory.entity.DutySchedule;
import com.dormitory.service.DutyScheduleService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/duties/schedules")
public class DutyScheduleController extends BaseCrudController<DutySchedule> {

    public DutyScheduleController(DutyScheduleService service) {
        super(service);
    }

    @Override
    protected void setId(DutySchedule entity, Long id) {
        entity.setScheduleId(id);
    }
}
