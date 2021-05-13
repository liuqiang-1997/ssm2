package com.liuqiang.service;

import com.liuqiang.dao.DepartmentMapper;
import com.liuqiang.pojo.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    /**
     * 查询所有部门
     * @return 部门列表
     */
   public List<Department> getAllDept(){
        return departmentMapper.selectByExample(null);
    }
}
