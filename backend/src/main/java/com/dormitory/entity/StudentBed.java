package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("student_bed")
public class StudentBed {
    @TableId
    private Long checkInId;
    private Long studentId;
    private Long bedId;
    private LocalDate checkInDate;
    private LocalDate checkOutDate;
    private String status;
    private String remark;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
