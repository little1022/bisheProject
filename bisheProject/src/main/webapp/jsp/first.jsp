<%@ page import="java.util.List" %>
<%@ page import="model.Title" %>
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
    <title>欢迎使用美发连锁店管理系统！</title>
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
        <jsp:include page="header_1.jsp"></jsp:include>
        <!-- 页面头部 /-->

        <!-- 导航侧栏 -->
        <jsp:include page="aside_1.jsp"></jsp:include>
        <!-- 导航侧栏 /-->

    </nav>
    <div id="page-wrapper">

        <img src="${pageContext.request.contextPath}/images/welcome.bmp"
             width="100%" height="100%" />

    </div>

    <!-- 创建保存店铺模态框 -->
    <div class="modal fade" id="newHsalonDialog" tabindex="-1" role="dialog"
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
                    <form action="saveFirstHsalon" method="post" enctype="multipart/form-data" class="form-horizontal" id="edit_hsalon_form">

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

                        <div class="form-group">
                            <label for="add_shopkeeper" class="col-sm-2 control-label">店长</label>
                            <div class="col-sm-10">
                                <select	 class="form-control"   name="hsalon.shopkeeper" id="add_shopkeeper" >
                                    <option value="-1" selected="selected">--请选择--</option>
                                    <option value="0" >无</option>
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
                                <input type="file" class="form-control" id="add_License1"  name="upload"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add_License2" class="col-sm-2 control-label">营业执照</label>
                            <div class="col-sm-10">
                                <input type="file" class="form-control" id="add_License2"  name="upload" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add_License3" class="col-sm-2 control-label">税务登记证</label>
                            <div class="col-sm-10">
                                <input type="file" class="form-control" id="add_License3"  name="upload" />
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button  onclick="return salonChecking()" type="submit"  class="btn btn-primary" value="确定添加" id="add_first_hsalon">确定添加</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

<script>
    $(function () {
        var times ='${times}';
        if(times== "0"){
            $("#newHsalonDialog").click();
        }
        if(times== "1"){
            $("#newFirstEmployee").click();
        }
        }
    )

</script>

    <a href="#" style="display: none" class="btn btn-primary" data-toggle="modal"
       data-target="#newEmployeeDialog" id="newFirstEmployee" >进入职员模态框</a>
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
                    <form action="saveFirstEmployee" class="form-horizontal" id="edit_employee_form">

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
                            <button  type="submit" onclick="return employeeChecking()" class="btn btn-primary" value="确定添加" id="employeeConfirmAdd">确定添加</button>
                        </div>
                    </form>
                </div>
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
<script>

    //验证
    function salonChecking() {
        var a1 =$("#add_salonName").val();
        var a2 =$("#add_salonAddress").val();
        var a3 =$("#add_shopkeeper").val();
        var a4 =$("#add_SalonTelephone").val();
        var a5 =$("#add_SalonEmail").val();
        var a6 =$("#upload1").val();
        var a7 =$("#upload2").val();
        var a8 =$("#upload3").val();
        if(a1.length>0&&a2.length>0&&a3!="-1"&&a4.length>0&&a5.length>0&&a6.length>0&&a7.length>0&&a8.length>0)
        {
            //uploadImg();
            return true;
        }
        else{
            alert("您有选项还没填写请注意检查");
            return false;
        }
    }

    //上传图片
    function uploadImg() {
        var add_License1 = $("#add_License1").val();
        var add_License2 = $("#add_License2").val();
        var add_License3 = $("#add_License3").val();
        $.ajax({
            type:"post",
            data:{add_License1:add_License1,
                  add_License2:add_License2,
                  add_License3:add_License3},
            url:"uploadImg",
            cache:"false",
            error: function(){
                return false;
                alert("服务器没有返回数据，可能服务器忙，请重试");

            },
            success:function (data) {
                var actObj = JSON.parse(data);
                $("#add_License1").val(actObj[0]);
                alert( $("#add_License1").val());
                $("#add_License2").val(actObj[1]);
                $("#add_License3").val(actObj[2]);
                return true;
            }
        })

    }

    //验证
    function employeeChecking() {
        var a1 =$("#add_employeeName").val();
        var a2 =$("#employee_sex").val();
        var a3 =$("#employeeTelephone").val();
        var a4 =$("#employeeEmail").val();
        var a5 =$("#employee_titleId").val();

        if(a1.length>0&&a3.length>0&&a4.length>0&&a5!="0"){

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
