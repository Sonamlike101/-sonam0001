package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("dorm_room")
public class DormRoom {
    @TableId
    private Long roomId;
    private Long buildingId;
    private String roomNo;
    private Integer floorNo;
    private Integer capacity;
    private Integer occupiedCount;
    private String roomType;
    private String status;
    private String remark;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
