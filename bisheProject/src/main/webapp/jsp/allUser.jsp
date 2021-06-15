<%@ page import="model.UserinfoEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Employee" %>
<%@ page import="model.Hsalon" %>
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
                <h1 class="page-header">账户管理</h1>
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
                                        onclick="location.href='${pageContext.request.contextPath}/getUser?page=1'">
                                    <i class="fa fa-refresh"></i> 刷新
                                </button>
                            </div>
                        </div>
                    </div>
                    <form action="${pageContext.request.contextPath}/findUserByFuzzy?page=1"
                          method="post">
                        <div class="col-md-4 data1">
                            <input type="text" class="form-control" name="inputUserId"
                                   placeholder="请输入用户ID查询" value="">
                        </div>
                        <button type="submit" class="btn bg-maroon">搜索</button>
                    </form>
                    <!--工具栏/-->

                    <!--数据列表-->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">用户信息列表</div>
                                <!-- /.panel-heading -->
                                <table id="dataList"
                                       class="table table-bordered table-striped table-hover dataTable">
                                    <thead>
                                    <tr>
                                        <th style="text-align: center"><input
                                                id="selall" type="checkbox" class="icheckbox_square-blue">
                                        </th>
                                        <th class="sorting_asc">用户ID</th>
                                        <th class="sorting_desc">加密密码</th>
                                        <th class="sorting_desc">角色</th>
                                        <th class="sorting_desc">使用者</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <%
                                        List<UserinfoEntity> list=(List<UserinfoEntity>)request.getAttribute("list");
                                        int tote=(Integer)request.getAttribute("tote");
                                        int p=(Integer)request.getAttribute("page");
                                        int totePage=(Integer)request.getAttribute("totalPage");
                                        if(p<=0){
                                            p=1;
                                        } if(p>totePage){
                                        p=(totePage-1)<0?1:totePage-1;
                                        }
                                        String role =null;
                                        UserinfoEntity u=null;
                                        for(int i=0;i<list.size();i++){
                                            u=list.get(i);
                                            switch (u.getRoleId()){
                                                case 0:role = "店长";break;
                                                case 1:role = "分店长";break;
                                                case 2:role = "收银员";break;
                                                default:break;
                                            }
                                        %>
                                    <tbody>
                                    <tr>
                                        <td style="text-align: center"><input name="ids" type="checkbox" class="icheckbox_square-blue"></td>
                                        <td style="text-align: center"><%=u.getUserId()%></td>
                                        <td style="text-align: center"><%=u.getPassword()%></td>
                                        <td style="text-align: center"><%=role%></td>
                                        <td style="text-align: center"><%=u.getUseBy()%></td>
                                        <td class="text-center">
                                            <a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#customerEditDialog" onclick="Values('<%=u.getUserId()%>','<%=u.getRoleId()%>','<%=u.getUseBy()%>','<%=u.getPassword()%>') ">修改</a>
                                            <% if(u.getRoleId()!=0) { %>
                                             <a href="${pageContext.request.contextPath}/deleteUser?userId=<%=u.getUserId()%>" class="btn btn-danger btn-xs" id="deleteUser" >删除</a>
                                            <% } %>
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
                <%
                    int pageType =(int) session.getAttribute("userPageType");
                    if(pageType ==0 ){
                %>
                <li><a href="${pageContext.request.contextPath}/getUser?page=<%=1%>" aria-label="Previous">首页</a></li>
                <li><a href="${pageContext.request.contextPath}/getUser?page=<%=(p-1)<1 ? 1 :p-1 %>">上一页</a></li>
                <li><a href="${pageContext.request.contextPath}/getUser?page=<%=p%>"><%=p%></a></li>
                <li><a href="${pageContext.request.contextPath}/getUser?page=<%=(p+1)>totePage ? totePage : p+1%>">下一页</a></li>
                <li><a href="${pageContext.request.contextPath}/getUser?page=<%=totePage %>" aria-label="Next">尾页</a></li>
                <%
                }
                else {
                %>
                <li><a href="${pageContext.request.contextPath}/findUserByFuzzy?page=<%=1%>" aria-label="Previous">首页</a></li>
                <li><a href="${pageContext.request.contextPath}/findUserByFuzzy?page=<%=(p-1)<1 ? 1 :p-1 %>">上一页</a></li>
                <li><a href="${pageContext.request.contextPath}/findUserByFuzzy?page=<%=p%>"><%=p%></a></li>
                <li><a href="${pageContext.request.contextPath}/findUserByFuzzy?page=<%=(p+1)>totePage ? totePage : p+1%>">下一页</a></li>
                <li><a href="${pageContext.request.contextPath}/findUserByFuzzy?page=<%=totePage %>" aria-label="Next">尾页</a></li>
                <%
                    }
                %>
            </ul>


        </div>

    </div>
    <!-- /.box-footer-->

    <!-- 正文区域 /-->

</div>
</div>
<!-- 创建客户模态框 -->
<div class="modal fade" id="newCustomerDialog" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >新增用户</h4>
            </div>
            <div class="modal-body">
                <form action="user_saveUser" class="form-horizontal" id="edit_user_form">

                    <div class="form-group">
                        <label for="add_UserId" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input class="form-control" id="add_UserId" type="text" name="userinfoEntity.userId" placeholder="用户名" list="P_Select" oninput="GetUser()">
                            <datalist id="P_Select">

                            </datalist>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="add_UserRoleId" class="col-sm-2 control-label">角色</label>
                        <div class="col-sm-10">
                            <select	 class="form-control"   name="userinfoEntity.roleId" id="add_UserRoleId" >
                                <option value="3" selected="selected">--请选择--</option>
                                <option value="1" >1.分店长</option>
                                <option value="2" >2.收银员</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="add_user_by" class="col-sm-2 control-label">使用者</label>
                        <div class="col-sm-10">
                            <%--<select	 class="form-control"   name="userinfoEntity.useBy" id="add_user_by" >--%>
                                <%--<option value="无" selected="selected">无</option>--%>
                                <%--<%--%>
                                    <%--List<Employee> employees =(List<Employee>)session.getAttribute("employeeList");--%>
                                    <%--int employeeNum = employees.size();--%>
                                    <%--for(int i=0;i<employeeNum;i++){--%>
                                <%--%>--%>
                                <%--<option value="<%=employees.get(i).getEmployeeId()%>"><%=employees.get(i).getEmployeeId()+" "+employees.get(i).getEmployeeName()%></option>--%>
                                <%--<%--%>
                                    <%--}--%>
                                <%--%>--%>

                            <%--</select>--%>
                                <input class="form-control" id="add_user_by" type="text" name="userinfoEntity.useBy" placeholder="使用者" list="P_UserBySelect" oninput="GetUserBy(this)">
                                <datalist id="P_UserBySelect">
                                    <option value="无" selected>无</option>
                                </datalist>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="add_UserPasswprd" class="col-sm-2 control-label" >密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="add_UserPasswprd" placeholder="密码"  name="userinfoEntity.password" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_UserPasswprd_1" class="col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="add_UserPasswprd_1" placeholder="密码" name="password" onkeyup="validate1()"/><span id="tishi1"></span>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button disabled="disabled" onclick="return certainRole()" type="submit" class="btn btn-primary" value="确定添加" id="confirm1">确定添加</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 修改客户模态框 -->
<div class="modal fade" id="customerEditDialog" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >修改用户密码</h4>
            </div>
            <div class="modal-body">
                <form action="user_updateUser" class="form-horizontal" id="edit_customer_form" method="post">

                    <div class="form-group">
                        <label for="edit_customerName" class="col-sm-2 control-label" >用户ID</label>
                        <div class="col-sm-10">
                            <input readonly="readonly" type="text" class="form-control" id="edit_customerName" placeholder="用户ID"  name="userinfoEntity.userId"   />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="roleId" class="col-sm-2 control-label">角色</label>
                        <div class="col-sm-10">
                            <select	 class="form-control"   name="userinfoEntity.roleId" id="roleId" >
                                <option value="3" selected="selected">--请选择--</option>
                                <option value="1" >1.分店长</option>
                                <option value="2" >2.收银员</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">使用者</label>
                        <div class="col-sm-10">
                            <%--<select	 class="form-control"   name="userinfoEntity.useBy" id="user_by" >--%>
                                <%--<option value="无" selected="selected">无</option>--%>
                                <%--<%--%>
                                    <%--for(int i=0;i<employeeNum;i++){--%>
                                <%--%>--%>
                                <%--<option value="<%=employees.get(i).getEmployeeId()%>"><%=employees.get(i).getEmployeeId()+" "+employees.get(i).getEmployeeName()%></option>--%>
                                <%--<%--%>
                                    <%--}--%>
                                <%--%>--%>
                            <%--</select>--%>
                                <input class="form-control" id="edit_user_by" type="text" name="userinfoEntity.useBy" placeholder="使用者" list="P_UserBySelect" oninput="GetUserBy(this)">
                                <datalist id="P_UserBySelect">

                                </datalist>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit_customerPasswprd" class="col-sm-2 control-label" >密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="edit_customerPasswprd" placeholder="密码"  name="userinfoEntity.password" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_customerPasswprd_1" class="col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="edit_customerPasswprd_1" placeholder="密码" name="password" onkeyup="validate()"/><span id="tishi"></span>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button onclick="return certainPassword()" type="submit" class="btn btn-primary" value="确定修改" id="confirm">确定修改</button>
                    </div>
                </form>
            </div>

        </div>
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


    function GetUserBy(obj) {
        $("#P_UserBySelect").empty();
        var fuzzyEmployeeId = $(obj).val();
        $.ajax({
            type:"post",
            data:{
                fuzzyEmployeeId:fuzzyEmployeeId
            },
            url:"getEmployeeByFuzzy",
            cache:"false",
            async:false,
            error: function(data){

                alert("服务器没有返回数据，可能服务器忙，请重试");
            },
            success:function (data) {
                var actObj = JSON.parse(data);
                if(actObj.length != 0) {
                    // $("#userCheck").html("用户名已存在");
                    // $("#userCheck").css("color","red");
                }
                $("#P_UserBySelect").append('<option value="无">无</option>');
                for(var i =0;i<actObj.length;i++){

                    $("#P_UserBySelect").append('<option value="'+actObj[i].substring(0,12)+'">'+actObj[i].substring(12)+'</option>');
                }
            }

        })

    }

    //使用ajax向后台发送数据请求
    function GetUser(){
        $("#P_Select").empty();
        var fuzzyUserId = $("#add_UserId").val();
        $.ajax({
            type:"post",
            data:{
                fuzzyUserId:fuzzyUserId
            },
            url:"getUserByFuzzy",
            cache:"false",
            error: function(){
                alert("服务器没有返回数据，可能服务器忙，请重试");
            },
            success:function (data) {
                   var actObj = JSON.parse(data);
                   if(actObj.length != 0) {
                      // $("#userCheck").html("用户名已存在");
                      // $("#userCheck").css("color","red");
                   }

                   for(var i =0;i<actObj.length;i++){

                       $("#P_Select").append('<option value="'+actObj[i].userId+'">'+'</option>');
                   }
            }

        })
    }

    //修改用户时密码验证
    function validate(){
        var password1 =$("#edit_customerPasswprd").val();
        var password2 =$("#edit_customerPasswprd_1").val();
        if(password1 == password2 && password1 !=null){
            $("#tishi").html("两次密码相同");
            $("#tishi").css("color","green");
            $("#confirm").removeAttr("disabled");
        }
        else{
            $("#tishi").html("两次密码不相同");
            $("#tishi").css("color","red");


        }
    }

    //新增用户时密码验证
    function validate1(){
        var password1 =$("#add_UserPasswprd").val();
        var password2 =$("#add_UserPasswprd_1").val();
        var addUserRoleId = $("#add_UserRoleId").val();
       /* if(addUserRoleId=="3") {
            $("#tishi1").html("角色未选择！");
            $("#tishi1").css("color","red");
            return false;
        }*/
        if(password1 == password2 && password1 !=null){
            $("#tishi1").html("两次密码相同");
            $("#tishi1").css("color","green");
            $("#confirm1").removeAttr("disabled");
        }
        else{
            $("#tishi1").html("两次密码不相同！");
            $("#tishi1").css("color","red");


        }
    }
    //角色验证
    function certainPassword(){
        var password1 =$("#edit_customerPasswprd").val();
        var password2 =$("#edit_customerPasswprd_1").val();
        var roleId = $("#roleId").val();
        if(roleId=="3") {
            alert("请选择角色！");
            return false;
            //window.location.reload();
        }
        if(password2.length<=0){
            alert("请再次输入密码！");
            return false;
        }

        $("#roleId").removeAttr("disabled");
        $("#edit_user_by").removeAttr("disabled");

    }

    function certainRole() {
        var roleId = $("#add_UserRoleId").val();
        var userId = $("#add_UserId").val();
        var password1 =$("#add_UserPasswprd").val();
        var password2 =$("#add_UserPasswprd_1").val();
        var userBy =$("#add_user_by").val();
        if(userId.length<=0) {
            alert("用户名不能为空！");
            return false;
        }
        if(roleId=="3") {
            alert("请选择角色！");
            return false;
            //window.location.reload();
        }
        if(password2.length<=0){
            alert("请再次输入密码！");
            return false;
        }
        if(userBy.length<=0){
            alert("请选择使用者，若无请选择“无”！");
            return false;
        }
    }
    function  Values(ID,ROLE,USERBY,PASS) {
        $("#edit_customerName").val(ID);
        $("#roleId").val(ROLE);
        $("#edit_user_by").val(USERBY);
        $("#edit_customerPasswprd").val(PASS);
        $("#edit_customerPasswprd_1").val(PASS);
        if(ROLE == "0" ){
            $("#roleId").attr("disabled","disabled");
            $("#edit_user_by").attr("disabled","disabled");
        }
        else{
            $("#roleId").removeAttr("disabled");
            $("#edit_user_by").removeAttr("disabled");
        }
        //$("#confirm").attr("disabled","disabled");

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