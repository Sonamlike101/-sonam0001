/*
  11栋南区504宿舍管理系统 - 查询示例脚本
*/

USE dormitory_system;
SET NAMES utf8mb4;

-- 1. 查询南区11栋504宿舍当前成员
SELECT *
FROM v_room_504_members
ORDER BY bed_label;

-- 2. 查询南区11栋504宿舍床位使用情况
SELECT
  b.area_name,
  b.building_no,
  r.room_no,
  CONCAT(r.room_no, '-', bed.bed_no) AS bed_label,
  bed.status AS bed_status,
  s.student_name
FROM dorm_building b
JOIN dorm_room r ON b.building_id = r.building_id
JOIN bed ON r.room_id = bed.room_id
LEFT JOIN student_bed sb ON bed.bed_id = sb.bed_id AND sb.status = 'LIVING'
LEFT JOIN student s ON sb.student_id = s.student_id
WHERE b.area_name = '南区'
  AND b.building_no = '11栋'
  AND r.room_no = '504'
ORDER BY bed.bed_no;

-- 3. 查询504宿舍5月费用汇总
SELECT *
FROM v_room_fee_summary
WHERE area_name = '南区'
  AND building_no = '11栋'
  AND room_no = '504'
  AND bill_month = '2026-05';

-- 4. 查询504宿舍未缴清费用明细
SELECT
  ft.type_name,
  fb.bill_month,
  fb.amount,
  fb.paid_amount,
  fb.amount - fb.paid_amount AS unpaid_amount,
  fb.due_date,
  fb.status
FROM fee_bill fb
JOIN fee_type ft ON fb.type_id = ft.type_id
JOIN dorm_room r ON fb.room_id = r.room_id
WHERE r.room_no = '504'
  AND fb.status <> 'PAID'
ORDER BY fb.due_date;

-- 5. 查询504宿舍卫生值日和检查记录
SELECT
  ds.duty_date,
  s.student_name,
  ds.task_content,
  ds.status AS duty_status,
  dr.score,
  dr.result,
  dr.remark
FROM duty_schedule ds
JOIN student s ON ds.student_id = s.student_id
LEFT JOIN duty_record dr ON ds.schedule_id = dr.schedule_id
WHERE ds.room_id = 4
ORDER BY ds.duty_date;

-- 6. 查询504宿舍维修进度
SELECT *
FROM v_repair_order_detail
WHERE area_name = '南区'
  AND building_no = '11栋'
  AND room_no = '504'
ORDER BY report_time DESC;

-- 7. 查询504宿舍来访记录
SELECT
  v.visitor_name,
  v.phone,
  v.relationship,
  s.student_name AS visited_student,
  vr.visit_reason,
  vr.visit_time,
  vr.leave_time,
  vr.status
FROM visit_record vr
JOIN visitor v ON vr.visitor_id = v.visitor_id
JOIN student s ON vr.student_id = s.student_id
WHERE vr.room_id = 4
ORDER BY vr.visit_time DESC;

-- 8. 查询各房间入住率
SELECT
  b.area_name,
  b.building_no,
  r.room_no,
  r.capacity,
  r.occupied_count,
  ROUND(r.occupied_count / r.capacity * 100, 2) AS occupancy_rate
FROM dorm_room r
JOIN dorm_building b ON r.building_id = b.building_id
ORDER BY b.building_no, r.room_no;

-- 9. 查询费用类型月度统计，适合 ECharts 柱状图
SELECT
  fb.bill_month,
  ft.type_name,
  SUM(fb.amount) AS total_amount,
  SUM(fb.paid_amount) AS total_paid_amount
FROM fee_bill fb
JOIN fee_type ft ON fb.type_id = ft.type_id
GROUP BY fb.bill_month, ft.type_name
ORDER BY fb.bill_month, ft.type_name;

-- 10. 查询操作日志
SELECT
  ol.operation_time,
  a.real_name,
  ol.module_name,
  ol.operation_type,
  ol.operation_desc,
  ol.result_status
FROM operation_log ol
LEFT JOIN admin a ON ol.admin_id = a.admin_id
ORDER BY ol.operation_time DESC;

-- 11. 存储过程调用示例：以下语句会修改数据，需要演示时再取消注释执行
-- CALL sp_create_fee_bill(4, 2, '2026-06', 118.60, '2026-06-30', 2);
-- CALL sp_assign_student_bed('2024011109', 17, 2);
