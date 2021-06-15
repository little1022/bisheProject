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
<aside >
    <div id="wrapper">
        <!-- 导航栏部分 -->


        <!-- 左侧显示列表部分 start-->
        <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="sidebar-search">
                        <div class="input-group custom-search-form">
                            <input type="text" class="form-control" placeholder="查询内容...">
                            <span class="input-group-btn">
							<button class="btn btn-default" type="button">
								<i class="fa fa-search" style="padding: 3px 0 3px 0;"></i>
							</button>
						</span>
                        </div>
                    </li>

                    <li id="f1">
                        <a href="#" class="active">
                            <i class="fa fa-edit fa-fw"></i> 系统管理
                        </a>
                        <ul>
                            <li>
                                <a href="${pageContext.request.contextPath }/getUser?page=1"> <i class="fa fa-edit fa-fw"></i>账户列表</a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath }/showHairProject?page=1"> <i class="fa fa-edit fa-fw"></i>美发套餐</a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath }/showVipScheme?page=1"> <i class="fa fa-edit fa-fw"></i>会员方案</a>
                            </li>

                        </ul>

                    </li>
                    <li id="f2">
                        <a href="#" class="active">
                            <i class="fa fa-edit fa-fw"></i> 美发店管理

                        </a>
                        <ul>
                            <li>
                                <a href="${pageContext.request.contextPath }/showSalon?page=1" onclick="test9()"> <i class="fa fa-edit fa-fw"></i>美发店列表</a>
                            </li>
                        </ul>
                    </li>
                    <li id="f3">
                        <a href="#" class="active">
                            <i class="fa fa-edit fa-fw"></i> 会员管理

                        </a>
                        <ul>
                            <li>
                                <a href="${pageContext.request.contextPath }/showVip?page=1"> <i class="fa fa-edit fa-fw"></i>会员列表</a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath }/showWait?page=1" onclick="test5()"> <i class="fa fa-edit fa-fw"></i>预约列表</a>
                            </li>
                        </ul>
                    </li>
                    <li id="f4">
                        <a href="#" class="active">
                            <i class="fa fa-edit fa-fw"></i> 美发师管理
                        </a>

                        <ul>
                            <li>
                                <a href="${pageContext.request.contextPath }/showEmployee?page=1" onclick="test7()"> <i class="fa fa-edit fa-fw"></i>美发师列表</a>
                            </li>


                        </ul>

                    </li>
                    <li id="f5">
                        <a href="${pageContext.request.contextPath }/toAccountHair">
                            <i class="fa fa-edit fa-fw"></i> 美发结算
                        </a>
                    </li>

                    <li id="f6">
                        <a href="#" class="active">
                            <i class="fa fa-edit fa-fw"></i> 结算单
                        </a>
                        <ul>
                            <li>
                                <a href="${pageContext.request.contextPath }/showVorder?page=1"> <i class="fa fa-edit fa-fw"></i>会员结算单</a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath }/showHorder?page=1"> <i class="fa fa-edit fa-fw"></i>美发结算单</a>
                            </li>

                        </ul>
                    </li>

                    <li id="f7" style="display: none">
                        <a href="#" class="active" data-toggle="modal"
                           data-target="#newHsalonDialog">
                            <i class="fa fa-edit fa-fw"></i> 基本信息填写
                        </a>
                    </li>

                </ul>
            </div>
        </div>
        <!-- 左侧显示列表部分 end-->

    </div>
    <!-- 编写js代码 -->
    <script type="text/javascript">
        window.onload=check();

        function check() {
            var user = <%=session.getAttribute("loginUser")%>;
            if(user == null){
                $("#f1").empty();
                $("#f2").empty();
                $("#f3").empty();
                $("#f4").empty();
                $("#f5").empty();
                $("#f6").empty();
                $("#f7").attr('style','display:block');;
            }
        }

        function test() {
            var cALL ="";
            $.ajax({
                type:'post',
                url:"setSession",
                data:{
                    showWaitType:3,
                    name:cALL
                },
                error:function(result){
                    alert("失败");
                    window.location.href='${pageContext.request.contextPath}/showWait?page=1';
                },
                success:function(result){
                    alert("成功");
                    window.location.href='${pageContext.request.contextPath}/showWait?page=1';
                }
            })
        }
    </script>
</aside>
</html>
