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
	
	boolean canView = stockist != null;
%>
	  
  <script language="javascript">
  
 	function doSubmit() {
		
		thisform = document.frmEdit;
		
		if (!validateText(thisform.Name)) {
			alert("<i18n:label code="MSG_ENTER_NAME"/>");
			focusAndSelect(thisform.Name);
			return false;
		} 
		if (!validateText(thisform.RegistrationInfo)) {
			alert("<i18n:label code="MSG_ENTER_ICNO"/>");
			focusAndSelect(thisform.RegistrationInfo);
			return false;
		}	
   		if (!validateText(thisform.Address1)) {
			alert("<i18n:label code="MSG_ENTER_ADDRESS"/>");
			focusAndSelect(thisform.Address1);
			return false;
		}		
		
		/*if (!validateZipCode(thisform.ZipCode)) {
			alert("Please enter ZipCode.");
			return false;
		} else {
			thisform.MailZipCode.value = thisform.ZipCode.value;
		}*/
		
		if (!validateObj(thisform.CountryID, 1)) {			
			alert("<i18n:label code="MSG_ENTER_COUNTRY"/>");
			return false;
		} 
		
		if (!validateObj(thisform.StateID, 1)) {
			alert("<i18n:label code="MSG_ENTER_STATE"/>");
			return false;
		}
		
		if (!validateObj(thisform.CityID, 0)) {
			alert("<i18n:label code="MSG_ENTER_CITY"/>");
			return false;
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

<div class="functionhead"><i18n:label code="STOCKIST_EDIT_PROFILE"/></div>

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

<c:if test="<%=canView%>">

<form name="frmEdit" action="<%=Sys.getControllerURL(StockistManager.TASKID_EDIT_STOCKIST_SUBMIT,request)%>" method="post" onSubmit="return doSubmit();">
	<table class="tbldata" width="100%">
		
		<tr>
			<td colspan="2" class="sectionhead"><i18n:label code="STOCKIST_INFO"/></td>
  		</tr>
<c:if test="<%=(stockist!=null)%>">
		<tr>
			<td align="right" width="180"><i18n:label code="STOCKIST_ID"/>:</td>
	    	<td><%= stockist.getStockistCode() %></td>
		</tr>	
</c:if>
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    <td><%= stockist.getMemberID() %></td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="STOCKIST_TYPE"/>:</td>
			<td> <b><%=StockistManager.defineStockistType(stockist.getType()) %> </b>				
			</td>
		</tr>
		<tr valign="top">
			<td align="right"><span class="required note">* </span><i18n:label code="GENERAL_NAME"/>:</td>
			<td><std:input type="text" name="Name" value="<%= stockist.getName()%>" size="<%=size%>" maxlength="100"/></td>
		</tr>	
		<tr valign="top">
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>.:</td>
			<td><std:input type="text" name="RegistrationInfo" value="<%= stockist.getRegistrationInfo()%>" size="<%=size%>" maxlength="<%=size%>"/></td>
		</tr>
		    <tr>
			<td colspan="2">&nbsp</td>
		</tr>
	  <%
	     String address1 = stockist.getAddress1();
	     String address2 = stockist.getAddress2();	    	 
	     String zip = stockist.getZipcode();
	     String country = stockist.getCountryID();
	     String state = stockist.getStateID();
	     String city = stockist.getCityID();
	  %>	
		
  	  <tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MAILING_ADD%>"/>:</td>
			<td><std:input type="text" name="Address1" value="<%=address1%>" size="<%= size %>" maxlength="30"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><std:input type="text" name="Address2" value="<%=address2%>" size="<%= size %>" maxlength="30"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ZIP_CODE%>"/>:</td>
			<td><std:input type="text" name="Zipcode" value="<%=zip%>" size="<%= size %>" maxlength="5"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.COUNTRY%>"/>:</td>
			<td><std:input type="select_country" value="<%=country%>" name="CountryID" form="frmEdit"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATE%>"/>:</td>
			<td><std:input type="select_state" value="<%=state%>" name="StateID" form="frmEdit"/></td>
		</tr>
		<tr>
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CITY%>"/>:</td>
			<td><std:input type="select_city" value="<%=city%>" name="CityID" form="frmEdit"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TEL_OFF%>"/>:</td>
			<td><std:input type="text" name="OfficeTel" size="<%= size %>" value="<%=stockist.getOfficeTel()%>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.FAX_NO%>"/>:</td>
			<td><std:input type="text" name="FaxNo" size="<%= size %>" value="<%= stockist.getFaxNo()%>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TEL_HOME%>"/>:</td>
			<td><std:input type="text" name="HomeTel" size="<%= size %>" value="<%= stockist.getHomeTel()%>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MOBILE_NO%>"/>:</td>
			<td><std:input type="text" name="MobileTel" size="<%= size %>" value="<%= stockist.getMobileTel() %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.EMAIL%>"/>:</td>
			<td><std:input type="text" name="Email" size="<%= size %>" value="<%=stockist.getEmail()%>"/></td>
		</tr>
	</table>
  
	<br>
	<std:input type="hidden" name="StockistID"/>
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_EDIT_PROFILE"/>"> 
	<a name="btn">
</form>

</c:if>

</body>
</html>		