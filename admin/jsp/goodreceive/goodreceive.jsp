<%-- 
    Created By  : Ferdiansyah Dwiputra
    Created on  : 2 September 2015
    Project     : Good Receive
--%>

<%@ page import="com.ecosmosis.orca.goodreceive.GoodReceiveManager"%>
<%@ page import="com.ecosmosis.orca.goodreceive.GoodReceiveBean"%>
<%@ page import="java.sql.*" %>

<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  
  GoodReceiveBean[] bean = (GoodReceiveBean[]) returnBean.getReturnObject("GoodReceive");
%>
<html>
    <head>
        <%@ include file="/lib/header.jsp"%>
    </head>
    <body onLoad="self.focus();">

        <%@ include file="/lib/return_error_msg.jsp"%>

        <table width="100%">
         <tr>
           <td width="10%" align="left">
           <input class=noprint type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()">
           </td>
         </tr>
        </table>
        <table width="100%">
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td valign=top width="70%" >
                                <table width="100%" border="0" style="border:1px #000000 solid pading:3">
                                    <tr>
                                        <td colspan=3 align=center height="20"><b><font size=4 face="Arial">GOOD RECEIVED</font></b></td>
                                    </tr>
                                </table>
                                <table width="100%" border="0" style="border:1px #000000 solid pading:3">
                                    <tr>
                                        <td width="25%" align=left><b>Document No.</b></td>
                                        <td>:</td>
                                        <td nowrap align=left><%=bean[0].getTrnxDocNo()%></td>
                                    </tr>
                                    <tr>
                                        <td width="25%" align=left><b><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.DATE%>"/></b></td>
                                        <td>:</td>
                                        <td nowrap align=left><fmt:formatDate  pattern="dd MMMM yyyy" type="both" value="<%= bean[0].getTrnxDate()%>" /></td>
                                    </tr>
                                    <tr>
                                        <td width="25%" align=left><b>Brand</b></td>
                                        <td>:</td>
                                        <td nowrap align=left><%=bean[0].getBrand()%></td>
                                    </tr>
                                    <tr>
                                        <td align=left><b>Warehouse</b></td>
                                        <td>:</td>
                                        <td nowrap align=left><%=bean[0].getOwnerID()%></td>
                                    </tr>                    
                                    <tr>
                                        <td align=left><b>Print Date</b></td>
                                        <td>:</td>
                                        <td nowrap align=left><fmt:formatDate pattern="dd MMMM yyyy" type="both" value="<%= bean[0].getStd_createDate()%>" /></td>
                                    </tr>
                                    <tr>
                                        <td align=left><b>Created By</b></td>
                                        <td>:</td>
                                        <td nowrap align=left><%=bean[0].getStd_createBy()%></td>
                                    </tr>                    
                                </table>
                            </td>
                            <td width="30%"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0">
                        <tr>
                            <td>
                                <table width="100%" border="0" style="border:1px #000000 solid pading:3">  
                                    <tr valign=top >
                                        <td align=center width="3%"><i18n:label code="<%=StandardMessageTag.NO%>"/>.</td>
                                        <td align=center width="15%">Reference No </td>                       
                                        <td align=center width="30%">Description</td>
                                        <td align=center width="15%">Serial No</td>
                                        <td align=center width="5%">Qty</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table width="100%" border="0" >  
                    <% 
                    int total = 0;
                    int no = 0;

                    for(int i=0; i<bean.length;i++){

                        //if(bean[i].getProductBean().getProductSelling().equalsIgnoreCase("Y")) {
                            total += bean[i].getTotalIn();
                            no ++;
                    %>             
                    <tr>
                    <td align="center" width="3%"><%=no%>.</td>
                    <td align="left" width="15%"><%=bean[i].getProductCode() %></td>                        
                    <td align="left" width="30%"><%=bean[i].getProductName() %></td>
                    <td align="left" width="15%"><%=bean[i].getProductSerial() %></td>
                    <td align="center" width="5%"><%=bean[i].getTotalIn() %></td>
                    </tr>
                    <%
                        //}//end if
                    }//end for
                    %>

                    </table>
                    <table width="100%" border="0" >  
                        <tr>
                            <td align="right" colspan="4" width="63%" ><b>Total Qty :</b></td>
                            <td align="center" width="5%"><b><%= total%></b></td>
                        </tr>   
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td height="150"></td>
                        </tr>
                    </table>
                    <table width="100%" border="0" style="border:1px #000000 solid pading:3">  
                        <tr>
                            <td><b><i18n:label code="GENERAL_REMARK"/> : </b><br>
                            <%=((bean[0].getRemark()!=null && bean[0].getRemark().length()>0) ? bean[0].getRemark().replaceAll("\n","<br>"):"-")%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td>
                    <input class=noprint type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()">
                </td>
            </tr>
        </table>
    </body>
</html>