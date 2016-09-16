<%@page import="com.ecosmosis.orca.webcontent.*"%>
<%@page import="com.ecosmosis.mvc.manager.MvcReturnBean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/lib/header_no_auth_without_css.jsp"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ContentCategoryBean[] list = (ContentCategoryBean[])returnBean.getReturnObject("CatList");
	TreeMap status_list = (TreeMap) returnBean.getReturnObject("Status");
	
	boolean canView = (list!=null);	
	boolean isEnglish = (request.getParameter("en")!=null);
%> 
<title>PT Chi Indonesia</title>
<style type="text/css">
<!--
body {cfo.
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<script type="text/javascript" src="<%= request.getContextPath() %>/public/webcontent/chi/menu.js"></script>
<link href="<%= request.getContextPath() %>/public/webcontent/chi/chi.css" rel="stylesheet" type="text/css" />
</head>

<body bgcolor="#f2f4ea">
<table cellpadding="0" cellspacing="0" border="0" width="770" align="center">
<tr><td height="15" colspan="3"></td></tr>
<tr>
<td width="5"></td>
<td background="<%= request.getContextPath() %>/public/webcontent/chi/shadow(v).jpg" width="760" height="5"><img src="<%= request.getContextPath() %>/public/webcontent/chi/shadow(v).jpg" width="760" height="5"/></td>
<td width="5"></td></tr>
<tr><td width="770" colspan="3">
<table cellpadding="0" cellspacing="0" border="0" width="100%">
	<tr>
		<td width="5" background="<%= request.getContextPath() %>/public/webcontent/chi/shadow(h).jpg"></td>
		<td width="760">
		<table cellpadding="0" cellspacing="0" border="0" width="760" align="center">
		<tr>
	<td width="760">
	<table cellpadding="0" cellspacing="0" border="0" width="760">
	<tr>
		<td bgcolor="#51a902" width="10"><img src="<%= request.getContextPath() %>/public/webcontent/chi/corner_top.jpg" width="10" height="10" /></td>
		<td width="740" bgcolor="#51a902" class="bordertop" colspan="2"><span class="hidden">&nbsp;</span></td>
		<td><img src="<%= request.getContextPath() %>/public/webcontent/chi/corner_top_right.jpg" width="10" height="10" /></td>
	</tr>
	<tr>
		<td background="<%= request.getContextPath() %>/public/webcontent/chi/topbg.jpg" width="9" class="border_left">&nbsp;</td>
		<%if(!isEnglish){%>
			<td class="verdana12white" background="<%= request.getContextPath() %>/public/webcontent/chi/topbg.jpg" colspan="2">&nbsp;&nbsp;<b>BAHASA</b> <a href="../public_html/" class="verdana12white"><b>INDONESIA</b></a> | <a href="../public_html/home.htm" class="verdana12white">ENGLISH</a>
		<%}else{ %>	
			<td class="verdana12white" background="<%= request.getContextPath() %>/public/webcontent/chi/topbg.jpg" colspan="2">&nbsp;&nbsp;BAHASA <a href="../public_html/" class="verdana12white">INDONESIA</a> | <a href="../public_html/home.htm" class="verdana12white"><b>ENGLISH</b></a>	
		<%} %>
		
		<span class="hidden"><br /><br /></span>&nbsp;&nbsp;<a href="../emember/"><img src="<%= request.getContextPath() %>/public/webcontent/chi/login_button.jpg" border="0" /></a>
		</td>
		<td background="<%= request.getContextPath() %>/public/webcontent/chi/topbg.jpg" width="9" class="border_right">&nbsp;</td>
	</tr>
	<tr>
		<td background="<%= request.getContextPath() %>/public/webcontent/chi/topbg2.jpg" width="9" height="48" class="border_left">&nbsp;</td>
		<td background="<%= request.getContextPath() %>/public/webcontent/chi/topbg2.jpg" width="380" height="48"></td>
		<td background="<%= request.getContextPath() %>/public/webcontent/chi/topbg2.jpg" height="48" valign="top" width="360"><img src="<%= request.getContextPath() %>/public/webcontent/chi/toptext.jpg" /></td>
		<td background="<%= request.getContextPath() %>/public/webcontent/chi/topbg2.jpg" width="9" height="48" class="border_right">&nbsp;</td>
	</tr>
	</table>
	</td>
</tr>
<tr><td><img src="<%= request.getContextPath() %>/public/webcontent/chi/berita_banner.jpg" /></td></tr>
<tr>
<td>
<ul id="maintab" class="basictab">

<%if(!isEnglish){%>
	<li rel="home"><a href="http://192.168.0.7/test/public_html/">Home&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="basictab2">|</span></a></li>
	<li rel="profile"><a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/message.htm">Profile Perusahaan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="basictab2">|</span></a></li>
	<li rel="peluang"><a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/anggota.htm">Peluang Usaha&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="basictab2">|</span></a></li>
	<li rel="produk"><a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/product.htm">Produk&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="basictab2">|</span></a></li>
	<li rel="berita"><a href="#">Berita&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="basictab2">|</span></a></li>
	<li rel="hubungi"><a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/contact.htm">Hubungi Kami</a></li>
<%}else{ %>
	<li rel="home"><a href="http://192.168.0.7/test/public_html/home.htm">Home&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="basictab2">|</span></a></li>
	<li rel="profile"><a href="http://192.168.0.7/test/public_html/web.htm/en/US/message.htm">Company Profile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="basictab2">|</span></a></li>
	<li rel="peluang"><a href="http://192.168.0.7/test/public_html/web.htm/en/US/anggota.htm">Business Opportunity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="basictab2">|</span></a></li>
	<li rel="produk"><a href="http://192.168.0.7/test/public_html/web.htm/en/US/product.htm">Product&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="basictab2">|</span></a></li>
	<li rel="berita"><a href="#">News&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="basictab2">|</span></a></li>
	<li rel="hubungi"><a href="http://192.168.0.7/test/public_html/web.htm/en/US/contact.htm">Contact Us</a></li>
<%} %>

</ul></td></tr>
<tr><td>
<div class="visible">
<div id="home" class="submenustyle">&nbsp;
</div>

<%if(!isEnglish){%>

<div id="profile" class="submenustyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/message.htm">Pesan dari Kami</a>
<a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/visi.htm">Visi, Misi dan Value Kami</a>
<a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/rekan.htm">Rekan Bisnis Kami</a>
</div>

<div id="peluang" class="submenustyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/anggota.htm">Bagaimana Menjadi Chi Franchise Owner (CFO)</a>
<a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/peluang.htm">Rancangan Bisnis</a>
<a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/wajibcfo.htm">Kewajiban CFO Kami</a>
</div>

<div id="produk" class="submenustyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/product.htm">Rangkaian Produk</a>
</div>

<div id="berita" class="submenustyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="#">Berita Chi</a>
<a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/construction.htm">Berita Kemasyarakatan</a>
<a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/info.htm">Info Chi</a>
</div>

<div id="hubungi" class="submenustyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/contact.htm">Alamat Chi</a>
<a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/construction.htm">Tanya Jawab</a>
<a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/sub.htm">Franchise Sub Store</a>
</div>

<%}else{ %>
<div id="profile" class="submenustyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="http://192.168.0.7/test/public_html/web.htm/en/US/message.htm">Message from Us</a>
<a href="http://192.168.0.7/test/public_html/web.htm/en/US/visi.htm">Our Vision, Mission, and Values</a>
<a href="http://192.168.0.7/test/public_html/web.htm/en/US/rekan.htm">Our Business Partner</a>
</div>

<div id="peluang" class="submenustyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="http://192.168.0.7/test/public_html/web.htm/en/US/anggota.htm">How to Become a Chi Franchise Owner (CFO)</a>
<a href="http://192.168.0.7/test/public_html/web.htm/en/US/peluang.htm">Business Plan</a>
<a href="http://192.168.0.7/test/public_html/web.htm/en/US/wajibcfo.htm">Our CFO's Obligation</a>
</div>

<div id="produk" class="submenustyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="http://192.168.0.7/test/public_html/web.htm/en/US/product.htm">Product Series</a>
</div>

<div id="berita" class="submenustyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="#">Chi News</a>
<a href="http://192.168.0.7/test/public_html/web.htm/en/US/construction.htm">Society News</a>
<a href="http://192.168.0.7/test/public_html/web.htm/en/US/info.htm">Chi Info</a>
</div>

<div id="hubungi" class="submenustyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="http://192.168.0.7/test/public_html/web.htm/en/US/contact.htm">Address Chi</a>
<a href="http://192.168.0.7/test/public_html/web.htm/en/US/construction.htm">FAQ</a>
<a href="http://192.168.0.7/test/public_html/web.htm/en/US/sub.htm">Franchise Sub Store</a>
</div>
<%} %>

<script type="text/javascript">
//initialize tab menu, by passing in ID of UL
initalizetab("maintab")
</script>
</div>
</td></tr>
<tr>
	<td valign="top" width="760">
	<table cellpadding="0" cellspacing="0" border="0" width="100%" bgcolor="#ffffff">
	<tr>
		<td class="border_right" colspan="3"><img src="<%= request.getContextPath() %>/public/webcontent/chi/corner_left.jpg" width="10" height="10" /></td>
	</tr>
	<tr>
		<td width="37" class="border_left">&nbsp;</td>
		<td class="arial17green" width="713">
		<%if(!isEnglish){%>
		<strong>Berita</strong>  /  Berita Chi
		<%}else{%>
		<strong>News</strong>  /  Chi News
		<%}%>		
		</td>
		<td class="border_right" width="10"><span class="hidden">&nbsp;</span></td>
	</tr>
	<tr>
		<td colspan="3" class="border_left_right" background="<%= request.getContextPath() %>/public/webcontent/chi/bg4.jpg" height="10"><span class="hidden">&nbsp;</span></td>
	</tr>
	<tr>
		<td colspan="3" width="760">
  		
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
		<tr>
			<td width="188" height="300" align="right" class="border_top_left" bgcolor="#f8fcf3" valign="top"><span class="hidden"><br /><br /><br /></span><img src="<%= request.getContextPath() %>/public/webcontent/chi/berita.jpg"/></td>
			<td valign="top" bgcolor="#f8fcf3"><img src="<%= request.getContextPath() %>/public/webcontent/chi/corner_middle_right.jpg" width="10" height="10" /></td>
			<td rowspan="2" class="border_left" width="10" valign="top"><img src="<%= request.getContextPath() %>/public/webcontent/chi/corner_left.jpg" width="10" height="10" /></td>
			<td rowspan="2" width="552" class="border_top_right" valign="top">
			<table cellpadding="15" cellspacing="0" border="0" width="100%">
			<tr>
				<td class="verdana11green">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
		  <%
  		  		if(list!=null && list.length>0){	
  		  			for(int i=0; i<list.length;i++){
  		  				boolean isActive = (list[i].getStatus().equalsIgnoreCase("A"));
		  %>
			<c:if test="<%=(i>0)%>">
				<tr><td height="20" colspan=3></td></tr>
			</c:if>				
				<tr>
					<td colspan="3"><strong><%=(isActive)?"":"<S>"%><%=list[i].getCategoryName()%><%=(isActive)?"":"</S>"%></strong></td>
				</tr>				
		  <%
		  		  		if(list[i].getContents()!=null){	
			  		  		for(int j=0; j<list[i].getContents().length;j++){
				  		  		boolean isContentActive = (list[i].getContents()[j].getStatus().equalsIgnoreCase("A"));
		  %>				
				<tr><td height="10" colspan="3"></td>
				</tr>
				<tr>
					<td><%=(j+1)%>. </td>
					<td width="75%">
						<%=(isActive)?"":"<S>"%>			  	
					  	<a href="<%=Sys.getControllerURL(WebManager.TASKID_CONTENT_DISPLAY_PUBLIC,request)%>&ID=<%=list[i].getContents()[j].getContentID()%>" target="_blank" class="verdana11lightgreen">
					  	<%=list[i].getContents()[j].getTopic()%>
					  	</a>			  	
			  			<%=(isActive)?"":"</S>"%>
			  		</td>
					<td width="22%"><%=list[i].getContents()[j].getPostDate()%></td>
				</tr>
		 <%
			  		  		}//end for
		  		  		}//end if	
		 %>				  		
		  
		  <%	}//end for 
		  	}else{
		  %>
		  	<tr><td colspan=3 align=center><i18n:label code="MSG_NO_RECORDFOUND"/></td></tr>
		  <%} %>
				</table>
				</td>
			</tr>
			</table>
			
			</td>
		</tr>
		<tr>
				<td colspan="2" class="border_left" bgcolor="#f8fcf3" height="95" valign="top">&nbsp;&nbsp;&nbsp;</td>
			</tr>
		<tr>
			<td colspan="2" width="198" bgcolor="#f8fcf3">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td><img src="<%= request.getContextPath() %>/public/webcontent/chi/corner_bottom_left.jpg" width="10" height="10" /></td>
				<td class="border_bottom" width="188"><span class="hidden">&nbsp;</span></td>
			</tr>
			</table>
			</td>
			<td colspan="2" width="562">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td class="border_bottom_left" width="10"><span class="hidden">&nbsp;</span></td>
				<td class="border_bottom" width="542"><span class="hidden">&nbsp;</span></td>
				<td width="10"><img src="<%= request.getContextPath() %>/public/webcontent/chi/corner_bottom_right.jpg" width="10" height="10" /></td>
			</tr>
			</table>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	</td>
</tr>
		</table>
		</td>
		<td width="5" background="<%= request.getContextPath() %>/public/webcontent/chi/shadow(hd).jpg"></td>
	</tr>
	<tr>
	<td></td>
	<td background="<%= request.getContextPath() %>/public/webcontent/chi/shadow(vd).jpg" width="760" height="5"></td>
	<td></td></tr>
	<tr><td height="5" colspan="3"></td></tr>
<tr>
<td></td>
<td>
<table cellspacing="0" cellpadding="0" border="0" width="760">
<tr>
	<td width="7"></td>
	<td width="48"><img src="<%= request.getContextPath() %>/public/webcontent/chi/pt.jpg" /></td>
	<td class="text10none" >@ Copyright by PT Chi 2006. All rights reserved.</td>
	<td class="text10none" align="right">
	<%if(!isEnglish){%>
	<a href="http://192.168.0.7/test/public_html/" class="text10none">Home</a> I <a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/message.htm" class="text10none">Profil Perusahaan</a> I <a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/peluang.htm" class="text10none">Peluang Usaha</a>  I <a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/product.htm" class="text10none">Produk</a> I <a href="#" class="text10none">Berita</a> I <a href="http://192.168.0.7/test/public_html/web.htm/bm/MY/contact.htm" class="text10none">Hubungi Kami</a>&nbsp;
	<%}else{%>
	<a href="http://192.168.0.7/test/public_html/home.htm" class="text10none">Home</a> I <a href="http://192.168.0.7/test/public_html/web.htm/en/US/message.htm" class="text10none">Company Profile</a> I <a href="http://192.168.0.7/test/public_html/web.htm/en/US/peluang.htm" class="text10none">Business Opportunity</a>  I <a href="http://192.168.0.7/test/public_html/web.htm/en/US/product.htm" class="text10none">Product</a> I <a href="#" class="text10none">News</a> I <a href="http://192.168.0.7/test/public_html/web.htm/en/US/contact.htm" class="text10none">Contact Us</a>&nbsp;
	<%}%>
	</td>
	<td width="7"></td>
</tr>
<tr><td height="10"></td></tr>
</table>
</td>
<td></td></tr>
</table></td></tr>

</table>
</body>
</html>