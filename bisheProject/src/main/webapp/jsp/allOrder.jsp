<%@ page import="java.util.List" %>
<%@ page import="model.Title" %>
<%@ page import="model.Hairproject" %>
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
        <jsp:include page="header.jsp"></jsp:include>
        <!-- 页面头部 /-->

        <!-- 导航侧栏 -->
        <jsp:include page="aside.jsp"></jsp:include>
        <!-- 导航侧栏 /-->

    </nav>
    <div id="page-wrapper">

        <img src="${pageContext.request.contextPath}/images/hSalonBack.jpg"
             width="100%" height="100%" />

    </div>

    <script>
        $(function () {

                $("#toNewHOrderDialog").click();

            }
        )

    </script>

    <!-- 创建美发结算模态框 -->
    <div class="modal fade" id="newHOrderDialog" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" >美发结算</h4>
                </div>
                <div class="modal-body">
                    <form action="accountHair" method="post"  class="form-horizontal" id="edit_hairOrder_form">

                        <div class="form-group">
                            <label for="optionsRadios3" class="col-sm-2 control-label">是否会员</label>
                            <div class="col-sm-10">
                              <label class="radio-inline">
                                <input type="radio" name="optionsRadiosinline" id="optionsRadios3" value="0" checked> 否
                              </label>
                              <label class="radio-inline">
                                <input type="radio" name="optionsRadiosinline" id="optionsRadios4"  value="1"> 是
                              </label>
                            </div>
                        </div>
                        <script>

                            $("#optionsRadios4").click(function () {
                                $("#add_vipId").removeAttr("readonly");
                                $("#optionsRadios6").removeAttr("disabled");
                                $("#add_vipId").val("");

                                $("#payType").append("<option value='2' id='isVip'>会员账户支付</option>");

                            })
                            $("#optionsRadios3").click(function () {
                                $("#add_vipId").val("000000000000");
                                $("#add_vipId").attr("readonly","readonly");
                                $("#optionsRadios6").attr("disabled", true);
                                $("#optionsRadios5").prop("checked",true);
                                $("#isVip").remove();

                            })
                        </script>

                        <div class="form-group">
                            <label for="add_vipId" class="col-sm-2 control-label">会员号</label>
                            <div class="col-sm-10">
                                <input readonly="readonly" list="P_VipBySelect" oninput="GetVipBy(this)" class="form-control" id="add_vipId" type="text" name="horder.vipId" placeholder="会员号" value="000000000000">
                                <datalist id="P_VipBySelect">

                                </datalist>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="optionsRadios5" class="col-sm-2 control-label">是否预约</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="horder.waitTag" id="optionsRadios5" value="0" checked> 否
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" readonly="readonly" name="horder.waitTag" id="optionsRadios6"  value="1"> 是
                                </label>
                            </div>
                        </div>
                        <script>
                            //点击预约
                            $("#optionsRadios6").click(function () {

                               var add_vipId= $("#add_vipId").val();
                                $.ajax({
                                    type:"post",
                                    data:{
                                        add_vipId:add_vipId,
                                        waitStatus:1
                                    },
                                    url:"getWaitByVipId",
                                    cache:"false",
                                    async:false,
                                    error: function(data){

                                        alert("服务器没有返回数据，可能服务器忙，请重试");
                                    },
                                    success:function (data) {
                                        var actObj = JSON.parse(data);
                                        if(actObj.length == 0) {
                                            alert("该会员没有正在的预约！请检查");
                                            $("#optionsRadios5").prop("checked",true);
                                            return false;
                                        }
                                        //$("#P_VipBySelect").append('<option value="无">无</option>');
                                        for(var i =0;i<actObj.length;i++){

                                            $("#edit_hair_employee").val(actObj[i].substring(1));
                                            $("#edit_hair_project").val(actObj[i].substring(0,1));
                                        }
                                    }

                                })


                            })
                        </script>

                        <div class="form-group">
                            <label for="edit_hair_employee" class="col-sm-2 control-label">美发师</label>
                            <div class="col-sm-10">
                                <input class="form-control" id="edit_hair_employee" type="text" name="horder.employeeId" placeholder="美发师" list="P_UserBySelect" oninput="GetUserBy2(this)">
                                <datalist id="P_UserBySelect">

                                </datalist>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit_hair_project" class="col-sm-2 control-label">美发项目</label>
                            <div class="col-sm-10">
                                <select	 onclick="func2()" class="form-control"   name="horder.hairId" id="edit_hair_project" >
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
                            <label for="base" class="col-sm-2 control-label" >基础费</label>
                            <div class="col-sm-10">
                                <input type="text" readonly="readonly" class="form-control" id="base"   name="horder.base" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="addition" class="col-sm-2 control-label">附加费</label>
                            <div class="col-sm-10">
                                <input type="text" onchange="func3(this)" class="form-control" id="addition"  name="horder.addition" value="0"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="totalCost" class="col-sm-2 control-label">总消费</label>
                            <div class="col-sm-10">
                                <input readonly="readonly" type="text" class="form-control" id="totalCost"  name="horder.totalCost"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="payType" class="col-sm-2 control-label">支付方式</label>
                            <div class="col-sm-6">
                            <select	 class="form-control"   name="horder.payType" id="payType" >
                                <option value="0"  selected>现金支付</option>
                                <option value="1" >网络支付</option>
                            </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button  onclick="return hairChecking()" type="submit"  class="btn btn-primary" value="确定添加" id="add_first_hsalon">确定结算</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>



    <a href="#" style="display: none" class="btn btn-primary" data-toggle="modal"
       data-target="#newHOrderDialog" id="toNewHOrderDialog" >进入美发结算</a>

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
    function func3(obj) {
         $("#totalCost").val( parseInt($(obj).val())+ parseInt($("#base").val()));
    }

    function GetVipBy(obj) {

        $("#P_VipBySelect").empty();
        var fuzzyVipId = $(obj).val();
        $.ajax({
            type:"post",
            data:{
                fuzzyVipId:fuzzyVipId
            },
            url:"getHairVipByFuzzy",
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
                //$("#P_VipBySelect").append('<option value="无">无</option>');
                for(var i =0;i<actObj.length;i++){
                    $("#P_VipBySelect").append('<option value="'+actObj[i].substring(0,12)+'">'+actObj[i].substring(12)+'</option>');
                }
            }

        })

    }
    function func2() {
        var i =$("#edit_hair_project").prop("selectedIndex");
        $("#base").empty();
        $.ajax({
            type:"post",
            data:{
                i:i
            },
            url:"getHairPrice",
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
                    $("#base").val(actObj[i].basePrice);
                    $("#totalCost").val(actObj[i].basePrice);

                }
            }
        })

    }
    //验证
    function hairChecking() {
        var a1 =$("#add_vipId").val();
        var a3 =$("#edit_hair_employee").val();
        var a4 =$("#edit_hair_project").val();
        var a5 =$("#base").val();
        var a6 =$("#addition").val();
        var a7 =$("#totalCost").val();
        var a8 =$("#payType").val();
        if(a1.length>0&&a3!="无"&&a4.length>0&&a5.length>0&&a6.length>0&&a7.length>0&&a8.length>0)
        {
            //uploadImg();
            return true;
        }
        else{
            alert("您有选项还没填写请注意检查");
            return false;
        }
    }

    function GetUserBy2(obj) {
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


</script>

</body>
</html>
