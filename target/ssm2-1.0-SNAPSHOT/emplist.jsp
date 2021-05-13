<%--
  Created by IntelliJ IDEA.
  User: liuqiang
  Date: 2021/3/28
  Time: 9:25 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib prefix="c" uri="http://javasun.com/jsp/jstl/core"%>--%>
<html>
<head>
    <title>员工管理</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());  // 引入项目资源路径
    %>
    <%--      引入jquery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.js"></script>
    <%--      引入样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<%--    修改数据的模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工信息修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="input_empName" class="col-sm-2 control-label">员工姓名:</label>
                        <div class="col-sm-10">
                            <p  class="form-control-static" id="update_empName"
                               ></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_email" class="col-sm-2 control-label">员工邮箱</label>
                        <div class="col-sm-10">
                            <input type="email"  name="email" class="form-control" id="update_email"
                                   placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="updategender1" value="b"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="updategender2" value="g"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">所属部门</label>
                        <div class="col-sm-5">
                            <select class="form-control" name="dId" >

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<%--    添加数据的模态框--%>
<!-- Button trigger modal -->

<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="input_empName" class="col-sm-2 control-label">员工姓名:</label>
                        <div class="col-sm-10">
                            <input type="text"  name="empName" class="form-control" id="input_empName"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_email" class="col-sm-2 control-label">员工邮箱</label>
                        <div class="col-sm-10">
                            <input type="email"  name="email" class="form-control" id="input_email" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1" value="b"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2" value="g"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">所属部门</label>
                        <div class="col-sm-5">
                            <select class="form-control" name="dId" id="deptname_list">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">提交</button>
            </div>
        </div>
    </div>
</div>

<%--         显示页面--%>
<div class="container"align="center">
    <%--      标题--%>
    <div class="row clearfix" >
        <div class="col-md-11 column">
            <div class="page-header">
                <h1>
                    <small>      显示所有员工</small>
                </h1>
            </div>
        </div>
        <%--       按钮--%>
        <div class="row">
            <div class="col-md-2 column">
                <button class="btn btn-primary" id="emp_add_modal_btn">insert</button>
                <button class="btn btn-danger" id="emp_delete_all_btn" >delete</button>
            </div>
            <div class="col-md-9 column">
                <form  class="form-inline" action="${pageContext.request.contextPath}/book/querybook " method="post"
                       style="float:right">
                    <span style="color: red" ;font-weight:bold>${erro}</span>
                    <input type="text" class="form-control" name="queryBookName" placeholder="请输入员工编号查询">
                    <input type="submit" class="btn btn-primary" value="query">
                </form>
            </div>
        </div>
        <%--    显示表格数据--%>
        <div class="row" >
            <div class="col-md-12">
                <table class="table table-hover" id="emp_table">
                    <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>员工编号</th>
                        <th>员工姓名</th>
                        <th>员工性别</th>
                        <th>员工邮箱</th>
                        <th>所属部门</th>
                        <th>操&nbsp;&nbsp;作</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>


                </table>
            </div>
        </div>
        <%--    显示分页信息--%>
        <div class="row">
            <%--          分页文字信息--%>
            <div class="col-md-6" id="page_info_area">

            </div>
            <%--           分页条信息--%>
            <div class="col-md-6" id="page_nav_area">

            </div>
        </div>



    </div>

        <%--                     使用 ajax 请求处理json数据--%>
        <script type="text/javascript">
            // 定义全局变量
            var totalRecord; // 总页数
            var currentNum;  // 当前页面
            // 1.页面加载完成之后，直接发送一个ajax请求获取分页数据
            $(function(){
                to_page(1);
            });
            // 页面跳转
            function to_page(page){
                $.ajax({
                    // 请求地址
                    url:"${APP_PATH}/employee/get_emp",
                    // 请求数据
                    data:"page="+page,
                    // 请求类型
                    type:"GET",
                    // 请求成功的回调函数
                    success:function (result){
                        // console.log(result);  // 控制台输出
                        // 1。解析并显示部门数据
                        build_dept_table(result);
                        // 解析显示分页信息
                        build_page_info(result);
                        // 2。解析并显示分页数据
                        build_page_nav(result);

                    }
                });

            }

            // 构建员工表格
            function build_dept_table(result){
                // 清空原有数据
                $("#emp_table tbody").empty();
                var emp = result.extend.emp_pageInfo.list;
                $.each(emp,function (index,item){
                    // 构建单元格
                    var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                    var empIdTd = $("<td></td>").append(item.empId);
                    var empNameTd = $("<td></td>").append(item.empName);
                    var genderTd = $("<td></td>").append(item.gender=="b"?"男":"女");
                    var emailTd = $("<td></td>").append(item.email);
                    var dIdTd = $("<td></td>").append(item.department==null?"无":item.department.deptName);

                    var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                        .append("UpDate");
                    // 为编辑按钮添加一个自定义的属性，来表示当前员工的ID
                    editBtn.attr("edit-id",item.empId);
                    var deleBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                        .append("Delete");
                    // 为删除按钮添加一个自定义的属性，来表示当前员工的ID
                    deleBtn.attr("delete-id",item.empId);
                    var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleBtn);
                    $("<tr></tr>").append(checkBoxTd)
                        .append(empIdTd)
                        .append(empNameTd)
                        .append(genderTd)
                        .append(emailTd)
                        .append(emailTd)
                        .append(dIdTd)
                        .append(btnTd)
                        .appendTo("#emp_table tbody");  // 将数据提交到对应的标签下

                });

            }
            // 解析显示分页信息
            function build_page_info(result){
                // 清空原有数据
                $("#page_info_area").empty();
                $("#page_info_area").append("当前第["+result.extend.emp_pageInfo.pageNum+"]页,总共["
                    +result.extend.emp_pageInfo.pages+"]页,总记录数["+result.extend.emp_pageInfo.total+"]");
                totalRecord = result.extend.emp_pageInfo.total;
                currentNum = result.extend.emp_pageInfo.pageNum;
            }
            // 构建分页条
            function build_page_nav(result){
                $("#page_nav_area").empty();
            //     // 构建父元素ul
                var ul = $("<ul></ul>").addClass("pagination");
                // 构建首页
                var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));

                // 构建前一页
                var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));


            //     // 判断是否有前一页
                if(result.extend.emp_pageInfo.hasPreviousPage == false){
                    firstPageLi.addClass("disabled");
                    prePageLi.addClass("disabled");
                }else{
                    // 绑定首页单击事件
                    firstPageLi.click(function (){
                        to_page(1);
                    });
                    // 绑定前一页单击事件
                    prePageLi.click(function (){
                        to_page(result.extend.emp_pageInfo.pageNum-1);
                    })
                }
                // 添加前一页和首页的提示
                ul.append(firstPageLi).append(prePageLi);
                // 构建导航页码号
                $.each(result.extend.emp_pageInfo.navigatepageNums,function (index,item){
                    var numLi = $("<li></li>").append($("<a></a>").append(item))
                    // 判断当前页是否相等添加活动效果
                    if (result.extend.emp_pageInfo.pageNum == item){
                        numLi.addClass("active");
                    }
                    // 绑定页码单击翻页事件
                    numLi.click(function (){
                        to_page(item);
                    });
                    // 添加遍历的页码号
                    ul.append(numLi);
                });
                // 构建后一页
                var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));

                // 构建末页
                var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

                // 判断是否有后一页
                if(result.extend.emp_pageInfo.hasNextPage == false){
                    nextPageLi.addClass("disabled");
                    lastPageLi.addClass("disabled");
                }else{
                    // 绑定后一页单击事件
                    nextPageLi.click(function (){
                        to_page(result.extend.emp_pageInfo.pageNum+1);
                    });
                    // 绑定末页单击事件
                    lastPageLi.click(function (){
                        to_page(result.extend.emp_pageInfo.pages);
                    });
                }
                // 添加后一页和末页提示
                ul.append(nextPageLi).append(lastPageLi);

                var navEle = $("<nav></nav>").append(ul);
                navEle.appendTo("#page_nav_area");
            }

            // 清空表单样式及内容
            function reset_form(ele){
                $(ele)[0].reset();
                // 清空表单样式
                $(ele).find("*").removeClass("has-error has-success");
                $(ele).find(".help-block").text("");
            }

        //    绑定添加数据模态框事件,点击弹出模态框
            $("#emp_add_modal_btn").click(function (){
                // 防止数据校验重复导致失败，表单重置
                reset_form("#empAddModal form");
                // $("#empAddModal form")[0].reset();
                // 发送ajax请求，查出部门信息显示在下拉框
                getDepts("#deptname_list");
                // 弹出模态框
                  $("#empAddModal").modal({
                     backdrop:"static"
                  });
            });

            // 发送ajax请求，查出部门信息显示在下拉框
            function getDepts(ele){
                $.ajax({
                    url:"${APP_PATH}/department/get_dept",
                    type:"GET",
                    success:function (result){

                        // 遍历部门信息
                        var dept = result.extend.pageInfo.list;
                        $.each(dept,function (index,item){
                           var  optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
                            optionEle.appendTo(ele);
                        });
                    }
                });
            }

            // 表单数据校验
            function add_form(){
                // 1，拿到要校验的数据
             var empName = $("#input_empName").val();
             var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
                if(!regName.test(empName)){
                    //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
                    // $("#input_empName").parent().addClass("has-error");
                    // $("#input_empName").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合");
                    show_validate_msg("#input_empName", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
                    return false;
                }else{
                    // $("#input_empName").parent().addClass("has-success");
                    // $("#input_empName").next("span").text("success!");
                    show_validate_msg("#input_empName", "success", "");
                };

                var empEmail = $("#input_email").val();
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regEmail.test(empEmail)){
                    //alert("邮箱格式不正确");
                    //应该清空这个元素之前的样式
                    show_validate_msg("#input_email", "error", "邮箱格式不正确");
                   // $("#input_email").parent().addClass("has-error");
                   //  $("#input_email").next("span").text("邮箱格式不正确");
                    return false;
                }else{
                    show_validate_msg("#input_email", "success", "");
                    // $("#input_email").parent().addClass("has-success");
                }
                return true;
            }

            //显示校验结果的提示信息
            function show_validate_msg(ele,status,msg){
                //清除当前元素的校验状态
                $(ele).parent().removeClass("has-success has-error");
                $(ele).next("span").text("");
                if("success"==status){
                    $(ele).parent().addClass("has-success");
                    $(ele).next("span").text(msg);
                }else if("error" == status){
                    $(ele).parent().addClass("has-error");
                    $(ele).next("span").text(msg);
                }
            }

            // 校验用户名是否可用
            $("#input_empName").change(function (){
                // 发送ajax请求校验用户名是否可用
                var empName= this.value;
                $.ajax({
                   url:"${APP_PATH}/employee/check" ,
                    data:"empName="+empName,
                    type:"POST",
                    success:function (result){
                       if(result.code == 100){
                           show_validate_msg("#input_empName","success","当前用户名可以使用！");
                           $("#emp_save_btn").attr("ajax-va","success");
                       }else{
                           show_validate_msg("#input_empName","error",result.extend.vs_msg);
                           $("#emp_save_btn").attr("ajax-va","error");
                       }
                    }
                });
            });


        //    提交添加的数据,新增员工
            $("#emp_save_btn").click(function (){
                // 1 模态框填交表单数据给服务器保存
                // 2。先对数据进行校验
                if(!add_form()){
                    return false;
                };
                // 判断ajax用户名校验
                   if ($(this).attr("ajax-va")=="error"){

                       // show_validate_msg("#input_empName","error","用户名已存在");
                       // $("#input_empName").empty();
                       return false;
                   }
                // 3 发送ajax请求保存
                // alert($("#empAddModal form").serialize())
                $.ajax({
                   url: "${APP_PATH}/employee/save_emp",
                    type:"POST",
                    data:$("#empAddModal form").serialize(),
                    success:function (result){
                       // alert(result.msg);
                        if(result.code == 100){
                            // 保存成功
                            // 1关闭模态框
                            $("#empAddModal").modal("hide");
                            // 2跳转最后一页显示刚保存的数据(发送ajax请求）
                            to_page(totalRecord);

                        }else{
                            // 显示失败信息
                            console.log(result);
                            // alert(result.extend.errorFields.email);
                            // alert(result.extend.errorFields.empName);
                        }


                    }

                });

            });

            // 删除按钮绑定事件
            $(document).on("click",".delete_btn",function(){
                // 弹出是否确认删除对话框
                alert( $(this).parents("tr").find("td:eq(1)").text());
                var empname = $(this).parents("tr").find("td:eq(2)").text();
                var empid = $(this).attr("delete-id");
                if(confirm("确认删除{"+empname+"}嘛？")){
                    // 确认发送ajax请求
                    $.ajax({
                        url:"${APP_PATH}/employee/delete/"+ empid,
                        type:"DELETE",
                        success:function(result){
                            alert(result.msg);
                        }

                    })
                }
            });

            // 修改按钮绑定事件
            $(document).on("click",".edit_btn",function (){
               // alert("edit");

               // 查询员工部门
                getDepts("#empUpdateModal select ");
                // 查询员工信息
                getEmp($(this).attr("edit-id"));
                // 将员工ID传递给模态框的更新按钮
                $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"))
                $("#empUpdateModal").modal({
                    backdrop:"static"
                });
            });

        //    查询员工信息返回修改页面
            function getEmp(id){
                $.ajax({
                   url:"${APP_PATH}/employee/select/"+id ,
                    type:"GET",
                    success:function (result){
                       console.log(result);
                        var empData = result.extend.emp;
                        $("#update_empName").text(empData.empName);
                        $("#update_email").val(empData.email);
                        $("#empUpdateModal input[name=gender]").val([empData.gender]);
                        $("#empUpdateModal select").val([empData.dId])
                    }
                });
            }

            // 点击更新，更新员工信息
            $("#emp_update_btn").click(function (){
                //验证邮箱
                var empEmail = $("#update_email").val();
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regEmail.test(empEmail)){
                    //alert("邮箱格式不正确");
                    //应该清空这个元素之前的样式
                    show_validate_msg("#update_email", "error", "邮箱格式不正确");

                    return false;
                }else{
                    show_validate_msg("#update_email", "success", "");
                }

                // 发送ajax请求保存更新的数据
                $.ajax({
                   url:"${APP_PATH}/employee/querys/"+ $(this).attr("edit-id"),
                    type:"POST",
                    data:$("#empUpdateModal form").serialize(),
                    success:function (result){
                       alert(result.msg);

                        // 关闭对话框
                        $("#empUpdateModal").modal("hide");
                        // 回到本页面
                        to_page(currentNum);
                    }
                });
            });


            // 完成全选/不选删除
            $("#check_all").click(function (){
                // 使用prop修改和读取原生dom的属性值。attr获取自定义属性值
                $(".check_item").prop("checked",$(this).prop("checked"));

            });

            // check_item
            $(document).on("click",".check_item",function (){
                // 判断当前选择的元素是否满足显示
               var flag =  $(".check_item:checked").length==$(".check_item").length ;
               $("#check_all").prop("checked",flag);
            })

            // 批量删除
            $("#emp_delete_all_btn").click(function (){

                var empnames="";
                var del_idstr = "";
                $.each($(".check_item:checked"),function (){
                   empnames += $(this).parents("tr").find("td:eq(2)").text()+",";
                    del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
                });
                empnames = empnames.substring(0,empnames.length-1);
                del_idstr = del_idstr.substring(0,del_idstr.length-1);
                if(confirm("确认删除["+empnames+"]嘛？")){
                    // 发ajax请求
                    $.ajax({
                        url:"${APP_PATH}/employee/delete/"+del_idstr,
                        type:"DELETE",
                        success:function (result){

                            // 关闭对话框
                            $("#empUpdateModal").modal("hide");
                            // 回到本页面
                            to_page(currentNum);
                        }
                    })

                }

            })


        </script>

</body>
</html>
