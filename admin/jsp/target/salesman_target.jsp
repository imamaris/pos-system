<%-- 
    Created By  : Ferdiansyah Dwiputra
    Created on  : 8 Nov 2013
    Project     : Salesman Target
--%>

<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.target.*"%>
<%@ page import="com.ecosmosis.orca.document.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

String taskTitle = (String) returnBean.getReturnObject("TaskTitle");
String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);
Map periodeTargetMap = (Map) returnBean.getReturnObject(TargetManager.RETURN_PERIODE_TARGET);
Map brandTargetMap = (Map) returnBean.getReturnObject(TargetManager.RETURN_BRAND_TARGET);
TargetManager mgr = new TargetManager();

int taskID = 0;
if (task != null)
    taskID = Integer.parseInt(task);

TargetBean target = (TargetBean) returnBean.getReturnObject("Target");
TargetBean[] salesman = (TargetBean[]) returnBean.getReturnObject("Salesman");
double targetAmt = target.getTargetAmount();
String curID = target.getCurrency();
String month = target.getMonth();
String year = target.getYear();
String brand = target.getBrand();
String outletID = target.getOutletID();
String periodeTarget = target.getPeriode();
String periode = month + " " + year;
%>
<html>
    <head>
        <title></title>
        
        <%@ include file="/lib/header.jsp"%>
        
        <script>
            $( document ).ready(function() {
                 $("#salesmanTarget_0").focus();
                 $("[name=periodeTarget]").val("<%=periode%>");
                 $("[name=brandTarget]").val("<%=brand%>");
                 $("[name=periodeTarget]").change(function() {
                    $("#act").val("periode");
                    $("#frm_periodTarget").submit();
                 });
                 $("[name=brandTarget]").change(function() {
                    $("#act").val("");
                    $("#frm_periodTarget").submit();
                 });
            });
            
            function checkTarget()
            {
                var answer = confirm("Anda Yakin Ingin Simpan Data ?");
                
                if(answer)
                {
                    var target = parseInt($("#targetAmt").val());
                    var salesmanTarget = 0;
                    var count = $("#countSalesman").val();
                    var totTarget = 0;
                    var salesmanTgt = 0;

                    for(var i=0;i < count;i++)
                    {
                        salesmanTgt = $("#salesmanTarget_" + i).val();

                        if(salesmanTgt == "") 
                        {
                            $("#salesmanTarget_" + i).val(0);
                            salesmanTgt = 0;
                        }

                        totTarget += parseInt(salesmanTgt); 
                    }
                 }
                 else
                 {
                    return false;
                 }
            }
            
            function checkNumeric(e)
            {
                var unicode=e.charCode? e.charCode : e.keyCode
                if (unicode!=8){ //if the key isn't the backspace key (which we should allow)
                if (unicode<48||unicode>57) //if not a number
                    return false //disable key press
                }
            }
        </script>
        
    </head>
    <body>   
    <div class="functionhead"><%= taskTitle %></div>
        <form name="frm_periodTarget" id="frm_periodTarget" action="<%=Sys.getControllerURL(taskID,request)%>" method="post">
            <input type="hidden" id="act" name="act" value=""/>
            <table>
                <tr>
                    <td colspan="2">Currency</td>
                    <td>:</td>
                    <td><b><%=curID%></b></td>
                </tr>
                <tr>
                    <td colspan="2">Brand Amount Target</td>
                    <td>:</td>
                    <td><b><std:currencyformater code="" value="<%=targetAmt%>"/></b></td>
                </tr>
                <tr>
                    <td colspan="2">Periode</td>
                    <td>:</td>
                    <td>
                        <std:input type="select" name="periodeTarget" options="<%=periodeTargetMap%>" value="<%=request.getParameter("periodeTarget") %>" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">Brand</td>
                    <td>:</td>
                    <td>
                        <std:input type="select" name="brandTarget" options="<%=brandTargetMap%>" value="<%=request.getParameter("brandTarget") %>" />
                    </td>
                </tr>
            </table>
        </form>
        <form name="frm_target" id="frm_target" action="<%=Sys.getControllerURL(taskID,request)%>" method="post" onSubmit="return checkTarget()">
        <input type="hidden" id="targetAmt" name="targetAmt" value="<%=mgr.getFormatNumber(targetAmt)%>"/>
        <input type="hidden" id="countSalesman" name="countSalesman" value="<%=salesman.length%>"/>
        <input type="hidden" id="curID" name="curID" value="<%=curID%>"/>
        <input type="hidden" id="periode" name="periode" value="<%=periode%>"/>
        <input type="hidden" id="brand" name="brand" value="<%=brand%>"/>
        <input type="hidden" id="outletID" name="outletID" value="<%=outletID%>"/>
        <table>
            <tr>
                <td width="50" align="center"><b>ID</b></td>
                <td colspan="2" align="center"><b>Salesman</b></td>
                <td align="center"><b>Target</b></td>
            </tr>
            <%
            for(int i=0;i<salesman.length;i++)
            {
            int n = i % 2;
            String rowCss = "";
            
            if(i % 2 == 0) rowCss = "even"; else rowCss = "odd";
            %>
            <tr class="<%=rowCss %>">
                <td align="center"><%=salesman[i].getSalesmanID()%></td>
                <td><%=salesman[i].getSalesman()%></td>
                <td>:</td>
                <td>
                    <input type="hidden" name="salesmanID_<%=i%>" id="salesmanID_<%=i%>" value="<%=salesman[i].getSalesmanID()%>"/>
                    <input type="text" name="salesmanTarget_<%=i%>" id="salesmanTarget_<%=i%>" value="<%=mgr.getFormatNumber(salesman[i].getSalesmanTarget())%>" onKeyPress="return checkNumeric(event)"/>
                </td>
            </tr>
            <%
            }
            %>
            <tr>
                <td colspan="4" height="50" align="center"><input class="textbutton" type="submit" name="SubmitData" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>"></td>
            </tr>
        </table>
    </form>

    </body>
</html>
