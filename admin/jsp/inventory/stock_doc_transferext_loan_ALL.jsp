<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.outlet.OutletBean"%>
<%@page import="com.ecosmosis.orca.member.MemberBean"%>
<%@page import="com.ecosmosis.orca.outlet.store.OutletStoreBean"%>
<%@page import="com.ecosmosis.orca.supplier.SupplierBean"%>
<%@page import="com.ecosmosis.orca.product.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date"%>

<html>
    <head>
        <%@ include file="/lib/header.jsp"%>
    </head>
    <%
    MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
    
    OutletBean outlet = (OutletBean) returnBean.getReturnObject("Outlet");
    // MemberBean outletTo = (MemberBean) returnBean.getReturnObject("OutletTo");
    
    InventoryBean invenBean = (InventoryBean) returnBean.getReturnObject("InventoryBean");
    InventoryBean[] invenBeans = (InventoryBean[]) returnBean.getReturnObject("InventoryBeans");
    String target = (String) returnBean.getReturnObject("Target");
    
    String document_name = lang.display("STOCK_TRANSFER_EXTERNAL");
    
    
  Calendar startCal = Calendar.getInstance();
  startCal.setTime(invenBean.getTrnxDate());

  for (int i = 1; i < 7; i++)
  {
    startCal.add(Calendar.DAY_OF_MONTH, 1);
    /* If not Saturday & Sunday 
    while (startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY)
    {
      startCal.add(Calendar.DAY_OF_MONTH, -1);
    }
    */
  }
  
  String awal1 = Sys.getDateFormater().format(startCal.getTime());

  System.out.println("Nilai awal "+awal1); 
    
        
    %>
    
    <body onLoad="self.focus();">
        <table width="100%">
            
            <% if(invenBean.getStatus()==90 && invenBean.getTrnxType().equalsIgnoreCase("SKLO")) { %>
                             
            <table width="100%" class=noprint >
                <tr>
                    <td width="50%" align="left">
                        <table width="25%" border="1" cellspacing="1" cellpadding="1">
                            <tr>         
                                <td align=center height="30" > <font color="red"> <b><std:doc_invt doc="LOAN" value2= "<%=invenBean.getTrnxDocNo() %>" value="Process Verify LOAN OUT" type="1"/> </b> </font></td>            
                            </tr>
                        </table>
                    </td>
                    <td width="50%" align="right">
                        <table width="25%" border="1" cellspacing="1" cellpadding="1">
                            <tr>         
                                <td align=center height="30" > <font color="red"> <b><std:doc_invt doc="VOIDLOAN" value2= "<%=invenBean.getTrnxDocNo() %>" value="Process VOID" type="1"/> </b> </font></td>            
                            </tr>
                        </table>
                    </td>               
                    
                </tr>
            </table>
            
            <% 
            } else if(invenBean.getStatus()==100 && invenBean.getTrnxType().equalsIgnoreCase("SKLO")) {      
            %> 
            
            <table width="100%" >
                <tr>       
                    <td width="15%" align="left"  height="30">
                        <input class=noprint type="button" value="  PRINT  " onclick="window.print()">
                    </td>                    
                    <td width="50%" align=center height="30" class=noprint > <font color="blue"> <b>This document has been verified loan out </b> </font> </td> 
                    
                    <td width="35%" align="right">

                    </td>               
                </tr>
                
                <tr>       
                    <td width="15%" align="left"  height="30">                  
                    </td>                    
                    <td width="50%" align=center height="30" class=noprint ></td> 
                    
                    <td width="35%" align="right">
 
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
                    <%@ include file="/admin/jsp/inventory/stock_doc_headerparties_loan.jsp"%>
                </td>
            </tr>
            
            <tr>
                <td>
                    <table width="100%" border="0">
                        <table width="100%" border="0">  
                            <tr valign=top >
                                <td align=center width="3%"><b><i18n:label code="<%=StandardMessageTag.NO%>"/>.</td>
                                <td align=center width="15%"><b>Reference No </td>                       
                                <td align=center width="30%"><b>Description</td>
                                <td align=center width="15%"><b>Serial No</td>
                                <td align=center width="5%"><b>Qty</b></td>
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
                                <td align="left" width="15%"><%=invenBeans[i].getProductBean().getSkuCode()%></td>
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
                            kode1 = new String[21];
                            String[] nama1;
                            nama1 = new String[21];
                            int[] jumlah1;
                            jumlah1 = new int[21];
                            
                            String[] kode2;
                            kode2 = new String[21];
                            String[] nama2;
                            nama2 = new String[21];
                            int[] jumlah2;
                            jumlah2 = new int[21];
                            
                           System.out.println("simpan ke arrray ");
                           for(int y=0; y<invenBeans.length;y++){
                                if(invenBeans[y].getProductBean().getProductSelling().equalsIgnoreCase("N")) {
                                    nom++;
                                    // simpan ke array
                                    kode1[nom-1] = invenBeans[y].getProductBean().getProductCode().trim();
                                    nama1[nom-1] = invenBeans[y].getProductBean().getDefaultName().trim();
                                    jumlah1[nom-1] = invenBeans[y].getTotalOut();
                                    System.out.println("A. Nilai kode1-"+nom+" = "+kode1[nom-1]+ " Nama-"+nom+" = "+nama1[nom-1]+ " Jumlah-"+nom+" = "+jumlah1[nom-1]);
                                }
                            }
                            
                            
                            // print nilai akhir array
                            String kode = "";
                            int jumlah = 0;
                            int status2 = 0;
                            String status3 = "";
                            
                            int hit = 0;
                            
                            System.out.println("mulai Create/Update ke array ");
                            for (int x=0; x < 21 ; x++) {
                                
                                if(kode1[x] != null) {
                                    // not null
                                    status2 = 0;
                                    hit = hit + 1;
                                    System.out.println("  Hit Awal : "+hit+ " kode1-"+x+" = "+kode1[x]+ " jumlah1-"+x+" = "+jumlah1[x]+ " Cek Kode: "+kode + " Status: "+status2);
                                    
                                    if(!kode1[x].equalsIgnoreCase("") && !kode1[x].trim().equalsIgnoreCase(kode)) {
                                        
                                        // find item di array, tuk update jumlah
                                        if(hit > 1) {
                                            kode = kode1[x];
                                            System.out.println("   find item di array, tuk update jumlah ");
                                            for (int y=1; y <= hit ; y++) {
                                                if(kode2[y] == null)
                                                    kode2[y] = "";
                                                
                                                if(!kode2[y].equalsIgnoreCase("") && kode2[y].trim().equalsIgnoreCase(kode)) {
                                                    // update jumlah
                                                    jumlah2[y] = jumlah2[y] + jumlah1[x];

                                                    kode = kode2[y];
                                                    status2 = 3;
                                                    System.out.println("   Hit : "+hit+ " Status Update= "+ status2 + " kode2-"+y+" = "+kode2[y]+ " jumlah2-"+y+" = "+jumlah2[y] +" Status: "+status2);
                                                    continue;
                                                }  
                                            }
                                            
                                            if(status2 < 3)
                                                System.out.println("  update ga ketemu ");
                                        }
                                        
                                        // find item di array, tuk create new array
                                        for (int y=1; y <= hit ; y++) {
                                            
                                        // if(hit>3)
                                           // System.out.println(" Sampai sini 03, cek status2 "+status2);
                                            
                                            if(kode2[y] == null)
                                                kode2[y] = "";
                                               
                                               if(kode2[y].equalsIgnoreCase("") && !(kode1[x].equalsIgnoreCase("")) && status2 < 3) {

                                                kode2[hit] = kode1[x];                                             
                                                nama2[hit] = nama1[x];
                                                jumlah2[hit] = jumlah1[x];
                                                kode = kode2[hit];

                                                status2 = 1;
                                                System.out.println("   find item di array, tuk create new array ");
                                                System.out.println("   Hit : "+hit+ " Status Create = "+ status2 + " kode2-"+hit+" = "+kode2[hit]+ " jumlah2-"+hit+" = "+jumlah2[hit]+ " Status: "+status2);
                                                continue;
                                            }
                                        }
                                        
                                            if(status2 > 1)
                                                System.out.println("  create ga berhasil ");                                        
                                    }
                                        
                                    else{
                                        // sama
                                        // System.out.println("Masuk sini mas ");                                        
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
                                                    System.out.println("Posisi Sama, find item di array, tuk update jumlah ");
                                                    System.out.println("Hit : "+hit+ " Status Update= "+ status2 + " kode2-"+y+" = "+kode2[y]+ " jumlah2-"+y+" = "+jumlah2[y]+ " Status: "+status2);
                                                    continue;
                                                }
                                            }
                                            
                                            
                                        }                                          
                                        
                                    }
                                    
                                }
                            }
                            
                            // print kode2
                            System.out.println("Print kode2 ");
                            
                            for (int x=0; x < 21 ; x++) {
                                                if(kode2[x] == null)
                                                    kode2[x] = "";                                
                                
                                if(!kode2[x].trim().equalsIgnoreCase("")) {
                                    total = total + jumlah2[x];
                                    no ++;    
                                    System.out.println("Hit : "+hit+ " Nilai kode2-"+x+" = "+kode2[x]+ " Nama2-"+x+" = "+nama2[x]+ " Jumlah2-"+x+" = "+jumlah2[x]);
                            %>
                            
                            <tr>
                                <td align="center" width="3%"><%=no%>.</td>
                                <td align="left" width="15%"><%=kode2[x] %></td>                        
                                <td align="left" width="30%"><%=nama2[x] %></td>
                                <td align="left" width="15%"></td>
                                <td align="center" width="5%"><%= jumlah2[x] %></td>
                            </tr> 
                            
                            <%       
                               }
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
                    <td height="10"></td>
     
                </tr>
            </table>
            
            <tr>
                <td>
                    <%@ include file="/admin/jsp/inventory/stock_doc_bottomsign_loan.jsp"%>
                </td>
            </tr>
            
        </table>
        
        <%@ include file="/lib/return_error_msg.jsp"%> 
        
    </body>
</html>