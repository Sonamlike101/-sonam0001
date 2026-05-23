package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;

@Data
@TableName("item")
public class Item {
    @TableId
    private Long itemId;
    private Long roomId;
    private String itemCode;
    private String itemName;
    private String category;
    private Integer quantity;
    private String unit;
    private LocalDate purchaseDate;
    private String itemStatus;
    private Long keeperStudentId;
    private String remark;
}
