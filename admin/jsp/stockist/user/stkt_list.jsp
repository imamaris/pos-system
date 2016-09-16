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

	boolean canView = stockist != null;
%>
	  
  <script language="javascript">
 
  function doSearch(thisform) {
			
  	if (!validateStockistId(thisform.StockistID)) {
			alert("<i18n:label code="MSG_INVALID_STOCKISTID"/>");
			focusAndSelect(thisform.StockistID);
			return false;
  	} 
  	else
  		return true;
  } 

  </script>	
  
</head>

<body>

<div class="functionhead"><i18n:label code="STOCKIST_USER_LIST"/></div>

<form name="frmSearch" action="<%=Sys.getControllerURL(StockistManager.TASKID_LIST_USERS, request)%>" method="post" onSubmit="return doSearch(document.frmSearch);">

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

<form name="frmList" method="post">

	<table class="tbldata" width="60%">
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
  	</table>
  	
	<c:if test="<%=(stockist.getUserList().length > 0)%>">
	  	<table class="listbox" width="60%">
		
		<tr class="boxhead" valign=top>
			<td width="5%" align=right><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>" />.</td>
			<td width="10%" nowrap><i18n:label code="GENERAL_USERID"/></td>
			<td align="left"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>" /></td>		
			<td width="15%"  align="left"><i18n:label code="GENERAL_TYPE"/></td>
			<td width="10%"><i18n:label code="GENERAL_STATUS"/></td>		
			<td width="5%">&nbsp;</td>	
			<td width="5%">&nbsp;</td>	
		</tr>
		<% 
			for(int i=0; i< stockist.getUserList().length; i++){
		%>
		<tr class="<%=(i % 2 == 0)?"even":"odd"%>" valign=top>
			<td width="5%" align=right><%= (i+1) %>.</td>
			<td width="10%"><%=(stockist.getUserList()[i].getUserID())%></td>
			<td><%=(stockist.getUserList()[i].getName())%></td>		
			<td width="10%"><%=StockistManager.defineStockistLvl(stockist.getUserList()[i].getLevel())%></td>
			<td width="10%"  align="center"><%=StockistManager.defineStockistUserStatus(stockist.getUserList()[i].getStatus())%></td>		
			<td align=center nowrap><std:link text="edit" taskid="<%=StockistManager.TASKID_EDIT_USER%>" params="<%=("UserID=" + stockist.getUserList()[i].getUserID() +"&StockistID=" + stockist.getStockistRunningID())%>" /></td>
			<td align=center nowrap>
			<std:link text="<%=lang.display("GENERAL_BUTTON_RESET").toLowerCase()%>" taskid="<%=StockistManager.TASKID_RESET_USER_PWD%>" params="<%=("UserID=" + stockist.getUserList()[i].getUserID() +"&StockistID=" + stockist.getStockistRunningID())%>" />
			</td>
		</tr>
		<%	}//end for %>
		
		</table>
		<br>
		<input class="noprint" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">
		
	</c:if>
  	
  </form>		
</c:if>





</body>
</html>		