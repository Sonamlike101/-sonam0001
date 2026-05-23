/*
  11栋南区504宿舍管理系统 - 视图脚本
*/

USE dormitory_system;
SET NAMES utf8mb4;

CREATE OR REPLACE VIEW v_room_504_members AS
SELECT
  b.area_name,
  b.building_no,
  r.room_no,
  r.room_type,
  CONCAT(r.room_no, '-', bed.bed_no) AS bed_label,
  s.student_no,
  s.student_name,
  s.college,
  s.major,
  s.class_name,
  s.phone,
  sb.check_in_date
FROM student_bed sb
JOIN student s ON sb.student_id = s.student_id
JOIN bed ON sb.bed_id = bed.bed_id
JOIN dorm_room r ON bed.room_id = r.room_id
JOIN dorm_building b ON r.building_id = b.building_id
WHERE b.area_name = '南区'
  AND b.building_no = '11栋'
  AND r.room_no = '504'
  AND sb.status = 'LIVING';

CREATE OR REPLACE VIEW v_room_fee_summary AS
SELECT
  b.area_name,
  b.building_no,
  r.room_no,
  fb.bill_month,
  SUM(fb.amount) AS total_amount,
  SUM(fb.paid_amount) AS total_paid_amount,
  SUM(fb.amount - fb.paid_amount) AS total_unpaid_amount,
  COUNT(*) AS bill_count,
  SUM(CASE WHEN fb.status = 'PAID' THEN 1 ELSE 0 END) AS paid_bill_count,
  SUM(CASE WHEN fb.status <> 'PAID' THEN 1 ELSE 0 END) AS unpaid_bill_count
FROM fee_bill fb
JOIN dorm_room r ON fb.room_id = r.room_id
JOIN dorm_building b ON r.building_id = b.building_id
GROUP BY b.area_name, b.building_no, r.room_no, fb.bill_month;

CREATE OR REPLACE VIEW v_repair_order_detail AS
SELECT
  ro.order_id,
  b.area_name,
  b.building_no,
  r.room_no,
  s.student_name AS reporter_name,
  ro.repair_title,
  ro.priority,
  ro.status,
  ro.report_time,
  ro.finish_time,
  a.real_name AS handler_name
FROM repair_order ro
JOIN dorm_room r ON ro.room_id = r.room_id
JOIN dorm_building b ON r.building_id = b.building_id
LEFT JOIN student s ON ro.reporter_student_id = s.student_id
LEFT JOIN admin a ON ro.handler_admin_id = a.admin_id;
