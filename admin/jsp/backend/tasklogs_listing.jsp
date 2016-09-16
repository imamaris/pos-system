<%@ page import="com.ecosmosis.mvc.backend.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>


<html>
<head>
<%@ include file="/lib/header.jsp"%>
</head>
 <body>
<%
	MvcReturnBean returnBean = (MvcReturnBean) request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	
	BackendTaskBean[] btb = (BackendTaskBean[]) returnBean.getReturnObject("btbs");
	String[] trxs = (String[]) returnBean.getReturnObject("trx");
	
	TreeMap configs = (TreeMap) returnBean.getReturnObject("configs");

	boolean canView = btb != null;
	
	String taskgroup = request.getParameter("taskgroup");
	
	String toDate = request.getParameter("DateTo");
	String fromDate = request.getParameter("DateFrom");
	
	if (fromDate == null || toDate == null)
	{
		java.util.Calendar today = java.util.Calendar.getInstance();
		today.setTime(new java.util.Date());
		toDate = Sys.getDateFormater().format(today.getTime());
		today.add(java.util.Calendar.DATE,-7);
		fromDate = Sys.getDateFormater().format(today.getTime());
	}
	
%>


 <form name="sm" method="post" action="<%=Sys.getControllerURL(BackendTaskManager.TASKID_BACKEND_GET_TASK_LIST,request)%>">
 <input type="hidden" name="taskgroup" value="<%=taskgroup%>" >
 
 <div class="functionhead"><i18n:label code="TASK_LOGS_LISTING"/> - <%=taskgroup%></div>
 <br>
 <table  class="listbox">
  <tr >
   	<td  class="odd"><i18n:label code="TASK_ID"/></td>
	<td><std:input type="select" name="TaskID" options="<%=configs%>" value="<%=request.getParameter("TaskID")%>" /></td>
	<td  rowspan="3" valign="middle">
       <input type="submit" value="<i18n:label code="GENERAL_BUTTON_GO"/>">
     </td>
  </tr>
  <tr>
   <td  class="odd"><i18n:label code="GENERAL_FROMDATE"/></td>
   <td><std:input type="date" name="DateFrom" size="11" value="<%=fromDate%>"/></td>
  </tr>
  <tr>
   <td  class="odd"><i18n:label code="GENERAL_TODATE"/></td>
   <td><std:input type="date" name="DateTo" size="11" value="<%=toDate %>"/></td>
  </tr>
 </table>
 
 </form>
<%
	if (canView)
	{
%>
<table class="listbox" width="90%">

	 <tr  class="boxhead">
		  <td align=right><i18n:label code="GENERAL_NUMBER"/></td>
		  <td><i18n:label code="TASK_ID"/></td>
		  <td><i18n:label code="GENERAL_STATUS"/></td>
		  <td><i18n:label code="TASK_PARAMS"/></td>
		  <td><i18n:label code="GENERAL_START_TIME"/></td>
		  <td><i18n:label code="GENERAL_END_TIME"/></td>
		  <td><i18n:label code="GENERAL_PROCESSED_BY"/></td>
		  <td></td>
	 </tr>

<%
		for (int i = 0 ; i < btb.length; i ++)
		{
%>

 <tr class="<%=((i%2==1)?"odd":"even")%>" >
	  <td align=right><%=i+1%>.</td>
	  <td><%=btb[i].getTrxtype()%></td>
	  <td align="center"><%=BackendTask.definteShortTaskStatus(btb[i].getStatus())%></td>
	  <td align="left" width="250"><std:text value="<%=btb[i].getParamvalues()%>" defaultvalue=""/></td>
	  <td align="center"><%=btb[i].getStartTime()%></td>
	  <td align="center"><%=btb[i].getEndTime()%></td>
	  <td align="center"><%=btb[i].getDoneBy()%></td>
	  <td align="center"><std:link text="<%= lang.display("GENERAL_BUTTON_VIEW_DETAIL") %>" taskid="<%=BackendTaskManager.TASKID_BACKEND_GET_TASK_DETAILS%>" params="<%="TaskID="+btb[i].getTrxcode()%>" /></td>
 </tr>
<% }  // end for  %>

</table>

<%	} // end canView %>

 </body>
</html>
