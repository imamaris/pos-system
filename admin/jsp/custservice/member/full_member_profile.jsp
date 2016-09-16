<%@ page import="com.ecosmosis.common.bank.*"%>
<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
  LocationBean selfNationality = null;
  AddressBean address = null;
  PayeeBankBean payeeBank = null;
  SpouseBean spouse = null;
  BeneficiaryBean bf = null;
  
  MemberBean bean = (MemberBean) returnBean.getReturnObject(MemberManager.RETURN_MBRBEAN_CODE);
  
  boolean canView = false;
  if (bean != null && !bean.isHidden()) {
		selfNationality = bean.getSelfNationality();
		address = bean.getAddress();
		payeeBank = bean.getPayeeBank();
		spouse = bean.getSpouse();
		bf = bean.getBeneficiary();
	 	canView = true;
 	}
%>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<%
		if (bean.getType().equals(MemberManager.MBRTYPE_INDIVIDUAL)) {
%>

<%@ include file="/admin/jsp/custservice/member/member_profile_individual.jsp"%>

<%
		} else if (bean.getType().equals(MemberManager.MBRTYPE_COMPANY)) {
%>

<%@ include file="/admin/jsp/custservice/member/member_profile_company.jsp"%>

<%
		}
%>

<% 
	} // end canView
%>
