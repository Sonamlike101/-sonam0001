package com.dormitory.service.impl;

import com.dormitory.mapper.DashboardMapper;
import com.dormitory.service.DashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class DashboardServiceImpl implements DashboardService {

    private final DashboardMapper dashboardMapper;

    @Override
    public Map<String, Object> dashboard() {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("overview", dashboardMapper.selectOverview());
        data.put("repairStatus", dashboardMapper.selectRepairStatusStats());
        data.put("feeMonthly", dashboardMapper.selectFeeMonthlyStats());
        data.put("roomOccupancy", dashboardMapper.selectRoomOccupancyStats());
        return data;
    }
}
