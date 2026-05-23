package com.dormitory.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.dormitory.common.Result;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.Serializable;
import java.util.List;

public abstract class BaseCrudController<T> {

    private final IService<T> service;

    protected BaseCrudController(IService<T> service) {
        this.service = service;
    }

    protected abstract void setId(T entity, Long id);

    protected IService<T> service() {
        return service;
    }

    @GetMapping
    public Result<Page<T>> page(@RequestParam(defaultValue = "1") long page,
                                @RequestParam(defaultValue = "10") long size) {
        return Result.success(service.page(new Page<>(page, size)));
    }

    @GetMapping("/list")
    public Result<List<T>> list() {
        return Result.success(service.list());
    }

    @GetMapping("/{id}")
    public Result<T> getById(@PathVariable Long id) {
        return Result.success(service.getById((Serializable) id));
    }

    @PostMapping
    public Result<Boolean> create(@RequestBody T entity) {
        return Result.success(service.save(entity));
    }

    @PutMapping("/{id}")
    public Result<Boolean> update(@PathVariable Long id, @RequestBody T entity) {
        setId(entity, id);
        return Result.success(service.updateById(entity));
    }

    @DeleteMapping("/{id}")
    public Result<Boolean> delete(@PathVariable Long id) {
        return Result.success(service.removeById((Serializable) id));
    }
}
