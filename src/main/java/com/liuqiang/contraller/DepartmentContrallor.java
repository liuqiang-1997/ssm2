package com.liuqiang.contraller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.liuqiang.pojo.Department;

import com.liuqiang.pojo.Msg;
import com.liuqiang.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("department")
public class DepartmentContrallor {

    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/get_dept")
    @ResponseBody
    public Msg getEmpsByJson(@RequestParam(value = "page",defaultValue = "1") Integer page){
        PageHelper.startPage(page,5);
        List<Department> allDept = departmentService.getAllDept();
        PageInfo pageInfo = new PageInfo(allDept, 5);
        return Msg.success().add("pageInfo",pageInfo);
    }

//    @RequestMapping("getdepts")
//    public String getEmps(@RequestParam(value = "page",defaultValue = "1") Integer page,
//                          Model model){
//        // 引入PageHelper分页
//        PageHelper.startPage(page,10);
//        List<Department> allDept = departmentService.getAllDept();
//        // 使用pageInfo包装查询后的结果,将pageInfo提交给前端页面
//        // navigatePages:连续显示多少页
//        PageInfo pageInfo = new PageInfo(allDept, 5);
//        model.addAttribute("pageInfodept",pageInfo);
//
//        return "deptlist";
//    }
}
