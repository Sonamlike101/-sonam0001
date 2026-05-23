package com.dormitory.controller;

import com.dormitory.common.Result;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
public class HealthController {

    @GetMapping("/")
    public Result<Map<String, Object>> index() {
        return health();
    }

    @GetMapping("/api/health")
    public Result<Map<String, Object>> health() {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("system", "11栋南区504宿舍管理系统");
        data.put("service", "backend");
        data.put("status", "running");
        data.put("apiPrefix", "/api");
        return Result.success(data);
    }
}
