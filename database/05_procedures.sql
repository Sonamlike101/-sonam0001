/*
  11栋南区504宿舍管理系统 - 存储过程脚本
*/

USE dormitory_system;
SET NAMES utf8mb4;

DROP PROCEDURE IF EXISTS sp_assign_student_bed;
DROP PROCEDURE IF EXISTS sp_create_fee_bill;

DELIMITER $$

CREATE PROCEDURE sp_assign_student_bed (
  IN p_student_no VARCHAR(30),
  IN p_bed_id BIGINT UNSIGNED,
  IN p_admin_id BIGINT UNSIGNED
)
BEGIN
  DECLARE v_student_id BIGINT UNSIGNED;
  DECLARE v_living_count INT DEFAULT 0;
  DECLARE v_bed_status VARCHAR(20);

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  START TRANSACTION;

  SELECT student_id
  INTO v_student_id
  FROM student
  WHERE student_no = p_student_no
  LIMIT 1;

  IF v_student_id IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '学生不存在';
  END IF;

  SELECT COUNT(*)
  INTO v_living_count
  FROM student_bed
  WHERE student_id = v_student_id
    AND status = 'LIVING';

  IF v_living_count > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '该学生已有在住宿舍';
  END IF;

  SELECT status
  INTO v_bed_status
  FROM bed
  WHERE bed_id = p_bed_id
  LIMIT 1;

  IF v_bed_status IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '床位不存在';
  END IF;

  IF v_bed_status <> 'AVAILABLE' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '床位不可分配';
  END IF;

  INSERT INTO student_bed (student_id, bed_id, check_in_date, status, remark)
  VALUES (v_student_id, p_bed_id, CURRENT_DATE, 'LIVING', '通过存储过程分配床位');

  INSERT INTO operation_log (admin_id, module_name, operation_type, operation_desc, request_ip, result_status)
  VALUES (p_admin_id, '入住管理', 'CALL_PROCEDURE', CONCAT('为学生', p_student_no, '分配床位ID=', p_bed_id), '127.0.0.1', 'SUCCESS');

  COMMIT;
END$$

CREATE PROCEDURE sp_create_fee_bill (
  IN p_room_id BIGINT UNSIGNED,
  IN p_type_id BIGINT UNSIGNED,
  IN p_bill_month CHAR(7),
  IN p_amount DECIMAL(10,2),
  IN p_due_date DATE,
  IN p_admin_id BIGINT UNSIGNED
)
BEGIN
  DECLARE v_room_count INT DEFAULT 0;
  DECLARE v_type_count INT DEFAULT 0;
  DECLARE v_bill_count INT DEFAULT 0;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  START TRANSACTION;

  SELECT COUNT(*) INTO v_room_count
  FROM dorm_room
  WHERE room_id = p_room_id;

  IF v_room_count = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '房间不存在';
  END IF;

  SELECT COUNT(*) INTO v_type_count
  FROM fee_type
  WHERE type_id = p_type_id
    AND status = 1;

  IF v_type_count = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '费用类型不存在或已停用';
  END IF;

  SELECT COUNT(*) INTO v_bill_count
  FROM fee_bill
  WHERE room_id = p_room_id
    AND type_id = p_type_id
    AND bill_month = p_bill_month;

  IF v_bill_count > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '该房间该月份同类型账单已存在';
  END IF;

  INSERT INTO fee_bill (room_id, type_id, bill_month, amount, due_date, status, created_by, remark)
  VALUES (p_room_id, p_type_id, p_bill_month, p_amount, p_due_date, 'UNPAID', p_admin_id, '通过存储过程生成账单');

  INSERT INTO operation_log (admin_id, module_name, operation_type, operation_desc, request_ip, result_status)
  VALUES (p_admin_id, '费用管理', 'CALL_PROCEDURE', CONCAT('为房间ID=', p_room_id, '生成', p_bill_month, '账单'), '127.0.0.1', 'SUCCESS');

  COMMIT;
END$$

DELIMITER ;

