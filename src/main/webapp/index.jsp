<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
			cmdlist = new String[]{"docker-compose", "--no-ansi", "up", "-d"};
			break;
		}else if(param.startsWith("stop.x")){
	//		out.println("<h1>STOP</h1>");
			cmd = "stop";
			cmdlist = new String[]{"docker-compose", "--no-ansi", "down"};
			break;
		}else if(param.startsWith("pull.x")){
	//		out.println("<h1>PULL</h1>");
			cmd = "pull";
			cmdlist = new String[]{"docker-compose", "--no-ansi", "pull"};
			break;
		}else if(param.startsWith("process.x")){
	//		out.println("<h1>PROCESS</h1>");
			cmd = "ps";
			cmdlist = new String[]{"docker-compose", "ps"};
			break;
		}else if(param.startsWith("redeploy.x")){
	//		out.println("<h1>PROCESS</h1>");
			cmd = "mfadeploy";
			cmdlist = new String[]{"/opt/bin/mfadeploy"};
			break;
		}else if(param.startsWith("propstree.x")){
	//		out.println("<h1>PROCESS</h1>");
			cmd = "mfadeploy";
			cmdlist = new String[]{"tree", "-a"};
			break;
		}else if(param.startsWith("reprops.x")){
	//		out.println("<h1>PROCESS</h1>");
			cmd = "mfadeploy";
			cmdlist = new String[]{"/opt/bin/mfaprops"};
			break;
		}		
	}
	if (cmd != null){
		ProcessBuilder pb = new ProcessBuilder(cmdlist).redirectErrorStream(true);
		pb.directory(new File("/opt/mfa-deploy"));
		System.out.println("... executing command (" + pb.command() + ")");
//		out.println("... executing command (" + pb.command() + ")");
		sout.append("... attempting to execute the docker-compose command: '" + pb.command() + "'<br>");
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
.auto-style2 {
	text-align: left;
}
.auto-style3 {
	text-align: center;
}
</style>
</head>

<body>
<form id="tc" method="post" action="/index.jsp">
<div align="center">
<table style="width: 400pt; border: 1px solid red;">
	<tr>
		<td class="auto-style3">
		<img height="98" src="thundercats_logo.png" width="323" /></td>
	</tr>
	<tr>
		<td>
		<table style="width: 100%">
			<tr>
				<td class="auto-style1" style="width:50%; height: 44px;">START</td>
				<td style="height: 44px" class="auto-style2"><input type="image" name="start" value="0" alt="Start" src="start.png"/></td>
			</tr>
			<tr>
				<td class="auto-style1" style="width:50%">STOP</td>
				<td class="auto-style2"><input type="image" name="stop" value="1" alt="Stop" src="stop.png"/></td>
			</tr>
			<tr>
				<td class="auto-style1" style="width:50%">PULL</td>
				<td class="auto-style2"><input type="image" name="pull" value="2" alt="Pull" src="pull.png"/></td>
			</tr>
			<tr>
				<td class="auto-style1" style="width:50%">PROCESS</td>
				<td class="auto-style2"><input type="image" name="process" value="3" alt="Process" src="process.png"/></td>
			</tr>
			<tr>
				<td class="auto-style1" style="width:50%">REDEPLOY</td>
				<td class="auto-style2"><input type="image" name="redeploy" value="4" alt="Redeploy" src="mfadeploy.png"/></td>
			</tr>
			<tr>
				<td class="auto-style1" style="width:50%">PROPS TREE</td>
				<td class="auto-style2"><input type="image" name="propstree" value="5" alt="Properties Tree" src="tree.png"/></td>
			</tr>
			<tr>
				<td class="auto-style1" style="width:50%">REDEPLOY PROPS</td>
				<td class="auto-style2"><input type="image" name="reprops" value="6" alt="Redeploy Process" src="properties.png"/></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><%= sout.toString() %></td>
	</tr>
</table>
</div>
</form>

</body>

</html>

