<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.outlet.OutletBean"%>
<%@page import="com.ecosmosis.orca.member.MemberBean"%>
<%@page import="com.ecosmosis.orca.outlet.store.OutletStoreBean"%>
<%@page import="com.ecosmosis.orca.supplier.SupplierBean"%>

<%@ page import="java.sql.*" %>

<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">
      
var echo  = 0;

function updateStatus(dokumen)
{ 

alert ("Do you want to Process ? "+dokumen); 

// if(dokumen.length() > 0)
// {
    xmlHttp=GetXmlHttpObject();

    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return        
    }
 
    var url="NoVerifyout.jsp";   
    url=url+"?sku_kode="+dokumen+"&echo=" + echo;
    echo = echo + 1;       
    
 xmlHttp.onreadystatechange=function() {
    if (xmlHttp.readyState==4) {
      // alert(dokumen);
      stateChangedStatus(dokumen, xmlHttp.responseText);      
    }
  };
  
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
// }
// else
// {
   // alert("Please Fill Product Code 1 ...");
//   xmlHttp.close;
// }


}

function stateChangedStatus(dokumen, text) 
{ 
    //  document.getElementById("iprice_").value ="";	
        
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
	
  // var showdata = xmlHttp.responseText; 
  // var strar = showdata.split("~");
  
  /*
  
  // alert(text);
  
	 if(strar.length==1)
	 {         
                document.getElementById("icode_").focus();   
                // alert ("a");
	 }
	 else if(strar.length>1)
	 {
            var strname = strar[1];
            document.getElementById("iprice_").value= strar[9];  
            // document.getElementsByName("DiscountAmount").value= strar[9];    
             // alert ("b");
     }

	 */
	
    alert("sampai sini");	 
	
 }
}
    
</script>
</head>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  
  OutletBean outlet = (OutletBean) returnBean.getReturnObject("Outlet");
  // MemberBean outletTo = (MemberBean) returnBean.getReturnObject("OutletTo");
  
  InventoryBean invenBean = (InventoryBean) returnBean.getReturnObject("InventoryBean");
  InventoryBean[] invenBeans = (InventoryBean[]) returnBean.getReturnObject("InventoryBeans");
  String target = (String) returnBean.getReturnObject("Target");
	  
  String document_name = lang.display("STOCK_TRANSFER_EXTERNAL");
%>

<body onLoad="self.focus();">

<%@ include file="/lib/return_error_msg.jsp"%>

<table width="100%">
 <tr>
     <td width="10%" align="left" height="30">
         <input class=noprint type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()">
     </td>
   <%if(invenBean.getTrnxType().equalsIgnoreCase("SKLI") && invenBean.getStatus() == 100)
        { %>
        
            <td width="80%" align="right" class=noprint > <font color="blue"> <b>This document has been Verified Loan IN </b> </font> </td>     
 
        <% 
        }     
        %>         
        
    </tr> 
</table>
 
<table width="100%">

<tr>
<td>
  <%@ include file="/admin/jsp/inventory/stock_doc_headerparties_loan_in.jsp"%>
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
                            for(int i=0; i<invenBeans.length; i++){
                                
                                if(invenBeans[i].getTrnxType().equalsIgnoreCase("SKLI") && invenBeans[i].getProductBean().getProductSelling().equalsIgnoreCase("Y")) {
                                    total += invenBeans[i].getTotalIn();
                                    no ++;                                   
                            %>             
                            <tr>
                                <td align="center" width="3%"><%=no%>.</td>
                                <td align="left" width="15%"><%=invenBeans[i].getProductBean().getProductCode() %></td>                        
                                <td align="left" width="30%"><%=invenBeans[i].getProductBean().getDefaultName() %></td>
                                <td align="left" width="15%"><%=invenBeans[i].getProductBean().getSkuCode() %></td>
                                <td align="center" width="5%"><%= invenBeans[i].getTotalIn() %></td>
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
                                    jumlah1[nom-1] = invenBeans[y].getTotalIn();
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
        <td height="50"></td>
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

  	
</form>
</body>
</html>