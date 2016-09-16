<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<%@page import="com.ecosmosis.orca.stockist.StockistManager"%>
<%@page import="com.ecosmosis.orca.member.*"%>
<%@page import="com.ecosmosis.orca.bean.AddressBean"%>
<html>
<head>
  <title></title>

<%@ include file="/lib/header.jsp"%>
<%@ include file="/lib/select_locations.jsp"%>

<%
	int size = 40;
	
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	MemberBean bean = (MemberBean) returnBean.getReturnObject(MemberManager.RETURN_MBRBEAN_CODE);
	StockistBean stockist = (StockistBean) returnBean.getReturnObject(StockistManager.RETURN_STKBEAN_CODE);
	
	boolean canView = bean != null;
	boolean isUpgrade = stockist != null;
	
	if(request.getParameter("SubmitB4")!=null){
		
		isUpgrade = false;
	}

	String type = "";
	if(request.getParameter("store")!=null){
		
		type = request.getParameter("store");
	}
%>
	  
  <script language="javascript">
  
 	function doSubmit() {
		
		thisform = document.frmEdit;
		
		if (!validateStockistIdOnlyNumbers(thisform.StockistRunningID)) {
			alert("<i18n:label code="MSG_INVALID_STOCKISTID_REG"/>");
			focusAndSelect(thisform.StockistRunningID);
			return false;
		}		
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
		
		if(confirmProceed()){
		
			document.getElementById('btnSubmit').disabled = true;	
			return true;
		}else
		   return false;	
	}
		
  function confirmProceed() {
  
      if(confirm('<i18n:label code="MSG_PROCEED_REGISTER"/>'))
          return true;
      else
          return false;    
  }	
  
  </script>	
  
</head>

<body onLoad="self.focus();<%=((isUpgrade)?"":"document.frmEdit.StockistRunningID.focus();")%>">

<div class="functionhead"><i18n:label code="STOCKIST_APPOINT"/> > <i18n:label code="GENERAL_REGISTER_FORM"/> (<%=StockistManager.defineStockistType(type) %>)</div>

<%@ include file="/lib/return_error_msg.jsp"%>

<c:if test="<%=canView%>">

<form name="frmEdit" action="<%=Sys.getControllerURL(StockistManager.TASKID_SUBMIT_REG,request)%>" method="post" onSubmit="return doSubmit();">
	<table class="tbldata" width="100%">
		
		<tr>
			<td colspan="2" class="sectionhead"><i18n:label code="STOCKIST_INFO"/></td>
  		</tr>
		<tr>
			<td align="right" width="180"><i18n:label code="STOCKIST_ID"/>:</td>
	    	<td><b><%=(type) %> 
	    	<%if(!isUpgrade){ %>
		    	<std:input name="StockistRunningID" type="text" maxlength="5" value="<%=((stockist!=null)?stockist.getStockistRunningID():"")%>"/></td>
		    <%}else{ %>	
		    	<%=stockist.getStockistRunningID()%>
		    	<std:input name="StockistRunningID" type="hidden" value="<%=stockist.getStockistRunningID()%>"/>
		    <%}%>
		    </b>	
		</tr>	
		<tr>
			<td align="right"><i18n:label code="STOCKIST_TYPE"/>:</td>
			<td> <b><%=StockistManager.defineStockistType(type) %> </b>				
			</td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    	<td><b><%= bean.getMemberID() %></b></td>
		</tr>		
		<tr valign="top">
			<td align="right"><span class="required note">* </span><i18n:label code="GENERAL_NAME"/>:</td>
			<td><std:input type="text" name="Name" value="<%= (stockist!=null)?stockist.getName():bean.getName() %>" size="<%=size%>" maxlength="100"/></td>
		</tr>	
		<tr valign="top">
			<td align="right"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>.:</td>
			<td><std:input type="text" name="RegistrationInfo" value="<%= (stockist!=null)?stockist.getRegistrationInfo():bean.getIdentityNo() %>" size="<%=size%>" maxlength="<%=size%>"/></td>
		</tr>
		    <tr>
			<td colspan="2">&nbsp</td>
		</tr>
	  <%
	     AddressBean address = bean.getAddress();
	     String zip = "";
	     String country = "";
	     String state = "";
	     String city = "";
	     String address1 = "";
	     String address2 = "";
	     
	     if(address!=null){
	    	 
	    	 address1 = (stockist!=null)?stockist.getAddress1():address.getAddressLine1();
	    	 address2 = (stockist!=null)?stockist.getAddress2():address.getAddressLine2();	    	 
	    	 zip = (stockist!=null)?stockist.getZipcode():address.getZipCode();
	    	 country = (stockist!=null)?stockist.getCountryID():address.getCountryID();
	    	 state = (stockist!=null)?stockist.getStateID():address.getStateID();
	    	 city = (stockist!=null)?stockist.getCityID():address.getCityID();
	     }
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
			<td><std:input type="text" name="OfficeTel" size="<%= size %>" value="<%=(stockist!=null)?stockist.getOfficeTel():bean.getOfficeNo() %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.FAX_NO%>"/>:</td>
			<td><std:input type="text" name="FaxNo" size="<%= size %>" value="<%= (stockist!=null)?stockist.getFaxNo():bean.getFaxNo() %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TEL_HOME%>"/>:</td>
			<td><std:input type="text" name="HomeTel" size="<%= size %>" value="<%= (stockist!=null)?stockist.getHomeTel():bean.getHomeNo() %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MOBILE_NO%>"/>:</td>
			<td><std:input type="text" name="MobileTel" size="<%= size %>" value="<%= (stockist!=null)?stockist.getMobileTel():bean.getMobileNo() %>"/></td>
		</tr>
		<tr>
			<td align="right"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.EMAIL%>"/>:</td>
			<td><std:input type="text" name="Email" size="<%= size %>" value="<%=(stockist!=null)?stockist.getEmail():bean.getEmail() %>"/></td>
		</tr>
	</table>
  
	<br>
	
	<std:input type="hidden" name="Type" value="<%= type %>"/>
	<std:input type="hidden" name="SubmitB4" value="y"/>
	<std:input type="hidden" name="store" value="<%= type %>"/>
	<std:input type="hidden" name="MemberID"/> 
  
	<input id="btnSubmit"  class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_APPOINT"/>"> 
	<a name="btn">
</form>

</c:if>

</body>
</html>		