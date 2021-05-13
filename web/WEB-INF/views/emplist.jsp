<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: liuqiang
  Date: 2021/3/25
  Time: 4:02 下午
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
              <a class="btn btn-primary" href="${pageContext.request.contextPath}/book/toaddbook">insert</a>
              <a class="btn btn-danger" href="${pageContext.request.contextPath}/book/allbook">delete</a>
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
              <table class="table table-hover">
                  <tr>
                      <th>员工编号</th>
                      <th>员工姓名</th>
                      <th>员工性别</th>
                      <th>员工邮箱</th>
                      <th>所属部门</th>
                      <th>操&nbsp;&nbsp;作</th>
                  </tr>
                 <c:forEach items="${pageInfo.list}" var="emp" >



                  <tr>
                      <th>${emp.empId}</th>
                      <th>${emp.empName}</th>
                      <th>${emp.gender =="b"?"男":"女"}</th>
                      <th>${emp.email}</th>
                      <th>${emp.department.deptName}</th>
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
                 </c:forEach>
              </table>
          </div>
      </div>
<%--    显示分页信息--%>
      <div class="row">
<%--          分页文字信息--%>
          <div class="col-md-6">
          当前[${pageInfo.pageNum}]页,总共[${pageInfo.pages}]页,总记录数[${pageInfo.total}]
          </div>
<%--           分页条信息--%>
          <div class="col-md-6">
              <nav aria-label="Page navigation">
                  <ul class="pagination">

                      <li>
                          <a href="${APP_PATH}/employee/getemps?page=1">首页</a>
                      </li>
                      <c:if test="${pageInfo.hasPreviousPage}">
                          <li>
                              <a href="${APP_PATH}/employee/getemps?page=" aria-label="Previous">
                                  <span aria-hidden="true">&laquo;</span>
                              </a>
                          </li>
                      </c:if>

                      <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                         <c:if test="${page == pageInfo.pageNum}">
                             <li class="active"><a href="#">${page}</a></li>
                         </c:if>
                          <c:if test="${page != pageInfo.pageNum}">
                              <li ><a href="${APP_PATH}/employee/getemps?page=${page}">${page}</a></li>
                          </c:if>
                      </c:forEach>


                      <c:if test="${pageInfo.hasNextPage}">
                          <li>
                              <a href="${APP_PATH}/employee/getemps?page=${pageInfo.pageNum+1}" aria-label="Next">
                                  <span aria-hidden="true">&raquo;</span>
                              </a>
                          </li>
                      </c:if>
                      <li>
                          <a href="${APP_PATH}/employee/getemps?page=${pageInfo.pages}">末页</a>
                      </li>
                  </ul>
              </nav>
          </div>
      </div>



  </div>



  </body>
</html>
