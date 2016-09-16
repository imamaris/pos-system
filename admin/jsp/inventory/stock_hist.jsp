<%@ page import="com.syscatech.emrm.stock.product.*"%>
<%@ page import="com.syscatech.emrm.stock.inventory.*"%>
<%@ page import="com.syscatech.emrm.stockist.*"%>
<%@ page import="com.syscatech.emrm.document.*"%>
<%@ page import="com.syscatech.mvc.sys.*"%>
<%@ page import="com.syscatech.language.*"%>
<%@ page import="com.syscatech.calendar.*"%>
<%@ page import="com.syscatech.util.htmlutil.*"%>
<%@ page import="java.util.*"%>
<%
	String fromDate = (String)request.getAttribute("DateFrom");
	String toDate = (String)request.getAttribute("DateTo");
	int backTaskId = Integer.parseInt((String)request.getAttribute("BackTaskId"));
	int taskId = Integer.parseInt((String)request.getParameter(Sys.TASK));
	
	if (fromDate==null && toDate==null) {
		fromDate = Sys.getDateFormater().format(new Date());
		toDate = fromDate;
	}
	
	ProductInventoryBean[] invBeans = (ProductInventoryBean[]) request.getAttribute("HistoryList");
	InventoryReportBean[] bean = (InventoryReportBean[]) request.getAttribute("Inventory");
	StockistBean stockist = (StockistBean) request.getAttribute("Stockist");
	ProductBean siBean = (ProductBean) request.getAttribute("Product");
	
	int totalin=0, totalout=0, balance=0;
	if (bean!=null && bean.length>0){
		totalin = bean[0].getTotalIn();
		totalout = bean[0].getTotalOut();
		balance = totalin - totalout;
	}
%>

<html>
<head>
	<%@ include file="/jsp/lib/header.jsp"%>
	<script language="Javascript">
  <!--
     function viewDocument(trxid, _type){

      var _url = '#';
      myPopup = window.open('','InventoryDocument','menubr=no,resizable=yes,toolbar=no,scrollbars=yes,status=no,width=700,height=500,screenX=0,screenY=0');
      if (!myPopup.opener)
         myPopup.opener = self;

      if(_type == '<%=InventoryManager.TRX_STOCKABOLISH_OUT%>')
         _url = '<%=Sys.getControllerURL(InventoryManager.PSTOCK_DOC_ABOLISH,request)%>';

      else if(_type == '<%=InventoryManager.TRX_ADJUSTMENT_IN%>' || _type == '<%=InventoryManager.TRX_ADJUSTMENT_OUT%>')
         _url = '<%=Sys.getControllerURL(InventoryManager.PSTOCK_DOC_ADJUST,request)%>';
      
      else if(_type == '<%=InventoryManager.TRX_STOCKLOAN_IN%>' || _type == '<%=InventoryManager.TRX_STOCKLOAN_OUT%>')
         _url = '<%=Sys.getControllerURL(InventoryManager.PSTOCK_DOC_LOAN,request)%>';
         
      else if(_type == '<%=InventoryManager.TRX_STOCKPURC_IN%>' || _type == '<%=InventoryManager.TRX_STOCKPURC_OUT%>')
         _url = '<%=Sys.getControllerURL(InventoryManager.PSTOCK_DOC_PURCHASE,request)%>';
      
      else if(_type == '<%=InventoryManager.TRX_STOCKTRANSF_IN%>' || _type == '<%=InventoryManager.TRX_STOCKTRANSF_OUT%>')
         _url = '<%=Sys.getControllerURL(InventoryManager.PSTOCK_DOC_TRANSFER,request)%>';
			
      else if(_type == '<%=InventoryManager.TRX_STOCKFREE_IN%>' || _type == '<%=InventoryManager.TRX_STOCKFREE_OUT%>')
         _url = '<%=Sys.getControllerURL(InventoryManager.PSTOCK_DOC_COMPL,request)%>';
         
      else if(_type == '<%=InventoryManager.TRX_STOCKRETURN_OUT%>')
         _url = '<%=Sys.getControllerURL(InventoryManager.PSTOCK_DOC_RETURN,request)%>';
         
      else if(_type == '<%=InventoryManager.TRX_STOCKDISCREPANCY_IN%>' || _type == '<%=InventoryManager.TRX_STOCKDISCREPANCY_OUT%>')
         _url = '<%=Sys.getControllerURL(InventoryManager.PSTOCK_DOC_DISCREPANCY ,request)%>';
   
      
      document.stockDoc.InvId.value = trxid;
      document.stockDoc.method = "POST";
      document.stockDoc.action = _url;
      document.stockDoc.target = 'InventoryDocument';
      document.stockDoc.submit();
   }
  //-->
  </script>
</head>
<body>

<div class=titles><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"INV_HIST")%></div>
<form name="stockDoc" method="post" action="" target=''>
	<input type=hidden name="OwnerCode" value="<%=stockist.getStockistId()%>">
	<input type=hidden name="InvId" value="">
</form>

<form name="stockhist" method="post" action="<%= Sys.getControllerURL(taskId,request)%>">
 <input type=hidden name="OwnerCode" value="<%= stockist.getStockistId()%>">
 <input type=hidden name="ItemId" value="<%= siBean.getId()%>">
 <input type=hidden name="BackTaskId" value="<%= backTaskId %>">
 

<table width="60%">
	<tr>
		<td width="30%"><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"PRDT_CODE")%></td>
		<td>: <b><%=siBean.getPrCode()%></b></td>
	</tr>
	<tr>
		<td><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"PRDT_NAME")%></td>
		<td>: <b><%=siBean.getPrName()%></b></td>
	</tr>  
	<tr>
		<td><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"TOTAL_IN")%></td>
		<td>: <%=totalin%></td>
	</tr>
	<tr>
		<td><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"TOTAL_OUT")%></td>
	  <td>: <%=totalout%></td>
	</tr>
	<tr>
		<td><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"BALANCE")%></td>
		<td>: <b><%=balance%></b></td>
	</tr>
	<tr valign=top>
		<td><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"DATE_FRM")%></td>
		<td>: <input type=text name="DateFrom" value="<%=fromDate!=null? fromDate:""%>">
					<%=CalendarManager.show(null,"DateFrom","button_fromDate")%>
					<!--
					<a href="Javascript:opennewcal('<%=Sys.getControllerURL(CalendarManager.VIEW_PICKER,request) %>&FormName=stockhist&ObjName=DateFrom')">
						<img border="0" src="<%=Sys.getWebapp()%>/img/calendar.gif">
					</a>
					-->
					(<%=Sys.getDateFormat().toUpperCase()%>)
		</td>
	</tr>
	<tr valign=top>
		<td><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"DATE_TO")%></td>
		<td>: <input type=text name="DateTo" value="<%=toDate!=null? toDate:""%>">
					<%=CalendarManager.show(null,"DateTo","button_toDate")%>
					<!--
					<a href="Javascript:opennewcal('<%=Sys.getControllerURL(CalendarManager.VIEW_PICKER,request) %>&FormName=stockhist&ObjName=DateTo')">
						<img border="0" src="<%=Sys.getWebapp()%>/img/calendar.gif">
					</a>
					-->
					(<%=Sys.getDateFormat().toUpperCase()%>)
		</td>
	</tr>
</table>
<br>
<input type=submit name="btnSubmit" value="<%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"SUBMIT")%>">
<input type="button" name="btnCancel" value="<%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"CANCEL")%>" onClick="location.href('<%=(Sys.getControllerURL(backTaskId,request)+ "&OwnerCode=" + stockist.getStockistId())%>')">
</form>
<hr>
<br>

<b><u><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"ST_OW_INFO")%></u></b>
<table>
	<tr>
		<td><%= MessageResource.getJSPLocalizedMessage(basicLoginInfo,"OWN_COD") %></td>
		<td>: <%=stockist.getStockistId()%></td>
	</tr>
	<tr>
		<td><%= MessageResource.getJSPLocalizedMessage(basicLoginInfo,"OWN_NAME") %></td>
		<td>: <%=stockist.getName()%></td>
	</tr>
</table>
<br>

<b><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"ST_TRX_LST")%></b>
<table width="100%">
	<tr class="head">
		<td width="3%" align=right><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"NO.")%></td>
		<td width="12%"><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"DATE")%></td>
		<td><%= MessageResource.getJSPLocalizedMessage(basicLoginInfo,"REF_NO") %></td>
		<td width="7%" align=right><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"ST_IN")%></td>
		<td width="7%" align=right><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"ST_OUT")%></td>
		<td width="8%"><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"TRX_TYPE")%></td>
		<td width="36%"><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"REMARK")%></td>
		<td><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"DONE_BY")%></td>
		<td><%= MessageResource.getJSPLocalizedMessage(basicLoginInfo,"TRX_DATE_TIME") %></td>
	</tr>
	<%
		if (invBeans!=null && invBeans.length>0) {
	 
	  	PageIndexGenerator pig = new PageIndexGenerator(10,30);
			pig.setTotalRecordsCount(invBeans.length);
			
			int selectedPage = 1;
			try {
				selectedPage = Integer.parseInt(request.getParameter("page"));
			} catch (Exception e) {
	 		}
	
			pig.setSelectedPage(selectedPage);
	
			pig.setPageLink(Sys.getControllerURL(InventoryManager.PSTOCK_HISTORY,request) + "&BackTaskId="+ backTaskId +"&OwnerCode=" + stockist.getStockistId() + "&ItemId=" + siBean.getId() + ((fromDate!=null)?"&DateFrom=" + fromDate:"") + ((toDate!=null)?"&DateTo=" + toDate:""));
			int startIndex = pig.getStartRecordIndex();
			int endIndex = pig.getEndRecordIndex();
	
			for (int i=startIndex; i < endIndex; i++) {
				String _link = "-";
				String refNo = invBeans[i].getReferenceNo();
				if (refNo != null && refNo.length() > 0) {
					_link = "<a href=\"javascript: viewDocument('" + invBeans[i].getId() + "','" + invBeans[i].getTransactionType()+ "');\">" + refNo + "</a>";
				
					if(invBeans[i].getTransactionType().equalsIgnoreCase(InventoryManager.TRX_STOCKIN) ||
	          invBeans[i].getTransactionType().equalsIgnoreCase(InventoryManager.TRX_STOCKOUT) ||
	          invBeans[i].getTransactionType().equalsIgnoreCase(InventoryManager.TRX_STOCKADJ_IN) ||
	          invBeans[i].getTransactionType().equalsIgnoreCase(InventoryManager.TRX_STOCKADJ_OUT)) {
	          _link = "-";
	      	} else if (invBeans[i].getTransactionType().equalsIgnoreCase(InventoryManager.TRX_STOCKFREE_IN) ||
	          invBeans[i].getTransactionType().equalsIgnoreCase(InventoryManager.TRX_STOCKFREE_OUT)) {
		          if (!refNo.startsWith(DocumentManager.COMPLIMENT))
		          	_link = "-";
	        }    
        }  
	%>
	<tr class="<%=((i+1) % 2 == 0)?"even":"odd"%>" valign=top>
		<td align=right><%=(i+1)%>.</td>
		<td><%=Sys.getDateFormater().format(invBeans[i].getDate())%></td>
		<td align="left"><%=_link%></td>
		<td align="right"><%=invBeans[i].getQuantityIn()%></td>
		<td align="right"><%=invBeans[i].getQuantityOut()%></td>
		<td align="center"><%=invBeans[i].getTransactionType()%></td>
		<td><%=invBeans[i].getRemark()%></td>
		<td><%=invBeans[i].getDoneBy()%></a></td>
		<td align="center"><%=Sys.getDateFormater().format(invBeans[i].getCreateDate())%><br><%=invBeans[i].getTime()%></td>
	</tr>
	<%
			} // end for
	%>
	<tr><td colspan="9"><hr></td></tr>
	<tr><td colspan="9" align=center><%=pig.toHTMLString()%></td></tr>
	<%
		} else {
	%>
	<tr>
		<td colspan=9 align=center><%= MessageResource.getLocalizedMessage(basicLoginInfo, "REC_NT_FND") %></td>
	</tr>
	<% } %>
</table>
<%@ include file="/jsp/inventory/stock_legend.jsp"%>
<p>
	<div align=left><input class=noprint type="button" value="<%= MessageResource.getLocalizedMessage(basicLoginInfo, "PRINT") %>" onclick="window.print()"></div>
</p>
</body>
</html>
