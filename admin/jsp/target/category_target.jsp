<%-- 
    Created By  : Ferdiansyah Dwiputra
    Created on  : 29 Okt 2014
    Project     : Category Target
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
Map periodeTargetMap = (Map) returnBean.getReturnObject(TargetCategoryManager.RETURN_PERIODE_TARGET);
Map brandTargetMap = (Map) returnBean.getReturnObject(TargetCategoryManager.RETURN_BRAND_TARGET);
TargetCategoryManager mgr = new TargetCategoryManager();

int taskID = 0;
if (task != null)
    taskID = Integer.parseInt(task);

TargetCategoryBean target = (TargetCategoryBean) returnBean.getReturnObject("Target");
//TargetCategoryBean[] category = (TargetCategoryBean[]) returnBean.getReturnObject("Category");
double targetAmt = target.getTargetAmount();
String curID = target.getCurrency();
String month = target.getMonth();
String year = target.getYear();
String brand = target.getBrand();
String outletID = target.getOutletID();
String periodeTarget = target.getPeriode();
String periode = month + " " + year;

TargetCategoryBean[] category = mgr.getCategory(outletID,"",brand);
%>
<html>
    <head>
        <title></title>
        
        <%@ include file="/lib/header.jsp"%>
        
        <script>
            $( document ).ready(function() {
                 $("#categoryTarget_0").focus();
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
                    var categoryTarget = 0;
                    var count = $("#countCategory").val();
                    var totTarget = 0;
                    var categoryTgt = 0;

                    for(var i=0;i < count;i++)
                    {
                        categoryTgt = $("#categoryTarget_" + i).val();

                        if(categoryTgt == "") 
                        {
                            $("#categoryTarget_" + i).val(0);
                            categoryTgt = 0;
                        }

                        totTarget += parseInt(categoryTgt); 
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
        <input type="hidden" id="countCategory" name="countCategory" value="<%=category.length%>"/>
        <input type="hidden" id="curID" name="curID" value="<%=curID%>"/>
        <input type="hidden" id="periode" name="periode" value="<%=periode%>"/>
        <input type="hidden" id="brand" name="brand" value="<%=brand%>"/>
        <input type="hidden" id="outletID" name="outletID" value="<%=outletID%>"/>
        <table>
            <tr>
                <td colspan="2" align="center"><b>Category</b></td>
                <td align="center"><b>Target</b></td>
            </tr>
            <%
            for(int i=0;i<category.length;i++)
            {
            int n = i % 2;
            String rowCss = "";
            
            if(i % 2 == 0) rowCss = "even"; else rowCss = "odd";
            %>
            <tr class="<%=rowCss %>">
                <td><%=category[i].getCategory()%></td>
                <td>:</td>
                <td>
                    <input type="hidden" name="categoryID_<%=i%>" id="categoryID_<%=i%>" value="<%=category[i].getCategoryID()%>"/>
                    <input type="text" name="categoryTarget_<%=i%>" id="categoryTarget_<%=i%>" value="<%=mgr.getFormatNumber(category[i].getCategoryTarget())%>" onKeyPress="return checkNumeric(event)"/>
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
