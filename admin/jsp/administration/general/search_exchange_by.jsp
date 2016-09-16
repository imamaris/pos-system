<%@ page import="com.ecosmosis.common.currency.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	CurrencyExchangeBean[] beans = (CurrencyExchangeBean[]) returnBean.getReturnObject("List");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;

%>
<html>
        <head>
            <%@ include file="/lib/header.jsp"%>
            <script language="javascript">
                function choose(id,symbol, name, format){
                var opener = window.opener.document.frmSearch;
                opener.id.value = id;
                opener.symbol.value = symbol;
                opener.name.value = name;
                opener.format.value = format;
                    window.close();
                }
            </script>
            
            <title><i18n:label code="Search Exchange Rate ID"/></title>
        </head>
        <body>
	<div class="functionhead">Search Exchange ID</div>
	<br>
        
<% if (canView) { %>   
            <form name="frmSearch" method="post" action="service.do?Fin=101811&Tail=null&JdkSeOIUy=1348469914916&Scale=139f711fd24','_blank','height=300,width=350,scrollbars=1,resizable=yes">
                <table class="listbox" width="600">
                    <tr class="boxhead" valign=top>
                        <td>ID</td>
                        <td>Code</td>
                        <td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
                        <td>Currency</td>
                    </tr>
                    <% for (int i=0;i<beans.length;i++) { 
                    String rowCss = "";
                    if((i+1) % 2 == 0)
                    rowCss = "even";
                    else
                    rowCss = "odd";
                    %>
                    <tr class="<%=rowCss%>" valign=top>
                        <td align="center"><%=i+1%></td>
                        <td align ="center"><a href="javascript:choose('<%=i+1%>','<%=beans[i].getSymbol()%>','<%=beans[i].getName()%>','<%=beans[i].getDisplayformat()%>')"><%=beans[i].getSymbol()%></a></td>
                        <td align ="center"><%=beans[i].getName()%></td>
                        <td align ="center"><%=((beans[i].getDisplayformat() != null) ? beans[i].getDisplayformat() : "")%></td>
                        <input type="hidden" name="id" value="<%= beans[i].getDisplayformat() %>">
                        <input type="hidden" name="symbol" value="<%=beans[i].getSymbol()%>">
                        <input type="hidden" name="name" value="<%=beans[i].getName()%>">
                        <input type="hidden" name="format" value="<%= beans[i].getDisplayformat() %>"> 
                    </tr>
                    <% } %>
                </table>
                <% } // end if canView
                else{%>
                kosong
                <%}%>
            </form>
	</body>
</html>