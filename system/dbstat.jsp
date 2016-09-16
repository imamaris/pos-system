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

 <div class="functionhead"><i18n:label code="ADMIN_DB_MONITOR"/></div>
 <meta http-equiv="refresh" content="30";>
 </head>
<body>


<br>
<table class="listbox" width="300">
<tr>
<td colspan="3" class="boxhead"><i18n:label code="GENERAL_DB_INFO"/></td>
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
 </table>
 
 
 <br>
 
<table class="listbox" width="300">
<tr>
<td colspan="3" class="boxhead"><i18n:label code="GENERAL_DB_STATS"/></td>
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
<br>

<table class="listbox" width="80%" cellpadding="2" callspacing="2" border="0">
<tr class="boxhead" align=left>
  <td colspan=2>Busy DbConnection Trace</td>
 </tr>
 <tr class="boxhead">
  <td align=right width=8%>No.</td>
  <td>Stack Trace </td>
 </tr>

<%

		java.lang.Throwable[] stackTrace = DbConnectionManager.getInstance().getBusyConnectionStackTrace();
		
		for (int i = 0 ; i < stackTrace.length; i ++)
    	{
			if (stackTrace[i] == null ) continue;

%>
 <tr class="<%= (i%2 == 0) ? "even":"odd" %>" valign=top>
  <td align=right><%=i+1%>.</td>
  <td><% stackTrace[i].printStackTrace(new java.io.PrintWriter(out)); %></td>
  </tr>
<%
		}
%>
</table>




</body>
</html>