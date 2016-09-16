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
	OutletBean outletBean = (OutletBean) returnBean.getReturnObject("Outlet");
	OutletStoreBean[] storeBean = (OutletStoreBean[]) returnBean.getReturnObject("Store");	
%>
<html>
<head>
	<%@ include file="/lib/header.jsp"%>

	<script language="javascript">

		function doSubmit(thisform) 
		{	
			thisform.submit();
		}

	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_INFO%>"/></div>

<form name="frmOutletStoreMng1" action="<%=Sys.getControllerURL(OutletStoreManager.TASKID_OUTLET_STORE_LISTING,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

	<table class="tbldata" width="100%">
		<tr>
			<td colspan="2" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET%>"/></td>
		</tr>
		<tr>
			<td class="td1" width="130"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_ID%>"/>:</td>
			<td><%=outletBean.getOutletID()%><std:input type="hidden" name="OutletID" value="<%=outletBean.getOutletID()%>"/></td>
		</tr>
		<tr>
			<td class="td1"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_NAME%>"/>:</td>
			<td><%=outletBean.getName()%></td>
		</tr>
		<tr>
			<td height="15"></td>
		</tr>
		<tr>
			<td colspan="2" class="sectionhead"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_STORE_DETAILS%>"/></td>
		</tr>
		<%
		for (int i=0;i<storeBean.length;i++) { 
		
			String warehouse = storeBean[i].getWarehouseStoreCode();
			String sales = storeBean[i].getSalesStoreCode();
			String writeoff = storeBean[i].getWriteoffStoreCode();
		%>
		<tr>
			<td class="td1"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_STORE_CODE%>"/> : </td>
			<td><%= storeBean[i].getStoreID() %></td>
		</tr>
		<tr>
			<td class="td1" valign="top"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.ROLES%>"/> :</td>
			<td>
				<%= warehouse==null? "" : warehouse %><%= warehouse==null? "" : "<br>" %>
				<%= sales==null? "" : sales %><%= sales==null? "": "<br>" %>
				<%= writeoff==null? "" : writeoff %>
				<%= warehouse==null&&sales==null&&writeoff==null? "--" : "" %>
			</td>
		</tr>
		<tr>
			<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/> : </td>
			<td><%= storeBean[i].getStatus() %></td>
		</tr>
		<%
		}
		%>
	</table>
	<br><br>
	<input class="textbutton" type="button" value="Back" onClick="doSubmit(this.form);">
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	
</form>
</html>