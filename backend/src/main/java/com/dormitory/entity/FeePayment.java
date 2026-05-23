package com.dormitory.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("fee_payment")
public class FeePayment {
    @TableId
    private Long paymentId;
    private Long billId;
    private Long studentId;
    private String payerName;
    private BigDecimal amount;
    private LocalDateTime paymentTime;
    private String paymentMethod;
    private String transactionNo;
    private Long createdBy;
}
