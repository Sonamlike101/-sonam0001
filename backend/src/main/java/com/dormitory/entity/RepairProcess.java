package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("repair_process")
public class RepairProcess {
    @TableId
    private Long processId;
    private Long orderId;
    private Long operatorAdminId;
    private String oldStatus;
    private String newStatus;
    private String processContent;
    private LocalDateTime processTime;
}
