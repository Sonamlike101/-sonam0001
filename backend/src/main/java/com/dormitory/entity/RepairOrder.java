package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("repair_order")
public class RepairOrder {
    @TableId
    private Long orderId;
    private Long roomId;
    private Long reporterStudentId;
    private String repairTitle;
    private String repairContent;
    private String locationDesc;
    private String priority;
    private String status;
    private LocalDateTime reportTime;
    private LocalDateTime finishTime;
    private Long handlerAdminId;
}
