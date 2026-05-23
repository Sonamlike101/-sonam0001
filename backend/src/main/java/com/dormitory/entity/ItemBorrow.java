package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("item_borrow")
public class ItemBorrow {
    @TableId
    private Long borrowId;
    private Long itemId;
    private Long borrowerStudentId;
    private LocalDateTime borrowTime;
    private LocalDateTime expectedReturnTime;
    private LocalDateTime actualReturnTime;
    private String status;
    private String remark;
}
