<%@ page import="model.UserinfoEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Employee" %>
<%@ page import="model.Title" %>
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
                <h1 class="page-header">美发师管理</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- 内容头部 /-->

        <!-- 正文区域 -->

        <div class="box box-primary">
            <div class="box-body">

                <!-- 数据表格 -->
                <div class="table-box">
                    <%--<%--%>
                        <%--Object obj =session.getAttribute("refreshTimes");--%>
                        <%--if(obj ==null){--%>
                    <%--%>--%>
                    <%--<script>--%>
                            <%--$("#refresh").click();--%>
                    <%--</script>--%>
                    <%--<%--%>
                            <%--session.setAttribute("refreshTimes",1);--%>
                        <%--}--%>

                    <%--%>--%>
                    <!--工具栏-->
                    <div class="pull-left">
                        <div class="form-group form-inline">
                            <div class="btn-group">
                                <%
                                    UserinfoEntity loginUser =(UserinfoEntity)session.getAttribute("loginUser");
                                    String loginSalon =(String)session.getAttribute("loginSalon");
                                    if(loginUser.getRoleId()==2){
                                %>
                                <script>
                                    $(function () {
                                        $("#newCreateEmployee").attr("style","dispaly:none");
                                        $("#updateEmployee").remove();
                                    })
                                </script>
                                <%
                                    }
                                %>
                                <a href="#" id="newCreateEmployee" class="btn btn-primary" data-toggle="modal"
                                   data-target="#newEmployeeDialog" >新建</a>

                                <button id ="refresh" type="button" class="btn btn-default" title="刷新"
                                        onclick="test7()">
                                    <i class="fa fa-refresh"></i> 刷新
                                </button>
                            </div>
                        </div>
                    </div>
                    <form  id="searchEmployee" action="${pageContext.request.contextPath}/showEmployee?page=1"
                          method="post">
                        <div class="col-md-4 data1">
                            <input type="text" class="form-control" name="inputUserId" id="cName"
                                   placeholder="请输入美发师ID或姓名查询" >
                        </div>
                        <button onclick="return test6()" type="button" class="btn bg-maroon">搜索</button>
                    </form>
                    <!--工具栏/-->

                    <!--数据列表-->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">美发师信息列表</div>
                                <!-- /.panel-heading -->
                                <table id="dataList"
                                       class="table table-bordered table-striped table-hover dataTable">
                                    <thead>
                                    <tr>
                                        <th style="text-align: center"><input
                                                id="selall" type="checkbox" class="icheckbox_square-blue">
                                        </th>
                                        <th class="sorting_asc">美发师ID</th>
                                        <th class="sorting_desc">姓名</th>
                                        <th class="sorting_desc">性别</th>
                                        <th class="sorting_desc">入职日期</th>
                                        <th class="sorting_desc">联系电话</th>
                                        <th class="sorting_desc">邮箱</th>
                                        <th class="sorting_desc">职称</th>
                                        <th class="sorting_desc">所在店铺</th>
                                        <th class="sorting_desc">是否离职</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <%
                                        List<Employee> list=(List<Employee>)request.getAttribute("list");
                                        List<String> eTitleList=(List<String>)request.getAttribute("eTitleList");
                                        int tote=(Integer)request.getAttribute("tote");
                                        int p=(Integer)request.getAttribute("page");
                                        int totePage=(Integer)request.getAttribute("totalPage");
                                        if(p<=0){
                                            p=1;
                                        } if(p>totePage){
                                        p=(totePage-1)<0?1:totePage-1;
                                    }
                                        String isOut =null;
                                        String titleName=null;
                                        String sex =null;
                                        Employee u=null;
                                        for(int i=0;i<list.size();i++){
                                            u=list.get(i);
                                            titleName=eTitleList.get(i);
                                            switch (u.getSex()){
                                                case "0":sex="男";break;
                                                case "1":sex="女";break;
                                                default:break;
                                            }
                                            switch (u.getOutTag()){
                                                case 0:isOut="在职";break;
                                                case 1:isOut="离职";break;
                                                default:break;
                                            }
                                    %>
                                    <tbody>
                                    <tr>
                                        <td style="text-align: center"><input name="ids" type="checkbox" class="icheckbox_square-blue"></td>
                                        <td style="text-align: center"><%=u.getEmployeeId()%></td>
                                        <td style="text-align: center"><%=u.getEmployeeName()%></td>
                                        <td style="text-align: center"><%=sex%></td>
                                        <td style="text-align: center"><%=u.getInDate()%></td>
                                        <td style="text-align: center"><%=u.getTelephone()%></td>
                                        <td style="text-align: center"><%=u.getEmail()%></td>
                                        <td style="text-align: center"><%=titleName%></td>
                                        <td style="text-align: center"><%=u.getSalonId()%></td>
                                        <td style="text-align: center"><%=isOut%></td>
                                        <td class="text-center">
                                            <a id ="updateEmployee" href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#changeEmployeeDialog" onclick="Values4('<%=u.getEmployeeId()%>','<%=u.getEmployeeName()%>','<%=u.getSex()%>','<%=u.getInDate()%>','<%=u.getTelephone()%>','<%=u.getEmail()%>','<%=u.getTitleId()%>','<%=u.getSalonId()%>','<%=u.getUpdateTag()%>','<%=u.getOutTag()%>') ">修改</a>
                                            <%--<% if(u.getOutTag()==0) { %>--%>
                                            <%--<a href="${pageContext.request.contextPath}/deleteEmployee?deleteEmployeeId=<%=u.getEmployeeId()%>" class="btn btn-danger btn-xs" id="deleteUser" >离职</a>--%>
                                            <%--<% } %>--%>
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

                <li><a href="${pageContext.request.contextPath}/showEmployee?page=<%=1%>" aria-label="Previous">首页</a></li>
                <li><a href="${pageContext.request.contextPath}/showEmployee?page=<%=(p-1)<1 ? 1 :p-1 %>">上一页</a></li>
                <li><a href="${pageContext.request.contextPath}/showEmployee?page=<%=p%>"><%=p%></a></li>
                <li><a href="${pageContext.request.contextPath}/showEmployee?page=<%=(p+1)>totePage ? totePage : p+1%>">下一页</a></li>
                <li><a href="${pageContext.request.contextPath}/showEmployee?page=<%=totePage %>" aria-label="Next">尾页</a></li>

            </ul>


        </div>

    </div>
    <!-- /.box-footer-->

    <!-- 正文区域 /-->

</div>

<!--创建职员信息-->
<div class="modal fade" id="newEmployeeDialog" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >新增美发师</h4>
            </div>
            <div class="modal-body">
                <form action="saveEmployee" class="form-horizontal" id="edit_employee_form">

                    <div class="form-group">
                        <label for="add_employeeName" class="col-sm-2 control-label">美发师名</label>
                        <div class="col-sm-10">
                            <input class="form-control" id="add_employeeName" type="text" name="employee.employeeName" placeholder="美发师名" >
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="employee_sex" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <select	 class="form-control"   name="employee.sex" id="employee_sex" >
                                <option value="0" selected="selected">男</option>
                                <option value="1" >女</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="employeeTelephone" class="col-sm-2 control-label" >电话</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="employeeTelephone"   name="employee.telephone" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="employeeEmail" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="employeeEmail"  name="employee.email" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="employee_titleId" class="col-sm-2 control-label">职能</label>
                        <div class="col-sm-10">
                            <select	 class="form-control"   name="employee.titleId" id="employee_titleId" >
                                <option value="0" selected="selected">--请选择--</option>
                                <%
                                    List<Title> titles=(List<Title>)session.getAttribute("titleList");
                                    int titleNumber = titles.size();
                                    for(int i=0;i<titleNumber;i++){
                                %>
                                <option value="<%=i+1%>" ><%=titles.get(i).getTitleName()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="employee_salonId" class="col-sm-2 control-label">店铺</label>
                        <div class="col-sm-10">
                            <select	id="chooseSalon" class="form-control"   name="employee.salonId" id="employee_salonId" >
                                <option value="0" selected="selected">--请选择--</option>
                                <%
                                    List<Hsalon> hsalons=(List<Hsalon>)session.getAttribute("hSalonList");
                                    int hSalonNumber = hsalons.size();
                                    if(loginUser.getRoleId()==0){
                                    for(int i=0;i<hSalonNumber;i++){
                                %>
                                <option value="<%=hsalons.get(i).getSalonId()%>" ><%=hsalons.get(i).getSalonId()+hsalons.get(i).getSalonName()%></option>
                                <%
                                    }
                                }else{
                                %>
                                <script>
                                    $("#chooseSalon").attr("disabled","disabled");
                                </script>
                                <option value="<%=loginSalon%>" selected="selected" ><%=loginSalon%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                    </div>


                    <!--
                    <div class="form-group">
                        <label for="employee_salonId" class="col-sm-2 control-label">所在店铺</label>
                        <div class="col-sm-10">
                            <select	 class="form-control"   name="employee.salonId" id="employee_salonId" >
                                <option value="0" selected="selected">男</option>
                                <option value="1" >女</option>
                            </select>
                        </div>
                    </div>-->

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button  type="submit" onclick="return employeeChecking()" class="btn btn-primary" value="确定添加" id="employeeConfirmAdd">确定添加</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!--修改职员信息-->
<div class="modal fade" id="changeEmployeeDialog" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >美发师</h4>
            </div>
            <div class="modal-body">
                <form action="updateEmployee" class="form-horizontal" id="edit_employee_form2">

                    <div class="form-group">
                        <label for="update_employeeId" class="col-sm-2 control-label">美发师编号</label>
                        <div class="col-sm-10">
                            <input readonly="readonly" class="form-control" id="update_employeeId" type="text" name="employee.employeeId" placeholder="美发师编号" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_employeeName" class="col-sm-2 control-label">美发师名</label>
                        <div class="col-sm-10">
                            <input class="form-control" id="update_employeeName" type="text" name="employee.employeeName" placeholder="美发师名" >
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="update_employee_sex" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <select	 class="form-control"   name="employee.sex" id="update_employee_sex" >
                                <option value="0" selected="selected">男</option>
                                <option value="1" >女</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="update_employeeTelephone" class="col-sm-2 control-label" >电话</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_employeeTelephone"   name="employee.telephone" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="update_employeeEmail" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_employeeEmail"  name="employee.email" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="update_employee_titleId" class="col-sm-2 control-label">职能</label>
                        <div class="col-sm-10">
                            <select	 class="form-control"   name="employee.titleId" id="update_employee_titleId" >
                                <option value="0" selected="selected">--请选择--</option>
                                <%
                                    titles=(List<Title>)session.getAttribute("titleList");
                                    titleNumber = titles.size();
                                    for(int i=0;i<titleNumber;i++){
                                %>
                                <option value="<%=i+1%>" ><%=titles.get(i).getTitleName()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="update_employee_salonId" class="col-sm-2 control-label">店铺</label>
                        <div class="col-sm-10">
                            <select	 disabled="disabled" class="form-control"   name="employee.salonId" id="update_employee_salonId" >
                                <option value="0" selected="selected">--请选择--</option>
                                <%
                                    hsalons=(List<Hsalon>)session.getAttribute("hSalonList");

                                    hSalonNumber = hsalons.size();
                                    for(int i=0;i<hSalonNumber;i++){
                                %>
                                <option value="<%=hsalons.get(i).getSalonId()%>" ><%=hsalons.get(i).getSalonId()+hsalons.get(i).getSalonName()%></option>
                               <%
                                   }
                               %>
                            </select>
                            <%
                                UserinfoEntity login =(UserinfoEntity)session.getAttribute("loginUser");
                                if(login.getRoleId()!=1){
                            %>
                            <script>
                                $("#update_employee_salonId").removeAttr("disabled");
                            </script>
                            <%
                                }
                            %>

                        </div>
                    </div>
                    <input id="tag1" style="display: none" name="employee.updateTag">
                    <input id="tag2" style="display: none" name="employee.outTag">
                    <input id="inDate" style="display: none" name="inDate">


                    <!--
                    <div class="form-group">
                        <label for="employee_salonId" class="col-sm-2 control-label">所在店铺</label>
                        <div class="col-sm-10">
                            <select	 class="form-control"   name="employee.salonId" id="employee_salonId" >
                                <option value="0" selected="selected">男</option>
                                <option value="1" >女</option>
                            </select>
                        </div>
                    </div>-->

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button  type="submit" onclick="return employeeChecking2()" class="btn btn-primary" value="确定修改" id="employeeConfirmUpdate">确定修改</button>
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

    function test6(){
        var cName = $("#cName").val();
        if(cName.length<=0){
            alert("您未输入任何信息！");
            return false;
        }

        $.ajax({
            type:'post',
            url:"setEmployeeSession",
            data:{
                showEmployeeType:0,
                name:cName
            },
            error:function(){
                $("#searchEmployee").submit();
            },
            success:function () {
                $("#searchEmployee").submit();
            }
        })
        return true;
    }

    function test7(){
        var cALL ="";
        $.ajax({
            type:'post',
            url:"setEmployeeSession",
            data:{
                showEmployeeType:4,
                name:cALL
            },
            error:function(result){
                window.location.href='${pageContext.request.contextPath}/showEmployee?page=1';
            },
            success:function(result){
                window.location.href='${pageContext.request.contextPath}/showEmployee?page=1';
            }
        })

    }
    function Values4(ID,NAME,SEX,DATE,TELE,EMAIL,TITLE,SALON,TAG1,TAG2) {
     $("#update_employeeId").val(ID);
       $("#update_employeeName").val(NAME);
        $("#update_employee_sex").val(SEX);
       $("#update_employeeTelephone").val(TELE);
       $("#update_employeeEmail").val(EMAIL);
        $("#update_employee_titleId").val(TITLE);
       $("#update_employee_salonId").val(SALON);
        $("#tag1").val(TAG1);
        $("#tag2").val(TAG2);
        $("#inDate").val(DATE);


    }

    function employeeChecking2() {
        var a1 =$("#update_employeeName").val();
        var a2 =$("#update_employee_sex").val();
        var a3 =$("#update_employeeTelephone").val();
        var a4 =$("#update_employeeEmail").val();
        var a5 =$("#update_employee_titleId").val();
        var a6 =$("#update_employee_salonId").val();

        if(a1.length>0&&a3.length>0&&a4.length>0&&a5!="0"&&a6!="0"){

            $("#update_employee_salonId").removeAttr("disabled");
            return true;
        }
        else{
            alert("您还有信息未填写！");
            return false;
        }
    }
    //验证
    function employeeChecking() {
        var a1 =$("#add_employeeName").val();
        var a2 =$("#employee_sex").val();
        var a3 =$("#employeeTelephone").val();
        var a4 =$("#employeeEmail").val();
        var a5 =$("#employee_titleId").val();
        var a6 =$("#employee_salonId").val();

        if(a1.length>0&&a3.length>0&&a4.length>0&&a5!="0"&&a6!="0"){
            $("#chooseSalon").removeAttr("disabled");
            return true;
        }
        else{
            alert("您还有信息未填写！");
            return false;
        }


    }

</script>
</body>
</html>