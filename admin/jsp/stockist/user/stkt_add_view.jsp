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
	StockistUserBean user = (StockistUserBean) returnBean.getReturnObject(StockistManager.RETURN_STKUSRBEAN_CODE);
	boolean canView = (stockist != null && user!=null);
%>
	  
  <script language="javascript">
  </script>	
  
</head>

<body>

<div class="functionhead">Stockist User</div>
<%@ include file="/lib/return_error_msg.jsp"%>

<c:if test="<%=(canView)%>">

<form name="frmView">

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
			<td align="right"><b><i18n:label code="GENERAL_USERID"/> :</b></td>
	    	<td><%= user.getUserID() %></td>
		</tr>
  		<tr>
			<td align="right"><b><i18n:label code="GENERAL_PASSWORD"/> :</b></td>
	    	<td>**********</td>
		</tr>
		<tr>
			<td align="right"><b><i18n:label code="GENERAL_NAME"/>:</b></td>
	    	<td><%= user.getName() %></td>
		</tr>
		<tr>
			<td align="right"><b><i18n:label code="GENERAL_TYPE"/>:</b></td>
	    	<td><%= StockistManager.defineStockistLvl(user.getLevel()) %></td>
		</tr>		
  	</table>
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_CONT_ADD_USER"/>" onClick="location.href='<%=Sys.getControllerURL(StockistManager.TASKID_ADD_USER,request)%>&StockistID=<%= stockist.getStockistCode() %>'"> 
  </form>		
</c:if>





</body>
</html>		