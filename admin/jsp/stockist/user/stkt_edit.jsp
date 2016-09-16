<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<%@page import="com.ecosmosis.orca.stockist.StockistManager"%>
<%@page import="com.ecosmosis.orca.stockist.StockistUserBean"%>
<html>
<head>
  <title></title>

<%@ include file="/lib/header.jsp"%>
<%
	int size = 40;
	int memberIDLength = 12;
	
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	StockistBean stockist = (StockistBean) returnBean.getReturnObject(StockistManager.RETURN_STKBEAN_CODE);
	Map usrLvls = (Map) returnBean.getReturnObject(StockistManager.RETURN_USR_LVLS);
	Map usrStatus = (Map) returnBean.getReturnObject(StockistManager.RETURN_USR_STATUS);
	
	StockistUserBean user = null;	
	if(stockist != null)
		user = stockist.getUser();
	
	boolean canView = (stockist != null && user!=null);
%>
	  
  <script language="javascript">
   function confirmProceed(thisform) {
  
  	if(thisform.Name.value == ''){
  		
  		alert("<i18n:label code="MSG_INVALID_NAME"/>");
  		focusAndSelect(thisform.Name);
		return false;
  	}  	  	
  	
	if(confirm('<i18n:label code="MSG_PROCEED_CHANGE"/>'))
	    return true;
	else
	    return false;    
  }		
  </script>	
  
</head>

<body>

<div class="functionhead"><i18n:label code="STOCKIST_EDIT_USER"/></div>
<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

<c:if test="<%=(canView)%>">

<form name="frmEdit" action="<%=Sys.getControllerURL(StockistManager.TASKID_EDIT_USER_SUBMIT, request)%>" method="post" onSubmit="return confirmProceed(document.frmEdit);">

	<table class="tbldata" width="100%">

		<tr>
			<td colspan="2" class="sectionhead"><i18n:label code="STOCKIST_INFO"/></td>
  		</tr>
		<tr>
			<td align="right" width="300"><b><i18n:label code="STOCKIST_ID"/>:</b></td>
	    	<td><%= stockist.getStockistCode() %></td>
		</tr>	
		<tr>
			<td align="right"><b><i18n:label code="GENERAL_NAME"/>:</b></td>
	    	<td><%= stockist.getName() %></td>
		</tr>
		<tr valign=top>
			<td align="right"><b><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>.:</b></td>
	    	<td><%= stockist.getRegistrationInfo() %></td>
		</tr>
		<tr>
			<td align="right"><b><i18n:label code="GENERAL_TYPE"/>:</b></td>
	    	<td><%= StockistManager.defineStockistType(stockist.getType()) %></td>
		</tr>
		<tr>
			<td colspan="2" >&nbsp;</td>
  		</tr>
  		<tr>
			<td align="right"><i18n:label code="GENERAL_USERID"/>:</td>
	    	<td><b><%= user.getUserID() %></b></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label code="GENERAL_NAME"/>:</td>
	    	<td><std:input type="text" name="Name" maxlength="100" size="40" value="<%= user.getName() %>"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label code="GENERAL_TYPE"/>:</td>
	    	<td><std:input type="select" name="Level" options="<%=usrLvls%>" value="<%= user.getLevel() %>" /></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label code="GENERAL_STATUS"/>:</td>
	    	<td><std:input type="select" name="Status" options="<%=usrStatus%>" value="<%= user.getStatus() %>" /></td>
		</tr>		
  	</table>
  	<std:input type="hidden" name="StockistID"/>
  	<std:input type="hidden" name="UserID" value="<%= user.getUserID() %>"/>
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>"> 
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_BACK"/>" onClick="location.href='<%=Sys.getControllerURL(StockistManager.TASKID_LIST_USERS, request)%>&StockistID=<%= stockist.getStockistCode() %>'">
  </form>		
</c:if>





</body>
</html>		