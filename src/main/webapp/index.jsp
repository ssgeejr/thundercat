﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="java.util.*,java.io.*" %>
<%
StringBuffer sout = new StringBuffer();
Enumeration en=request.getParameterNames();
String cmd = null;
String[] cmdlist = null;
while(en.hasMoreElements()) {
	Object objOri=en.nextElement();
	String param=(String)objOri;
	if(param.startsWith("start.x")){
//		out.println("<h1>START</h1>");
		cmd = "start";
		cmdlist = new String[]{"docker-compose", "up", "-d"};
		break;
	}else if(param.startsWith("stop.x")){
//		out.println("<h1>STOP</h1>");
		cmd = "stop";
		cmdlist = new String[]{"docker-compose", "down"};
		break;
	}else if(param.startsWith("pull.x")){
//		out.println("<h1>PULL</h1>");
		cmd = "pull";
		cmdlist = new String[]{"docker-compose", "pull"};
		break;
	}else if(param.startsWith("process.x")){
//		out.println("<h1>PROCESS</h1>");
		cmd = "ps";
		cmdlist = new String[]{"docker-compose", "ps"};
		break;
	}
}	
	if (cmd != null){
		ProcessBuilder pb = new ProcessBuilder(cmdlist);
		System.out.println("... executing command (" + pb.command() + ")");
//		out.println("... executing command (" + pb.command() + ")");
		sout.append("... attempting to execute the docker-compose command: '" + pb.command() + "'<br>");
		pb.directory(new File("/opt/projects/testcompose/"));
		Process p = pb.start();

		DataInputStream dis = new DataInputStream(p.getInputStream());
		String disr = dis.readLine();
		while ( disr != null ) {
   			sout.append(disr + "<br>");
    		disr = dis.readLine();
    	}//end while
    	dis.close();
	}//end if

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
<form id="tc" method="post" action="/index.jsp">

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
		<td><%= sout.toString() %></td>
	</tr>
</table>
</form>
</body>

</html>

