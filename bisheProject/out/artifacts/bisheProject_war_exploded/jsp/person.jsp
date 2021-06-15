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
    <title>水利项目信息化管理</title>
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
<body>
<div id="wrapper">
    <nav class="navbar navbar-default navbar-static-top" role="navigation"
         style="margin-bottom: 0">

        <!-- 页面头部 -->
        <jsp:include page="header.jsp"></jsp:include>
        <!-- 页面头部 /-->

        <!-- 导航侧栏 -->
        <jsp:include page="aside.jsp"></jsp:include>
        <!-- 导航侧栏 /-->

    </nav>

    <!-- 个人信息  start-->
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">个人信息</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <form class="form-horizontal" method="get" id="edit_person_form" action="/user/updatePerson.do">
            <div class="form-group">
                <label for="user_id" class="col-sm-offset-2 col-sm-2 control-label">用户id</label>
                <div class="col-sm-5">
                    <input type="text" class="form-control" id="user_id" value="${PERSON.user_id}" name="user_id" placeholder="请输入">
                </div>
            </div>
            <div class="form-group">
                <label for="realname" class="col-sm-offset-2 col-sm-2 control-label">真实姓名</label>
                <div class="col-sm-5">
                    <input type="text" class="form-control" id="realname" value="${PERSON.realname}" name="realname" placeholder="请输入">
                </div>
            </div>
            <div class="form-group">
                <label for="sex" class="col-sm-offset-2 col-sm-2 control-label">性别</label>
                <div class="col-sm-5">
                    <input type="text" class="form-control" id="sex" value="${PERSON.sex} "name="sex" placeholder="请输入">
                </div>
            </div>
            <div class="form-group">
                <label for="email" class="col-sm-offset-2 col-sm-2 control-label">邮件</label>
                <div class="col-sm-5">
                    <input type="text" class="form-control" id="email" value="${PERSON.email}" name="email" placeholder="nyh@qq.com">
                </div>
            </div>
            <div class="form-group">
                <label for="title" class="col-sm-offset-2 col-sm-2 control-label">职称</label>
                <div class="col-sm-5">
                    <input type="text" class="form-control" id="title" value="${PERSON.title}" name="title" placeholder="请输入">
                </div>
            </div>
            <div class="form-group">
                <label for="telephone" class="col-sm-offset-2 col-sm-2 control-label">电话</label>
                <div class="col-sm-5">
                    <input type="text" class="form-control" id="telephone" value="${PERSON.telephone}" name="telephone" placeholder="请输入">
                </div>
            </div>
            <div class="form-group">
                <center>
                    <button type="button" class="btn btn-default" onclick="history.back(-1)">返回</button>
                    <button type="submit" class="btn btn-primary" >保存修改</button>
                </center>
            </div>
        </form>
    </div>
</div>

</body>
</html>