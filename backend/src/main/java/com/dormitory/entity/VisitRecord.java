package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("visit_record")
public class VisitRecord {
    @TableId
    private Long visitId;
    private Long visitorId;
    private Long studentId;
    private Long roomId;
    private String visitReason;
    private LocalDateTime visitTime;
    private LocalDateTime leaveTime;
    private String status;
    private Long registerAdminId;
}
