<%--
  Created by IntelliJ IDEA.
  User: liuqiang
  Date: 2021/3/19
  Time: 3:30 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:forward page="/department/get_dept"></jsp:forward>--%>
<html>
<head>
    <title>员工部门管理</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());  // 引入项目资源路径
    %>
    <%--      引入jquery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.js"></script>
    <%--      引入样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <style>
        h3{
            width: 180px;
            height: 38px;
            margin: 100px auto;
            text-align: center;
            line-height: 38px;
        }
        a{
            text-decoration: none;
            color: black;
            font-size: 18px;
        }
    </style>
</head>
<body>
<div class="jumbotron" align="center">
    <h1>欢迎进入员工管理系统</h1>
    <p>...</p>
    <p><a class="btn btn-primary btn-lg" href="emplist.jsp">进入员工模块</a></p>
    <p><a class="btn btn-primary btn-lg" href="deptlist.jsp">进入部门模块</a></p>
</div>

</body>
</html>
