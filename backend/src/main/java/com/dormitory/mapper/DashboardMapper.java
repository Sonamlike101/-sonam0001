package com.dormitory.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface DashboardMapper {

    @Select("""
            SELECT
              (SELECT COUNT(*) FROM student) AS studentCount,
              (SELECT COUNT(*) FROM dorm_room) AS roomCount,
              (SELECT COUNT(*) FROM bed) AS bedCount,
              (SELECT COUNT(*) FROM bed WHERE status = 'OCCUPIED') AS occupiedBedCount,
              (SELECT COUNT(*) FROM fee_bill WHERE status <> 'PAID') AS unpaidBillCount,
              (SELECT COUNT(*) FROM repair_order WHERE status IN ('SUBMITTED','ACCEPTED','PROCESSING')) AS pendingRepairCount,
              (SELECT COUNT(*) FROM visit_record WHERE DATE(visit_time) = CURRENT_DATE) AS todayVisitCount
            """)
    Map<String, Object> selectOverview();

    @Select("""
            SELECT status, COUNT(*) AS count
            FROM repair_order
            GROUP BY status
            ORDER BY status
            """)
    List<Map<String, Object>> selectRepairStatusStats();

    @Select("""
            SELECT fb.bill_month AS billMonth, ft.type_name AS typeName,
                   SUM(fb.amount) AS totalAmount, SUM(fb.paid_amount) AS paidAmount
            FROM fee_bill fb
            JOIN fee_type ft ON fb.type_id = ft.type_id
            GROUP BY fb.bill_month, ft.type_name
            ORDER BY fb.bill_month, ft.type_name
            """)
    List<Map<String, Object>> selectFeeMonthlyStats();

    @Select("""
            SELECT r.room_no AS roomNo, r.capacity, r.occupied_count AS occupiedCount,
                   ROUND(r.occupied_count / r.capacity * 100, 2) AS occupancyRate
            FROM dorm_room r
            ORDER BY r.room_no
            """)
    List<Map<String, Object>> selectRoomOccupancyStats();
}
