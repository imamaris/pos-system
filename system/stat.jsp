<%@ page import="com.ecosmosis.util.db.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<html>
 <head>
<%@ include file="/lib/header.jsp"%>

<%

   long maxSize = 0l;
   String dbVersion = "unknown";
   Connection conn = null;
   PreparedStatement stmt = null;
   ResultSet rs = null;
   
   try {
   
       conn = DbConnectionManager.getConnection();
       stmt = conn.prepareStatement("SHOW TABLE STATUS");
       rs = stmt.executeQuery();
   
       while(rs.next()){
       
          maxSize +=( rs.getLong("Data_length") +  rs.getLong("Index_length"));
       }
       stmt.close();
       rs.close();
       
       stmt = conn.prepareStatement("SELECT VERSION()");
       rs = stmt.executeQuery();
       if(rs.next()){
       
           dbVersion = rs.getString(1);
       }

   } catch (SQLException sqlex) {

        sqlex.printStackTrace();

   } finally{

      if(conn!=null && !conn.isClosed())
          conn.close();
      if(stmt!=null)
          stmt.close();
      if(rs!=null)
          rs.close();
   }

   DecimalFormat twoFormat = new DecimalFormat("#,###,###,##0.00");
   double sizeInMb = (maxSize/1000000d);
%>

<%!
	public ThreadGroup getTopGroup(ThreadGroup current)
	{
		ThreadGroup parent = current.getParent();
		if (parent == null)
			return current;
		else
		return getTopGroup(parent);
	}
%>


<%		Runtime runtime = Runtime.getRuntime();
		long freemem = runtime.freeMemory();
		int availableprocessor = runtime.availableProcessors();
		long totalmemory  = runtime.totalMemory();
		long maxmem = runtime.maxMemory();

		Thread currentThread = Thread.currentThread();
		ThreadGroup topgroup = getTopGroup(currentThread.getThreadGroup());
		
/*		ThreadGroup[] $2nd = new ThreadGroup[topgroup.activeGroupCount()];
		topgroup.enumerate($2nd);


		ThreadGroup[] $1st = new ThreadGroup[1];
		$1st[0] = topgroup;
		ThreadGroup[] grouplist = new ThreadGroup[$2nd.length+1];

		System.arraycopy($1st,0,grouplist,0,$1st.length);
		System.arraycopy($2nd,0,grouplist,$1st.length,$2nd.length);
		*/
%>

<%
		TreeMap maps = new TreeMap();
		maps.put("N","GENERAL_DETAILSNO");			//	No Details
		maps.put("Y","GENERAL_DETAILSSHOW");		//	Show Details
		
		String type = request.getParameter("type");
		boolean viewDetails = false;
		
		if (type != null && type.equals("Y"))
			viewDetails = true;
%>
 
 <script LANGUAGE="JavaScript">
<!--
function submitform(){
var myform = document.form;
myform.submit();
}
// -->
</script>
<meta http-equiv="refresh" content="30";>
<div class="functionhead"><i18n:label code="ADMIN_SYS_MONITOR"/></div>
</head>
<body>


<br>

<form name="form" action="" method="post">	
<table width="200"%>
	 <tr>
	 	<td><i18n:label code="GENERAL_DISPLAY_OPTIONS"/> </td>
	 	<td><std:input type="select" name="type" options="<%=maps%>" value="<%=request.getParameter("type")%>" status="onChange=submitform();" /></td>
	 </tr>
</table>
</form>

<br>
<table class="listbox" width="300">
<tr class="boxhead">
  <td colspan="3"><i18n:label code="ADMIN_SYS_CPU"/></td>
 </tr>
 <tr>
  <td><i18n:label code="ADMIN_SYS_CPUS"/></td>
  <td>:</td>
  <td><%=availableprocessor%></td>
 </tr>
 <tr>
  <td><i18n:label code="ADMIN_SYS_MEMORY_CURRENT"/></td>
  <td>:</td>
  <td><%=twoFormat.format(totalmemory/(1024D * 1024D))%> MB</td>
 </tr>
 <tr>
  <td><i18n:label code="ADMIN_SYS_MEMORY_USED"/></td>
  <td>:</td>
  <td><%=twoFormat.format((totalmemory-freemem)/(1024D * 1024D))%> MB</td>
 </tr>
 <tr>
  <td><i18n:label code="ADMIN_SYS_MEMORY_FREE"/></td>
  <td>:</td>
  <td><%=twoFormat.format((freemem)/(1024D * 1024D))%> MB</td>
 </tr>
 <tr>
  <td><i18n:label code="ADMIN_SYS_MEMORY_MAX"/></td>
  <td>:</td>
  <td><%=twoFormat.format((maxmem)/(1024D * 1024D))%> MB</td>
 </tr>
</table>

<br>

<table class="listbox"  width="300">
<tr class="boxhead">
  <td colspan="3"><i18n:label code="GENERAL_DB_INFO"/></td>
 </tr>
 
 <tr>
  <td><i18n:label code="GENERAL_DB_VERSION"/></td>
  <td>:</td>
  <td><%= dbVersion %></td>
 </tr>
 <tr>
  <td><i18n:label code="GENERAL_DB_SIZE"/></td>
  <td>:</td>
  <td><%= twoFormat.format(sizeInMb)%>MB</td>
 </tr>
 <tr>
  <td><i18n:label code="GENERAL_DB_MAXHIT"/></td>
  <td>:</td>
  <td><%= DbConnectionManager.getInstance().countConnections() %></td>
 </tr>
 <tr>
  <td><i18n:label code="GENERAL_DB_FREE"/></td>
  <td>:</td>
  <td><%= DbConnectionManager.getInstance().countFreeConnections() %></td>
 </tr>
 <tr>
  <td><i18n:label code="GENERAL_DB_CONCURRENT"/></td>
  <td>:</td>
  <td><%= DbConnectionManager.getInstance().countBusyConnections() %></td>
 </tr>
</table>

<br>

<% if (viewDetails) { %> 

<table width="80%" class="listbox" >
 
 <tr class="boxhead">
  <td colspan="7">ACTIVE PROCESSES</td>
 </tr>
 
 <tr class="boxhead">
  <td>No</td>
  <td>Process Name</td>
  <td>Priority</td>
  <td>Group Name</td>
  <td>Is Alive</td>
  <td>Is Deamon</td>
  <td>Is Interrupted</td>
 </tr>

<%
/*	for (int j = 0 ; j < grouplist.length ; j ++)
	{
*/		
		Thread[] threads = new Thread[topgroup.activeCount()];
		topgroup.enumerate(threads);

		for (int i = 0 ; i < threads.length; i ++)
    	{
			if (threads[i] == null ) continue;
			boolean isCurrent = currentThread.equals(threads[i]);

%>
 <tr class="<%=((i%2==1)?"odd":"even")%>" >
  <td><%=i+1%></td>
  <td><%=isCurrent?"<b>":""%><%=threads[i].getName()%><%=isCurrent?"</b> (<i>current thread</i>)":""%></td>
  <td align="center"><%=threads[i].getPriority()%></td>
  <td align="center"><%=threads[i].getThreadGroup().getName()%> </td>
  <td align="center"><%=threads[i].isAlive()%></td>
  <td align="center"><%=threads[i].isDaemon()%></td>
  <td align="center"><%=threads[i].isInterrupted()%></td>
 </tr>
<%
		}
//	}
%>

<% } %>

</table>
</body>
</html>
