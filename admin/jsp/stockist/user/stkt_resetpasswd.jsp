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
	
	StockistUserBean user = null;	
	if(stockist != null)
		user = stockist.getUser();
	
	boolean canView =(stockist != null && user!=null);
%>
	  
  <script language="javascript">
	function doSearch(thisform) {
		
		if (!validateStockistId(thisform.StockistID)) {
			alert("<i18n:label code="MSG_INVALID_STOCKISTID"/>");
			focusAndSelect(thisform.StockistID);
			return false;
		}else{			
			return true;
		}  	    		
	}  
  function confirmProceed(thisform) {

   	if (!countPassword(thisform.Password) || 
  		!countPassword(thisform.ConfirmPassword) || 
  		!validatePassword(thisform.Password, thisform.ConfirmPassword)) {

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
<div class="functionhead"><i18n:label code="STOCKIST_CHANGE_PASSWORD"/></div>
<form name="frmSearch" action="<%=Sys.getControllerURL(StockistManager.TASKID_RESET_USER_PWD,request)%>#btn" method="post" onSubmit="return doSearch(document.frmSearch);">
	<table class="noprint">
		<tr>
			<td align="right"><i18n:label code="STOCKIST_ID"/>:</td>
	    <td><std:stockistid name="StockistID" form="frmSearch"/></td>
		</tr>
	</table>
	
	<br>
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" >
</form>

<hr class=noprint>

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

<c:if test="<%=(canView)%>">

<form name="frmEdit" action="<%=Sys.getControllerURL(StockistManager.TASKID_RESET_USER_PWD_SUBMIT,request)%>" method="post" onSubmit="return confirmProceed(document.frmEdit);">

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
			<td align="right"><b><i18n:label code="GENERAL_REGISTER_DATE"/>:</b></td>
	    	<td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= stockist.getStd_createDate() %>" /></td>
		</tr>
		<tr>
			<td colspan="2" >&nbsp;</td>
  		</tr>
  		<tr>
			<td align="right"><i18n:label code="GENERAL_USERID"/>:</td>
	    	<td><b><%= user.getUserID() %></b></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="GENERAL_NAME"/>:</td>
	    	<td><b><%= user.getName() %></b></td>
		</tr>		
  		<tr>
			<td align="right"><span class="required note">* </span><i18n:label code="GENERAL_PASSWD_NEW"/> (4-10 <i18n:label code="GENERAL_CHAR"/>):</td>
	    	<td><input type="password" name="Password" maxlength="10" size="20" /></td>
		</tr>
  		<tr>
			<td align="right" nowrap><span class="required note">* </span><i18n:label code="GENERAL_PASSWD_CONFIRMNEW"/> (4-10 <i18n:label code="GENERAL_CHAR"/>):</td>
	    	<td><input type="password" name="ConfirmPassword" maxlength="10" size="20" ></td>
		</tr>			
  	</table>

		<br>
		<std:input type="hidden" name="StockistID"/>	
		<std:input type="hidden" name="UserID" value="<%= user.getUserID() %>"/>	
		<input class="textbutton" type="submit" value="<%=lang.display("GENERAL_CHANGE_PASSWD").toUpperCase()%>"> 
		<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_BACK"/>" onClick="location.href='<%=Sys.getControllerURL(StockistManager.TASKID_LIST_USERS, request)%>&StockistID=<%= stockist.getStockistCode() %>'">
  </form>		
</c:if>





</body>
</html>		