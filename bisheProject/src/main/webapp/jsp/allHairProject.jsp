<%@ page import="model.UserinfoEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Employee" %>
<%@ page import="model.Hsalon" %>
<%@ page import="model.Hairproject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 引入struts2 的标签库--%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName()
            + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>美发连锁店管理系统</title>
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

    <!-- 客户列表查询部分  start-->
    <div id="page-wrapper">
        <!-- 内容头部 -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">美发套餐</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- 内容头部 /-->

        <!-- 正文区域 -->

        <div class="box box-primary">
            <div class="box-body">

                <!-- 数据表格 -->
                <div class="table-box">

                    <!--工具栏-->
                    <div class="pull-left">
                        <div class="form-group form-inline">
                            <div class="btn-group">
                                <a href="#" class="btn btn-primary" data-toggle="modal"
                                   data-target="#newCustomerDialog" onclick="clearCustomer()">新建</a>

                                <button type="button" class="btn btn-default" title="刷新"
                                        onclick="location.href='${pageContext.request.contextPath}/showHairProject?page=1'">
                                    <i class="fa fa-refresh"></i> 刷新
                                </button>
                            </div>
                        </div>
                    </div>
                    <!--工具栏/-->

                    <!--数据列表-->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">美发套餐列表</div>
                                <!-- /.panel-heading -->
                                <table id="dataList"
                                       class="table table-bordered table-striped table-hover dataTable">
                                    <thead>
                                    <tr>
                                        <th style="text-align: center"><input
                                                id="selall" type="checkbox" class="icheckbox_square-blue">
                                        </th>
                                        <th class="sorting_asc">编号</th>
                                        <th class="sorting_desc">套餐内容</th>
                                        <th class="sorting_desc">基础价格</th>
                                        <th class="sorting_desc">套餐描述</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <%
                                        List<Hairproject> list=(List<Hairproject>)request.getAttribute("list");
                                        int tote=(Integer)request.getAttribute("tote");
                                        int p=(Integer)request.getAttribute("page");
                                        int totePage=(Integer)request.getAttribute("totalPage");
                                        if(p<=0){
                                            p=1;
                                        } if(p>totePage){
                                        p=(totePage-1)<0?1:totePage-1;
                                    }
                                        Hairproject u=null;
                                        for(int i=0;i<list.size();i++){
                                            u=list.get(i);
                                    %>
                                    <tbody>
                                    <tr>
                                        <td style="text-align: center"><input name="ids" type="checkbox" class="icheckbox_square-blue"></td>
                                        <td style="text-align: center"><%=u.getHairId()%></td>
                                        <td style="text-align: center"><%=u.getHairService()%></td>
                                        <td style="text-align: center"><%=u.getBasePrice()%></td>
                                        <td style="text-align: center"><%=u.getpDesc()%></td>
                                        <td class="text-center">
                                            <a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#customerEditDialog" onclick="Values('<%=u.getHairId()%>','<%=u.getHairService()%>','<%=u.getBasePrice()%>','<%=u.getpDesc()%>') ">修改</a>

                                            <%--<a href="${pageContext.request.contextPath}/deleteHairProject?hairId=<%=u.getHairId()%>" class="btn btn-danger btn-xs" id="deleteUser" >删除</a>--%>

                                        </td>
                                    </tr>
                                    </tbody>
                                    <%
                                        }
                                    %>
                                    <!--
                                <tfoot>
                                <tr>
                                <th>Rendering engine</th>
                                <th>Browser</th>
                                <th>Platform(s)</th>
                                <th>Engine version</th>
                                <th>CSS grade</th>
                                </tr>
                                </tfoot>-->
                                </table>
                                <!--数据列表/-->
                            </div>
                            <!-- /.panel -->
                        </div>
                        <!-- /.col-lg-12 -->
                    </div>
                </div>
                <!-- 客户列表查询部分  end-->
            </div>
            <!-- 数据表格 /-->

        </div>
        <!-- /.box-body -->
        <div class="box-tools pull-right">
            <ul class="pagination">
                <li><a href="${pageContext.request.contextPath}/showHairProject?page=<%=1%>" aria-label="Previous">首页</a></li>
                <li><a href="${pageContext.request.contextPath}/showHairProject?page=<%=(p-1)<1 ? 1 :p-1 %>">上一页</a></li>
                <li><a href="${pageContext.request.contextPath}/showHairProject?page=<%=p%>"><%=p%></a></li>
                <li><a href="${pageContext.request.contextPath}/showHairProject?page=<%=(p+1)>totePage ? totePage : p+1%>">下一页</a></li>
                <li><a href="${pageContext.request.contextPath}/showHairProject?page=<%=totePage %>" aria-label="Next">尾页</a></li>
            </ul>


        </div>

    </div>
    <!-- /.box-footer-->

    <!-- 正文区域 /-->

</div>
</div>

<!-- 引入js文件 -->
<!-- jQuery -->
<script src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="<%=basePath%>js/bootstrap.min.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="<%=basePath%>js/metisMenu.min.js"></script>
<!-- DataTables JavaScript -->
<script src="<%=basePath%>js/jquery.dataTables.min.js"></script>
<script src="<%=basePath%>js/dataTables.bootstrap.min.js"></script>
<!-- Custom Theme JavaScript -->
<script src="<%=basePath%>js/sb-admin-2.js"></script>
<!-- 编写js代码 -->
<script type="text/javascript">



    function  Values(ID,ROLE,USERBY,PASS) {


    }

    //清空新建客户窗口中的数据
    function clearCustomer() {
        $("#new_customerName").val("");
        $("#new_customerFrom").val("")
        $("#new_custIndustry").val("")
        $("#new_custLevel").val("")
        $("#new_linkMan").val("");
        $("#new_phone").val("");
        $("#new_mobile").val("");
        $("#new_zipcode").val("");
        $("#new_address").val("");
    }

</script>
</body>
</html>