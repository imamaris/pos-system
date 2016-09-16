<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bonus.stmtdetails.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.bonus.chi.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	TreeMap periods = (TreeMap) returnBean.getReturnObject("BonusList");
	int gotStmt = 0;
	
	String specmsg = "";
	
	if (periods != null && periods.size() > 0)
	 	gotStmt = 1;
	else if (periods != null && periods.size() == 0)
	{
	 	gotStmt = 2;
	 	specmsg = "No Bonus Statement For This Member.";
 	}
 	
 	BonusPeriodBean period = (BonusPeriodBean) returnBean.getReturnObject("BonusPeriod");	
	BonusBean bean = (BonusBean) returnBean.getReturnObject("BonusPayment");
	MemberBean member = null;
	boolean canView = false;
	if (bean != null)
	{
	 	canView = true;
	 	member = bean.getMemberBean();
	} 	 	
	
	java.text.DecimalFormat dollar = new java.text.DecimalFormat("#,##0");
	java.text.DecimalFormat number = new java.text.DecimalFormat("#,##0");
	java.text.DecimalFormat pointvalue = new java.text.DecimalFormat("#,##0.000000");
	java.text.DecimalFormat pvpoint = new java.text.DecimalFormat("#,##0.00");
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
        <div class="functionhead"><i18n:label code="Bonus Payment Update"/></div>        
 	<form method="post" name="bonusstmt" action="<%=Sys.getControllerURL(BonusMasterReportManager.TASKID_UPDATE_BONUS_PAYMENT_SUBMIT,request)%>">
 	
 	<%@ include file="/general/mvc_return_msg.jsp"%>
 	
 	<table class="listbox" width=350>
 	 <tr>
	 	<td width="150" class="odd">Member ID</td>
	 	<td><std:memberid form="bonusstmt" name="memberid" value="<%=request.getParameter("memberid")%>" /></td>
	 	<td rowspan="2" align="center"><input type="submit" value="GO"></td>
	 </tr>	

<% if (gotStmt == 1) {%>
	 <tr>
	 	<td width="150" class="odd">Bonus Period</td>
	 	<td><std:input type="select" name="periodid" options="<%=periods%>" value="<%=request.getParameter("periodid")%>"/></td>
	 </tr> 
<% } %>
	 
	</table>
    </form>

<%=specmsg%>
    
<% if (canView) { %>    
	
	<div>
		<input class="noprint textbutton" type="button" value="Print" onclick="window.print()">
                
	</div>
	
	<c:if test="<%=bean.getAdjustmentRemark()!=null%>">
		<br>
		<div><font color="red"><%=bean.getAdjustmentRemark()%></font></div>
	</c:if>
	
	<br>
	
	<table class="listbox" width="500">
	     <tr class="boxhead">
		 	<td colspan=2">Distributor Information</td>
		 </tr>
	 	 <tr>
		 	<td width="150" class="odd">Distributor ID</td>
		 	<td width="350"><%=member.getMemberID()%></td>
                    
                 </tr>
		 <tr>
		 	<td width="150" class="odd">Name</td>
		 	<td width="350"><%=member.getName()%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">Mobile Number</td>
		 	<td width="350"><%=member.getMobileNo()%></td>
		 </tr>
		 <tr>
		 	<td width="150" class="odd">Address</td>
		 	<td width="350"><%=member.getAddress().getFullAddress()%></td>
		 </tr>	
		 <tr>
		  	<td width="150" class="odd">Bank Account</td>
                        <td><std:text value="<%=bean.getMemberBean().getPayeeBank().getBankAcctNo()%>" defaultvalue="-"/></td>
		 </tr>	
		 <tr>
		  	<td width="150" class="odd">Bank Name</td>
                        <td>
		  		<%if(bean.getMemberBean().getPayeeBank().getBankBean()!=null){%>
					<std:text value="<%=bean.getMemberBean().getPayeeBank().getBankBean().getName()%>" defaultvalue="-"/>	
		  		<%}else{%>
		  			-
		  		<%}%>
		  	</td>
		 </tr>	
		 <tr>
		  	<td width="150" class="odd">Account Name</td>                        
		  	<td><std:text value="<%=bean.getMemberBean().getPayeeBank().getBankPayeeName()%>" defaultvalue="-"/></td>
		 </tr>	

        </table>
	<table class="listbox" width="500">
	     <tr class="boxhead">
		 	<td colspan=2">Bonus Information</td>
		 </tr>
	 	 <tr>
		 	<td width="150" class="odd">Bonus Sponsor</td>
		 	<td width="350"><%=dollar.format(bean.getBonusSponsor())%></td>
                 </tr>	 	                  
                 <tr>
		 	<td width="150" class="odd">Tax</td>
		 	<td width="350"><%=dollar.format(bean.getTax())%></td>
		 </tr>
                 <tr>
		 	<td width="150" class="odd">Admin Fees</td>
		 	<td width="350"><%=dollar.format(bean.getAdminfees())%></td>
		 </tr>
                 <tr>
		 	<td width="150" class="odd">Admin Bank</td>
		 	<td width="350"><%=dollar.format(bean.getAdminbank())%></td>
		 </tr>

                 <tr>
		 	<td width="150" class="odd">Net Payout</td>
		 	<td width="350"><%=dollar.format(bean.getBonusSponsor()-(bean.getTax()+bean.getAdminfees()+bean.getAdminbank()))%></td>
		 </tr>
        </table>        

        
        <form method="post" name="bonuspayment" action="<%=Sys.getControllerURL(BonusMasterReportManager.TASKID_UPDATE_BONUS_PAYMENT_SUBMIT2,request)%>">        
        <table class="listbox" width="500">
	     <tr class="boxhead">
		 	<td colspan=2">Bonus Payment Update</td>
		 </tr>
	 	 <tr>		 	
                        <td width="250"  class="odd"><i18n:label code="Payment Amount "/></td>
                        <td align=left><input type=text value="<%=bean.getPaymentAmount()%>" name="paymentamount" maxlength=12 size=15 style="text-align:right"></td>
                 </tr>	 	                  
                 <tr>
                        <td width="250"  class="odd"><i18n:label code="Payment Date"/> (<%= SystemConstant.DEFAULT_DATEFORMAT %>)</td>
		        <td><std:input type="date" value="<%=bean.getPaymentDate()%>" name="paymentdate"  size="15"/></td>                        
                 </tr>
                 <tr>
		 	<td width="250"  class="odd"><i18n:label code="Payment Remark"/></td>
                        <td align=left><input type=text value="<%=bean.getPaymentRemark()%>" name="paymentstatus" maxlength=8 size=15 style="text-align:left"></td>                        
                    </tr>
	</table>    

    <table width=500 border="0" cellspacing="0" cellpadding="0" >
	<tr><td>&nbsp</td></tr>
	<tr class="head">
		<td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>" onclick="return confirmSubmit()"></td>
	</tr>
</table>
</form>
        
	<c:if test="<%=bean.getAdjustmentRemark()!=null%>">
		<br>
		<div><font color="red"><%=bean.getAdjustmentRemark()%></font></div>
	</c:if>
<% } // end canView %>
	

	</body>
</html>
