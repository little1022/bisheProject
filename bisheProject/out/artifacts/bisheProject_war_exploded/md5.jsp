<%--
  Created by IntelliJ IDEA.
  User: 55235
  Date: 2021/6/6
  Time: 20:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>md5加密</title>
</head>
<body>

    <form action="md5">
        <div>
            <label>密码</label>
            <input type="text" name="md5_password"/>
            <button type="submit">md5加密</button>
        </div>
    </form>
<div>
    <%
        Object obj =session.getAttribute("md5");
        String mes="";
        if(obj!=null)
            mes=(String)obj;
    %>
    <label>加密后：<%=mes%></label>
</div>


</body>
</html>
