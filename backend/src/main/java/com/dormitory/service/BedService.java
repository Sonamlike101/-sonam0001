package com.dormitory.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dormitory.entity.Bed;

import java.util.List;
import java.util.Map;

public interface BedService extends IService<Bed> {
    List<Map<String, Object>> listBedDetails();
}
