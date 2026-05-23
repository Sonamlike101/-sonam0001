package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("bed")
public class Bed {
    @TableId
    private Long bedId;
    private Long roomId;
    private String bedNo;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
