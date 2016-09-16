<%@page import="com.ecosmosis.orca.stockist.*"%>
<%@page import="java.util.Hashtable"%>

<html>
<head>
<title></title>

<%@ include file="/lib/header.jsp"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean) request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	Hashtable reports = (Hashtable) returnBean.getReturnObject(StockistManager.RETURN_STATUS_RPT);
	
	boolean showResult = (reports != null && reports.size()>0);
%>

<script language="javascript"> 	 
</script>

</head>

<body>

<div class="functionhead"><i18n:label code="STOCKIST_STATUS_REPORT"/></div>
<br>

<%@ include file="/lib/return_error_msg.jsp"%>
	
<div><b><std:date text="<%=lang.display("GENERAL_PRINTED_DATE")%>"/></b></div>
<c:if test="<%= showResult %>">
<%
	String[] columns = (String[])reports.get("column_fields");
	String[] rows = (String[])reports.get("row_fields");
	int[][] figures = (int[][])reports.get("records");
	
	int total_horiz[] = new int[columns.length];
	int total_vert[] = new int[rows.length];
%>
<table class="listbox" width="60%">
	<tr class="boxhead" valign=top>
		<td align=right>&nbsp;</td>
<%
		for(int column=0; column<columns.length; column++){
%>	
	
		<td align=right><%= StockistManager.defineStockistStatus(columns[column])%>&nbsp;</td>
		
<%
		}//end for
%>	
		<td align=right><i18n:label code="GENERAL_TOTAL"/>&nbsp;</td>
	</tr>
	
<%
		for(int row = 0; row < rows.length; row++){
%>	
	<tr class="<%=(row%2==0)?"odd":"even" %>" valign=top>
				<td align=left><b><%= StockistManager.defineStockistType(rows[row])%> &nbsp;</b></td>
		<%
				for(int column=0; column<columns.length; column++){
					total_horiz[column] +=  figures[row][column];
					total_vert[row] += figures[row][column];
		%>	
			
				<td align=right>
				<%if(figures[row][column] > 0) { %>				
					<std:link taskid="<%=StockistManager.TASKID_STOCKIST_STATUS_LIST%>" 
					text="<%= String.valueOf(figures[row][column])%>" 
					params="<%=("Type=" + rows[row] + "&Status=" + columns[column]+"&StockistID")%>" type="1"/>
				<%}else{%>
					<%= figures[row][column]%>
				<%} %>	
				&nbsp;
				</td>
				
		<%
				}//end for
		%>			
				<td align=right>
				<%if( total_vert[row] > 0) { %>				
					<std:link taskid="<%=StockistManager.TASKID_STOCKIST_STATUS_LIST%>" 
					text="<%= String.valueOf(total_vert[row])%>" 
					params="<%=("Type=" + rows[row] +"&StockistID")%>" type="1"/>
				<%}else{%>
					<%=  total_vert[row] %>
				<%} %>				
				&nbsp;</td>
	</tr>
<%
		}//end for
%>
	<tr class="boxhead" valign=top>
	
		<td align=right><i18n:label code="GENERAL_TOTAL"/>&nbsp;</td>
<%
		    int total = 0;
			for(int i=0; i<total_horiz.length; i++){
				total += total_horiz[i];
			
%>
		<td align=right>
				<%if( total_horiz[i] > 0) { %>				
					<std:link taskid="<%=StockistManager.TASKID_STOCKIST_STATUS_LIST%>" 
					text="<%= String.valueOf(total_horiz[i])%>" 
					params="<%=("Status=" + columns[i] +"&StockistID")%>" type="1"/>
				<%}else{%>
					<%=  total_horiz[i] %>
				<%} %>			
		&nbsp;</td>
<%
			}//end for
%>		<td align=right>
			<%if( total > 0) { %>				
				<std:link taskid="<%=StockistManager.TASKID_STOCKIST_STATUS_LIST%>" 
				text="<%= String.valueOf(total)%>" 
				params="<%=("StockistID")%>" type="1"/>
			<%}else{%>
				<%=  total %>
			<%} %>			
			&nbsp;</td>
	</tr>
</table>

<br>
<br>
<input class="noprint" type="button" value="<i18n:label code="GENERAL_TOTAL"/>" onClick="window.print();">

	
</c:if>



</body>
</html>
