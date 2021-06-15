<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>登录页面</title>
	<meta http-equiv=Content-Type content="text/html; charset=utf-8">
	<link href="${pageContext.request.contextPath}/css/style.css"
		  type=text/css rel=stylesheet>
	<link href="${pageContext.request.contextPath}/css/boot-crm.css"
		  type=text/css rel=stylesheet>
	<script src=
					"${pageContext.request.contextPath}/js/jquery-1.11.3.min.js">
	</script>
	<meta content="MSHTML 6.00.2600.0" name=GENERATOR>
	<script>
        // 判断是登录账号和密码是否为空
        function check(){
            var user_id = $("#user_id").val();
            var password = $("#password").val();
            var code=$("#code").val();
            if(usercode=="" || password==""){
                $("#message").text("账号或密码不能为空！");
                return false;
            }
            if(code==""){
                $("#message").text("验证码不能为空！");
                return false;
            }
            return true;
        }
	</script>
</head>
<body leftMargin=0 topMargin=0 marginwidth="0" marginheight="0"
	  background="${pageContext.request.contextPath}/images/rightbg.jpg">
<div ALIGN="center">
	<table border="0" width="1140px" cellspacing="0" cellpadding="0"
		   id="table1">
		<tr>
			<td height="93"></td>
			<td></td>
		</tr>
		<tr>
			<td background="${pageContext.request.contextPath}/images/back.jpg"
				width="740" height="412">
			</td>
			<td class="login_msg" width="400" align="center">
				<!-- margin:0px auto; 控制当前标签居中 -->
				<fieldset style="width: auto; margin: 0px auto;">
					<legend>
						<font color="white" style="font-size:20px" face="宋体">
							欢迎使用信息管理系统
						</font>
					</legend>
					<font color="white" size="3px">
						<%-- 提示信息--%>
						<br/>
						<span id="message">${msg}</span>
					</font>

					<form action="/user/login.do"  method="post" onsubmit="return check()">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<div>
							<br />
							<font color="white" size="4px"> 账&nbsp;号：&nbsp;&nbsp;</font>&nbsp;&nbsp;
							<input id="user_id" type="text" name="user_id" placeholder="" value = "${param.user_id}"/>
						</div>
						<div>
							<br />
							<font color="white" size="4px">  密&nbsp;码：&nbsp;&nbsp;</font>&nbsp;&nbsp;
							<input id="password" type="password" name="password"  value = "${param.password}"/>
						</div>
						<!--
						<div id="searchDiv">
							<br />
							<input type="text" name="code"  placeholder="验证码"/>&nbsp;
							<img border="0" alt="点击刷新" onclick="this.src=this.src+'?'" src="/user/checkCode.do" >
						</div>
						-->
						<div>
							<br />
							<input type="submit" value="登录" />
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="注销" />
						</div>
					</form>
					<div>
						<br />
						<a  href="#"><font color="white" size="3px">忘记密码？</font></a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a  href="#"><font color="white" size="3px">常见问题解决方案</font></a>
						<br /> <br />
					</div>

				</fieldset>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
