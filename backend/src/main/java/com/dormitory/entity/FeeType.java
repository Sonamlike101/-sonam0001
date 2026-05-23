package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("fee_type")
public class FeeType {
    @TableId
    private Long typeId;
    private String typeCode;
    private String typeName;
    private String billingCycle;
    private String unit;
    private Integer status;
    private LocalDateTime createdAt;
}
