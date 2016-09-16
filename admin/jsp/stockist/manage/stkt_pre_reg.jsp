<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<%@page import="com.ecosmosis.orca.stockist.StockistManager"%>
<%@page import="com.ecosmosis.orca.member.*"%>
<%@page import="com.ecosmosis.orca.bonus.chi.BonusConstants"%>
<html>
<head>
  <title></title>

<%@ include file="/lib/header.jsp"%>

<%
	int size = 40;
	int memberIDLength = 12;
	
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	MemberBean bean = (MemberBean) returnBean.getReturnObject(MemberManager.RETURN_MBRBEAN_CODE);
	StockistBean stockist = (StockistBean) returnBean.getReturnObject(StockistManager.RETURN_STKBEAN_CODE);
	Integer totalObj = (Integer)returnBean.getReturnObject(StockistManager.RETURN_DOWNLINES_CODE);
	int totalDownlines = (totalObj!=null)?totalObj.intValue():0;
	
	String type = "";
	if(request.getParameter("store")!=null){
		
		type = request.getParameter("store");
	}
	boolean canView = bean != null;
%>
	  
  <script language="javascript">

  function confirmProceed() {
  
      if(confirm('<i18n:label code="MSG_FULLFILL_REQUIRE"/>'))
          return true;
      else
          return false;    
  }		
  function doSearch(thisform) {
			
  	if (!validateMemberId(thisform.MemberID)) {
			alert("<i18n:label code="MSG_INVALID_MEMBERID"/>");
			focusAndSelect(thisform.MemberID);
			return false;
  	}  	    		
  	else
  		return true;
  } 
  </script>	
  
</head>

<body>

<div class="functionhead"><i18n:label code="STOCKIST_APPOINT"/> - <%=StockistManager.defineStockistType(type) %></div>

<form name="frmSearch" action="<%=Sys.getControllerURL(StockistManager.TASKID_PRE_REG_FORM,request)%>#btn" method="post" onSubmit="return doSearch(document.frmSearch);">

	<table class="noprint">
		<tr>
			<td align="right"><i18n:label code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    <td><std:memberid name="MemberID" form="frmSearch"/></td>
		</tr>
	</table>
	
	<br>
	<std:input type="hidden" name="store"/> 
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
</form>

<hr class=noprint>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>



<form name="frmEdit" action="<%=Sys.getControllerURL(StockistManager.TASKID_REG_FORM,request)%>" method="post" onSubmit="return confirmProceed();">

	<table class="tbldata" width="100%">
<c:if test="<%=(stockist!=null)%>">
		<tr>
			<td colspan="2" class="sectionhead"><i18n:label code="STOCKIST_INFO"/></td>
  		</tr>
		<tr>
			<td align="right" width="180"><i18n:label code="STOCKIST_ID"/>:</td>
	    	<td><%= stockist.getStockistCode() %></td>
		</tr>	
		<tr>
			<td align="right"><i18n:label code="GENERAL_NAME"/>:</td>
	    	<td><%= stockist.getName() %></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="GENERAL_TYPE"/>:</td>
	    	<td><%= StockistManager.defineStockistType(stockist.getType()) %></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="GENERAL_REGISTER_DATE"/>:</td>
	    	<td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= stockist.getStd_createDate() %>" /></td>
		</tr>
		<tr>
			<td colspan="2" >&nbsp;</td>
  		</tr>
</c:if>
	
<c:if test="<%=canView%>">
		<tr>
			<td colspan="2" class="sectionhead"><i18n:label code="DISTRIBUTOR_INFO"/></td>
  		</tr>
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    	<td><%= bean.getMemberID() %></td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/>:</td>
			<td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= bean.getJoinDate() %>" /></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MBRSHIP_TYPE%>"/>:</td>
			<td><%= MemberManager.defineMbrType(bean.getType()) %></td>
		</tr>
		<tr valign="top">
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INDIVIDUAL%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.CORPORATION_NAME%>"/>:</td>
			<td><std:text value="<%= bean.getName() %>" defaultvalue="-"/></td>
		</tr>
		<tr valign="top">
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>.:</td>
			<td><std:text value="<%= bean.getIdentityNo() %>" defaultvalue="-"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_DATE%>"/>:</td>
			<td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= (bean.getCompanyRegDate()) %>" /></td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label code="DISTRIBUTOR_UPLINE_ID"/>:</td>
			<td><std:text value="<%= bean.getIntroducerID() %>" defaultvalue="-"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="DISTRIBUTOR_UPLINE_NAME"/>:</td>
			<td><std:text value="<%= bean.getIntroducerName() %>" defaultvalue="-"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="DISTRIBUTOR_UPLINE_CONTACT"/>:</td>
			<td><std:text value="<%= bean.getIntroducerContact()%>" defaultvalue="-"/></td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label code="DISTRIBUTOR_PLACEMENT_ID"/>:</td>
			<td><std:text value="<%= bean.getPlacementID() %>" defaultvalue="-"/></td>
		</tr>
		<tr>
			<td colspan="2" >&nbsp;</td>
  		</tr>
  		<tr>
			<td align="right" width="180"><b><i18n:label code="DISTRIBUTOR_RANK"/>:</b></td>
			<td><std:text value="<%= BonusConstants.defineRank(bean.getBonusRank()) %>" defaultvalue="-"/></td>
		</tr>
  		<tr>
			<td align="right" width="180"><b><i18n:label code="DISTRIBUTOR_TOTAL_DOWNLINES"/>:</b></td>
			<td><%=totalDownlines%></td>
		</tr>		
  		<!-- 
  		<tr>
			<td align="right" width="180"><b>Bonus Info</b></td>
			<td>click to view</td>
		</tr>
		 -->
	</table>
  
	<br>
	
	<std:input type="hidden" name="MemberID"/>
	<std:input type="hidden" name="store"/> 
  
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_PROCEED"/>"> 
	<a name="btn">
</c:if>
</form>


</body>
</html>		