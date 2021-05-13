<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: liuqiang
  Date: 2021/3/26
  Time: 9:06 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>部门管理</title>
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
<div class="container"align="center">
    <%--      标题--%>
    <div class="row clearfix" >
        <div class="col-md-11 column">
            <div class="page-header">
                <h1>
                    <small>      显示所有部门</small>
                </h1>
            </div>
        </div>
        <%--       按钮--%>
        <div class="row">
            <div class="col-md-2 column">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/book/toaddbook">insert</a>
                <a class="btn btn-danger" href="${pageContext.request.contextPath}/book/allbook">delete</a>
            </div>
            <div class="col-md-9 column">
                <form  class="form-inline" action="${pageContext.request.contextPath}/book/querybook " method="post"
                       style="float:right">
                    <span style="color: red" ;font-weight:bold>${erro}</span>
                    <input type="text" class="form-control" name="queryBookName" placeholder="请输入部门编号查询">
                    <input type="submit" class="btn btn-primary" value="query">
                </form>
            </div>
        </div>
        <%--    显示表格数据--%>
        <div class="row" >
            <div class="col-md-12">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>部门编号</th>
                        <th>部门名称</th>
                        <th>操&nbsp;&nbsp;作</th>

                    </tr>
                    </thead>
                    <c:forEach items="${pageInfodept.list}" var="dept" >
                        <tbody>
                        <tr>
                            <th>${dept.deptId}</th>
                            <th>${dept.deptName}</th>

                            <th>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    update
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    delete
                                </button>
                            </th>
                        </tr>
                        </tbody>
                    </c:forEach>
                </table>
            </div>
        </div>
        <%--    显示分页信息--%>
        <div class="row">
            <%--          分页文字信息--%>
            <div class="col-md-6">
                当前[${pageInfodept.pageNum}]页,总共[${pageInfodept.pages}]页,总记录数[${pageInfodept.total}]
            </div>
            <%--           分页条信息--%>
            <div class="col-md-6">
<%--                <nav aria-label="Page navigation">--%>
<%--                    <ul class="pagination">--%>

<%--                        <li>--%>
<%--                            <a href="${APP_PATH}/department/getdepts?page=1">首页</a>--%>
<%--                        </li>--%>
<%--                        <c:if test="${pageInfodept.hasPreviousPage}">--%>
<%--                            <li>--%>
<%--                                <a href="${APP_PATH}/department/getdepts??page=" aria-label="Previous">--%>
<%--                                    <span aria-hidden="true">&laquo;</span>--%>
<%--                                </a>--%>
<%--                            </li>--%>
<%--                        </c:if>--%>

<%--                        <c:forEach items="${pageInfodept.navigatepageNums}" var="page">--%>
<%--                            <c:if test="${page == pageInfodept.pageNum}">--%>
<%--                                <li class="active"><a href="#">${page}</a></li>--%>
<%--                            </c:if>--%>
<%--                            <c:if test="${page != pageInfodept.pageNum}">--%>
<%--                                <li ><a href="${APP_PATH}/department/getdepts?page=${page}">${page}</a></li>--%>
<%--                            </c:if>--%>
<%--                        </c:forEach>--%>


<%--                        <c:if test="${pageInfodept.hasNextPage}">--%>
<%--                            <li>--%>
<%--                                <a href="${APP_PATH}/department/getdepts?page=${pageInfodept.pageNum+1}" aria-label="Next">--%>
<%--                                    <span aria-hidden="true">&raquo;</span>--%>
<%--                                </a>--%>
<%--                            </li>--%>
<%--                        </c:if>--%>
<%--                        <li>--%>
<%--                            <a href="${APP_PATH}/department/getdepts??page=${pageInfodept.pages}">末页</a>--%>
<%--                        </li>--%>
<%--                    </ul>--%>
<%--                </nav>--%>
            </div>
        </div>


    </div>
<%--&lt;%&ndash;                     使用 ajax 请求处理json数据&ndash;%&gt;--%>
<%--        <script type="text/javascript">--%>
<%--                // 1.页面加载完成之后，直接发送一个ajax请求获取分页数据--%>
<%--             $(function(){--%>
<%--                $.ajax({--%>
<%--                    // 请求地址--%>
<%--                    url:"${APP_PATH}/get_dept",--%>
<%--                    // 请求数据--%>
<%--                    // data:"page=1",--%>
<%--                    // 请求类型--%>
<%--                    type:"GET",--%>
<%--                    // 请求成功的回调函数--%>
<%--                    success:function (result){--%>
<%--                       // console.log(result);  // 控制台输出--%>
<%--                        // 1。解析并显示员工数据--%>
<%--                        // 2。解析并显示分页数据--%>

<%--                    }--%>
<%--                });--%>
<%--             });--%>
<%--            // 构建部门表格--%>
<%--                function build_dept_table(result){--%>

<%--                }--%>
<%--             // 构建分页导航--%>
<%--                function build_page_nav(result){--%>

<%--                }

             </script>--%>




</div>


</body>
</html>
