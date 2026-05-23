package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("operation_log")
public class OperationLog {
    @TableId
    private Long logId;
    private Long adminId;
    private String moduleName;
    private String operationType;
    private String operationDesc;
    private String requestIp;
    private LocalDateTime operationTime;
    private String resultStatus;
}
