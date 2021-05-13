package com.liuqiang.service;

import com.liuqiang.dao.EmployeeMapper;
import com.liuqiang.pojo.Employee;
import com.liuqiang.pojo.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     */
    public List<Employee> getEmpAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 添加员工
     * @param employee 员工对象
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     *  查询员工名是否可用，通过查询条件在数据库中返回的数值进行判断
     * @param empName
     * @return true:可用; false:不可用
     */
    public boolean checkUser(String empName){
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        System.out.println("count-->"+count);
        boolean b = count == 0;
        System.out.println(b);
        return count == 0;
    }

    /**
     * 按照员工id查询员工
     * @param id id
     * @return 员工对象
     */
    public  Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     * 根据条件更新
     * @param employee 对象
     */
    public void updateEmp(Employee employee){
        employeeMapper.updateByPrimaryKeySelective(employee);

    }

    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employeeExample);
    }
}
