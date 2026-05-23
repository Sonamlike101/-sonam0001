package com.dormitory.controller;

import com.dormitory.entity.ItemBorrow;
import com.dormitory.service.ItemBorrowService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/items/borrows")
public class ItemBorrowController extends BaseCrudController<ItemBorrow> {

    public ItemBorrowController(ItemBorrowService service) {
        super(service);
    }

    @Override
    protected void setId(ItemBorrow entity, Long id) {
        entity.setBorrowId(id);
    }
}
