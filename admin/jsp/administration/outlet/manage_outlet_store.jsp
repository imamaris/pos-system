<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.outlet.store.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="java.util.*"%>

<%
	String outletSel = request.getParameter("OutletID");
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	OutletBean outletBean = (OutletBean) returnBean.getReturnObject("Outlet");
	OutletBean[] outletListBean = (OutletBean[]) returnBean.getReturnObject("OutletList");
	OutletStoreBean[] storeListBean = (OutletStoreBean[]) returnBean.getReturnObject("StoreListing");
	
	boolean canView = false;
	
	int editCnt = 0;
	
	if (outletBean!=null && storeListBean != null)
		canView = true;
%>
<html>
<head>
	<%@ include file="/lib/header.jsp"%>

	<script language="javascript">
	
		function chkSubmit(thisform) 
		{	
			if (thisform.OutletID.value == "default") {
					alert("<i18n:label code="MSG_SELECT_OUTLET"/>");
					thisform.OutletID.focus();
					return false;
			} else {
				return true;
			}
		}
		function doxSubmit(thisform) 
		{			
		    if(thisform.WarehouseStoreCode.options!=null){
		    
			    var warehouse = thisform.WarehouseStoreCode.options[thisform.WarehouseStoreCode.selectedIndex].value;
				if ( warehouse != null && warehouse == "default") {
						alert("<i18n:label code="MSG_SELECT_WAREHOUSE"/>");
						thisform.WarehouseStoreCode.focus();
						return;
				}
				var sales = thisform.SalesStoreCode.options[thisform.SalesStoreCode.selectedIndex].value;
				if (sales != null && sales == "default") {
						alert("<i18n:label code="MSG_SELECT_SALESSTORE"/>");
						thisform.SalesStoreCode.focus();
						return;
				}
				var writeoff = thisform.WriteoffStoreCode.options[thisform.WriteoffStoreCode.selectedIndex].value;		
				if (writeoff != null && writeoff == "default") {
						alert("<i18n:label code="MSG_SELECT_WRITEOFF"/>");
						thisform.WriteoffStoreCode.focus();
						return;
				}
		    }			
			thisform.submit();
		}
		function doSubmit(thisform) 
		{	
			thisform.submit();
		}
		function insert() {
			var thisform = frmOutletStoreMng2;
			var warehouse = thisform.hidWarehouse.value;
			var sales = thisform.hidSales.value;
			var writeoff = thisform.hidWriteoff.value;
			thisform.WarehouseStoreCode.value = warehouse;
			thisform.SalesStoreCode.value = sales;
			thisform.WriteoffStoreCode.value = writeoff;
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.MANAGE_OUTLET_STORE%>"/></div>

<form name="frmOutletStoreMng1" action="<%=Sys.getControllerURL(OutletStoreManager.TASKID_OUTLET_STORE_MANAGE,request)%>" method="post" onSubmit="return chkSubmit(document.frmOutletStoreMng1);">

<%@ include file="/lib/return_error_msg.jsp"%>
	
	<table width="100%">
		<tr>
			<td><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET%>"/>:
			    <select name="OutletID">
			      	<option value="default" selected>[<i18n:label code="OUTLET_SELECT"/>]</option>
			      	<%
					for (int i=0;i<outletListBean.length;i++) { 
						String selected = "";
						if (outletListBean[i].getOutletID().equals(outletSel))
							selected = "selected";
					%>
					<option value="<%=outletListBean[i].getOutletID()%>" <%= selected %>><%=outletListBean[i].getOutletID()%> - <%=outletListBean[i].getName()%></option>
					<%
					} // end for
					%>
			    </select>&nbsp;&nbsp;
			</td>
		</tr>
		<tr><td><br><input type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" ></td></tr>
	</table>
	<br>
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
</form>

<% if (canView) { %>
<form name="frmOutletStoreMng2" action="<%=Sys.getControllerURL(OutletStoreManager.TASKID_OUTLET_STORE_MANAGE,request)%>" method="post">
	<table width="100%">
		<tr>
			<td align="left">
			  	<table width="100%">
			  		<tr>
						<td colspan="2" class="sectionhead"><i18n:label code="<%=OutletMessageTag.OUTLET_STORE_DETAILS%>"/></td>
			  	  	</tr>
			  		<tr>
			  			<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_ID%>"/>:</td>
			      		<td><%=outletBean.getOutletID()%><std:input type="hidden" name="OutletID" value="<%=outletBean.getOutletID()%>"/></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET_NAME%>"/>:</td>
			      		<td><%=outletBean.getName()%></td>
			  		</tr>
			  		<%
			  		if (true)//(outletBean.getWarehouseStore() == null || outletBean.getWarehouseStore().getStatus() != "Active")
			  		{
			  		%>
			  		<tr>
			  			<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.WAREHOUSE%>"/>:</td>
			  			<td>
			      			<select name="WarehouseStoreCode">
			      				<option value="default" selected>[<i18n:label code="STORE_SELECT"/>]</option>
			      				<%
								for (int i=0;i<storeListBean.length;i++) { 
									
									String isSelected = "";
									if(storeListBean[i].getStoreID().equals(outletBean.getWarehouseStoreCode()))
										isSelected = "selected";
								%>
								<option value="<%=storeListBean[i].getStoreID()%>" <%=isSelected%>><%=storeListBean[i].getStoreID()%></option>
								<%
								} // end for
								%>
			      			</select>
			      		</td>
			  		</tr>
			  		<%
			  		} else {
			  			editCnt++;
			  		%>
			  		<tr>
			  			<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.WAREHOUSE%>"/>:</td>
			      		<td><%=outletBean.getWarehouseStoreCode()%><input type="hidden" name="WarehouseStoreCode" value="<%=outletBean.getWarehouseStoreCode()%>"/></td>
			  		</tr>
			  		<%
			  		}
			  		%>
			  		
			  		<%
			  		if(true)// (outletBean.getSalesStore() == null || outletBean.getSalesStore().getStatus() != "Active")
			  		{
			  		%>
			  		<tr>
			  			<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.SALES%>"/>:</td>
			  			<td>
			      			<select name="SalesStoreCode">
			      				<option value="default" selected>[<i18n:label code="STORE_SELECT"/>]</option>
								<%
								for (int i=0;i<storeListBean.length;i++) { 
									
									String isSelected = "";
									if(storeListBean[i].getStoreID().equals(outletBean.getSalesStoreCode()))
										isSelected = "selected";
								%>
								<option value="<%=storeListBean[i].getStoreID()%>" <%=isSelected%>><%=storeListBean[i].getStoreID()%></option>
								<%
								} // end for
								%>
			      			</select>
			      		</td>
			  		</tr>
			  		<%
			  		} else {
			  			editCnt++;
			  		%>
			  		<tr>
			  			<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.SALES%>"/>:</td>
			      		<td><%=outletBean.getSalesStoreCode()%><input type="hidden" name="SalesStoreCode" value="<%=outletBean.getSalesStoreCode()%>"/></td>
			  		</tr>
			  		<%
			  		}
			  		%>
			  		
			  		<%
			  		if(true)// (outletBean.getWriteoffStore() == null || outletBean.getWriteoffStore().getStatus() != "Active")
			  		{
			  		%>
			  		<tr>
			  			<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.WRITEOFF%>"/>:</td>
			  			<td>
			      			<select name="WriteoffStoreCode">
			      				<option value="default" selected>[<i18n:label code="STORE_SELECT"/>]</option>
			      				<%
								for (int i=0;i<storeListBean.length;i++) { 
									
									String isSelected = "";
									if(storeListBean[i].getStoreID().equals(outletBean.getWriteoffStoreCode()))
										isSelected = "selected";
								%>
								<option value="<%=storeListBean[i].getStoreID()%>" <%=isSelected%>><%=storeListBean[i].getStoreID()%></option>
								<%
								} // end for
								%>
			      			</select>
			      		</td>
			  		</tr>
			  		<%
			  		} else {
			  			editCnt++;
			  		%>
			  		<tr>
			  			<td class="td1" width="180"><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.WRITEOFF%>"/>:</td>
			      		<td><%=outletBean.getWriteoffStoreCode()%><input type="hidden" name="WriteoffStoreCode" value="<%=outletBean.getWriteoffStoreCode()%>"/></td>
			  		</tr>
			  		<%
			  		}
			  		%>
			  		
			  	</table>
			  	
			  	<br>
			  	<table>				  	
				  	<tr>
			  			<td>
			  			<% if (editCnt < 3){ %>
			  				<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doxSubmit(this.form);">
						  	<input class="textbutton" type="reset" value="<i18n:label code="GENERAL_BUTTON_RESET"/>">
						 <% }else {%>
						 
							 <input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_BACK"/>" onClick="history.back(-1);"> 	
						<%  } %>	 
			  			</td>
			  		</tr>
			  	</table>
			</td>
		</tr>	
	</table>
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="add" value="true"/>
<% } // end if canView %>
  	
</form>
</html>