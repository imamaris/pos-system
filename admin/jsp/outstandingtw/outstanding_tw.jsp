<%-- 
    Created By  : Ferdiansyah Dwiputra
    Created on  : 26 Agustus 2015
    Project     : Outstanding TW
--%>

<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.outstandingtw.*"%>
<%@ page import="com.ecosmosis.orca.inventory.InventoryManager"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>

<%
    MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
    String taskTitle = (String) returnBean.getReturnObject("TaskTitle");
    String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);
    
    int taskID = 0;
    if (task != null) taskID = Integer.parseInt(task);
    
    OutstandingTwBean[] bean = (OutstandingTwBean[]) returnBean.getReturnObject("OutstandingTW");
    
    String StoreFrom = "";
    String StoreTo = "";
    String docNo = "";
%>

<html>
    <head>
        <title></title>
        <%@ include file="/lib/header.jsp"%>
        <script>
            function cekStock(qty, stockAwal, item, no)
            {
                if(qty != "" && qty > 0)
                {
                    if(qty <= stockAwal)
                    {
                        var total = stockAwal - qty;

                        $(".stock_" + item).val(total);
                    }
                    else
                    {
                        alert("Qty To Transfer Greater than Qty Stock");
                        $("#qty_" + no).val(0);
                    }
                }
                else
                {
                    $(".stock_" + item).val(stockAwal);
                }
            }
            
            function cekQty(qty, qtyOrder, no)
            {
                if(qty != "" && qty > 0)
                {
                    if(qty > qtyOrder)
                    {
                        alert("Qty To Transfer Greater than Qty Order");
                        $("#qty_" + no).val(0);
                    }
                }
            }
            
            function doSubmit(DocNo, Sum, no)
            {
                var Remark = $("#remark_" + no).val();
                
                var id = $("#storeFrom_" + no).val();
                var storeTo = $("#storeTo_" + no).val();
                var start = no - (Sum - 1);
                var ulangi_kit2 = Sum + 1;
                var n = 1;
                var totalQty = 0;

                var jsonStr = '{"id" : "' + id + '", "storeTo" : "' + storeTo + '", "Remark" : "' + Remark + '", "ulangi_kit2" : "' + ulangi_kit2 + '"';

                for(var i = start; i <= no; i++)
                {
                    jsonStr += ', "qty_' + n + '" : "' + $("#qty_" + i).val() + '", "icode_' + n + '" : "' + $("#icode_" + i).val() + '"';

                    if($("#qty_" + i).val() != "") totalQty += parseInt($("#qty_" + i).val());

                    n++;
                }

                jsonStr += '}';
                
                if(totalQty > 0)
                {
                    var answer = confirm("Anda Yakin Ingin Proses TW : " + DocNo + " ?");

                    if(answer)
                    {

                        $.post('<%=Sys.getControllerURL(InventoryManager.TASKID_STOCK_TRANSFER_EXTERNAL_TW, request)%>',$.parseJSON(jsonStr),function(data) {
                            $("#content").html(data); 
                        });
                    }
                }
                else
                {
                    alert("Total Qty To Transfer = 0. Process Failed !");
                }
            }
        </script>
    </head>
    <body>
        <div id=content>
            <div class="functionhead"><%= taskTitle %></div>
            <br>
            <table class="listbox" width="100%">
                <tr class="boxhead">
                    <td height="50">No.</td>
                    <td>Product Ref</td>
                    <td>Product Name</td>
                    <td width="100">From</td>
                    <td width="100">To</td>
                    <td>Document</td>
                    <td>Qty<br>Back Order</td>
                    <td>Qty Out</td>
                    <td>Qty Order</td>
                    <td>Qty<br>To Transfer</td>
                    <td>Qty<br>Stock</td>
                </tr>
                <% 
                int no = 0;
                int TotQtyBackOrder = 0;
                int TotQtyOut = 0;
                int Sum = 0;
                int QtyOrder = 0;
                int TotQtyOrder = 0;
                
                if(bean.length > 0)
                {
                    for(int i=0;i<bean.length;i++) {

                    StoreFrom = bean[i].getOutletFrom() + "-001";
                    StoreTo = bean[i].getOutletTo() + "-001";
                    no++;
                    Sum++;

                    if(no < bean.length) docNo = bean[no].getDocNo();

                    TotQtyBackOrder += bean[i].getQtyOrder();
                    TotQtyOut += bean[i].getQtyOut();
                    QtyOrder = bean[i].getQtyOrder() - bean[i].getQtyOut();
                    TotQtyOrder += QtyOrder;
                %>
                <tr>
                    <td align="center"><%=no%></td>
                    <td align="center">
                        <%=bean[i].getItemCode()%>
                        <input type="hidden" id="icode_<%=no%>" name="icode_<%=no%>" value="<%=bean[i].getItemCode()%>"/>
                    </td>
                    <td align="center"><%=bean[i].getItemName()%></td>
                    <td align="center"><%=bean[i].getOutletFrom()%></td>
                    <td align="center"><%=bean[i].getOutletTo()%></td>
                    <td align="center"><std:doc_invt doc="<%=bean[i].getTrxType()%>" value2="<%=bean[i].getDocNo()%>" value="<%=bean[i].getDocNo()%>" type="1"/></td>
                    <td align="center"><%=bean[i].getQtyOrder()%></td>
                    <td align="center"><%=bean[i].getQtyOut()%></td>
                    <td align="center"><%=QtyOrder%></td>
                    <td align="center"><input type="text" id="qty_<%=no%>" name="qty_<%=no%>" value="0" size="1" maxlength="2" onKeyPress="return checkNumeric(event)" onkeyup="cekStock(this.value,<%=bean[i].getQtyStock()%>,'<%=bean[i].getItemCode()%>',<%=no%>)" onblur="cekQty(this.value,<%=QtyOrder%>,<%=no%>)"></td>
                    <td align="center"><input type="text" class="stock_<%=bean[i].getItemCode()%>" name="stock_<%=no%>" value="<%=bean[i].getQtyStock()%>" size="1" disabled="disabled"></td>
                </tr>
                <% 
                if((!docNo.equalsIgnoreCase(bean[i].getDocNo()) && docNo != "") || no == bean.length)
                {
                %>
                <tr class="boxhead">
                    <td colspan="5">Total</td>
                    <td></td>
                    <td><%=TotQtyBackOrder%></td>
                    <td><%=TotQtyOut%></td>
                    <td><%=TotQtyOrder%></td>
                    <td colspan="2"><a href="#" onclick="doSubmit('<%=bean[i].getDocNo()%>',<%=Sum%>,<%=no%>)">Process</a></td>
                </tr>
                <input type="hidden" id="storeFrom_<%=no%>" name="storeFrom_<%=no%>" value="<%=bean[i].getOutletFrom()%>-001"/>
                <input type="hidden" id="storeTo_<%=no%>" name="storeTo_<%=no%>" value="<%=bean[i].getOutletTo()%>-001"/>
                <input type="hidden" id="remark_<%=no%>" name="remark_<%=no%>" value="Ref. to : <%=bean[i].getDocNo()%>"/>
                <%
                        Sum = 0;
                        TotQtyBackOrder = 0;
                        TotQtyOrder = 0;
                        TotQtyOut = 0;
                      }
                    }
                }
                else
                {
                %>
                <tr>
                    <td colspan="11" align="center">No record found</td>
                </tr>
                <% 
                } 
                %>
            </table>
        </div>
    </body>
</html>
