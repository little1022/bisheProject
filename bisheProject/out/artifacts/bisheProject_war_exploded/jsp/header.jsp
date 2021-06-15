<%@ page import="model.UserinfoEntity" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName()
            + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户管理</title>
    <!-- 引入css样式文件 -->
    <!-- Bootstrap Core CSS -->
    <link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" />
    <!-- MetisMenu CSS -->
    <link href="<%=basePath%>css/metisMenu.min.css" rel="stylesheet" />
    <!-- DataTables CSS -->
    <link href="<%=basePath%>css/dataTables.bootstrap.css" rel="stylesheet" />
    <!-- Custom CSS -->
    <link href="<%=basePath%>css/sb-admin-2.css" rel="stylesheet" />
    <!-- Custom Fonts -->
    <link href="<%=basePath%>css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>css/boot-crm.css" rel="stylesheet" type="text/css" />
</head>

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>


<header>
<div id="wrapper">

        <div class="navbar-header">
            <a class="navbar-brand" href="#">美发连锁店管理系统</a>
        </div>
        <!-- 导航栏右侧图标部分 -->
        <ul class="nav navbar-top-links navbar-right">
            <i class="fa fa-user fa-fw"></i>
            <li class="dropdown">
                <a class="dropdown-toggle"  href="#">用户名：${loginUser.userId}
                </a>
            </li>
            <li class="dropdown">
                <%
                    UserinfoEntity loginUser =(UserinfoEntity)session.getAttribute("loginUser");
                    String role =null;
                    switch (loginUser.getRoleId()){
                        case 0:role ="店长";break;
                        case 1:role="分店长";break;
                        case 2:role="收银员";break;
                        default:break;
                    }
                %>
                <a class="dropdown-toggle"  href="#">角色：<%=role%>
                </a>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle"  href="#">使用者：${loginEmployee.employeeName}
                </a>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle"  href="#">店铺：${loginSalon}
                </a>
            </li>
            <!-- 用户信息和系统设置 start -->
            <li class="dropdown">
                <a class="dropdown-toggle"  href="${pageContext.request.contextPath}/logout">退出
                </a>
            </li>
            <!-- 用户信息和系统设置结束 -->

        </ul>
</div>

</header>

</html>
