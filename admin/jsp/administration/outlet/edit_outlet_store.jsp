<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.outlet.store.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	OutletBean outlet = (OutletBean) returnBean.getReturnObject("Outlet");
	OutletStoreBean[] store = (OutletStoreBean[]) returnBean.getReturnObject("Store");
	boolean canView = true;
%>
<html>
<head>
	<%@ include file="/lib/header.jsp"%>

	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			if (thisform.Status.value == "default") {
					alert("<i18n:label code="MSG_SELECT_STATUS"/>");
					thisform.Status.focus();
					return;
			}
			else
				thisform.submit();
		}
		function insert() {
			var thisform = frmOutletStoreEdit;
			var status = thisform.hidStatus.value;
			if (status == "Active")
				thisform.Status.value = "A";
			else
				thisform.Status.value = "I";
		}
	</script>
</head>

<body onLoad="self.focus(); insert();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.EDIT_OUTLET_STORE%>"/></div>

<form name="frmOutletStoreEdit" action="<%=Sys.getControllerURL(OutletStoreManager.TASKID_OUTLET_STORE_EDIT,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

<% if (canView) { %>  

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
				  	<tr>
						<td colspan="2" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET%>"/></td>
			  	  	</tr>
			  	  	<tr>
			  			<td class="td1" width="130"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_ID%>"/>:</td>
			      		<td><%= outlet.getOutletID() %><std:input type="hidden" name="OutletID" value="<%= outlet.getOutletID() %>" /></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="130"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.STORE_ID%>"/>:</td>
			      		<td><%= outlet.getName() %></td>
			  		</tr>
			  		<tr>
			  			<td height="15"></td>
			      	</tr>
					<tr>
						<td colspan="2" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_STORE_DETAILS%>"/></td>
			  	  	</tr>
			  	  	<%
					for (int i=0;i<store.length;i++) { 
						String warehouse = store[i].getWarehouseStoreCode();
						String sales = store[i].getSalesStoreCode();
						String writeoff = store[i].getWriteoffStoreCode();
					%>
			  		<tr>
			  			<td class="td1" width="130"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_STORE_CODE%>"/>:</td>
			      		<td><%= store[i].getStoreID() %><std:input type="hidden" name="StoreID" value="<%= store[i].getStoreID() %>" /></td>
			  		</tr>
			  		<std:input type="hidden" name="hidStatus" value="<%= store[i].getStatus() %>"/>
			  		<tr>
						<td class="td1" valign="top" width="130"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.ROLES%>"/> :</td>
						<td>
							<%= warehouse==null? "" : warehouse + "<input type='hidden' name='Warehouse' value='true'>" %><%= warehouse==null? "" : "<br>" %>
							<%= sales==null? "" : sales + "<input type='hidden' name='Sales' value='true'>" %><%= sales==null? "": "<br>" %>
							<%= writeoff==null? "" : writeoff + "<input type='hidden' name='Writeoff' value='true'>" %>
							<%= warehouse==null&&sales==null&&writeoff==null? "--" : "" %>
						</td>
					</tr>
			  		<tr>
			  			<td class="td1" width="130"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
			      		<td>
			      			<select name="Status">
			      				<option value="default" selected>[<i18n:label code="STATUS_SELECT"/>]</option>
			      				<option value="A"><i18n:label code="GENERAL_ACTIVE"/></option>
			      				<option value="I"><i18n:label code="GENERAL_INACTIVE"/></option>
			      			</select>
			      		</td>
			  		</tr>
			  		<%
					} // end for
					%>
			  	</table>
			</td>
		</tr>	
	</table>
<% } // end if canView %>	
	<br><br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="" value=""/> 

	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);">
  	<input class="textbutton" type="reset" value="<i18n:label code="GENERAL_BUTTON_RESET"/>">
  	
</form>
</html>