package com.dormitory.controller;

import com.dormitory.entity.DormRoom;
import com.dormitory.service.DormRoomService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/rooms")
public class DormRoomController extends BaseCrudController<DormRoom> {

    public DormRoomController(DormRoomService service) {
        super(service);
    }

    @Override
    protected void setId(DormRoom entity, Long id) {
        entity.setRoomId(id);
    }
}
