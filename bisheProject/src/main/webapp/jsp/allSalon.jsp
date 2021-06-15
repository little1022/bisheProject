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
                    <form id="searchSalon" action="${pageContext.request.contextPath}/showSalon?page=1"
                          method="post">
                        <div class="col-md-4 data1">
                            <input type="text" class="form-control" name="inputUserId" id="cName"
                                   placeholder="请输入美发店名或地址查询" >
                        </div>
                        <button onclick="test8()" type="button" class="btn bg-maroon">搜索</button>
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
                                        p=(totePage-1)<0?1:totePage-1;
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

                                        <td style="text-align: center"><a href="${pageContext.request.contextPath}/toPicture?picPath=<%=u.getLicense2()%>" target="_blank">卫生许可证</a></td>
                                        <td style="text-align: center"><a href="${pageContext.request.contextPath}/toPicture?picPath=<%=u.getLicense2()%>" target="_blank">营业执照</a></td>
                                        <td style="text-align: center"><a href="${pageContext.request.contextPath}/toPicture?picPath=<%=u.getLicense3()%>" target="_blank">税务登记证</a></td>
                                        <td class="text-center">
                                            <a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#changeSalonDialog" onclick="Values5('<%=u.getSalonId()%>','<%=u.getSalonName()%>','<%=u.getAddress()%>','<%=u.getShopkeeper()%>','<%=u.getTelephone()%>','<%=u.getEmail()%>','<%=u.getLicense1()%>','<%=u.getLicense2()%>','<%=u.getLicense3()%>') ">修改</a>

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
                <form action="saveSalon" method="post" class="form-horizontal" id="edit_hsalon_form" enctype="multipart/form-data">

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
                                <option value="无" selected="selected">无</option>
                                <%
                                    List<Employee> employees =(List<Employee>)session.getAttribute("employeeList");
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
                        <label for="upload1" class="col-sm-2 control-label">卫生许可证</label>
                        <div class="col-sm-10">

                             <input type="file" class="form-control" id="upload1"  name="upload"  />

                        </div>
                      </div>
                      <div class="form-group">
                        <label for="upload2" class="col-sm-2 control-label">营业执照</label>
                        <div class="col-sm-10">


                              <input type="file" class="form-control" id="upload2"  name="upload"  />

                        </div>
                      </div>
                      <div class="form-group">
                        <label for="upload3" class="col-sm-2 control-label">税务登记证</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="upload3"  name="upload"  />

                        </div>
                      </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">关闭</button>
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
                <form action="updateSalon" class="form-horizontal" id="edit_employee_form2">

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
                            <select	 class="form-control"   name="hsalon.shopkeeper" id="update_shopkeeper" >
                                <option value="无" selected="selected">无</option>
                                <%
                                    employees =(List<Employee>)session.getAttribute("employeeList");
                                    employeeNum = employees.size();
                                    for(int i=0;i<employeeNum;i++){
                                %>
                                <option value="<%=employees.get(i).getEmployeeId()%>"><%=employees.get(i).getEmployeeId()+" "+employees.get(i).getEmployeeName()%></option>
                                <%
                                    }
                                %>
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

                    <div style="display: none" class="form-group">
                        <label for="update_License1" class="col-sm-2 control-label">卫生许可证</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="update_License1"  name="upload"  />
                        </div>
                    </div>
                    <div style="display: none" class="form-group">
                        <label for="update_License2" class="col-sm-2 control-label">营业执照</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="update_License2"  name="upload" />
                        </div>
                    </div>
                    <div style="display: none" class="form-group">
                        <label for="update_License3" class="col-sm-2 control-label">税务登记证</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="update_License3"  name="upload" />
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


    // $("#add_License1,#add_License2,#add_License3").change(function(event) {
    //     //$('.dianpuzhuangxiu .addmokuai .block .shuoming1 .pic .pic1').children().remove();
    //     // 根据这个 <input> 获取文件的 HTML5 js 对象
    //     var files = event.target.files, file;
    //     var flag =true;
    //     if (files && files.length > 0) {
    //         // 获取目前上传的文件
    //         file = files[0];
    //         //alert("文件"+file);
    //         for(var i=0;i<files.length;i++){
    //             myFileReader(files[i],function(result,file){
    //                 if(result){
    //                     //文件
    //                     console.log(file.name);
    //
    //                 }else{
    //                     //文件夹
    //                     console.log("不要上传文件夹");
    //                     flag=false;
    //                 }
    //             });
    //         }
    //         //alert("文件"+file);
    //         if(flag){
    //             $(this)[0].files=files;   //关键：将取到的文件赋值给input，用于ajax提交文件！！！
    //             alert("文件"+file);
    //             var formData = new FormData($("#form1")[0]);
    //             console.log(formData);
    //             alert("formData"+formData);
    //             formData.append("file",$(this)[0]);
    //
    //             $.ajax({
    //                 url : "uploadLicense",
    //                 type : 'POST',
    //                 data : formData,
    //                 cache: false,        // 不缓存数据
    //                 // 告诉jQuery不要去处理发送的数据
    //                 processData : false,
    //                 // 告诉jQuery不要去设置Content-Type请求头
    //                 contentType : false,
    //                 async : true,
    //                 success : function(ret) {
    //                     alert("上传成功");
    //
    //                 }
    //             });
    //         }
    //     }
    // });
    //
    // function ignoreDrag(e) {e.originalEvent.stopPropagation();
    //     e.originalEvent.preventDefault();
    // }
    //
    // function myFileReader(file, callback){
    //     if(!window.FileReader){
    //         callback(true,file);
    //         return false;
    //     }
    //     var fr = new FileReader();
    //     fr.readAsDataURL(file);
    //     fr.onload=function(e){
    //         callback(true,file);
    //     }
    //     fr.onerror=function(e){  //不好判断是否是文件夹，通过上传报错可以判断是文件夹
    //         callback(false,file);
    //     }
    //     return true;
    // };


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

    // function getPicturePath(event) {
    //     alert("1");
    //     var files = event.tar;
    //     alert("2");
    //     var file;
    //     if (files && files.length > 0){
    //         alert("上传文件个数："+files.length);
    //         file = files[0];
    //         console.log(file);
    //         var uri =getInputURL(file);
    //     }
    //
    //     alert("改变");
    //     var a6 = $("#add_License1").val();
    //     alert(a6);
    //     if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
    //
    //
    //     } else {
    //         alert("此上传控件暂时只支持IE浏览器！");
    //         return;
    //     }
    //     $(this).attr("disabled", true);
    //     if (realpath.indexOf("C:\\fakepath") > -1) {
    //         alert("系统未能获取正确的文件路径，请根据提示修改浏览器安全级别！");
    //         return;
    //
    //     }

        //验证
        function salonChecking1() {

            var a1 = $("#add_salonName").val();
            var a2 = $("#add_salonAddress").val();
            var a3 = $("#add_shopkeeper").val();
            var a4 = $("#add_SalonTelephone").val();
            var a5 = $("#add_SalonEmail").val();
            var a6 = $("#upload1").val();
            var a7 = $("#upload2").val();
            var a8 = $("#upload3").val();
            if (a1.length > 0 && a2.length > 0 && a4.length > 0 && a5.length > 0 && a6.length > 0 && a7.length > 0 && a8.length > 0) {
                //uploadLicense();
                return true;
            }
            else {
                alert("您有选项还没填写请注意检查");
                return false;
            }
        }

        // function uploadLicense() {
        //
        //     var add_License1 = $("#add_License1").val();
        //     var add_License2 = $("#add_License2").val();
        //     var add_License3 = $("#add_License3").val();
        //
        //     $.ajax({
        //         type: "post",
        //         data: {
        //             add_License1: add_License1,
        //             add_License2: add_License2,
        //             add_License3: add_License3
        //         },
        //         url: "uploadLicense",
        //         cache: "false",
        //         error: function () {
        //             return false;
        //             alert("服务器没有返回数据，可能服务器忙，请重试");
        //
        //         },
        //         success: function (data) {
        //             var actObj = JSON.parse(data);
        //             $("#add_License1").val(actObj[0]);
        //             //alert( $("#add_License1").val());
        //             $("#add_License2").val(actObj[1]);
        //             $("#add_License3").val(actObj[2]);
        //             return true;
        //         }
        //     })
        //
        // }

        function test8() {
            var cName = $("#cName").val();
            if (cName.length <= 0) {
                alert("您未输入任何信息！");
                return false;
            }
            $.ajax({
                type: 'post',
                url: "setSalonSession",
                data: {
                    showSalonType: 0,
                    name: cName
                },
                error: function (result) {
                    $("#searchSalon").submit();

                },
                success: function (result) {
                    $("#searchSalon").submit();
                }
            })
            return true;

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

    function salonChecking2() {

        var a1= $("#update_salonName").val();
        var a2= $("#update_salonAddress").val();
        var a3= $("#update_shopkeeper").val();
        var a4= $("#update_salonTelephone").val();
        var a5= $("#update_salonEmail").val();
        var a6= $("#update_License1").val();
        var a7= $("#update_License2").val();
        var a8= $("#update_License3").val();
        if (a1.length > 0 && a2.length > 0 && a4.length > 0 && a5.length > 0 ) {
            //uploadLicense();
            return true;
        }
        else {
            alert("您有选项还没填写请注意检查");
            return false;
        }

    }

</script>
</body>
</html>