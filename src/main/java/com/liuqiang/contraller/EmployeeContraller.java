package com.liuqiang.contraller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.liuqiang.pojo.Department;
import com.liuqiang.pojo.Employee;
import com.liuqiang.pojo.Msg;
import com.liuqiang.service.EmployeeService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * 处理员工CRUD
 */
@Controller
@RequestMapping("employee")
public class EmployeeContraller {

    @Autowired
    EmployeeService employeeService;

    /**
     * 单个批量删除合集
     * 批量 1-2-3-4。。。
     * 单个 1
     * @param ids
     * @return
     */
    @RequestMapping(value = "delete/{ids}")
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        System.err.println("调用方法了");
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for (String s:str_ids
                 ) {
                del_ids.add(Integer.parseInt(s));
            }
            employeeService.deleteBatch(del_ids);

        }else{
            Integer i = Integer.parseInt(ids);
            employeeService.deleteEmpById(i);

        }
        return Msg.success();
    }

    @RequestMapping(value = "querys/{empId}")
    public Msg saveEmp(Employee employee){
        System.out.println("更新的数据"+ employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 根据id查询员工
     * @param id id
     * @return 对象
     */
    @RequestMapping(value = "select/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);

        return Msg.success().add("emp",employee);
    }
    

    /**
     * 查询所有员工（分页）
     * @return 员工列表
     */
    @RequestMapping("get_emp")
    @ResponseBody
    public Msg getEmps(@RequestParam(value = "page",defaultValue = "1") Integer page){
        PageHelper.startPage(page,10);
        List<Employee> allEmp = employeeService.getEmpAll();
        PageInfo pageInfo = new PageInfo(allEmp, 5);
        return Msg.success().add("emp_pageInfo",pageInfo);
    }
//    @RequestMapping("getemps")
//    public String getEmps(@RequestParam(value = "page",defaultValue = "1") Integer page,
//                          Model model){
//        // 引入PageHelper分页
//        PageHelper.startPage(page,10);
//        List<Employee> empAll = employeeService.getEmpAll();
//        // 使用pageInfo包装查询后的结果,将pageInfo提交给前端页面
//        // navigatePages:连续显示多少页
//        PageInfo<Employee> pageInfo = new PageInfo(empAll,5);
//        model.addAttribute("pageInfo",pageInfo);
//        return "emplist";
//    }

    /**
     * 添加员工
     * @return
     * @Valid 传入的数据需要校验，BindingResult为校验的结果
     */
    @RequestMapping(value = "save_emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg insertEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            // 校验失败，在模态框中显示校验失败的错误信息
            List<FieldError> errors = result.getFieldErrors();
            HashMap<String, Object> map = new HashMap<>();
            for (FieldError error:errors
                 ) {
                System.out.println("错误的字段名--->"+error.getField());
                System.out.println("错误信息--->"+error.getDefaultMessage());
                map.put(error.getField(),error.getDefaultMessage());
            }


            return Msg.fail().add("errorFields",map);

        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    };

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @RequestMapping("check")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
        // 判断用户名是否合法
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)) {
            return Msg.fail().add("vs_msg","用户名太短");
        }
        boolean b = employeeService.checkUser(empName);
        System.out.println("zheshi ---->"+b);
        if(b){
            return Msg.success();
        }else {
            System.out.println("200不可用");
            return Msg.fail().add("vs_msg","用户名已存在，不可用");

        }

    }


}
