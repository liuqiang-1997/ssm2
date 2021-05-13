package com.liuqiang.dao;

import com.liuqiang.pojo.Employee;
import com.liuqiang.pojo.EmployeeExample;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

/**
 * dao层测试
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    SqlSession sqlSession;  // 可执行批量注入的
    /**
     * DepartmentMapper测试
     */
    @Test
    public void test(){
//        // 创建Spring容器
//        ApplicationContext applicationContext =  new ClassPathXmlApplicationContext("applicationContext.xml");
////        // 获取mapper
//        DepartmentMapper bean = applicationContext.getBean(DepartmentMapper.class);
//        System.out.println(bean);
//        System.out.println("dept-->"+employeeMapper);
//        List<Employee> employees = employeeMapper.selectByExampleWithDept(new EmployeeExample());
//        System.out.println(employees);
//        int insert = employeeMapper.insert(new Employee(null, "沃尔德", "b", "231@qq.com"));
//        int insert = employeeMapper.insert(new Employee(null, "杜富国", "g", "987@126.com", 2));
//        System.out.println(insert);

    }

    /**
     *  sqlsession 批量注入
     */
    @Test
    public void test1(){
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0;i<1000;i++){
            String substring = UUID.randomUUID().toString().substring(0, 5);
            mapper.insertSelective(new Employee(null,substring,"b",substring+"@168.com"));
        }
    }
}
