<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.outlet.store.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>

<%
	String outletSel = request.getParameter("OutletID");
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	OutletBean[] outletListbeans = (OutletBean[]) returnBean.getReturnObject("OutletList");
	OutletStoreBean[] storeListBean = (OutletStoreBean[]) returnBean.getReturnObject("StoreListing");
	boolean canView = false;
	
	if (storeListBean != null)
	{
		canView = true;
	}
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
			thisform.submit();
		}
		
		function check(thisform)
		{
			var outlet = thisform.OutletID.value;
			var store = thisform.tempStoreID.value;
			var outletstore = outlet+"-"+store;
			thisform.StoreID.value = outletstore;
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_STORE_LISTING%>"/></div>

<form name="frmOutletStoreReg" action="<%=Sys.getControllerURL(OutletStoreManager.TASKID_OUTLET_STORE_LISTING,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

	<table class="tbldata" width="750">
		<tr>
			<td><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET%>"/>:
			    <select name="OutletID">
			      	<option value="default" selected>[<i18n:label code="OUTLET_SELECT"/>]</option>
			      	<%
					for (int i=0;i<outletListbeans.length;i++) { 
						String selected = "";
						if (outletListbeans[i].getOutletID().equals(outletSel))
							selected = "selected";
					%>
					<option value="<%=outletListbeans[i].getOutletID()%>"<%= selected %>><%=outletListbeans[i].getOutletID()%> - <%=outletListbeans[i].getName()%></option>
					<%
					} // end for
					%>
			    </select>
			 </td>
		</tr>
		<tr>
			<td class=""><br><input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSubmit(this.form);"><br><br></td>
		</tr>
	</table>	

<% if (canView) { %>  

	<table class="listbox" width="53%">
		<tr class="boxhead" valign=top>
			<td width="20%"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_STORE_CODE%>"/></td>
			<td width="20%"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.ROLES%>"/></td>
			<td width="10%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/></td>
			<td width="3%"></td>
		</tr>
		<%
		for (int i=0;i<storeListBean.length;i++) { 
			
			String rowCss = "";
  		  	
  		  	if((i+1) % 2 == 0)
  	      		rowCss = "even";
  	      	else
  	        	rowCss = "odd";
		
			String warehouse = storeListBean[i].getWarehouseStoreCode();
			String sales = storeListBean[i].getSalesStoreCode();
			String writeoff = storeListBean[i].getWriteoffStoreCode();
		%>
		<tr class="<%=rowCss%>" align="center" valign=top>
			<td><%= storeListBean[i].getStoreID() %>
				<!-- a href="<%=Sys.getControllerURL(OutletStoreManager.TASKID_OUTLET_STORE_INFO,request)%>&storeid=<%=storeListBean[i].getStoreID()%>&outletid=<%=storeListBean[i].getOutletID()%>">
					<%= storeListBean[i].getStoreID() %>
				</a // -->
			</td>
			<td>
				<%= warehouse==null? "" : warehouse %><%= warehouse==null? "" : "<br>" %>
				<%= sales==null? "" : sales %><%= sales==null? "": "<br>" %>
				<%= writeoff==null? "" : writeoff %>
				<%= warehouse==null&&sales==null&&writeoff==null? "--" : "" %>
			</td>
			<td><%= storeListBean[i].getStatus() %></td>
			<td>
				<a href="<%=Sys.getControllerURL(OutletStoreManager.TASKID_OUTLET_STORE_EDIT,request)%>&storeid=<%=storeListBean[i].getStoreID()%>&outletid=<%=storeListBean[i].getOutletID()%>">
					<img border="0" alt='<i18n:label code="STORE_EDIT"/>' src="<%= Sys.getWebapp() %>/img/icon_edit.gif"/>
				</a>
			</td>
		</tr>
		<%
		}
		%>
	</table>

<% } // end if canView %>
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="" value=""/> 
  	
</form>
</html>