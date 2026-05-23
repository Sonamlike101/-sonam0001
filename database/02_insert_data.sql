/*
  11栋南区504宿舍管理系统 - 测试数据脚本
  数据重点围绕：南区11栋504宿舍
*/

USE dormitory_system;
SET NAMES utf8mb4;

INSERT INTO role (role_id, role_code, role_name, description) VALUES
(1, 'SUPER_ADMIN', '超级管理员', '拥有系统全部管理权限'),
(2, 'DORM_MANAGER', '宿舍管理员', '负责宿舍日常管理'),
(3, 'ROOM_LEADER', '宿舍长', '负责本宿舍事务登记');

INSERT INTO admin (admin_id, username, password_hash, real_name, phone, email, status) VALUES
(1, 'admin', '123456_hash_demo', '系统管理员', '13800000001', 'admin@example.com', 1),
(2, 'manager11', '123456_hash_demo', '南区宿舍管理员', '13800000002', 'manager11@example.com', 1),
(3, 'leader504', '123456_hash_demo', '504宿舍长', '13800000003', 'leader504@example.com', 1);

INSERT INTO admin_role (admin_id, role_id) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO dorm_building (building_id, area_name, building_no, building_name, floor_count, gender_type, address, status) VALUES
(1, '南区', '11栋', '南区11栋学生宿舍', 6, 'MALE', '学校南区生活区11栋', 1);

INSERT INTO dorm_room (room_id, building_id, room_no, floor_no, capacity, occupied_count, room_type, status, remark) VALUES
(1, 1, '501', 5, 4, 1, '四人间', 'AVAILABLE', '备用演示房间'),
(2, 1, '502', 5, 4, 2, '四人间', 'AVAILABLE', '备用演示房间'),
(3, 1, '503', 5, 4, 0, '四人间', 'AVAILABLE', '空房间'),
(4, 1, '504', 5, 4, 4, '四人间', 'FULL', '课程设计核心宿舍'),
(5, 1, '505', 5, 4, 0, '四人间', 'AVAILABLE', '空房间'),
(6, 1, '506', 5, 4, 1, '四人间', 'AVAILABLE', '备用演示房间');

INSERT INTO bed (bed_id, room_id, bed_no, status) VALUES
(1, 1, 'A', 'OCCUPIED'),
(2, 1, 'B', 'AVAILABLE'),
(3, 1, 'C', 'AVAILABLE'),
(4, 1, 'D', 'AVAILABLE'),
(5, 2, 'A', 'OCCUPIED'),
(6, 2, 'B', 'OCCUPIED'),
(7, 2, 'C', 'AVAILABLE'),
(8, 2, 'D', 'AVAILABLE'),
(9, 3, 'A', 'AVAILABLE'),
(10, 3, 'B', 'AVAILABLE'),
(11, 3, 'C', 'AVAILABLE'),
(12, 3, 'D', 'AVAILABLE'),
(13, 4, 'A', 'OCCUPIED'),
(14, 4, 'B', 'OCCUPIED'),
(15, 4, 'C', 'OCCUPIED'),
(16, 4, 'D', 'OCCUPIED'),
(17, 5, 'A', 'AVAILABLE'),
(18, 5, 'B', 'AVAILABLE'),
(19, 5, 'C', 'AVAILABLE'),
(20, 5, 'D', 'AVAILABLE'),
(21, 6, 'A', 'OCCUPIED'),
(22, 6, 'B', 'AVAILABLE'),
(23, 6, 'C', 'AVAILABLE'),
(24, 6, 'D', 'AVAILABLE');

INSERT INTO student (student_id, student_no, student_name, gender, college, major, class_name, phone, id_card, check_in_status) VALUES
(1, '2024011101', '张明', 'MALE', '计算机学院', '软件工程', '软件2401', '13900000101', '110101200501010011', 'LIVING'),
(2, '2024011102', '李强', 'MALE', '计算机学院', '软件工程', '软件2401', '13900000102', '110101200501010012', 'LIVING'),
(3, '2024011103', '王磊', 'MALE', '计算机学院', '软件工程', '软件2401', '13900000103', '110101200501010013', 'LIVING'),
(4, '2024011104', '赵宇', 'MALE', '计算机学院', '软件工程', '软件2401', '13900000104', '110101200501010014', 'LIVING'),
(5, '2024011105', '陈浩', 'MALE', '计算机学院', '数据科学', '数据2401', '13900000105', '110101200501010015', 'LIVING'),
(6, '2024011106', '刘洋', 'MALE', '信息工程学院', '网络工程', '网络2401', '13900000106', '110101200501010016', 'LIVING'),
(7, '2024011107', '孙杰', 'MALE', '信息工程学院', '网络工程', '网络2401', '13900000107', '110101200501010017', 'LIVING'),
(8, '2024011108', '周航', 'MALE', '计算机学院', '软件工程', '软件2402', '13900000108', '110101200501010018', 'LIVING');

INSERT INTO student_bed (check_in_id, student_id, bed_id, check_in_date, status, remark) VALUES
(1, 5, 1, '2026-03-01', 'LIVING', '501宿舍入住'),
(2, 6, 5, '2026-03-01', 'LIVING', '502宿舍入住'),
(3, 7, 6, '2026-03-01', 'LIVING', '502宿舍入住'),
(4, 1, 13, '2026-03-01', 'LIVING', '504宿舍A床'),
(5, 2, 14, '2026-03-01', 'LIVING', '504宿舍B床'),
(6, 3, 15, '2026-03-01', 'LIVING', '504宿舍C床'),
(7, 4, 16, '2026-03-01', 'LIVING', '504宿舍D床'),
(8, 8, 21, '2026-03-01', 'LIVING', '506宿舍入住');

INSERT INTO duty_schedule (schedule_id, room_id, student_id, duty_date, duty_type, task_content, status, created_by) VALUES
(1, 4, 1, '2026-05-20', 'DAILY', '扫地、拖地、倒垃圾', 'FINISHED', 3),
(2, 4, 2, '2026-05-21', 'DAILY', '整理桌面、清理阳台', 'FINISHED', 3),
(3, 4, 3, '2026-05-22', 'DAILY', '扫地、拖地、检查卫生死角', 'FINISHED', 3),
(4, 4, 4, '2026-05-23', 'DAILY', '倒垃圾、清理洗漱台', 'PENDING', 3),
(5, 4, 1, '2026-05-24', 'GENERAL_CLEANING', '宿舍大扫除', 'PENDING', 3);

INSERT INTO duty_record (record_id, schedule_id, check_time, score, result, inspector_id, remark) VALUES
(1, 1, '2026-05-20 21:00:00', 92.00, 'EXCELLENT', 2, '地面干净，物品摆放整齐'),
(2, 2, '2026-05-21 21:10:00', 86.00, 'GOOD', 2, '阳台仍需保持'),
(3, 3, '2026-05-22 21:20:00', 88.00, 'GOOD', 2, '整体良好');

INSERT INTO fee_type (type_id, type_code, type_name, billing_cycle, unit, status) VALUES
(1, 'WATER', '水费', 'MONTHLY', '元', 1),
(2, 'ELECTRICITY', '电费', 'MONTHLY', '元', 1),
(3, 'NETWORK', '网费', 'MONTHLY', '元', 1),
(4, 'PUBLIC', '公共用品费', 'ONCE', '元', 1);

INSERT INTO fee_bill (bill_id, room_id, type_id, bill_month, amount, paid_amount, due_date, status, remark, created_by) VALUES
(1, 4, 1, '2026-05', 68.50, 68.50, '2026-05-30', 'PAID', '504宿舍5月水费', 2),
(2, 4, 2, '2026-05', 126.80, 80.00, '2026-05-30', 'PARTIAL', '504宿舍5月电费', 2),
(3, 4, 3, '2026-05', 60.00, 0.00, '2026-05-30', 'UNPAID', '504宿舍5月网费', 2),
(4, 4, 4, '2026-05', 40.00, 40.00, '2026-05-25', 'PAID', '504宿舍公共用品费', 3),
(5, 2, 2, '2026-05', 98.20, 0.00, '2026-05-30', 'UNPAID', '502宿舍5月电费', 2);

INSERT INTO fee_payment (payment_id, bill_id, student_id, payer_name, amount, payment_time, payment_method, transaction_no, created_by) VALUES
(1, 1, 1, '张明', 68.50, '2026-05-18 19:30:00', 'WECHAT', 'PAY202605180001', 2),
(2, 2, 2, '李强', 40.00, '2026-05-19 20:00:00', 'ALIPAY', 'PAY202605190001', 2),
(3, 2, 3, '王磊', 40.00, '2026-05-20 20:10:00', 'WECHAT', 'PAY202605200001', 2),
(4, 4, 4, '赵宇', 40.00, '2026-05-21 18:40:00', 'CASH', 'PAY202605210001', 3);

INSERT INTO repair_order (order_id, room_id, reporter_student_id, repair_title, repair_content, location_desc, priority, status, report_time, finish_time, handler_admin_id) VALUES
(1, 4, 1, '504宿舍空调漏水', '空调运行半小时后开始滴水，需要检查排水管。', '504宿舍阳台侧空调', 'HIGH', 'PROCESSING', '2026-05-21 09:20:00', NULL, 2),
(2, 4, 2, '504宿舍门锁松动', '宿舍门锁把手松动，影响关门。', '504宿舍门口', 'NORMAL', 'FINISHED', '2026-05-18 10:00:00', '2026-05-19 16:30:00', 2),
(3, 2, 6, '502宿舍灯管闪烁', '主灯灯管频繁闪烁。', '502宿舍天花板', 'NORMAL', 'SUBMITTED', '2026-05-22 12:30:00', NULL, NULL);

INSERT INTO repair_process (process_id, order_id, operator_admin_id, old_status, new_status, process_content, process_time) VALUES
(1, 1, 2, 'SUBMITTED', 'ACCEPTED', '已受理，安排维修人员检查。', '2026-05-21 10:00:00'),
(2, 1, 2, 'ACCEPTED', 'PROCESSING', '维修人员反馈需更换排水软管。', '2026-05-21 16:00:00'),
(3, 2, 2, 'SUBMITTED', 'ACCEPTED', '已受理门锁维修。', '2026-05-18 11:00:00'),
(4, 2, 2, 'ACCEPTED', 'FINISHED', '门锁螺丝已加固，维修完成。', '2026-05-19 16:30:00');

INSERT INTO item (item_id, room_id, item_code, item_name, category, quantity, unit, purchase_date, item_status, keeper_student_id, remark) VALUES
(1, 4, 'ITEM-504-001', '扫帚', '清洁用品', 2, '把', '2026-03-02', 'NORMAL', 1, '504公共物品'),
(2, 4, 'ITEM-504-002', '拖把', '清洁用品', 1, '把', '2026-03-02', 'NORMAL', 2, '504公共物品'),
(3, 4, 'ITEM-504-003', '插线板', '电器用品', 1, '个', '2026-03-05', 'BORROWED', 3, '外借登记中'),
(4, 4, 'ITEM-504-004', '垃圾桶', '生活用品', 1, '个', '2026-03-02', 'NORMAL', 4, '504公共物品'),
(5, 2, 'ITEM-502-001', '拖把', '清洁用品', 1, '把', '2026-03-02', 'NORMAL', 6, '502公共物品');

INSERT INTO item_borrow (borrow_id, item_id, borrower_student_id, borrow_time, expected_return_time, actual_return_time, status, remark) VALUES
(1, 3, 1, '2026-05-22 18:00:00', '2026-05-24 18:00:00', NULL, 'BORROWING', '张明借用插线板做课程设计演示'),
(2, 2, 4, '2026-05-15 18:00:00', '2026-05-15 22:00:00', '2026-05-15 21:30:00', 'RETURNED', '大扫除后已归还');

INSERT INTO visitor (visitor_id, visitor_name, phone, id_card, relationship) VALUES
(1, '张伟', '13700000001', '110101197801010011', '张明父亲'),
(2, '李娜', '13700000002', '110101197901010012', '李强姐姐'),
(3, '王老师', '13700000003', '110101198001010013', '辅导员');

INSERT INTO visit_record (visit_id, visitor_id, student_id, room_id, visit_reason, visit_time, leave_time, status, register_admin_id) VALUES
(1, 1, 1, 4, '送生活用品到504宿舍', '2026-05-20 15:00:00', '2026-05-20 15:30:00', 'LEFT', 2),
(2, 2, 2, 4, '探望学生', '2026-05-21 16:20:00', '2026-05-21 17:00:00', 'LEFT', 2),
(3, 3, 3, 4, '检查宿舍安全与卫生', '2026-05-23 10:00:00', NULL, 'VISITING', 2);

INSERT INTO operation_log (admin_id, module_name, operation_type, operation_desc, request_ip, operation_time, result_status) VALUES
(1, '系统初始化', 'INSERT', '初始化角色、管理员、楼栋与宿舍数据', '127.0.0.1', '2026-05-18 08:00:00', 'SUCCESS'),
(2, '费用管理', 'INSERT', '创建504宿舍5月水电网费账单', '127.0.0.1', '2026-05-18 09:00:00', 'SUCCESS'),
(3, '卫生值日', 'INSERT', '创建504宿舍本周值日安排', '127.0.0.1', '2026-05-18 09:30:00', 'SUCCESS'),
(2, '来访管理', 'INSERT', '登记504宿舍访客记录', '127.0.0.1', '2026-05-20 15:00:00', 'SUCCESS'),
(2, '维修管理', 'UPDATE', '处理504宿舍门锁维修单', '127.0.0.1', '2026-05-19 16:30:00', 'SUCCESS');
