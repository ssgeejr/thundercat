<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="java.util.*,java.io.*" %>
<%
StringBuffer sout = new StringBuffer();
Enumeration en=request.getParameterNames();
while(en.hasMoreElements())
{
	Object objOri=en.nextElement();
	String param=(String)objOri;
	if(param.startsWith("start.x")){
		out.println("<h1>START</h1>");
	}else if(param.startsWith("stop.x")){
		out.println("<h1>STOP</h1>");
	}else if(param.startsWith("pull.x")){
		out.println("<h1>PULL</h1>");
	}else if(param.startsWith("process.x")){
		out.println("<h1>PROCESS</h1>");
	}
	
}	

%>

<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Thundercat</title>
<style type="text/css">
.auto-style1 {
	text-align: right;
}
</style>
</head>

<body>
<form id="tc" method="post" action="index.jsp">

<table style="width: 100%">
	<tr>
		<td class="auto-style1">
		<img height="42" src="thundercats.logo_sm.png" width="42" /></td>
	</tr>
	<tr>
		<td>
		<table style="width: 100%">
			<tr>
				<td class="auto-style1" style="width:50%; height: 44px;">START</td>
				<td style="height: 44px"><input type="image" name="start" value="0" alt="Start" src="start.png"/></td>
			</tr>
			<tr>
				<td class="auto-style1" style="width:50%">STOP</td>
				<td><input type="image" name="stop" value="1" alt="Stop" src="stop.png"/></td>
			</tr>
			<tr>
				<td class="auto-style1" style="width:50%">PULL</td>
				<td><input type="image" name="pull" value="2" alt="Pull" src="pull.png"/></td>
			</tr>
			<tr>
				<td class="auto-style1" style="width:50%">PROCESS</td>
				<td><input type="image" name="process" value="3" alt="Process" src="process.png"/></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
			&nbsp;&nbsp;</td>
	</tr>
</table>
</form>
</body>

</html>
