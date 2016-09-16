<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<%@page import="com.ecosmosis.orca.stockist.StockistManager"%>
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
	boolean canView = stockist != null;
%>
	  
  <script language="javascript">

  function confirmProceed(thisform) {
  	if(!validateStockistUserId(thisform.UserID)){
  		
  		alert("<i18n:label code="MSG_INVALID_USERID"/>");
		focusAndSelect(thisform.UserID);
		return false;
  	}
  	
   	if (!countPassword(thisform.Password)) {

			return false;
  	}

	if (!countPassword(thisform.ConfirmPassword)) {

			return false;
  	}
  	
  	if (!validatePassword(thisform.Password, thisform.ConfirmPassword)) {

			return false;
  	}
  	
	if(thisform.Name.value == ''){
  		
  		alert("<i18n:label code="MSG_INVALID_NAME"/>");
  		focusAndSelect(thisform.Name);
		return false;
  	}  	  	
  	
	if(confirm('<i18n:label code="MSG_CONFIRM_CREATE_USER"/> <%=((stockist!=null)?stockist.getStockistCode():"")%>?'))
	    return true;
	else
	    return false;    
  }		
  function doSearch(thisform) {
			
  	if (!validateStockistId(thisform.StockistID)) {
			alert("<i18n:label code="MSG_INVALID_STOCKISTID"/>");
			focusAndSelect(thisform.StockistID);
			return false;
  	} 
  	else
  		return true;
  } 
  function checkUserIDAvailability(thisform) {
	
	if(!validateStockistUserId(thisform.UserID)){
  		
  		alert("<i18n:label code="MSG_INVALID_USERID"/>");
		focusAndSelect(thisform.UserID);
		return;
		
  	}else{  	
	  	var link = '<%=Sys.getControllerURL(StockistManager.TASKID_CHECK_USER_EXIST,request)%>' + 
					'&StockistID=<%=((stockist!=null)?stockist.getStockistCode():"")%>' + 
					'&UserID=' + thisform.UserID.value;
		window.open(link,'CheckUserID','menubr=no,resizable=no,toolbar=no,scrollbars=no,status=no,width=360,height=200,screenX=0,screenY=0');
		return;	
  	}  	
  } 
  </script>	
  
</head>

<body>

<div class="functionhead"><i18n:label code="STOCKIST_CREATE_USER"/></div>

<form name="frmSearch" action="<%=Sys.getControllerURL(StockistManager.TASKID_ADD_USER,request)%>#btn" method="post" onSubmit="return doSearch(document.frmSearch);">

	<table class="noprint">
		<tr>
			<td align="right"><i18n:label code="STOCKIST_ID"/>:</td>
	    <td><std:stockistid name="StockistID" form="frmSearch"/></td>
		</tr>
	</table>
	
	<br>
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
</form>

<hr class=noprint>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>


<c:if test="<%=(canView)%>">

<form name="frmEdit" action="<%=Sys.getControllerURL(StockistManager.TASKID_ADD_USER_SUBMIT,request)%>" method="post" onSubmit="return confirmProceed(document.frmEdit);">

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
			<td align="right"><span class="required note">* </span><i18n:label code="GENERAL_USERID"/> (4-10 <i18n:label code="GENERAL_CHAR"/>):</td>
	    	<td><std:input type="text" name="UserID" maxlength="10" size="20" /> <small>(<i18n:label code="GENERAL_ALPHABET ONLY"/>) 
	    	<a href="Javascript:checkUserIDAvailability(document.frmEdit);" > <i18n:label code="GENERAL_CHECK_AVAILABILITY"/></a></small></td>
		</tr>
  		<tr>
			<td align="right"><span class="required note">* </span><i18n:label code="GENERAL_PASSWD_NEW"/> (4-10 <i18n:label code="GENERAL_CHAR"/>):</td>
	    	<td><input type="password" name="Password" maxlength="10" size="20" /></td>
		</tr>
  		<tr>
			<td align="right" nowrap><span class="required note">* </span><i18n:label code="GENERAL_PASSWD_CONFIRMNEW"/> (4-10 <i18n:label code="GENERAL_CHAR"/>):</td>
	    	<td><input type="password" name="ConfirmPassword" maxlength="10" size="20" ></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label code="GENERAL_NAME"/>:</td>
	    	<td><std:input type="text" name="Name" maxlength="100" size="40" /></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label code="GENERAL_TYPE"/>:</td>
	    	<td><std:input type="select" name="Level" options="<%=usrLvls%>"/></td>
		</tr>		
  	</table>

		<br>
		<std:input type="hidden" name="StockistID"/>	
		<std:input type="hidden" name="Status" value="<%= StockistManager.USRTYPE_ACTIVE %>"/>	
		<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>"> 
		<a name="btn">	
  </form>		
</c:if>





</body>
</html>		