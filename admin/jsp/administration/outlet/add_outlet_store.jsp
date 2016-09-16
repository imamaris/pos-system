<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.outlet.store.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	OutletBean[] beans = (OutletBean[]) returnBean.getReturnObject("OutletList");
	boolean canView = true;
%>
<html>
<head>
	<%@ include file="/lib/header.jsp"%>

	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			if (thisform.OutletID.value == "default") {
					alert("<i18n:label code="MSG_SELECT_OUTLET"/>");
					thisform.OutletID.focus();
					return;
			}
			if (!validateText(thisform.tempStoreID)) {
					alert("<i18n:label code="MSG_ENTER_STOREID"/>");
					thisform.tempStoreID.focus();
					return;
			}    
			thisform.submit();
		}
		
		function check(thisform)
		{
			var outlet = thisform.OutletID.value;
			var store = thisform.tempStoreID.value;
			var outletstore = '';
			
			if(outlet != 'default')
			    outletstore = outlet+"-"+store;
			    
			thisform.StoreID.value = outletstore;			
			lblStoreID.innerText = outletstore;
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.ADD_OUTLET_STORE%>"/></div>

<form name="frmOutletStoreReg" action="<%=Sys.getControllerURL(OutletStoreManager.TASKID_OUTLET_STORE_ADD,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>
 
<p class="required note">* <i18n:label code="GENERAL_REQUIRED_FIELDS"/></p>

<% if (canView) { %>  

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
				  	<tr>
						<td colspan="2" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_STORE_DETAILS%>"/></td>
			  	  	</tr>
			  	  	<tr>
			  			<td class="td1" width="130"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_ID%>"/>:</td>
			      		<td>
			      			<select name="OutletID" onChange='check(this.form);'>
			      				<option value="default" selected >[<i18n:label code="OUTLET_SELECT"/>]</option>
			      				<%
								for (int i=0;i<beans.length;i++) { 
								%>
								<option value="<%=beans[i].getOutletID()%>"><%=beans[i].getOutletID()%> - <%=beans[i].getName()%></option>
								<%
								} // end for
								%>
			      			</select>
			      		</td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="130"><span class="required note">* </span><i18n:label code="STORE_ID"/>:</td>
			      		<td><input type="text" size="5" maxlength="3" name="tempStoreID" onKeyUp='check(this.form)'"> <small><i18n:label code="GENERAL_EG"/> 001</small></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="130"><i18n:label code="OUTLET_FULL_STOREID"/>:</td>
			      		<td><LABEL id="lblStoreID"></LABEL>
			      		<std:input type="hidden" name="StoreID"/>
			      		</td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="130"><i18n:label code="GENERAL_STATUS"/>:</td>
			      		<td>
			      			<select name="Status">
			      				<option value="A"><i18n:label code="GENERAL_ACTIVE"/></option>
			      				<option value="I"><i18n:label code="GENERAL_INACTIVE"/></option>
			      			</select>
			      		</td>
			  		</tr>
			  	</table>
			</td>
		</tr>	
	</table>
<% } // end if canView %>	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="" value=""/> 

	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);">
  	<input class="textbutton" type="reset" value="<i18n:label code="GENERAL_BUTTON_RESET"/>">
  	
</form>
</html>