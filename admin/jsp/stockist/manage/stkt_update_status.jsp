<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<%@page import="com.ecosmosis.orca.stockist.StockistManager"%>
<html>
<head>
  <title></title>

<%@ include file="/lib/header.jsp"%>
<%@ include file="/lib/select_locations.jsp"%>

<%
	int size = 40;
	
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	StockistBean stockist = (StockistBean) returnBean.getReturnObject(StockistManager.RETURN_STKBEAN_CODE);
	Map status = (Map) returnBean.getReturnObject(StockistManager.RETURN_STKSTATUS_CODE);
	
	boolean canView = stockist != null;
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
   
 	function doSubmit() {
		
		thisform = document.frmEdit;

		if (!validateObj(thisform.Status, 1)) {			
			alert("<i18n:label code="MSG_SELECT_STATUS"/>");
			return false;
		}
		
		if(thisform.Remark.value.length == 0){
		    thisform.Remark.value = thisform.CurrentRemark.value;
		}
		if(confirmProceed())		
			return true;
		else
		   return false;	
	}
		
	function confirmProceed() {
	
	    if(confirm('<i18n:label code="MSG_PROCEED_CHANGE"/>'))
	        return true;
	    else
	        return false;    
	}

  </script>	
  
</head>

<body>

<div class="functionhead"><i18n:label code="STOCKIST_MANAGE_ACCT"/></div>
<form name="frmSearch" action="<%=Sys.getControllerURL(StockistManager.TASKID_STATUS_UPDATE,request)%>#btn" method="post" onSubmit="return doSearch(document.frmSearch);">
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

<c:if test="<%=canView%>">

<form name="frmEdit" action="<%=Sys.getControllerURL(StockistManager.TASKID_STATUS_UPDATE,request)%>" method="post" onSubmit="return doSubmit();">
	<table class="tbldata" width="100%">
		
		<tr>
			<td colspan="2" class="sectionhead"><i18n:label code="STOCKIST_INFO"/></td>
  		</tr>
<c:if test="<%=(stockist!=null)%>">
		<tr>
			<td align="right" width="180"><i18n:label code="STOCKIST_ID"/>:</td>
	    	<td><b><%= stockist.getStockistCode() %></b></td>
		</tr>	
</c:if>
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    <td><%= stockist.getMemberID() %></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="STOCKIST_TYPE"/>:</td>
			<td> <%=StockistManager.defineStockistType(stockist.getType()) %> 			
			</td>
		</tr>
		<tr valign="top">
			<td align="right"><i18n:label code="GENERAL_NAME"/>:</td>
			<td><%= stockist.getName()%></td>
		</tr>	
		<tr valign="top">
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>.:</td>
			<td><%= stockist.getRegistrationInfo()%></td>
		</tr>
		<tr valign="top">
			<td align="right"><i18n:label code="GENERAL_STATUS_CURRENT"/>:</td>
			<td><b><%= StockistManager.defineStockistStatus(stockist.getStatus())%></b>	</td>
		</tr>
		<tr valign="top">
			<td align="right"><i18n:label code="GENERAL_REMARK_CURRENT"/>:</td>
			<td><b><std:text value="<%=stockist.getRemark()%>" defaultvalue="-"/>
			<std:input type="hidden" value="<%=stockist.getRemark()%>" name="CurrentRemark"/>
			</td>
		</tr>
		<tr valign="top">
			<td align="right"><i18n:label code="GENERAL_CHANGED_BY"/>:</td>
			<td><std:text value="<%= stockist.getStd_modifyBy()%>" defaultvalue="-"/> <fmt:formatDate pattern="<%=loginUser.getDateformat()%>" value="<%= stockist.getStd_modifyDate()%>" /></td>
		</tr>

		</tr>
		    <tr>
			<td colspan="2">&nbsp</td>
		</tr>

		<tr>
			<td align="right"><span class="required note">* </span><i18n:label code="GENERAL_ACCOUNT_STATUS"/>:</td>
			<td><std:input type="select" name="Status" options="<%=status %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="GENERAL_REMARK"/>:</td>
			<td><textarea name="Remark" rows="5" cols="50"></textarea></td>
		</tr>
	</table>
  
	<br>
	<std:input type="hidden" name="StockistID"/>
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>"> 
	<a name="btn">
</form>

</c:if>

</body>
</html>		