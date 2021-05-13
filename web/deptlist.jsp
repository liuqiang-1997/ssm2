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
        System.out.println(request.getContextPath());
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
                <table class="table table-hover" id="dept_table">
                    <thead>
                    <tr>
                        <th>部门编号</th>
                        <th>部门名称</th>
                        <th>操&nbsp;&nbsp;作</th>

                    </tr>
                    </thead>
                    <%--                    <c:forEach items="${pageInfodept.list}" var="dept" >--%>
                    <%--                        <tbody>--%>
                    <%--                        <tr>--%>
                    <%--                            <th>${dept.deptId}</th>--%>
                    <%--                            <th>${dept.deptName}</th>--%>

                    <%--                            <th>--%>
                    <%--                                <button class="btn btn-primary btn-sm">--%>
                    <%--                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>--%>
                    <%--                                    update--%>
                    <%--                                </button>--%>
                    <%--                                <button class="btn btn-danger btn-sm">--%>
                    <%--                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>--%>
                    <%--                                    delete--%>
                    <%--                                </button>--%>
                    <%--                            </th>--%>
                    <%--                        </tr>--%>
                    <%--                        </tbody>--%>
                    <%--                    </c:forEach>--%>
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
    <%--                     使用 ajax 请求处理json数据--%>
    <script type="text/javascript">
        // 1.页面加载完成之后，直接发送一个ajax请求获取分页数据
        $(function(){
                 to_page(1);
        });
        // 页面跳转
        function to_page(page){
            $.ajax({
                // 请求地址
                url:"${APP_PATH}/department/get_dept",
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

        // 构建部门表格
        function build_dept_table(result){
            // 清空原有数据
            $("#dept_table tbody").empty();
            var dept = result.extend.pageInfo.list;
            $.each(dept,function (index,item){
                // 构建单元格
                var deptIdTd = $("<td></td>").append("#"+item.deptId);
                var deptNameTd = $("<td></td>").append(item.deptName);
                <%--<button class="btn btn-danger btn-sm">--%>
                <%--    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>  --%>
                <%--       delete --%>
                <%--    </button>--%>
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                                                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                                                     .append("UpDate");
                var deleBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                                                    .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                                                    .append("Delete");
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleBtn);
                $("<tr></tr>").append(deptIdTd)
                              .append(deptNameTd)
                              .append(btnTd)
                              .appendTo("#dept_table tbody");  // 将数据提交到对应的标签下

            });

        }
        // 解析显示分页信息
        function build_page_info(result){
            // 清空原有数据
            $("#page_info_area").empty();
            $("#page_info_area").append("当前["+result.extend.pageInfo.pageNum+"]页,总共["
                                       +result.extend.pageInfo.pages+"]页,总记录数["+result.extend.pageInfo.total+"]")
        }
        // 构建分页条
        function build_page_nav(result){
            $("#page_nav_area").empty();
            // 构建父元素ul
            var ul = $("<ul></ul>").addClass("pagination");
            // 构建首页
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));

           // 构建前一页
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));


            // 判断是否有前一页
            if(result.extend.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                // 绑定首页单击事件
                firstPageLi.click(function (){
                    to_page(1);
                });
                // 绑定前一页单击事件
                prePageLi.click(function (){
                    to_page(result.extend.pageInfo.pageNum-1);
                })
            }
            // 添加前一页和首页的提示
            ul.append(firstPageLi).append(prePageLi);
            // 构建导航页码号
            $.each(result.extend.pageInfo.navigatepageNums,function (index,item){
                var numLi = $("<li></li>").append($("<a></a>").append(item))
                // 判断当前页是否相等添加活动效果
                if (result.extend.pageInfo.pageNum == item){
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
            if(result.extend.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                // 绑定后一页单击事件
                nextPageLi.click(function (){
                    to_page(result.extend.pageInfo.pageNum+1);
                });
                // 绑定末页单击事件
                lastPageLi.click(function (){
                    to_page(result.extend.pageInfo.pages);
                });
            }
            // 添加后一页和末页
            ul.append(nextPageLi).append(lastPageLi);

            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }




    </script>

</body>
</html>
