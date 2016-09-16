<%@page import="com.ecosmosis.mvc.sys.SystemConstant"%>
<%
	String taskid = request.getParameter(SystemConstant.TASK);

	String folder = "";
	if(taskid!=null && taskid.length() > 0){
		
		String sysid = taskid.substring(0,1);
		if(sysid.equals( String.valueOf(SystemConstant.ORCA_ERP_ADMIN_SYSTEMID)))
				folder  = "admin/";

		else if(sysid.equals( String.valueOf(SystemConstant.ORCA_ERP_STOCKIST_SYSTEMID)))
			folder  = "estockist/";

	}
		
%>

<html>
 <body>
  <script language="javascript">
   parent.window.location.href="<%="http://" + request.getHeader("host")+ request.getContextPath()%>/<%=folder%>";
  </script>
 </body>
</html>
