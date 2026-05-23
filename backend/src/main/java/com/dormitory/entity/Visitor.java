package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("visitor")
public class Visitor {
    @TableId
    private Long visitorId;
    private String visitorName;
    private String phone;
    private String idCard;
    private String relationship;
    private LocalDateTime createdAt;
}
