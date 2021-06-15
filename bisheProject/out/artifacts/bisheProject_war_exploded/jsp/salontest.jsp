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
                <h1 class="page-header">美发店管理</h1>
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
                                   data-target="#newSalonDialog" >新建</a>

                                <button type="button" class="btn btn-default" title="刷新"
                                        onclick="test9()">
                                    <i class="fa fa-refresh"></i> 刷新
                                </button>
                            </div>
                        </div>
                    </div>
                    <form action="${pageContext.request.contextPath}/showSalon?page=1"
                          method="post">
                        <div class="col-md-4 data1">
                            <input type="text" class="form-control" name="inputUserId" id="cName"
                                   placeholder="请输入美发店名或地址查询" >
                        </div>
                        <button onclick="test8()" type="submit" class="btn bg-maroon">搜索</button>
                    </form>
                    <!--工具栏/-->

                    <!--数据列表-->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">美发店信息列表</div>
                                <!-- /.panel-heading -->
                                <table id="dataList"
                                       class="table table-bordered table-striped table-hover dataTable">
                                    <thead>
                                    <tr>
                                        <th style="text-align: center"><input
                                                id="selall" type="checkbox" class="icheckbox_square-blue">
                                        </th>
                                        <th class="sorting_asc">美发店编号</th>
                                        <th class="sorting_desc">店名</th>
                                        <th class="sorting_desc">地址</th>
                                        <th class="sorting_desc">店长</th>
                                        <th class="sorting_desc">联系电话</th>
                                        <th class="sorting_desc">邮箱</th>
                                        <th class="sorting_desc">卫生许可证</th>
                                        <th class="sorting_desc">营业执照</th>
                                        <th class="sorting_desc">税务登记证</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <%
                                        List<Hsalon> list=(List<Hsalon>)request.getAttribute("list");
                                        int tote=(Integer)request.getAttribute("tote");
                                        int p=(Integer)request.getAttribute("page");
                                        int totePage=(Integer)request.getAttribute("totalPage");
                                        if(p<=0){
                                            p=1;
                                        } if(p>totePage){
                                        p=totePage-1;
                                    }

                                        String sex =null;
                                        Hsalon u=null;
                                        for(int i=0;i<list.size();i++){
                                            u=list.get(i);

                                    %>
                                    <tbody>
                                    <tr>
                                        <td style="text-align: center"><input name="ids" type="checkbox" class="icheckbox_square-blue"></td>
                                        <td style="text-align: center"><%=u.getSalonId()%></td>
                                        <td style="text-align: center"><%=u.getSalonName()%></td>
                                        <td style="text-align: center"><%=u.getAddress()%></td>
                                        <td style="text-align: center"><%=u.getShopkeeper()%></td>
                                        <td style="text-align: center"><%=u.getTelephone()%></td>
                                        <td style="text-align: center"><%=u.getEmail()%></td>
                                        <%
                                           String uploadPath= request.getServletContext().getRealPath("")+ "upload\\";
                                        %>
                                        <td style="text-align: center"><a href="#" onclick="showPic(<%=uploadPath+u.getLicense1()%>)" >卫生许可证</a></td>
                                        <td style="text-align: center"><a href="#" onclick="showPic(<%=uploadPath+u.getLicense2()%>)" >营业执照</a></td>
                                        <td style="text-align: center"><a href="#" onclick="showPic(<%=uploadPath+u.getLicense3()%>)" >税务登记证</a></td>
                                        <td class="text-center">
                                            <a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#changeSalonDialog" onclick="Values5('<%=u.getSalonId()%>','<%=u.getSalonName()%>','<%=u.getAddress()%>','<%=u.getShopkeeper()%>','<%=u.getTelephone()%>','<%=u.getEmail()%>','<%=u.getLicense1()%>','<%=u.getLicense2()%>','<%=u.getLicense3()%>') ">修改</a>
                                            <a href="${pageContext.request.contextPath}/deleteSalon?deleteSalonId=<%=u.getSalonId()%>" class="btn btn-danger btn-xs" id="deleteUser" >离职</a>
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

                <li><a href="${pageContext.request.contextPath}/showSalon?page=<%=1%>" aria-label="Previous">首页</a></li>
                <li><a href="${pageContext.request.contextPath}/showSalon?page=<%=(p-1)<1 ? 1 :p-1 %>">上一页</a></li>
                <li><a href="${pageContext.request.contextPath}/showSalon?page=<%=p%>"><%=p%></a></li>
                <li><a href="${pageContext.request.contextPath}/showSalon?page=<%=(p+1)>totePage ? totePage : p+1%>">下一页</a></li>
                <li><a href="${pageContext.request.contextPath}/showSalon?page=<%=totePage %>" aria-label="Next">尾页</a></li>

            </ul>


        </div>

    </div>
    <!-- /.box-footer-->

    <!-- 正文区域 /-->

</div>

<!-- 创建保存店铺模态框 -->
<div class="modal fade" id="newSalonDialog" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >新增店铺</h4>
            </div>
            <div class="modal-body">
                <form action="saveSalon"  class="form-horizontal" id="edit_hsalon_form">

                    <div class="form-group">
                        <label for="add_salonName" class="col-sm-2 control-label">店铺名</label>
                        <div class="col-sm-10">
                            <input class="form-control" id="add_salonName" type="text" name="hsalon.salonName" placeholder="店铺名" >
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="add_salonAddress" class="col-sm-2 control-label">店铺地址</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_salonAddress"  name="hsalon.address" />
                        </div>
                    </div>

                    <div style="display: none" class="form-group">
                        <label for="add_shopkeeper" class="col-sm-2 control-label">店长</label>
                        <div class="col-sm-10">
                            <select	 class="form-control"   name="hsalon.shopkeeper" id="add_shopkeeper" >
                                <%--<option value="-1" selected="selected">--请选择--</option>--%>
                                <option value="无" selected="selected">无</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="add_SalonTelephone" class="col-sm-2 control-label" >电话</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_SalonTelephone"   name="hsalon.telephone" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="add_SalonEmail" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_SalonEmail"  name="hsalon.email" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="add_License1" class="col-sm-2 control-label">卫生许可证</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="add_License1"  name="hsalon.license1" onchange="document.getElementById('add_License1').value=this.value" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_License2" class="col-sm-2 control-label">营业执照</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="add_License2"  name="hsalon.license2" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_License3" class="col-sm-2 control-label">税务登记证</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="add_License3"  name="hsalon.license3" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button  onclick="return salonChecking1()" type="submit"  class="btn btn-primary" value="确定添加" id="add_first_hsalon">确定添加</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!--修改店铺信息-->
<div class="modal fade" id="changeSalonDialog" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >美发店</h4>
            </div>
            <div class="modal-body">
                <form action="updateEmployee" class="form-horizontal" id="edit_employee_form2">

                    <input style="display: none" id="update_salonId" name="hsalon.salonId">
                    <div class="form-group">
                        <label for="update_salonName" class="col-sm-2 control-label">店铺名</label>
                        <div class="col-sm-10">
                            <input class="form-control" id="update_salonName" type="text" name="hsalon.salonName" placeholder="店铺名" >
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="update_salonAddress" class="col-sm-2 control-label">店铺地址</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_salonAddress"  name="hsalon.address" />
                        </div>
                    </div>

                    <div  class="form-group">
                        <label for="update_shopkeeper" class="col-sm-2 control-label">店长</label>
                        <div class="col-sm-10">
                            <select	readonly="readonly" class="form-control"   name="hsalon.shopkeeper" id="update_shopkeeper" >
                                <%--<option value="-1" selected="selected">--请选择--</option>--%>
                                <option value="0" selected="selected">无</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="update_salonTelephone" class="col-sm-2 control-label" >电话</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_salonTelephone"   name="hsalon.telephone" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="update_salonEmail" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_salonEmail"  name="hsalon.email" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="update_License1" class="col-sm-2 control-label">卫生许可证</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="update_License1"  name="hsalon.license1" onchange="document.getElementById('add_License1').value=this.value" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_License2" class="col-sm-2 control-label">营业执照</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="update_License2"  name="hsalon.license2" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_License3" class="col-sm-2 control-label">税务登记证</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="update_License3"  name="hsalon.license3" />
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button  type="submit" onclick="return salonChecking2()" class="btn btn-primary" value="确定修改" id="employeeConfirmUpdate">确定修改</button>
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

    function showPic(PICTURE){
        var picturePath=PICTURE;
        alert(PICTURE);
        window.open((picturePath.toString(),"newwindow","height=100, width=400, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no"));

        return false;
    }

    //验证
    function salonChecking1() {
        alert("haha");
        var a1 =$("#add_salonName").val();
        var a2 =$("#add_salonAddress").val();
        var a3 =$("#add_shopkeeper").val();
        var a4 =$("#add_SalonTelephone").val();
        var a5 =$("#add_SalonEmail").val();
        var a6 =$("#add_License1").val();
        var a7 =$("#add_License2").val();
        var a8 =$("#add_License3").val();
        if(a1.length>0&&a2.length>0&&a4.length>0&&a5.length>0&&a6.length>0&&a7.length>0&&a8.length>0)
        {
            uploadImg();
            return true;
        }
        else{
            alert("您有选项还没填写请注意检查");
            return false;
        }
    }

    function  test8(){
        var cName = $("#cName").val();
        if(cName.length<=0){
            alert("您未输入任何信息！");
            return false;
        }
        $.ajax({
            type:'post',
            url:"setSalonSession",
            data:{
                showSalonType:0,
                name:cName
            },
            error:function(result){
                return false;
            },
            success:function(result){
                return true;
            }
        })
    }

    function test9(){
        var cALL ="";
        $.ajax({
            type:'post',
            url:"setSalonSession",
            data:{
                showSalonType:4,
                name:cALL
            },
            error:function(result){
                window.location.href='${pageContext.request.contextPath}/showSalon?page=1';
            },
            success:function(result){
                window.location.href='${pageContext.request.contextPath}/showSalon?page=1';
            }
        })

    }
    function Values5(ID,NAME,ADDRESS,SHOPKEEPER,TELE,EMAIL,LI1,LI2,LI3) {
        $("#update_salonId").val(ID);
        $("#update_salonName").val(NAME);
        $("#update_salonAddress").val(ADDRESS);
        $("#update_shopkeeper").val(SHOPKEEPER);
        $("#update_salonTelephone").val(TELE);
        $("#update_salonEmail").val(EMAIL);
        $("#update_License1").val(LI1);
        $("#update_License2").val(LI2);
        $("#update_License3").val(LI3);
    }




</script>
</body>
</html>