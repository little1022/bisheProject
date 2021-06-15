<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 引入struts2 的标签库--%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
    <meta charset="utf-8">
    <title>美发连锁店管理系统</title>
    <link rel="stylesheet" type="text/css" href="css/style1.css" />
</head>
<body>

<div class="main">
    <div class="mainin">
        <h1><img src="images/title.png"></h1>
        <s:form action ="doLogin" method="post">
            <div class="mainin1">
                <ul>
                    <li><span>用户名：</span><input name="userinfoEntity.userId" type="text" id="loginName" placeholder="登录名" class="SearchKeyword"></li>
                    <li><span>密码：</span><input type="password" name="userinfoEntity.password" id="Possword" placeholder="密码" class="SearchKeyword2"></li>
                    <li >
                        <button  class="tijiao" display=“inline” type="submit">登录</button>
                        <button class="tijiao" display=“inline” type="reset">重置</button>
                    </li>
                </ul>
            </div>
        </s:form>
        <div class="footpage"><span style="" font-family:arial;><a href="md5.jsp" target="_blank">帮助</a></span>  </div>
        <div class="footpage"><span style="" font-family:arial;>Copyright @tyx</span>2021  </div>
    </div>
</div>
<img src="images/loading.gif" id="loading" style=" display:none;position:absolute;" />
<div id="POPLoading" class="cssPOPLoading">
    <div style=" height:110px; border-bottom:1px solid #9a9a9a">
        <div class="showMessge"></div>
    </div>

</div>


</body>
</html>

