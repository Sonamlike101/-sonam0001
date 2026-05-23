package com.dormitory.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dormitory.entity.Bed;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface BedMapper extends BaseMapper<Bed> {

    @Select("""
            SELECT
              bd.bed_id AS bedId,
              CONCAT(r.room_no, '-', bd.bed_no) AS bedLabel,
              bd.bed_no AS bedNo,
              bd.status AS bedStatus,
              r.room_id AS roomId,
              r.room_no AS roomNo,
              b.area_name AS areaName,
              b.building_no AS buildingNo,
              s.student_id AS studentId,
              s.student_no AS studentNo,
              s.student_name AS studentName
            FROM bed bd
            JOIN dorm_room r ON bd.room_id = r.room_id
            JOIN dorm_building b ON r.building_id = b.building_id
            LEFT JOIN student_bed sb ON bd.bed_id = sb.bed_id AND sb.status = 'LIVING'
            LEFT JOIN student s ON sb.student_id = s.student_id
            ORDER BY b.building_no, r.room_no, bd.bed_no
            """)
    List<Map<String, Object>> selectBedDetails();
}
