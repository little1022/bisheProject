<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
                <h1 class="page-header">预约管理</h1>
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
                    <div class="navbar-left">
                        <div class="form-group form-inline">
                            <div class="btn-group">
                                <%
                                    SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd" );
                                    Date today =new Date();
                                    String str1 = sdf.format(today);
                                    Calendar c = Calendar.getInstance();
                                    c.setTime(today);
                                    c.add(Calendar.DAY_OF_MONTH, 1);
                                    Date tomorrow = c.getTime();//这是明天
                                    String str2 = sdf.format(tomorrow);

                                %>
                               <form id="form1" action="${pageContext.request.contextPath}/showWait?page=1">
                                   <div class="input-group">
                                     <input  name="waitDate" readonly="readonly" class="form-control" value="<%=str1%>" />
                                       <div class="input-group-btn">
                                           <button onclick="test1('<%=str1%>')" type="button" class="btn btn-primary" >
                                            今日预约
                                           </button>
                                       </div>
                                   </div>
                               </form>
                                <form id="form1_2" action="${pageContext.request.contextPath}/showWait?page=1">
                                    <div class="input-group">
                                        <input  name="waitDate" readonly="readonly" class="form-control" value="<%=str2%>" />
                                      <div class="input-group-btn">
                                        <button onclick="test1_2('<%=str2%>')" type="button" class="btn btn-primary" >
                                            明日预约
                                        </button>
                                      </div>
                                    </div>
                                </form>

                                <form id="form2" action="${pageContext.request.contextPath}/showWait?page=1">
                                    <div class="input-group">
                                        <input id="cDate" placeholder="请点击选择日期" name="waitDate" class="form-control"  onclick="laydate({max: laydate.now(+1)})" ></input>
                                      <div class="input-group-btn">
                                          <button onclick="return test2()" type="button" class="btn btn-primary" title="日期">
                                              日期查询
                                          </button>
                                      </div>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                    <div class="navbar-left col-lg-1">

                    </div>
                    <div class="navbar-left">
                        <div class="form-group form-inline">
                            <div class="btn-group">
                                <form id="form4" action="${pageContext.request.contextPath}/showWait?page=1"
                                      method="post">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="inputVipId"
                                               placeholder="请输入会员ID查询" value="" id="cName">
                                        <div class="input-group-btn">
                                            <button onclick="return test4()" type="button" class="btn bg-maroon">搜索</button>
                                        </div>
                                    </div>
                                </form>
                                <form id="form3" action="${pageContext.request.contextPath}/showWait?page=1">
                                    <div class="input-group">
                                        <select	id="cStatus" class="form-control"   name="waitStatus"  >
                                            <option value="0" >预约中</option>
                                            <option value="1" >已到店</option>
                                            <option value="2" >已取消</option>
                                            <option value="3" >已结算</option>
                                        </select>
                                        <div class="input-group-btn">
                                            <button onclick=" return test3()" type="button" class="btn btn-primary">
                                                按状态搜索
                                            </button>
                                        </div>
                                    </div>
                                </form>
                                <%
                                    Object object =session.getAttribute("loginUser");
                                    if(object!=null&&((UserinfoEntity)object).getRoleId()==0){
                                %>
                                <a href="#" class="btn btn-primary"
                                   onclick="test23()">全部</a>
                                <%
                                    }
                                %>
                                <button type="button" class="btn btn-default" title="刷新"
                                        onclick="test5()">
                                    <i class="fa fa-refresh"></i> 本店
                                </button>

                            </div>
                        </div>
                    </div>


                    <!--工具栏/-->

                    <!--数据列表-->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">预约记录列表</div>
                                <!-- /.panel-heading -->
                                <table id="dataList"
                                       class="table table-bordered table-striped table-hover dataTable">
                                    <thead>
                                    <tr>
                                        <th style="text-align: center"><input
                                                id="selall" type="checkbox" class="icheckbox_square-blue">
                                        </th>
                                        <th class="sorting_asc">编号</th>
                                        <th class="sorting_desc">会员ID</th>
                                        <th class="sorting_desc">会员名</th>
                                        <th class="sorting_desc">预约时间</th>
                                        <th class="sorting_desc">预约理发师</th>
                                        <th class="sorting_desc">预约项目</th>
                                        <th class="sorting_desc">预约状态</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <%
                                        List<Wait> list=(List<Wait>)request.getAttribute("list");
                                        List<String> vipNameList =(List<String>)request.getAttribute("vipNameList");  //记录姓名
                                        List<String> hairProjectDescList = (List<String>)request.getAttribute("hairProjectDescList"); //记录美发项目名


                                        int tote=(Integer)request.getAttribute("tote");
                                        int p=(Integer)request.getAttribute("page");
                                        int totePage=(Integer)request.getAttribute("totalPage");
                                        if(p<=0){
                                            p=1;
                                        } if(p>totePage){
                                        p=(totePage-1)<0?1:totePage-1;
                                    }
                                        String status =null;
                                        String vipName =null;
                                        String hairProjectDesc=null;
                                        Wait u=null;
                                        for(int i=0;i<list.size();i++){
                                            u=list.get(i);
                                            vipName=vipNameList.get(i);
                                            hairProjectDesc=hairProjectDescList.get(i);
                                            switch (u.getwTag()){
                                                case 0:status = "预约中";break;
                                                case 1:status = "已到店";break;
                                                case 2:status = "已取消";break;
                                                case 3:status = "已结算";break;
                                                default:break;
                                            }


                                    %>
                                    <tbody>
                                    <tr>
                                        <td style="text-align: center"><input name="ids" type="checkbox" class="icheckbox_square-blue"></td>
                                        <td style="text-align: center">  <%=u.getWaitId()%>  </td>
                                        <td style="text-align: center">  <%=u.getVipId()%>  </td>
                                        <td style="text-align: center">  <%=vipName%>  </td>
                                        <td style="text-align: center">   <%=u.getWaitTime().toString().substring(0,19)%>  </td>
                                        <td style="text-align: center">   <%=u.getEmployeeId()%>  </td>
                                        <td style="text-align: center">  <a href="${pageContext.request.contextPath}/showHairProject?page=1"><%=u.getHairId()%></a>   </td>
                                        <td style="text-align: center">   <%=status%>   </td>
                                        <td class="text-center">
                                            <%
                                                if(u.getwTag()==0){
                                            %>
                                            <a href="${pageContext.request.contextPath}/changeStatus?waitStatus=2&waitId=<%=u.getWaitId()%>" class="btn btn-danger btn-xs" id="vipRefund" >取消</a>
                                            <a href="${pageContext.request.contextPath}/changeStatus?waitStatus=1&waitId=<%=u.getWaitId()%>" class="btn btn-primary btn-xs" >到店</a>
                                            <%
                                                }
                                            %>
                                            <%
                                                if(u.getwTag()==1){
                                            %>
                                            <%--<a href="${pageContext.request.contextPath}/changeStatus?waitStatus=3&waitId=<%=u.getWaitId()%>" class="btn btn-primary btn-xs"  id="vipDeposit" >完成</a>--%>
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

                <li><a href="${pageContext.request.contextPath}/showWait?page=<%=1%>" aria-label="Previous">首页</a></li>
                <li><a href="${pageContext.request.contextPath}/showWait?page=<%=(p-1)<1 ? 1 :p-1 %>">上一页</a></li>
                <li><a href="${pageContext.request.contextPath}/showWait?page=<%=p%>"><%=p%></a></li>
                <li><a href="${pageContext.request.contextPath}/showWait?page=<%=(p+1)>totePage ? totePage : p+1%>">下一页</a></li>
                <li><a href="${pageContext.request.contextPath}/showWait?page=<%=totePage %>" aria-label="Next">尾页</a></li>

            </ul>
        </div>

    </div>
    <!-- /.box-footer-->

    <!-- 正文区域 /-->

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

    function test1(DATE){
        $.ajax({
            type:"post",
            url:"setSession",
            data:{
                showWaitType:2,
                name:DATE
            },
            cache:"false",
            success:function(result){
                $("#form1").submit();

            },
            error:function (result) {
                $("#form1").submit();
            }
        })
        return true;
    }
    function test1_2(DATE){
        $.ajax({
            type:"post",
            url:"setSession",
            data:{
                showWaitType:2,
                name:DATE
            },
            cache:"false",
            success:function(result){
                $("#form1_2").submit();

            },
            error:function (result) {
                $("#form1_2").submit();
            }
        })
        return true;
    }
    function test2(){
        var cDate = $("#cDate").val();
        if(cDate.length<=0) {
            alert("您未选择日期！");
            return false;
        }
        $.ajax({
            type:'post',
            url:'setSession',
            data:{
                showWaitType:2,
                name:cDate
            },
            success:function(result){
                $("#form2").submit();

            },
            error:function (result) {
                $("#form2").submit();
            }
        })
        return true;
    }

    function test3(){
        var cStatus = $("#cStatus").val();
        if(cStatus.length<=0){
            alert("您未选择状态！");
            return false;
        }
        <%
        System.out.println("设置为1");
        %>
        $.ajax({
            type:'post',
            url:'setSession',
            data:{
                showWaitType:1,
                name:cStatus
            },
            success:function(result){
                $("#form3").submit();

            },
            error:function (result) {
                $("#form3").submit();
            }
        })
        return true;
    }
    function test4(){
        var cName = $("#cName").val();
        if(cName.length<=0){
            alert("您未输入任何信息！");
            return false;
        }
        <%
        System.out.println("设置为0");
        %>
        $.ajax({
            type:'post',
            url:'setSession',
            data:{
                showWaitType:0,
                name:cName
            },
            success:function(result){
                $("#form4").submit();

            },
            error:function (result) {
                $("#form4").submit();
            }
        })
        return true;
    }

    function test23() {
        var cALL ="";
        var all="yes";
        <%
        System.out.println("设置为3");
        %>
        $.ajax({
            type:'post',
            url:"setSession",
            data:{
                showWaitType:3,
                name:cALL,
                all:all
            },
            error:function(result){
                window.location.href='${pageContext.request.contextPath}/showWait?page=1';
            },
            success:function(result){
                window.location.href='${pageContext.request.contextPath}/showWait?page=1';
            }
        })


    }
    function test5(){
        var cALL ="";
        var all="no";
        <%
        System.out.println("设置为3");
        %>
        $.ajax({
            type:'post',
            url:"setSession",
            data:{
                showWaitType:3,
                name:cALL,
                all:all
            },
            error:function(result){
                window.location.href='${pageContext.request.contextPath}/showWait?page=1';
            },
            success:function(result){
                window.location.href='${pageContext.request.contextPath}/showWait?page=1';
            }
        })

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