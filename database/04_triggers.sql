/*
  11栋南区504宿舍管理系统 - 触发器脚本
*/

USE dormitory_system;
SET NAMES utf8mb4;

DROP TRIGGER IF EXISTS trg_student_bed_after_insert;
DROP TRIGGER IF EXISTS trg_student_bed_after_update;
DROP TRIGGER IF EXISTS trg_student_bed_before_insert;
DROP TRIGGER IF EXISTS trg_student_bed_before_update;
DROP TRIGGER IF EXISTS trg_fee_payment_after_insert;

DELIMITER $$

CREATE TRIGGER trg_student_bed_before_insert
BEFORE INSERT ON student_bed
FOR EACH ROW
BEGIN
  DECLARE v_student_living_count INT DEFAULT 0;
  DECLARE v_bed_living_count INT DEFAULT 0;
  DECLARE v_bed_status VARCHAR(20);

  IF NEW.status = 'LIVING' THEN
    SELECT COUNT(*)
    INTO v_student_living_count
    FROM student_bed
    WHERE student_id = NEW.student_id
      AND status = 'LIVING';

    IF v_student_living_count > 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '该学生已有在住宿舍';
    END IF;

    SELECT COUNT(*)
    INTO v_bed_living_count
    FROM student_bed
    WHERE bed_id = NEW.bed_id
      AND status = 'LIVING';

    IF v_bed_living_count > 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '该床位已有在住学生';
    END IF;

    SELECT status
    INTO v_bed_status
    FROM bed
    WHERE bed_id = NEW.bed_id;

    IF v_bed_status <> 'AVAILABLE' THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '床位当前不可入住';
    END IF;
  END IF;
END$$

CREATE TRIGGER trg_student_bed_before_update
BEFORE UPDATE ON student_bed
FOR EACH ROW
BEGIN
  DECLARE v_student_living_count INT DEFAULT 0;
  DECLARE v_bed_living_count INT DEFAULT 0;
  DECLARE v_bed_status VARCHAR(20);

  IF NEW.status = 'LIVING' THEN
    SELECT COUNT(*)
    INTO v_student_living_count
    FROM student_bed
    WHERE student_id = NEW.student_id
      AND status = 'LIVING'
      AND check_in_id <> OLD.check_in_id;

    IF v_student_living_count > 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '该学生已有在住宿舍';
    END IF;

    SELECT COUNT(*)
    INTO v_bed_living_count
    FROM student_bed
    WHERE bed_id = NEW.bed_id
      AND status = 'LIVING'
      AND check_in_id <> OLD.check_in_id;

    IF v_bed_living_count > 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '该床位已有在住学生';
    END IF;

    SELECT status
    INTO v_bed_status
    FROM bed
    WHERE bed_id = NEW.bed_id;

    IF NEW.bed_id <> OLD.bed_id AND v_bed_status <> 'AVAILABLE' THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '床位当前不可入住';
    END IF;
  END IF;
END$$

CREATE TRIGGER trg_student_bed_after_insert
AFTER INSERT ON student_bed
FOR EACH ROW
BEGIN
  DECLARE v_room_id BIGINT UNSIGNED;

  IF NEW.status = 'LIVING' THEN
    SELECT room_id INTO v_room_id
    FROM bed
    WHERE bed_id = NEW.bed_id;

    UPDATE bed
    SET status = 'OCCUPIED'
    WHERE bed_id = NEW.bed_id;

    UPDATE student
    SET check_in_status = 'LIVING'
    WHERE student_id = NEW.student_id;

    UPDATE dorm_room
    SET occupied_count = (
        SELECT COUNT(*)
        FROM student_bed sb
        JOIN bed bd ON sb.bed_id = bd.bed_id
        WHERE bd.room_id = v_room_id
          AND sb.status = 'LIVING'
      ),
      status = CASE
        WHEN capacity <= (
          SELECT COUNT(*)
          FROM student_bed sb
          JOIN bed bd ON sb.bed_id = bd.bed_id
          WHERE bd.room_id = v_room_id
            AND sb.status = 'LIVING'
        ) THEN 'FULL'
        ELSE 'AVAILABLE'
      END
    WHERE room_id = v_room_id;
  END IF;
END$$

CREATE TRIGGER trg_student_bed_after_update
AFTER UPDATE ON student_bed
FOR EACH ROW
BEGIN
  DECLARE v_old_room_id BIGINT UNSIGNED;
  DECLARE v_new_room_id BIGINT UNSIGNED;

  SELECT room_id INTO v_old_room_id
  FROM bed
  WHERE bed_id = OLD.bed_id;

  SELECT room_id INTO v_new_room_id
  FROM bed
  WHERE bed_id = NEW.bed_id;

  IF OLD.status = 'LIVING' AND NEW.status = 'CHECKED_OUT' THEN
    UPDATE bed
    SET status = 'AVAILABLE'
    WHERE bed_id = OLD.bed_id;

    UPDATE student
    SET check_in_status = 'CHECKED_OUT'
    WHERE student_id = OLD.student_id;
  END IF;

  IF NEW.status = 'LIVING' THEN
    UPDATE bed
    SET status = 'OCCUPIED'
    WHERE bed_id = NEW.bed_id;

    UPDATE student
    SET check_in_status = 'LIVING'
    WHERE student_id = NEW.student_id;
  END IF;

  UPDATE dorm_room
  SET occupied_count = (
      SELECT COUNT(*)
      FROM student_bed sb
      JOIN bed bd ON sb.bed_id = bd.bed_id
      WHERE bd.room_id = v_old_room_id
        AND sb.status = 'LIVING'
    ),
    status = CASE
      WHEN capacity <= (
        SELECT COUNT(*)
        FROM student_bed sb
        JOIN bed bd ON sb.bed_id = bd.bed_id
        WHERE bd.room_id = v_old_room_id
          AND sb.status = 'LIVING'
      ) THEN 'FULL'
      ELSE 'AVAILABLE'
    END
  WHERE room_id = v_old_room_id;

  IF v_new_room_id <> v_old_room_id THEN
    UPDATE dorm_room
    SET occupied_count = (
        SELECT COUNT(*)
        FROM student_bed sb
        JOIN bed bd ON sb.bed_id = bd.bed_id
        WHERE bd.room_id = v_new_room_id
          AND sb.status = 'LIVING'
      ),
      status = CASE
        WHEN capacity <= (
          SELECT COUNT(*)
          FROM student_bed sb
          JOIN bed bd ON sb.bed_id = bd.bed_id
          WHERE bd.room_id = v_new_room_id
            AND sb.status = 'LIVING'
        ) THEN 'FULL'
        ELSE 'AVAILABLE'
      END
    WHERE room_id = v_new_room_id;
  END IF;
END$$

CREATE TRIGGER trg_fee_payment_after_insert
AFTER INSERT ON fee_payment
FOR EACH ROW
BEGIN
  DECLARE v_total_paid DECIMAL(10,2);
  DECLARE v_bill_amount DECIMAL(10,2);

  SELECT IFNULL(SUM(amount), 0)
  INTO v_total_paid
  FROM fee_payment
  WHERE bill_id = NEW.bill_id;

  SELECT amount
  INTO v_bill_amount
  FROM fee_bill
  WHERE bill_id = NEW.bill_id;

  UPDATE fee_bill
  SET paid_amount = v_total_paid,
      status = CASE
        WHEN v_total_paid >= v_bill_amount THEN 'PAID'
        WHEN v_total_paid > 0 THEN 'PARTIAL'
        WHEN due_date < CURRENT_DATE THEN 'OVERDUE'
        ELSE 'UNPAID'
      END
  WHERE bill_id = NEW.bill_id;
END$$

DELIMITER ;
