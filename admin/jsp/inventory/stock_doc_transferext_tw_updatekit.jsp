<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.outlet.OutletBean"%>
<%@page import="com.ecosmosis.orca.outlet.store.OutletStoreBean"%>
<%@page import="com.ecosmosis.orca.supplier.SupplierBean"%>
<%@page import="com.ecosmosis.orca.product.*"%>

<%@ page import="java.sql.*" %>

<html>
    <head>
        <%@ include file="/lib/header.jsp"%>
    </head>
    <%
    MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
    
    OutletBean outlet = (OutletBean) returnBean.getReturnObject("Outlet");
    OutletBean outletTo = (OutletBean) returnBean.getReturnObject("OutletTo");
    
    InventoryBean invenBean = (InventoryBean) returnBean.getReturnObject("InventoryBean");
    InventoryBean[] invenBeans = (InventoryBean[]) returnBean.getReturnObject("InventoryBeans");
    String target = (String) returnBean.getReturnObject("Target");
    
    String document_name = lang.display("STOCK_TRANSFER_EXTERNAL");
    %>
    
    <body onLoad="self.focus();">
        <table width="100%">
            
            <% if(invenBean.getStatus()==90 && invenBean.getTrnxType().equalsIgnoreCase("STAO")) { %>
            
            <table width="100%" class=noprint >
                <tr>
                    <td width="50%" align="left">
                        <table width="25%" border="1" cellspacing="1" cellpadding="1">
                            <tr>         
                                <td align=center height="30" > <font color="red"> <b><std:doc_invt doc="TW" value2= "<%=invenBean.getTrnxDocNo() %>" value="Process Verify OUT" type="1"/> </b> </font></td>            
                            </tr>
                        </table>
                    </td>
                    <td width="50%" align="right">
                        <table width="25%" border="1" cellspacing="1" cellpadding="1">
                            <tr>         
                                <td align=center height="30" > <font color="red"> <b><std:doc_invt doc="VOID" value2= "<%=invenBean.getTrnxDocNo() %>" value="Process VOID" type="1"/> </b> </font></td>            
                            </tr>
                        </table>
                    </td>               
                    
                </tr>
            </table>
            
            <% 
            } else if(invenBean.getStatus()==100 && invenBean.getTrnxType().equalsIgnoreCase("STAO")) {      
            %> 
            
            <table width="100%" >
                <tr>       
                    <td width="15%" align="left"  height="30">
                        <input class=noprint type="button" value="  PRINT  " onclick="window.print()">
                    </td>                    
                    <td width="50%" align=center height="30" class=noprint > <font color="blue"> <b>This document has been verified out </b> </font> </td> 
                    
                    <td width="35%" align="right">
                        <table width="50%" border="1" cellspacing="1" cellpadding="1" class=noprint >
                            <tr>         
                                <td align=center height="30" class=noprint  > <font color="red"> <b><std:doc_invt doc="VOID" value2= "<%=invenBean.getTrnxDocNo() %>" value="Process VOID" type="1"/> </b> </font></td>            
                            </tr>
                        </table>
                    </td>               
                </tr>
                
                <tr>       
                    <td width="15%" align="left"  height="30">                  
                    </td>                    
                    <td width="50%" align=center height="30" class=noprint ></td> 
                    
                    <td width="35%" align="right">
                        <table width="50%" border="1" >
                            <tr>         
                                <td align=center height="30" class=noprint > <font color="red"> <b> Attention !! Please make sure this items in this document have not been sent yet </b> </font></td>            
                            </tr>
                        </table>
                    </td>               
                </tr>
                
            </table>
            
            <% 
            } else {      
            %> 
            
            <table width="100%" >
                <tr>    
                    <td width="15%" align="left"  height="30">
                        <input class=noprint type="button" value="  PRINT  " onclick="window.print()">
                    </td>                 
                    <td width="20%" align="left"  height="30">
                        
                    </td>      
                    
                    <td width="65%" align=right height="30" > <font color="blue"> <b>This document has been VOIDED </b> </font> </td> 
                </tr>
            </table>
            
            <% } %>            
            
        </table>    
        
        
        <table width="100%">
            <tr>
                <td>
                    <%@ include file="/admin/jsp/inventory/stock_doc_headerparties02.jsp"%>
                </td>
            </tr>
            
            <tr>
                <td>
                    <table width="100%" border="0">
                        <table width="100%" border="0" style="border:1px #000000 solid pading:3">  
                            <tr valign=top >
                                <td align=center width="3%"><i18n:label code="<%=StandardMessageTag.NO%>"/>.</td>
                                <td align=center width="15%">Reference No </td>                       
                                <td align=center width="30%">Description</td>
                                <td align=center width="15%">Serial No</td>
                                <td align=center width="5%">Qty</td>
                            </tr>
                        </table>
                        <table width="100%" border="0" >  
                            <% 
                            int total = 0;
                            int no = 0;
                            // item
                            for(int i=0; i<invenBeans.length;i++){
                                
                                if(invenBeans[i].getProductBean().getProductSelling().equalsIgnoreCase("Y")) {
                                    total += invenBeans[i].getTotalOut();
                                    no ++;                                   
                            %>             
                            <tr>
                                <td align="center" width="3%"><%=no%>.</td>
                                <td align="left" width="15%"><%=invenBeans[i].getProductBean().getProductCode() %></td>                        
                                <td align="left" width="30%"><%=invenBeans[i].getProductBean().getDefaultName() %></td>
                                <td align="left" width="15%"><%=invenBeans[i].getProductBean().getSkuCode() %></td>
                                <td align="center" width="5%"><%= invenBeans[i].getTotalOut() %></td>
                            </tr>
                            <%
                                }//end if
                                
                            }//end for
                            %>
                        </table>
                        
                        <table width="100%" border="0" >  
                            <tr>
                                <td align="left" colspan="5" width="68%" ><b>KIT Item :</b></td>
                            </tr>   
                        </table>
                        
                        <table width="100%" border="0" >  
                            
                            <% 
                            no = 0 ;
                            // KIT item
                            
                            int nom = 0;
                            int nomor = 0;
                            String code_a = "";
                            
                            String code = "";
                            String name = "";
                            
                            int qty  = 0;
                            int qty1 = 0;
                            String code1 = "";
                            String code2 = "";
                            String name1 = "";
                            
                            String[] kode1;
                            kode1 = new String[10];
                            String[] nama1;
                            nama1 = new String[10];
                            int[] jumlah1;
                            jumlah1 = new int[10];
                            
                            String[] kode2;
                            kode2 = new String[10];
                            String[] nama2;
                            nama2 = new String[10];
                            int[] jumlah2;
                            jumlah2 = new int[10];
                            
                            for(int y=0; y<invenBeans.length;y++){
                                
                                if(invenBeans[y].getProductBean().getProductSelling().equalsIgnoreCase("N")) {
                                    
                                    total += invenBeans[y].getTotalOut();
                                    code_a = invenBeans[y].getProductBean().getProductCode().trim();
                                    nom++;
                                    
                                    
                                    // simpan ke array
                                    kode1[nom-1] = invenBeans[y].getProductBean().getProductCode().trim();
                                    nama1[nom-1] = invenBeans[y].getProductBean().getDefaultName().trim();
                                    jumlah1[nom-1] = invenBeans[y].getTotalOut();
                                    
                                    System.out.println("A. Nilai kode1-"+nom+" = "+kode1[nom-1]+ " Nama-"+nom+" = "+nama1[nom-1]+ " Jumlah-"+nom+" = "+jumlah1[nom-1]);
                                    
                                    // kondisi beda
                                    
                                    if(!code_a.equalsIgnoreCase(code)) {
                                        
                                        
                                        if(!code.equalsIgnoreCase("")) {
                                            if(y > 1) {
                                                nomor++;
                                                // System.out.println("Masuk Beda 1, Looping="+no+ " code="+code+" code_a "+code_a+ " code1="+code1+" name1="+name1+" qty1= "+qty1);
                            %>     
                            
                            <tr>
                                <td align="center" width="3%"><%=nomor%>.</td>
                                <td align="left" width="15%"><%=code1 %></td>                        
                                <td align="left" width="30%"><%=name1 %></td>
                                <td align="left" width="15%"></td>
                                <td align="center" width="5%"><%= qty1 %></td>
                            </tr>                        
                            
                            
                            
                            <%   
                                            }else{
                                                nomor++;
                                                // System.out.println("Masuk Beda 2, Looping="+no+ " code="+code+" code_a "+code_a+ " code1="+code1+" name1="+name1+" qty1= "+qty1);
                            %>                        
                            
                            <tr>
                                <td align="center" width="3%"><%=nomor%>.</td>
                                <td align="left" width="15%"><%=code1 %></td>                        
                                <td align="left" width="30%"><%=name1 %></td>
                                <td align="left" width="15%"></td>
                                <td align="center" width="5%"><%= qty1 %></td>
                            </tr>         
                            
                            <%               
                                            }
                                        }
                                        
                                        // no++;
                                        code = invenBeans[y].getProductBean().getProductCode().trim();
                                        
                                        qty1  = qty;
                                        code1 = invenBeans[y].getProductBean().getProductCode().trim();
                                        name1 = invenBeans[y].getProductBean().getDefaultName().trim();
                                        
                                    }
                                    
                                    // kondisi sama
                                    else{
                                        // chek nilai code1
                                        
                                        if(!code1.equalsIgnoreCase(invenBeans[y].getProductCode().trim())) {
                                            qty1  = qty1 + qty;
                                            code = invenBeans[y].getProductBean().getProductCode().trim();
                                            name = invenBeans[y].getProductBean().getDefaultName().trim();
                                        }else{
                                            qty1  = qty1 + qty;
                                            code1 = invenBeans[y].getProductBean().getProductCode().trim();
                                            name1 = invenBeans[y].getProductBean().getDefaultName().trim();
                                        }
                                    } // else if sama
                                } //end if kit
                            } //end for
                            %>
                            
                            
                            <% 
                            nomor++;
                            // System.out.println("Masuk Akhir, Looping="+no+ " code="+code+" code_a "+code_a+ " code1="+code1+" name1="+name1+" qty1= "+qty1);
                            
                            if(!code1.equalsIgnoreCase("")){
                            %>
                            
                            
                            <tr>
                                <td align="center" width="3%"><%=nomor%>.</td>
                                <td align="left" width="15%"><%=code1 %></td>                        
                                <td align="left" width="30%"><%=name1 %></td>
                                <td align="left" width="15%"></td>
                                <td align="center" width="5%"><%= qty1 %></td>
                            </tr>   
                            
                            <%
                            }
                            %>                            
                            
                            
                        </table>
                        
                        <table width="100%" border="0" >  
                            <tr>
                                <td align="right" colspan="4" width="63%" ><b>Total Qty :</b></td>
                                <td align="center" width="5%"><b><%= total%> </b></td>
                            </tr>   
                        </table>
                    </table>
                </td>
            </tr>
            
            <table width="100%">
                <tr>
                    <td height="150"></td>
                    
                    <%
                    // print nilai akhir array
                    String kode = "";
                    int jumlah = 0;
                    int status2 = 0;
                    int hit = 0;
                    
                    for (int x=0; x < 10 ; x++) {
                        
                        if(kode1[x] == null) {
                            // null
                            // System.out.println("Nilai Null kode1-"+x+" = "+kode1[x]+ " Nama-"+x+" = "+nama1[x]+ " Jumlah-"+x+" = "+jumlah1[x]);
                        }else{
                            // not null
                            hit = hit + 1;
                            
                            System.out.println("Hit Awal : "+hit+ " kode1-"+x+" = "+kode1[x]+ " jumlah1-"+x+" = "+jumlah1[x]);
                            
                            if(!kode1[x].equalsIgnoreCase("") && !kode1[x].trim().equalsIgnoreCase(kode)) {
                                
                                
                                // find item di array, tuk update jumlah
                                if(hit > 1) {
                                    
                                    kode = kode1[x];
                                    
                                    for (int y=1; y <= hit ; y++) {
                                        if(kode2[y] == null)
                                            kode2[y] = "";
                                        
                                        if(!kode2[y].equalsIgnoreCase("") && kode2[y].trim().equalsIgnoreCase(kode)) {
                                            // update jumlah
                                            jumlah2[y] = jumlah2[y] + jumlah1[x];
                                            kode = kode2[y];
                                            status2 = 3;
                                            System.out.println("Hit : "+hit+ " Status Update= "+ status2 + " kode2-"+y+" = "+kode2[y]+ " jumlah2-"+y+" = "+jumlah2[y]);
                                            continue;
                                        }
                                    }
                                }
                                
                                // find item di array, tuk create new array                                
                                for (int y=1; y <= hit ; y++) {
                                    
                                    if(kode2[y] == null)
                                        kode2[y] = "";
                                    
                                    if(kode2[y].equalsIgnoreCase("") && !kode2[y].trim().equalsIgnoreCase(kode1[x]) && status2 < 3) {
                                        // create item
                                        kode2[hit] = kode1[x];
                                        nama2[hit] = nama1[x];
                                        jumlah2[hit] = jumlah1[x];
                                        kode = kode2[hit];
                                        status2 = 1;
                                        System.out.println("Hit : "+hit+ " Status Create = "+ status2 + " kode2-"+y+" = "+kode2[y]+ " jumlah2-"+y+" = "+jumlah2[y]);
                                        continue;
                                    }
                                }
                                
                                // find item di array
                    /*
                    if(hit > 1)
                    {
 
                    for (int y=1; y <= hit ; y++) {
                    if(kode2[y] == null)
                    kode2[y] = "";
 
                    if(!kode2[y].equalsIgnoreCase("") && kode2[y].trim().equalsIgnoreCase(kode) ) {
                    // kode = kode1[y];
                    // update before
                    jumlah2[y] = jumlah2[y] + jumlah1[x];
                    status2 = 2;
                    System.out.println("Hit : "+hit+ " Status Update= "+ status2 + " kode2-"+y+" = "+kode2[y]+ " jumlah2-"+y+" = "+jumlah2[y]);
                    continue;
 
                    }
                    }
 
                    }
                     */
                                
                            }else{
                                // sama
                                // kode2[x-1] = kode1[x];
                                // nama2[x-1] = nama1[x];
                                // update jumlah
                                
                                // find array di kode2
                    /*
                    for (int y=0; y < 10 ; y++) {
                    if(kode2[y].trim().equalsIgnoreCase(kode1[x])) {
                    // update
                    System.out.println(" Status Update = "+ status2);
                    jumlah2[y]=jumlah2[y] + jumlah1[x];
                    }
 
                    System.out.println("check Find kode2-"+y+" = "+kode2[y] + " Nama-"+2+" = "+nama2[y]+ " Jumlah2-"+y+" = "+jumlah2[y]);
                    }
                    status2 = 0;
                     */
                                
                            }
                            
                        }
                    }
                    
                    // print kode2
                    
                    for (int x=1; x <= hit  && !kode2[x].trim().equalsIgnoreCase(""); x++) {
                        if(kode2[x] != null) {
                            System.out.println("Hit : "+hit+ " Nilai kode2-"+x+" = "+kode2[x]+ " Nama2-"+x+" = "+nama2[x]+ " Jumlah2-"+x+" = "+jumlah2[x]);
                        }
                        
                    }
                    
                    
                    %>                     
                </tr>
            </table>
            
            <table width="100%" border="0" style="border:1px #000000 solid pading:3">  
                <tr>
                    <td><b><i18n:label code="GENERAL_REMARK"/> : </b><br>
                        <%= ((invenBean.getRemark()!=null && invenBean.getRemark().length()>0)?invenBean.getRemark().replaceAll("\n","<br>"):"-")%>
                    </td>
                </tr>
            </table>
            
            <tr>
                <td>&nbsp;</td>
            </tr>
            
            <tr>
                <td>
                    <%@ include file="/admin/jsp/inventory/stock_doc_bottomsign.jsp"%>
                </td>
            </tr>
            
        </table>
        
        <%@ include file="/lib/return_error_msg.jsp"%> 
        
    </body>
</html>