package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("duty_record")
public class DutyRecord {
    @TableId
    private Long recordId;
    private Long scheduleId;
    private LocalDateTime checkTime;
    private BigDecimal score;
    private String result;
    private Long inspectorId;
    private String remark;
}
