package com.dormitory.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dormitory.common.Result;
import com.dormitory.entity.Student;
import com.dormitory.service.StudentService;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/students")
public class StudentController extends BaseCrudController<Student> {

    public StudentController(StudentService service) {
        super(service);
    }

    @Override
    protected void setId(Student entity, Long id) {
        entity.setStudentId(id);
    }

    @GetMapping("/search")
    public Result<Page<Student>> search(@RequestParam(defaultValue = "1") long page,
                                        @RequestParam(defaultValue = "10") long size,
                                        @RequestParam(required = false) String keyword) {
        LambdaQueryWrapper<Student> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(keyword)) {
            wrapper.like(Student::getStudentName, keyword)
                    .or()
                    .like(Student::getStudentNo, keyword)
                    .or()
                    .like(Student::getPhone, keyword);
        }
        wrapper.orderByAsc(Student::getStudentNo);
        return Result.success(service().page(new Page<>(page, size), wrapper));
    }
}
