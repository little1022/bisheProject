<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
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
    <!--日历-->
    <link href="<%=basePath%>calendar/need/laydate.css" rel="stylesheet" />
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
                <h1 class="page-header">会员管理</h1>
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
                                   data-target="#newCustomerDialog" onclick="clearCustomer()">会员办卡</a>

                                <button type="button" class="btn btn-default" title="刷新"
                                        onclick="location.href='${pageContext.request.contextPath}/showVip?page=1'">
                                    <i class="fa fa-refresh"></i> 刷新
                                </button>
                            </div>
                        </div>
                    </div>
                    <form action="${pageContext.request.contextPath}/findVipByFuzzy?page=1"
                          method="post">
                        <div class="col-md-4 data1">
                            <input type="text" class="form-control" name="inputVipId"
                                   placeholder="请输入会员ID查询" value="" id="vipIdOrName">
                        </div>
                        <button type="submit" class="btn bg-maroon">搜索</button>
                    </form>
                    <!--工具栏/-->

                    <!--数据列表-->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">会员信息列表</div>
                                <!-- /.panel-heading -->
                                <table id="dataList"
                                       class="table table-bordered table-striped table-hover dataTable">
                                    <thead>
                                    <tr>
                                        <th style="text-align: center"><input
                                                id="selall" type="checkbox" class="icheckbox_square-blue">
                                        </th>
                                        <th class="sorting_asc">会员ID</th>
                                        <th class="sorting_desc">姓名</th>
                                        <th class="sorting_desc">性别</th>
                                        <th class="sorting_desc">生日</th>
                                        <th class="sorting_desc">联系电话</th>
                                        <th class="sorting_desc">积分余额</th>
                                        <th class="sorting_desc">账户余额</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <%
                                        List<Vip> list=(List<Vip>)request.getAttribute("list");
                                        int tote=(Integer)request.getAttribute("tote");
                                        int p=(Integer)request.getAttribute("page");
                                        int totePage=(Integer)request.getAttribute("totalPage");
                                        if(p<=0){
                                            p=1;
                                        } if(p>totePage){
                                        p=(totePage-1)<0?1:totePage-1;
                                    }
                                        String sex =null;
                                        Vip u=null;
                                        for(int i=0;i<list.size();i++){
                                            u=list.get(i);
                                            switch (u.getSex()){
                                                case 0:sex = "男";break;
                                                case 1:sex = "女";break;
                                                default:break;
                                            }
                                    %>
                                    <tbody>
                                    <tr>
                                        <td style="text-align: center"><input name="ids" type="checkbox" class="icheckbox_square-blue"></td>
                                        <td style="text-align: center"><%=u.getVipId()%></td>
                                        <td style="text-align: center"><%=u.getVipName()%></td>
                                        <td style="text-align: center"><%=sex%></td>
                                        <td style="text-align: center"><%=u.getBirthday()%></td>
                                        <td style="text-align: center"><%=u.getTelephone()%></td>
                                        <td style="text-align: center"><%=u.getRewardPoints()%></td>
                                        <td style="text-align: center"><%=u.getAccBalance()%></td>
                                        <td class="text-center">
                                            <%
                                                if(!u.getVipId().equals("000000000000")){
                                            %>
                                            <a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#customerEditDialog" onclick="Values('<%=u.getVipId()%>','<%=u.getSex()%>','<%=u.getVipName()%>','<%=u.getBirthday()%>','<%=u.getTelephone()%>','<%=u.getRewardPoints()%>','<%=u.getAccBalance()%>') ">修改</a>
                                            <a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#vipBookingDialog" id="vipBooking" onclick="test5('<%=u.getVipId()%>')">预约</a>
                                            <a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#vipDepositDialog" id="vipDeposit" onclick="test3('<%=u.getVipId()%>')">充值</a>
                                            <a href="${pageContext.request.contextPath}/deleteVip?vipId=<%=u.getVipId()%>" class="btn btn-danger btn-xs" id="vipRefund" >退款</a>
                                             <%
                                                 }
                                             %>
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
                   int pageType =(int) session.getAttribute("vipPageType");
                   if(pageType ==0 ){
                %>
                    <li><a href="${pageContext.request.contextPath}/showVip?page=<%=1%>" aria-label="Previous">首页</a></li>
                    <li><a href="${pageContext.request.contextPath}/showVip?page=<%=(p-1)<1 ? 1 :p-1 %>">上一页</a></li>
                    <li><a href="${pageContext.request.contextPath}/showVip?page=<%=p%>"><%=p%></a></li>
                    <li><a href="${pageContext.request.contextPath}/showVip?page=<%=(p+1)>totePage ? totePage : p+1%>">下一页</a></li>
                    <li><a href="${pageContext.request.contextPath}/showVip?page=<%=totePage %>" aria-label="Next">尾页</a></li>
                <%
                    }
                    else {
                %>
                <li><a href="${pageContext.request.contextPath}/findVipByFuzzy?page=<%=1%>" aria-label="Previous">首页</a></li>
                <li><a href="${pageContext.request.contextPath}/findVipByFuzzy?page=<%=(p-1)<1 ? 1 :p-1 %>">上一页</a></li>
                <li><a href="${pageContext.request.contextPath}/findVipByFuzzy?page=<%=p%>"><%=p%></a></li>
                <li><a href="${pageContext.request.contextPath}/findVipByFuzzy?page=<%=(p+1)>totePage ? totePage : p+1%>">下一页</a></li>
                <li><a href="${pageContext.request.contextPath}/findVipByFuzzy?page=<%=totePage %>" aria-label="Next">尾页</a></li>
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

<!-- 创建会员模态框 -->
<div class="modal fade" id="newCustomerDialog" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >会员办卡</h4>
            </div>
            <div class="modal-body">
                <form action="saveVip" class="form-horizontal" id="edit_user_form">

                    <div class="form-group">
                        <label for="add_UserId" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input class="form-control" id="add_UserId" type="text" name="vip.vipName" placeholder="姓名" >
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="add_UserRoleId" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <select	 class="form-control"   name="vip.sex" id="add_UserRoleId" >
                                <option value="0" selected="selected">男</option>
                                <option value="1" >女</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="add_UserPasswprd" class="col-sm-2 control-label" >生日</label>
                        <div class="col-sm-10">
                            <input onclick="laydate({max:laydate.now(0)})" type="text" class="laydate_body" id="add_UserPasswprd" placeholder="生日"  name="birthday" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_UserPasswprd_1" class="col-sm-2 control-label">联系电话</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_UserPasswprd_1" placeholder="联系电话" name="vip.telephone" /></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_UserPasswprd" class="col-sm-2 control-label" >办理费用</label>
                        <div class="col-sm-10">
                            <%
                               List<Vipscheme> vipschemes=(List<Vipscheme>) session.getAttribute("vschList");
                            %>
                            <input readonly="readonly" type="text" class="form-control" id="cost" placeholder="办理费用"  name="" value="<%=vipschemes.get(1).getPrice()%>"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button onclick="return certainRole()" type="submit" class="btn btn-primary" value="确定办理" id="confirm1">确定办理</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 会员充值模态框 -->
<div class="modal fade" id="vipDepositDialog" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >会员充值</h4>
            </div>
            <div class="modal-body">
                <form action="depositVip" class="form-horizontal" id="vipDeposit_form">

                    <div  class="form-group">
                        <label for="vipId" class="col-sm-2 control-label" >会员号</label>
                        <div class="col-sm-10">
                            <input readonly="readonly" type="text" class="form-control" id="vipId" placeholder="会员号"  name="vip.vipId"   />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="vipDeposit_sche" class="col-sm-2 control-label">充值方案</label>
                        <div class="col-sm-10">
                            <select	onchange="test4()" class="form-control"   name="vorder.vschId" id="vipDeposit_sche" >
                                <%
                                    for(int i=4;i<vipschemes.size();i++){
                                %>
                                <option value="<%=i%>"><%=vipschemes.get(i).getVschDesc()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="depositMoney" class="col-sm-2 control-label" >充值金额</label>
                        <div class="col-sm-10">

                            <input  onkeyup="test4()" type="text" class="form-control" id="depositMoney" placeholder="办理费用"  name="vorder.cost" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inMoney" class="col-sm-2 control-label" >到账金额</label>
                        <div class="col-sm-10">

                            <input  readonly="readonly" type="text" class="form-control" id="inMoney" placeholder="到账金额"  name="inMoney"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button onclick="return certain2()" type="submit" class="btn btn-primary" value="确定充值" id="confirm2">确定充值</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 会员预约模态框 -->
<div class="modal fade" id="vipBookingDialog" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >会员预约</h4>
            </div>
            <div class="modal-body">
                <form action="bookingVip" class="form-horizontal" id="vipBooking_form">

                    <div  class="form-group">
                        <label for="vipBookingId" class="col-sm-2 control-label" >会员号</label>
                        <div class="col-sm-10">
                            <input readonly="readonly" type="text" class="form-control" id="vipBookingId" placeholder="会员号"  name="wait.vipId"   />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="vipBookingDate" class="col-sm-2 control-label" >预约时间</label>
                        <div class="col-sm-10">
                            <input onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss', min: laydate.now(0), max: laydate.now(+2)})" type="text" class="laydate_body" id="vipBookingDate" placeholder="预约时间"  name="bookingDate" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="booking_hair_id" class="col-sm-2 control-label">美发项目</label>
                        <div class="col-sm-10">
                            <select	 class="form-control"   name="wait.hairId" id="booking_hair_id" >
                                <option value="0" selected="selected">--请选择--</option>
                                <%
                                    List<Hairproject> hairprojects =(List<Hairproject>) session.getAttribute("hairprojects");
                                    for(int i=0;i<hairprojects.size();i++){
                                %>
                                <option value="<%=hairprojects.get(i).getHairId()%>"><%=hairprojects.get(i).getHairId()+". "+hairprojects.get(i).getpDesc()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="booking_employeeId" class="col-sm-2 control-label">预约美发师</label>
                        <div class="col-sm-10">
                            <select	 class="form-control"   name="wait.employeeId" id="booking_employeeId" >
                                <%--<option value="无" selected="selected">无</option>--%>
                                <%
                                    List<Employee> employees =(List<Employee>)session.getAttribute("employeeListBySalon");
                                    int employeeNum = employees.size();
                                    for(int i=0;i<employeeNum;i++){
                                %>
                                <option value="<%=employees.get(i).getEmployeeId()%>"><%=employees.get(i).getEmployeeId()+" "+employees.get(i).getEmployeeName()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <%--onclick="return certain3()"--%>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button  onclick="return certain3()" type="submit" class="btn btn-primary" value="确定预约" id="confirm3">确定预约</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 修改会员模态框 -->
<div class="modal fade" id="customerEditDialog" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >修改会员信息</h4>
            </div>
            <div class="modal-body">
                <form action="updateVip" class="form-horizontal" id="edit_customer_form" method="post">

                    <div class="form-group">
                        <label for="edit_customerName" class="col-sm-2 control-label" >会员号</label>
                        <div class="col-sm-10">
                            <input readonly="readonly" type="text" class="form-control" id="edit_customerName" placeholder="会员号"  name="vip.vipId"   />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="vip_name" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input class="form-control" id="vip_name" type="text" name="vip.vipName" placeholder="姓名" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="roleId" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <select	 class="form-control"   name="vip.sex" id="roleId" >
                                <option value="0" selected="selected">男</option>
                                <option value="1" >女</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit_customerPasswprd" class="col-sm-2 control-label" >生日</label>
                        <div class="col-sm-10">
                            <input onclick="laydate()" type="text" class="form-control" id="edit_customerPasswprd"   name="birthday" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_customerPasswprd_1" class="col-sm-2 control-label">联系电话</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit_customerPasswprd_1"  name="vip.telephone" /></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="vip_points" class="col-sm-2 control-label" >会员积分</label>
                        <div class="col-sm-10">
                            <input readonly="readonly" type="text" class="form-control" id="vip_points" placeholder="会员积分"  name="vip.rewardPoints"   />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="vip_balance" class="col-sm-2 control-label" >账户余额</label>
                        <div class="col-sm-10">
                            <input readonly="readonly" type="text" class="form-control" id="vip_balance" placeholder="账户余额"  name="vip.accBalance"   />
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
<!--日历-->
<script src="<%=basePath%>calendar/laydate.js"></script>
<script src="<%=basePath%>calendar/laydate.dev.js"></script>
<!-- 编写js代码 -->
<script type="text/javascript">

    function certain3() {
       var vipBookingDate= $("#vipBookingDate").val();
       var booking_hair_id =$("#booking_hair_id").val();
       if(vipBookingDate.length<=0||booking_hair_id=="0"){
           alert("您有信息未输入！请检查");
           return false;
       }
       return true;

    }

    function certain2() {
        var inMoney =  $("#inMoney").val();
        var depositMoney =   $("#depositMoney").val();
        if(inMoney.length<=0 ||depositMoney.length<=0){
            alert("充值金额不能为0！");
            return false;
        }
        return true;

    }
    function test4() {
        var selete = $("#vipDeposit_sche").prop("selectedIndex");
        $("#inMoney").empty();
        $("#depositMoney").empty();
        $.ajax({
            type:"post",
            data:{
                selectVsche:selete
            },
            url:"getVschePrice",
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
                    if(actObj[i].vschId!=4){

                        $("#inMoney").val(actObj[i].give);
                        $("#depositMoney").attr("readonly","readonly");
                        $("#depositMoney").val(actObj[i].price);
                    }
                    else{
                        $("#depositMoney").removeAttr("readonly");
                       // $("#inMoney").val("");
                       // $("#depositMoney").val("");
                        var depositMoney =  $("#depositMoney").val();
                        if(depositMoney>actObj[i].price){
                            alert("按照您选择的充值方案，您输入的金额超出范围，请检查！");
                            $("#depositMoney").val("");
                            $("#inMoney").val("");

                            //$("#confirm2").attr("disabled","disabled");
                            return false;
                        }
                        $("#inMoney").val(depositMoney);
                    }

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

                    $("#P_Select").append('<option value=" '+actObj[i].userId+'">'+'</option>');
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

        var roleId = $("#roleId").val();
        var userId = $("#edit_customerName").val();
        var birthday =$("#edit_customerPasswprd").val();
        var telephone =$("#edit_customerPasswprd_1").val();
        if(roleId.length<=0||userId.length<=0||birthday.length<=0||telephone.length<=0) {
            alert("您还有信息未填写，请检查！");
            return false;
        }
    }

    function certainRole() {
        var roleId = $("#add_UserRoleId").val();
        var userId = $("#add_UserId").val();
        var birthday =$("#add_UserPasswprd").val();
        var telephone =$("#add_UserPasswprd_1").val();
        if(roleId.length<=0||userId.length<=0||birthday.length<=0||telephone.length<=0) {
            alert("您还有信息未填写，请检查！");
            return false;
        }

            //window.location.reload();
    }
    function  Values(ID,ROLE,USERBY,V1,V2,V3,V4) {
        $("#edit_customerName").val(ID);
        $("#roleId").val(ROLE);
        $("#vip_name").val(USERBY);
        $("#edit_customerPasswprd").val(V1);
        $("#edit_customerPasswprd_1").val(V2);
        $("#vip_points").val(V3);
        $("#vip_balance").val(V4);

    }

    function test3(ID) {
        $("#vipId").val(ID);

    }
    function test5(ID) {
        $("#vipBookingId").val(ID);

    }

    //清空新建客户窗口中的数据
    function clearCustomer() {
        $("#new_customerName").val("");
        $("#new_customerFrom").val("");
        $("#new_custIndustry").val("");
        $("#new_custLevel").val("");
        $("#new_linkMan").val("");
        $("#new_phone").val("");
        $("#new_mobile").val("");
        $("#new_zipcode").val("");
        $("#new_address").val("");
    }
    // 创建客户
    function createCustomer() {
        $.post("<%=basePath%>customer/create.action",
            $("#new_customer_form").serialize(),function(data){
                if(data =="OK"){
                    alert("客户创建成功！");
                    window.location.reload();

                }else{
                    alert("客户创建失败！");
                    window.location.reload();
                }
            });
    }
    // 通过id获取修改的客户信息
    function editCustomer(id) {
        $.ajax({
            type:"get",
            url:"<%=basePath%>customer/getCustomerById.action",
            data:{"id":id},
            success:function(data) {
                $("#edit_cust_id").val(data.cust_id);
                $("#edit_customerName").val(data.cust_name);
                $("#edit_customerFrom").val(data.cust_source)
                $("#edit_custIndustry").val(data.cust_industry)
                $("#edit_custLevel").val(data.cust_level)
                $("#edit_linkMan").val(data.cust_linkman);
                $("#edit_phone").val(data.cust_phone);
                $("#edit_mobile").val(data.cust_mobile);
                $("#edit_zipcode").val(data.cust_zipcode);
                $("#edit_address").val(data.cust_address);

            }
        });
    }
    // 执行修改客户操作
    function updateCustomer() {
        $.post("<%=basePath%>customer/update.action",$("#edit_customer_form").serialize(),function(data){
            if(data =="OK"){
                alert("客户信息更新成功！");
                window.location.reload();
            }else{
                alert("客户信息更新失败！");
                window.location.reload();
            }
        });
    }
    // 删除客户
    function deleteCustomer(id) {
        if(confirm('确实要删除该客户吗?')) {
            $.post("<%=basePath%>customer/delete.action",{"id":id},
                function(data){
                    if(data =="OK"){
                        alert("客户删除成功！");
                        window.location.reload();
                    }else{
                        alert("删除客户失败！");
                        window.location.reload();
                    }
                });
        }
    }
</script>
</body>
</html>