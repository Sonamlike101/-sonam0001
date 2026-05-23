package com.dormitory.controller;

import com.dormitory.entity.Item;
import com.dormitory.service.ItemService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/items")
public class ItemController extends BaseCrudController<Item> {

    public ItemController(ItemService service) {
        super(service);
    }

    @Override
    protected void setId(Item entity, Long id) {
        entity.setItemId(id);
    }
}
