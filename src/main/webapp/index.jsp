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
		}else if(param.startsWith("redeploy.x")){
	//		out.println("<h1>PROCESS</h1>");
			cmd = "mfadeploy";
			cmdlist = new String[]{"/opt/projects/dctest/dcdeploy"};
			break;
		}
	}	

	if (cmd != null){
		ProcessBuilder builder = new ProcessBuilder(cmdlist).redirectErrorStream(true);
		builder.directory(new File("/opt/projects/dctest"));
		System.out.println("... executing command (" + builder.command() + ")");
//		out.println("... executing command (" + pb.command() + ")");
		sout.append("... attempting to execute the docker-compose command: '" + builder.command() + "'<br>");
		Process dockerComposeCommand = builder.start();
		String path = System.getenv("PATH");
        builder.environment().put("PATH","/usr/bin:"+path);
        builder.redirectErrorStream(true);
        builder.redirectError(ProcessBuilder.Redirect.INHERIT);

        try {
            dockerComposeCommand.waitFor();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(dockerComposeCommand.getInputStream()))) {
                String line = reader.readLine();
                while (line != null) {

   // // strips off all non-ASCII characters
   // text = text.replaceAll("[^\\x00-\\x7F]", "");
 
   // // erases all the ASCII control characters
   // text = text.replaceAll("[\\p{Cntrl}&&[^\r\n\t]]", "");
     
   // // removes non-printable characters from Unicode
   // text = text.replaceAll("\\p{C}", "");


//                	line = line.replaceAll("\\p{C}", "").replaceAll("[\\p{Cntrl}&&[^\r\n\t]]", "").replaceAll("[^\\x00-\\x7F]", "");
					line = line.replaceAll("\\[1A", "").replaceAll("\\[1B", "").replaceAll("\\[2K", "").replaceAll("\\[32m", "").replaceAll("\\[0m", "");
                	System.out.println(line);
                	sout.append(line + "<br>");
                    line = reader.readLine();
                }
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
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
				<td class="auto-style2"><input type="image" name="redeploy" value="4" alt="Process" src="mfadeploy.png"/></td>
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

