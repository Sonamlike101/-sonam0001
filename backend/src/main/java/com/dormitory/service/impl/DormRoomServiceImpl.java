package com.dormitory.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dormitory.entity.DormRoom;
import com.dormitory.mapper.DormRoomMapper;
import com.dormitory.service.DormRoomService;
import org.springframework.stereotype.Service;

@Service
public class DormRoomServiceImpl extends ServiceImpl<DormRoomMapper, DormRoom> implements DormRoomService {
}
