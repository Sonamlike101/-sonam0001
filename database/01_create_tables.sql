/*
  11栋南区504宿舍管理系统 - 表结构脚本
  MySQL 8.0
*/

DROP DATABASE IF EXISTS dormitory_system;
CREATE DATABASE dormitory_system
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;

USE dormitory_system;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE role (
  role_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  role_code VARCHAR(50) NOT NULL COMMENT '角色编码',
  role_name VARCHAR(50) NOT NULL COMMENT '角色名称',
  description VARCHAR(255) DEFAULT NULL COMMENT '角色描述',
  status TINYINT NOT NULL DEFAULT 1 COMMENT '状态：1启用，0禁用',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (role_id),
  UNIQUE KEY uk_role_code (role_code),
  CONSTRAINT chk_role_status CHECK (status IN (0, 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色表';

CREATE TABLE admin (
  admin_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  username VARCHAR(50) NOT NULL COMMENT '登录账号',
  password_hash VARCHAR(100) NOT NULL COMMENT '密码哈希',
  real_name VARCHAR(50) NOT NULL COMMENT '真实姓名',
  phone VARCHAR(20) DEFAULT NULL COMMENT '手机号',
  email VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
  status TINYINT NOT NULL DEFAULT 1 COMMENT '状态：1启用，0禁用',
  last_login_time DATETIME DEFAULT NULL COMMENT '最后登录时间',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (admin_id),
  UNIQUE KEY uk_admin_username (username),
  UNIQUE KEY uk_admin_phone (phone),
  UNIQUE KEY uk_admin_email (email),
  CONSTRAINT chk_admin_status CHECK (status IN (0, 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='管理员表';

CREATE TABLE admin_role (
  admin_role_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理员角色关系ID',
  admin_id BIGINT UNSIGNED NOT NULL COMMENT '管理员ID',
  role_id BIGINT UNSIGNED NOT NULL COMMENT '角色ID',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (admin_role_id),
  UNIQUE KEY uk_admin_role (admin_id, role_id),
  CONSTRAINT fk_admin_role_admin FOREIGN KEY (admin_id) REFERENCES admin (admin_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_admin_role_role FOREIGN KEY (role_id) REFERENCES role (role_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='管理员角色关系表';

CREATE TABLE dorm_building (
  building_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '宿舍楼ID',
  area_name VARCHAR(50) NOT NULL COMMENT '区域名称，例如南区',
  building_no VARCHAR(20) NOT NULL COMMENT '楼栋编号，例如11栋',
  building_name VARCHAR(100) NOT NULL COMMENT '宿舍楼名称',
  floor_count INT NOT NULL DEFAULT 6 COMMENT '楼层数',
  gender_type ENUM('MALE','FEMALE','MIXED') NOT NULL DEFAULT 'MIXED' COMMENT '住宿性别类型',
  address VARCHAR(255) DEFAULT NULL COMMENT '地址说明',
  status TINYINT NOT NULL DEFAULT 1 COMMENT '状态：1启用，0停用',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (building_id),
  UNIQUE KEY uk_building_area_no (area_name, building_no),
  CONSTRAINT chk_building_floor_count CHECK (floor_count > 0),
  CONSTRAINT chk_building_status CHECK (status IN (0, 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='宿舍楼表';

CREATE TABLE dorm_room (
  room_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '宿舍房间ID',
  building_id BIGINT UNSIGNED NOT NULL COMMENT '宿舍楼ID',
  room_no VARCHAR(20) NOT NULL COMMENT '房间号，例如504',
  floor_no INT NOT NULL COMMENT '楼层号',
  capacity INT NOT NULL DEFAULT 4 COMMENT '床位容量',
  occupied_count INT NOT NULL DEFAULT 0 COMMENT '当前入住人数',
  room_type VARCHAR(50) NOT NULL DEFAULT '四人间' COMMENT '房间类型',
  status ENUM('AVAILABLE','FULL','MAINTENANCE','DISABLED') NOT NULL DEFAULT 'AVAILABLE' COMMENT '房间状态',
  remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (room_id),
  UNIQUE KEY uk_room_building_no (building_id, room_no),
  KEY idx_room_status (status),
  CONSTRAINT chk_room_capacity CHECK (capacity > 0),
  CONSTRAINT chk_room_occupied_count CHECK (occupied_count >= 0 AND occupied_count <= capacity),
  CONSTRAINT fk_room_building FOREIGN KEY (building_id) REFERENCES dorm_building (building_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='宿舍房间表';

CREATE TABLE bed (
  bed_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '床位ID',
  room_id BIGINT UNSIGNED NOT NULL COMMENT '房间ID',
  bed_no VARCHAR(20) NOT NULL COMMENT '床位编号，例如A/B/C/D',
  status ENUM('AVAILABLE','OCCUPIED','REPAIR','DISABLED') NOT NULL DEFAULT 'AVAILABLE' COMMENT '床位状态',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (bed_id),
  UNIQUE KEY uk_bed_room_no (room_id, bed_no),
  KEY idx_bed_status (status),
  CONSTRAINT fk_bed_room FOREIGN KEY (room_id) REFERENCES dorm_room (room_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='床位表';

CREATE TABLE student (
  student_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '学生ID',
  student_no VARCHAR(30) NOT NULL COMMENT '学号',
  student_name VARCHAR(50) NOT NULL COMMENT '学生姓名',
  gender ENUM('MALE','FEMALE') NOT NULL COMMENT '性别',
  college VARCHAR(100) NOT NULL COMMENT '学院',
  major VARCHAR(100) NOT NULL COMMENT '专业',
  class_name VARCHAR(100) NOT NULL COMMENT '班级',
  phone VARCHAR(20) DEFAULT NULL COMMENT '手机号',
  id_card VARCHAR(30) DEFAULT NULL COMMENT '身份证号',
  check_in_status ENUM('NOT_CHECKED_IN','LIVING','CHECKED_OUT') NOT NULL DEFAULT 'NOT_CHECKED_IN' COMMENT '入住状态',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (student_id),
  UNIQUE KEY uk_student_no (student_no),
  UNIQUE KEY uk_student_phone (phone),
  UNIQUE KEY uk_student_id_card (id_card),
  KEY idx_student_name (student_name),
  KEY idx_student_status (check_in_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生表';

CREATE TABLE student_bed (
  check_in_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '入住记录ID',
  student_id BIGINT UNSIGNED NOT NULL COMMENT '学生ID',
  bed_id BIGINT UNSIGNED NOT NULL COMMENT '床位ID',
  check_in_date DATE NOT NULL COMMENT '入住日期',
  check_out_date DATE DEFAULT NULL COMMENT '退宿日期',
  status ENUM('LIVING','CHECKED_OUT') NOT NULL DEFAULT 'LIVING' COMMENT '入住记录状态',
  remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (check_in_id),
  UNIQUE KEY uk_student_bed_date (student_id, bed_id, check_in_date),
  KEY idx_student_bed_student_status (student_id, status),
  KEY idx_student_bed_bed_status (bed_id, status),
  CONSTRAINT chk_student_bed_checkout_date CHECK (check_out_date IS NULL OR check_out_date >= check_in_date),
  CONSTRAINT fk_student_bed_student FOREIGN KEY (student_id) REFERENCES student (student_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_student_bed_bed FOREIGN KEY (bed_id) REFERENCES bed (bed_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生床位入住表';

CREATE TABLE duty_schedule (
  schedule_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '值日安排ID',
  room_id BIGINT UNSIGNED NOT NULL COMMENT '房间ID',
  student_id BIGINT UNSIGNED NOT NULL COMMENT '值日学生ID',
  duty_date DATE NOT NULL COMMENT '值日日期',
  duty_type ENUM('DAILY','WEEKLY','GENERAL_CLEANING') NOT NULL DEFAULT 'DAILY' COMMENT '值日类型',
  task_content VARCHAR(255) NOT NULL COMMENT '值日任务内容',
  status ENUM('PENDING','FINISHED','MISSED') NOT NULL DEFAULT 'PENDING' COMMENT '完成状态',
  created_by BIGINT UNSIGNED DEFAULT NULL COMMENT '创建管理员ID',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (schedule_id),
  UNIQUE KEY uk_duty_room_date_type (room_id, duty_date, duty_type),
  KEY idx_duty_student_date (student_id, duty_date),
  CONSTRAINT fk_duty_schedule_room FOREIGN KEY (room_id) REFERENCES dorm_room (room_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_duty_schedule_student FOREIGN KEY (student_id) REFERENCES student (student_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_duty_schedule_admin FOREIGN KEY (created_by) REFERENCES admin (admin_id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='卫生值日安排表';

CREATE TABLE duty_record (
  record_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '卫生检查记录ID',
  schedule_id BIGINT UNSIGNED NOT NULL COMMENT '值日安排ID',
  check_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '检查时间',
  score DECIMAL(5,2) NOT NULL DEFAULT 0.00 COMMENT '卫生评分',
  result ENUM('EXCELLENT','GOOD','PASS','FAIL') NOT NULL DEFAULT 'PASS' COMMENT '检查结果',
  inspector_id BIGINT UNSIGNED DEFAULT NULL COMMENT '检查管理员ID',
  remark VARCHAR(255) DEFAULT NULL COMMENT '检查备注',
  PRIMARY KEY (record_id),
  UNIQUE KEY uk_duty_record_schedule (schedule_id),
  KEY idx_duty_record_result (result),
  CONSTRAINT chk_duty_score CHECK (score >= 0 AND score <= 100),
  CONSTRAINT fk_duty_record_schedule FOREIGN KEY (schedule_id) REFERENCES duty_schedule (schedule_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_duty_record_admin FOREIGN KEY (inspector_id) REFERENCES admin (admin_id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='卫生检查记录表';

CREATE TABLE fee_type (
  type_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '费用类型ID',
  type_code VARCHAR(50) NOT NULL COMMENT '费用类型编码',
  type_name VARCHAR(50) NOT NULL COMMENT '费用类型名称',
  billing_cycle ENUM('MONTHLY','QUARTERLY','ONCE') NOT NULL DEFAULT 'MONTHLY' COMMENT '计费周期',
  unit VARCHAR(20) NOT NULL DEFAULT '元' COMMENT '单位',
  status TINYINT NOT NULL DEFAULT 1 COMMENT '状态：1启用，0停用',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (type_id),
  UNIQUE KEY uk_fee_type_code (type_code),
  CONSTRAINT chk_fee_type_status CHECK (status IN (0, 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='费用类型表';

CREATE TABLE fee_bill (
  bill_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '费用账单ID',
  room_id BIGINT UNSIGNED NOT NULL COMMENT '房间ID',
  type_id BIGINT UNSIGNED NOT NULL COMMENT '费用类型ID',
  bill_month CHAR(7) NOT NULL COMMENT '账单月份，格式YYYY-MM',
  amount DECIMAL(10,2) NOT NULL COMMENT '应缴金额',
  paid_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '已缴金额',
  due_date DATE NOT NULL COMMENT '应缴截止日期',
  status ENUM('UNPAID','PARTIAL','PAID','OVERDUE') NOT NULL DEFAULT 'UNPAID' COMMENT '账单状态',
  remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
  created_by BIGINT UNSIGNED DEFAULT NULL COMMENT '创建管理员ID',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (bill_id),
  UNIQUE KEY uk_fee_bill_room_type_month (room_id, type_id, bill_month),
  KEY idx_fee_bill_status_due (status, due_date),
  KEY idx_fee_bill_month (bill_month),
  CONSTRAINT chk_fee_bill_amount CHECK (amount >= 0),
  CONSTRAINT chk_fee_bill_paid_amount CHECK (paid_amount >= 0 AND paid_amount <= amount),
  CONSTRAINT fk_fee_bill_room FOREIGN KEY (room_id) REFERENCES dorm_room (room_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_fee_bill_type FOREIGN KEY (type_id) REFERENCES fee_type (type_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_fee_bill_admin FOREIGN KEY (created_by) REFERENCES admin (admin_id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='费用账单表';

CREATE TABLE fee_payment (
  payment_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '缴费记录ID',
  bill_id BIGINT UNSIGNED NOT NULL COMMENT '费用账单ID',
  student_id BIGINT UNSIGNED DEFAULT NULL COMMENT '缴费学生ID',
  payer_name VARCHAR(50) NOT NULL COMMENT '缴费人姓名',
  amount DECIMAL(10,2) NOT NULL COMMENT '缴费金额',
  payment_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '缴费时间',
  payment_method ENUM('CASH','WECHAT','ALIPAY','BANK_CARD') NOT NULL DEFAULT 'WECHAT' COMMENT '缴费方式',
  transaction_no VARCHAR(100) DEFAULT NULL COMMENT '交易流水号',
  created_by BIGINT UNSIGNED DEFAULT NULL COMMENT '登记管理员ID',
  PRIMARY KEY (payment_id),
  UNIQUE KEY uk_payment_transaction_no (transaction_no),
  KEY idx_payment_bill_time (bill_id, payment_time),
  KEY idx_payment_student (student_id),
  CONSTRAINT chk_fee_payment_amount CHECK (amount > 0),
  CONSTRAINT fk_fee_payment_bill FOREIGN KEY (bill_id) REFERENCES fee_bill (bill_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_fee_payment_student FOREIGN KEY (student_id) REFERENCES student (student_id)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_fee_payment_admin FOREIGN KEY (created_by) REFERENCES admin (admin_id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='缴费记录表';

CREATE TABLE repair_order (
  order_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '维修单ID',
  room_id BIGINT UNSIGNED NOT NULL COMMENT '报修房间ID',
  reporter_student_id BIGINT UNSIGNED DEFAULT NULL COMMENT '报修学生ID',
  repair_title VARCHAR(100) NOT NULL COMMENT '维修标题',
  repair_content VARCHAR(500) NOT NULL COMMENT '维修内容',
  location_desc VARCHAR(100) NOT NULL COMMENT '位置描述',
  priority ENUM('LOW','NORMAL','HIGH','URGENT') NOT NULL DEFAULT 'NORMAL' COMMENT '优先级',
  status ENUM('SUBMITTED','ACCEPTED','PROCESSING','FINISHED','CANCELLED') NOT NULL DEFAULT 'SUBMITTED' COMMENT '维修状态',
  report_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '报修时间',
  finish_time DATETIME DEFAULT NULL COMMENT '完成时间',
  handler_admin_id BIGINT UNSIGNED DEFAULT NULL COMMENT '处理管理员ID',
  PRIMARY KEY (order_id),
  KEY idx_repair_room_status (room_id, status),
  KEY idx_repair_report_time (report_time),
  CONSTRAINT chk_repair_finish_time CHECK (finish_time IS NULL OR finish_time >= report_time),
  CONSTRAINT fk_repair_order_room FOREIGN KEY (room_id) REFERENCES dorm_room (room_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_repair_order_student FOREIGN KEY (reporter_student_id) REFERENCES student (student_id)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_repair_order_admin FOREIGN KEY (handler_admin_id) REFERENCES admin (admin_id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='维修报修表';

CREATE TABLE repair_process (
  process_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '维修处理记录ID',
  order_id BIGINT UNSIGNED NOT NULL COMMENT '维修单ID',
  operator_admin_id BIGINT UNSIGNED DEFAULT NULL COMMENT '操作管理员ID',
  old_status VARCHAR(30) DEFAULT NULL COMMENT '原状态',
  new_status VARCHAR(30) NOT NULL COMMENT '新状态',
  process_content VARCHAR(500) NOT NULL COMMENT '处理内容',
  process_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '处理时间',
  PRIMARY KEY (process_id),
  KEY idx_repair_process_order_time (order_id, process_time),
  CONSTRAINT fk_repair_process_order FOREIGN KEY (order_id) REFERENCES repair_order (order_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_repair_process_admin FOREIGN KEY (operator_admin_id) REFERENCES admin (admin_id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='维修处理记录表';

CREATE TABLE item (
  item_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '物品ID',
  room_id BIGINT UNSIGNED DEFAULT NULL COMMENT '所属房间ID',
  item_code VARCHAR(50) NOT NULL COMMENT '物品编码',
  item_name VARCHAR(100) NOT NULL COMMENT '物品名称',
  category VARCHAR(50) NOT NULL COMMENT '物品分类',
  quantity INT NOT NULL DEFAULT 1 COMMENT '数量',
  unit VARCHAR(20) NOT NULL DEFAULT '件' COMMENT '单位',
  purchase_date DATE DEFAULT NULL COMMENT '购入日期',
  item_status ENUM('NORMAL','BORROWED','DAMAGED','SCRAPPED') NOT NULL DEFAULT 'NORMAL' COMMENT '物品状态',
  keeper_student_id BIGINT UNSIGNED DEFAULT NULL COMMENT '保管学生ID',
  remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (item_id),
  UNIQUE KEY uk_item_code (item_code),
  KEY idx_item_room_status (room_id, item_status),
  CONSTRAINT chk_item_quantity CHECK (quantity > 0),
  CONSTRAINT fk_item_room FOREIGN KEY (room_id) REFERENCES dorm_room (room_id)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_item_keeper_student FOREIGN KEY (keeper_student_id) REFERENCES student (student_id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='宿舍物品表';

CREATE TABLE item_borrow (
  borrow_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '物品借用ID',
  item_id BIGINT UNSIGNED NOT NULL COMMENT '物品ID',
  borrower_student_id BIGINT UNSIGNED NOT NULL COMMENT '借用学生ID',
  borrow_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '借用时间',
  expected_return_time DATETIME NOT NULL COMMENT '预计归还时间',
  actual_return_time DATETIME DEFAULT NULL COMMENT '实际归还时间',
  status ENUM('BORROWING','RETURNED','OVERDUE') NOT NULL DEFAULT 'BORROWING' COMMENT '借用状态',
  remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (borrow_id),
  KEY idx_item_borrow_item_status (item_id, status),
  KEY idx_item_borrow_student (borrower_student_id),
  CONSTRAINT chk_item_borrow_time CHECK (expected_return_time > borrow_time AND (actual_return_time IS NULL OR actual_return_time >= borrow_time)),
  CONSTRAINT fk_item_borrow_item FOREIGN KEY (item_id) REFERENCES item (item_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_item_borrow_student FOREIGN KEY (borrower_student_id) REFERENCES student (student_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='物品借用表';

CREATE TABLE visitor (
  visitor_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '访客ID',
  visitor_name VARCHAR(50) NOT NULL COMMENT '访客姓名',
  phone VARCHAR(20) NOT NULL COMMENT '访客手机号',
  id_card VARCHAR(30) DEFAULT NULL COMMENT '证件号码',
  relationship VARCHAR(50) DEFAULT NULL COMMENT '与学生关系',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (visitor_id),
  UNIQUE KEY uk_visitor_phone (phone),
  UNIQUE KEY uk_visitor_id_card (id_card)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='来访人员表';

CREATE TABLE visit_record (
  visit_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '来访记录ID',
  visitor_id BIGINT UNSIGNED NOT NULL COMMENT '访客ID',
  student_id BIGINT UNSIGNED NOT NULL COMMENT '被访学生ID',
  room_id BIGINT UNSIGNED NOT NULL COMMENT '被访房间ID',
  visit_reason VARCHAR(255) NOT NULL COMMENT '来访原因',
  visit_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '来访时间',
  leave_time DATETIME DEFAULT NULL COMMENT '离开时间',
  status ENUM('VISITING','LEFT') NOT NULL DEFAULT 'VISITING' COMMENT '来访状态',
  register_admin_id BIGINT UNSIGNED DEFAULT NULL COMMENT '登记管理员ID',
  PRIMARY KEY (visit_id),
  KEY idx_visit_room_time (room_id, visit_time),
  KEY idx_visit_student_time (student_id, visit_time),
  CONSTRAINT chk_visit_leave_time CHECK (leave_time IS NULL OR leave_time >= visit_time),
  CONSTRAINT fk_visit_record_visitor FOREIGN KEY (visitor_id) REFERENCES visitor (visitor_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_visit_record_student FOREIGN KEY (student_id) REFERENCES student (student_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_visit_record_room FOREIGN KEY (room_id) REFERENCES dorm_room (room_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_visit_record_admin FOREIGN KEY (register_admin_id) REFERENCES admin (admin_id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='来访记录表';

CREATE TABLE operation_log (
  log_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '操作日志ID',
  admin_id BIGINT UNSIGNED DEFAULT NULL COMMENT '操作管理员ID',
  module_name VARCHAR(50) NOT NULL COMMENT '模块名称',
  operation_type VARCHAR(50) NOT NULL COMMENT '操作类型',
  operation_desc VARCHAR(500) NOT NULL COMMENT '操作描述',
  request_ip VARCHAR(45) DEFAULT NULL COMMENT '请求IP',
  operation_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  result_status ENUM('SUCCESS','FAIL') NOT NULL DEFAULT 'SUCCESS' COMMENT '操作结果',
  PRIMARY KEY (log_id),
  KEY idx_operation_admin_time (admin_id, operation_time),
  KEY idx_operation_module_time (module_name, operation_time),
  CONSTRAINT fk_operation_log_admin FOREIGN KEY (admin_id) REFERENCES admin (admin_id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志表';

SET FOREIGN_KEY_CHECKS = 1;
