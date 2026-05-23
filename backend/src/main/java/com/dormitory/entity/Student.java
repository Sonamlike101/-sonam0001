package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("student")
public class Student {
    @TableId
    private Long studentId;
    private String studentNo;
    private String studentName;
    private String gender;
    private String college;
    private String major;
    private String className;
    private String phone;
    private String idCard;
    private String checkInStatus;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
