package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("dorm_building")
public class DormBuilding {
    @TableId
    private Long buildingId;
    private String areaName;
    private String buildingNo;
    private String buildingName;
    private Integer floorCount;
    private String genderType;
    private String address;
    private Integer status;
    private LocalDateTime createdAt;
}
