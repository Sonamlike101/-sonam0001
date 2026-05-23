package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("duty_schedule")
public class DutySchedule {
    @TableId
    private Long scheduleId;
    private Long roomId;
    private Long studentId;
    private LocalDate dutyDate;
    private String dutyType;
    private String taskContent;
    private String status;
    private Long createdBy;
    private LocalDateTime createdAt;
}
