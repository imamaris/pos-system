<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bvwallet.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>

<%
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

%>


<html>
    <head>
        <%@ include file="/lib/header.jsp"%>
        
        <script LANGUAGE="JavaScript">
	
		function confirmSubmit()
		{                
			// var agree=confirm("<i18n:label code="MSG_CONFIRM"/>");                                                
                        var thisform = document.add;
                        dtStr = eval("thisform.periodid").value;
                        
                        var dtCh= "-";                
                        var daysInMonth = DaysArray(12);
                        var pos1=dtStr.indexOf(dtCh);
                        var pos2=dtStr.indexOf(dtCh,pos1+1);
                        var strYear=dtStr.substring(0,pos1);
                        var strMonth=dtStr.substring(pos1+1,pos2);
                        var strDay=dtStr.substring(pos2+1);
                        var nowDate = "<%= Sys.getDateFormater().format(new Date()) %>"; //Updated By Ferdi 2014-09-02

                        // alert("strDay :"+strDay+" strMonth :"+strMonth+" strYear :"+strYear);
                        
                        //Updated By Ferdi 2014-09-02
                        if(dtStr > nowDate)
                        {
                            alert("Initial Date Greater than Current Date\nProses Initial Date Failed !!!");
                            return false;
                        }
                        else
                        {
                            strYr=strYear
                            if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
                            if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
                            for (var i = 1; i <= 3; i++) {
                                    if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
                            }
                            month=parseInt(strMonth,10)
                            day=parseInt(strDay,10)
                            year=parseInt(strYr)

                            // alert("tahun :"+year);

                                    if (year<2013)
                                    {
                                       alert("The Year must be greater from 2012 !!");
                                       return false;  
                                    } 


                            var m_names = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");

                            var now1  = month+"/"+day+"/"+year;
                            var now2 = day+"-"+m_names[month-1]+"-"+year;
                            var agree = confirm("Confirm to Initial Date for \n '"+now2+"' ? ");

                            ///alert("now1 "+now1);

                            var sekarang = new Date(now1);
                            // sekarang.setDate(day);

                            var hari = sekarang.getDate();
                            var hari2 = "" + hari;                        
                            if(hari2.length<2) hari2="0"+hari2;

                            var bulan = sekarang.getMonth() + 1;                        
                            var bulan2 = "" + bulan;                        
                            if(bulan2.length<2) bulan2="0"+bulan2;

                            var tahun = sekarang.getYear();
                            var tanggal1 = tahun + "-" + bulan2 + "-01";

                            // alert("Tanggal1 :"+tanggal1);

                            if (agree)
                             {   

                            // cek H-1       
                            var echo = 0;
                            if(tanggal1 !="-1")
                            {
                                xmlHttp=GetXmlHttpObject();
                                if (xmlHttp==null)
                                {
                                    alert ("Browser does not support HTTP Request");
                                    return        
                                }

                                var url="CekInitial.jsp";
                                url=url+"?tanggal="+tanggal1+"&echo=" + echo;
                                echo = echo + 1;    

                             xmlHttp.onreadystatechange=function() {
                                if (xmlHttp.readyState==4) {
                                    stateChangedInitial(dtStr, nowDate, tanggal1, agree, xmlHttp.responseText); //Updated By Ferdi 2014-09-02                                                                  
                                }
                              };

                                xmlHttp.open("GET",url,false);
                                xmlHttp.send(null);
                            }
                            else
                            {
                                xmlHttp.close;   
                            }   
                            }
                            else
                            {
                                    return false ;
                            }
                        } //Updated By Ferdi 2014-09-02
		}
                
                
                
function stateChangedInitial(dtStr, sekarang, kemarin, agree, text) 
{ 
    // alert("tanggal :"+kemarin);
        
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
	
  var showdata = xmlHttp.responseText; 
  // alert(showdata);
  var strar = showdata.split(":");
	
         //Updated By Ferdi 2015-01-21
	 /*if((strar.length==1)  && (dtStr == sekarang)) //Updated By Ferdi 2014-09-02
	 {        
	   alert("Initial Date "+kemarin+" has not been created. Automatically, System will change the Initial Date for "+kemarin);    
           var thisform = document.add;
           thisform.periodid.value = kemarin ;
           var strDay=kemarin.substring(8);
           // alert("cek strDay : "+strDay);

                               if (strDay = "01")
                                {
                                  document.getElementById("Check").value = "1";                                                                        
                                } 
                                else 
                                {
                                  document.getElementById("Check").value = "0";  
                                }
                                
         }         
	 else if(strar.length>1)
	 {  
           // alert("Initial Date has been Made "+kemarin+ " aggre : "+agree);
	 }*/
         //End Updated
	
 }
 
}

function GetXmlHttpObject()
{
var xmlHttp=null;
try
 {
 // Firefox, Opera 8.0+, Safari
 xmlHttp=new XMLHttpRequest();
 }
catch (e)
 {
 //Internet Explorer
 try
  {
  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
  }
 catch (e)
  {
  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
 }
return xmlHttp;
}
                
                
                
                
	
        </script>
        
    </head>
    
    <body>
        
        <div class="functionhead">Add Initial Date</div>
        
        <%@ include file="/general/mvc_return_msg.jsp"%>
        
        <form name="add" action="<%=Sys.getControllerURL(BonusPeriodManager.TASKID_ADD_NEW_BONUSPERID_2,request)%>" method="post">
            
            <table  class="listbox" width=400>
                
                <tr>
                    <td width="200"  class="odd">Initial Date :</td>
                    <td><std:input type="date" name="periodid" value="<%= Sys.getDateFormater().format(new Date()) %>"  size="12" /></td>
                    
                </tr>	 
                <input type="hidden" name="Check" id="Check"  /> 
            </table>
            
            
            
            <table width=500 border="0" cellspacing="0" cellpadding="0" >
                <tr><td>&nbsp</td></tr>
                <tr><td>&nbsp</td></tr>
                <tr class="head">
                    <td align="center"><input type="submit" value="    OK     "  onclick="return confirmSubmit()" ></td>
                </tr>
            </table>
            
        </form>
        
    </body>
</html>