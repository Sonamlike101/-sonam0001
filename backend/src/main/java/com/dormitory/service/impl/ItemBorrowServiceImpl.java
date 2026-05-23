package com.dormitory.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.ItemBorrow;
import com.dormitory.mapper.ItemBorrowMapper;
import com.dormitory.service.ItemBorrowService;
import org.springframework.stereotype.Service;

@Service
public class ItemBorrowServiceImpl extends ServiceImpl<ItemBorrowMapper, ItemBorrow> implements ItemBorrowService {
}
