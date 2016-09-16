<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ProductCategoryBean[] beans = (ProductCategoryBean[]) returnBean.getReturnObject("CatList");
	ProductBean[] default_list = (ProductBean[]) returnBean.getReturnObject("Product");
	boolean canView = true;
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">Combo Product Listing **</div>
 	<form name="listcategory" action="<%=Sys.getControllerURL(ProductManager.TASKID_COMBO_PRODUCT_LISTING,request)%>" method="post">
 	<table width="50%">
 		<tr><td colspan="2">SEARCH BY :</td></tr>
 		<tr>
 			<td align="right">Status:</td>
	 		<td >
	            <select name="Status">
		 		    <option value="">ALL</option>
					<option value="A">Active</option>
					<option value="I">Inactive</option>
				</select>&nbsp;&nbsp;
			</td>
	 	</tr> 
	 	<tr>
 			<td align="right">Category:</td>
	 		<td >
	            <select name="CatID">
		 		    <option value="">ALL</option>
					<%
					for (int i=0;i<beans.length;i++) { 
					%>
					<option value="<%=beans[i].getCatID()%>"><%=beans[i].getName()%></option>
					<%
					} // end for
					%>
				</select>&nbsp;&nbsp;
			</td>
	 	</tr> 
	 	<tr>
 			<td align="right">Inventory:</td>
	 		<td >
	            <select name="InventoryCtrl">
		 		    <option value="">ALL</option>
					<option value="Y">Yes</option>
					<option value="N">No</option>
				</select>&nbsp;&nbsp;
			</td>
	 	</tr> 
	 	<tr>
 			<td align="right">Priority Level:</td>
	 		<td >
	            <select name="PriorityLevel">
		 		    <option value="">ALL</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
				</select>&nbsp;&nbsp;
			</td>
	 	</tr> 
	 	<tr>
 			<td align="right">Alert Level:</td>
	 		<td ><std:input type="text" size="5" name="SafeLevel" value=""/>&nbsp;&nbsp;<input type="submit" value="GO"></td>
	 	</tr> 
	</table>
    </form>

<% if (canView) { %>    
	<table width="100%" cellspacing="1">
		<tr class="head" valign=top align="center">
			<td>No.</td>
			<td>Category</td>
			<td>Product<br>Code</td>
			<td>UOM</td>
			<td>Inventory<br>Control</td>
			<td>Safe<br>Level</td>
			<td>Priority<br>Level</td>
			<td>Base<br>Value</td>
			<td>Reg</td>
			<td>Status</td>
			<td>Product<br>Name</td>
			<td>Description</td>	
		  </tr>
		  
		  <% for (int i=0;i<default_list.length;i++) { 
		  		int productid = default_list[i].getProductID();
		  %>
		  
		  	  <tr class="<%= (i%2 == 0) ? "even" : "odd"%>">
				<td align="center"><%=(i+1)%></td>
				<td align="center"><%=default_list[i].getName()%></td>
				<td align="center">
					<a href="<%=Sys.getControllerURL(ProductManager.TASKID_COMBO_PRODUCT_INFO,request)%>&productid=<%=productid%>">
						<%=default_list[i].getSkuCode()%>
					</a>
				</td>
				<td align="center"><%=default_list[i].getUom()%></td>
				<td align="center"><%=default_list[i].getInventory()%></td>
				<td align="center"><%=default_list[i].getSafeLevel()%></td>
				<td align="center"><%=default_list[i].getPriorityLevel()%></td>
				<td align="center"><%=default_list[i].getBaseValue()%></td>
				<td align="center"><%=default_list[i].getRegister()%></td>
				<td align="center"><%=default_list[i].getStatus()%></td>
				<td align="center"><%=default_list[i].getDefaultName()%></td>
				<td align="center"><%=default_list[i].getDefaultDesc()%></td>
				
				<td><input class="textbutton" type="button" value="Edit" onClick="window.location.href='<%=Sys.getControllerURL(ProductManager.TASKID_COMBO_PRODUCT_EDIT,request)%>&productid=<%=productid%>'"></td>
			  </tr>	
		  <% } // end for loop %>
	</table>

<% } // end if canView %>	
	
	</body>
</html>
