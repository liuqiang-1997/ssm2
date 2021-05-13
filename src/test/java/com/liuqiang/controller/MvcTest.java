package com.liuqiang.controller;

import com.github.pagehelper.PageInfo;
import com.liuqiang.pojo.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.DefaultMockMvcBuilder;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 *  使用Spring测试模块测试请求功能
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
@WebAppConfiguration   // 获取IOC容器自己
public class MvcTest {

    // 传入springmvc的ioc容器
    @Autowired
    WebApplicationContext context;
    // 虚拟mvc请求，获取处理结果
    MockMvc mockMvc;

    @Before
    public void initMokcMvc(){
        mockMvc= MockMvcBuilders.webAppContextSetup(context).build();
    }

    /**
     * 分页测试
     */
    @Test
    public void testPage() throws Exception{

        // 模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/employee/getemps")
                         .param("page", String.valueOf(6))).andReturn();
       // 请求成功以后，请求域中会有pageInfo，可取出验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码"+pageInfo.getPageNum());
        System.out.println("总页码"+pageInfo.getPages());
        System.out.println("总记录数"+pageInfo.getTotal());
        System.out.println("连续显示的页码");
        for (int i:pageInfo.getNavigatepageNums()
             ) {
            System.out.println(i);
        }

        // 获取员工信息
        List<Employee> list = pageInfo.getList();
        for (Employee e:list
             ) {
            System.out.println("ID"+e.getEmpId()+"==>name:"+e.getEmpName());
        }
    }
}
