// Decompiled Progress by Dodi
// DeCompiled : MemberManager.class

package com.ecosmosis.orca.salesman;

import com.ecosmosis.common.customlibs.FIFOMap;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.mvc.sys.Sys;
import com.ecosmosis.orca.bean.AddressBean;
import com.ecosmosis.orca.bean.BeneficiaryBean;
import com.ecosmosis.orca.bean.PayeeBankBean;
import com.ecosmosis.orca.bean.SpouseBean;
import com.ecosmosis.orca.bean.SupervisorBean;
import com.ecosmosis.orca.bonus.bonusperiod.BonusPeriodManager;
import com.ecosmosis.orca.bonus.chi.BonusConstants;
import com.ecosmosis.orca.bvwallet.BvWalletBean;
import com.ecosmosis.orca.bvwallet.BvWalletManager;
import com.ecosmosis.orca.member.id.MemberIDFactory;
import com.ecosmosis.orca.member.id.MemberIDInterface;
import com.ecosmosis.orca.member.printings.MemberIdBean;
import com.ecosmosis.orca.member.printings.MemberPrintManager;
import com.ecosmosis.orca.network.sponsortree.SponsorTreeManager;
import com.ecosmosis.orca.util.PasswordGenerator;
import com.ecosmosis.orca.util.PersonUtil;
import com.ecosmosis.util.crypto.DesEncrypt;
import com.ecosmosis.util.http.RequestParser;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;

// Referenced classes of package com.ecosmosis.orca.member:
//            MemberBean, MemberBroker, MemberChecklist

public class SalesmanManager extends DBTransactionManager
{

    public static final int TASKID_SALESMAN_LISTING = 0x1a2e6;
     
    public static final int TASKID_QUICK_REG_FORM = 0x19641;
    public static final int TASKID_FULL_PRE_REG_FORM = 0x19642;
    public static final int TASKID_FULL_REG_FORM = 0x19643;
    public static final int TASKID_REG_COMPLETED = 0x19644;
    public static final int TASKID_BASIC_VIEW_MEMBER = 0x19646;
    public static final int TASKID_FULL_VIEW_MEMBER = 0x19647;
    public static final int TASKID_COMPLETE_INCOMPLETE_REG = 0x19648;
    public static final int TASKID_BASIC_EDIT_MEMBER = 0x19649;
    public static final int TASKID_SPECIAL_EDIT_MEMBER = 0x1964a;
    public static final int TASKID_SEARCH_MEMBERS_BY = 0x1964b;
    public static final int TASKID_SEARCH_MEMBERS_SPECIAL_BY = 0x1964c;
    public static final int TASKID_SEARCH_MEMBERS_ALL_BY = 0x1964d;
    public static final int TASKID_SEARCH_MEMBERS_LIST = 0x1964e;
    public static final int TASKID_SEARCH_DOWNLINE_LIST = 0xf423f;
    public static final int TASKID_CHANGE_INTRODUCER = 0x1964f;
    public static final int TASKID_RESET_PASSWORD = 0x19650;
    public static final int TASKID_MBRSHIP_EDIT = 0x19651;
    public static final int TASKID_TRANSFER_MBRSHIP = 0x19652;
    public static final int TASKID_CHANGE_RANKING = 0x1965c;
    public static final int TASKID_CHANGE_RANKING_SUBMIT = 0x1965d;
    public static final int TASKID_FULL_PRE_REG_FORM_USR = 0x31511;
    public static final int TASKID_FULL_REG_FORM_USR = 0x31512;
    public static final int TASKID_REG_COMPLETED_USR = 0x31513;
    
    public static final int TASKID_SEARCH_MEMBERS_BY_USR = 0x3151b;
    public static final int TASKID_SEARCH_MEMBERS_LIST_USR = 0x31515;
    
    
    public static final int TASKID_FULL_VIEW_MEMBER_USR = 0x31516;
    public static final int TASKID_EMEMBER_BASIC_EDIT_MEMBER = 0x493ef;
    public static final int TASKID_EMEMBER_FULL_VIEW_MEMBER = 0x493f0;
    public static final int TASKID_EMEMBER_CHG_PASSWORD = 0x493f1;
    public static final int NTWKTYPE_SPONSOR = 0;
    public static final int NTWKTYPE_PLACEMENT = 1;
    public static final int REGSTATUS_QUICK = 0;
    public static final int REGSTATUS_FULL = 10;
    public static final int MBRSHIP_PENDING = 0;
    public static final int MBRSHIP_PENDING_REJECT = 5;
    public static final int MBRSHIP_ACTIVE = 10;
    public static final int MBRSHIP_INACTIVE = 20;
    public static final int MBRSHIP_SUSPENDED = 30;
    public static final int MBRSHIP_TERMINATED = 40;
    public static final int MBRSHIP_TRANSFERRED = 50;
    public static final String MBRTYPE_ROOT = "R";
    public static final String MBRTYPE_HQ = "Q";
    public static final String MBRTYPE_SECRET = "P";
    public static final String MBRTYPE_COMPANY = "C";
    public static final String MBRTYPE_INDIVIDUAL = "I";
    public static final String MBRTYPE_GUESS = "G";
    public static final String MBRTYPE_STAFF = "S";
    public static final String REGTYPE_PINE = "0";    
    public static final String REGTYPE_SNACK = "1";
    public static final String REGTYPE_FAST = "2";    
    public static final String REGTYPE_OTHER = "3";        
    public static final String IDENTYPE_SYS = "S";
    public static final String IDENTYPE_NRIC = "I";
    public static final String IDENTYPE_OLD_NRIC = "O";
    public static final String IDENTYPE_PASSPORT = "P";
    public static final String IDENTYPE_COMPANY_REGNO = "C";
    public static final String MISSING_INTRODUCER = "Y";
    public static final String RETURN_SHOWRECS_CODE = "ShowRecords";
    public static final String RETURN_ORDERBY_CODE = "OrderBy";
    public static final String RETURN_SEARCHBY_CODE = "SearchBy";
    public static final String RETURN_SEARCHBY_CODE2 = "SearchBy2";
        
    public static final String RETURN_MBRSHIPTYPE_CODE = "MbrshipType";
    public static final String RETURN_IDENTITYTYPE_CODE = "IdentityType";    
    public static final String RETURN_REGISTRATION_CODE = "RegisterType";
    
    public static final String RETURN_TYPE_CODE = "MemberType";
    public static final String RETURN_GENDER_CODE = "GenderType";
    public static final String RETURN_MARITAL_CODE = "MaritalType";
    public static final String RETURN_MBRBEAN_CODE = "MemberBean";
    public static final String RETURN_MBRLIST_CODE = "MemberList";
    public static final String RETURN_MBRCHKLIST_CODE = "MemberChkList";
    public static final String RETURN_MBRRANKS_CODE = "MemberRankings";
    public static final String RETURN_MBRBONUS_MAINT_CODE = "MemberBnsMaint";
    public static final int DEFAULT_BONUSTREE = 0;
    public static final int DEFAULT_BONUSRANK = 0;
    public static final int DEFAULT_MBRSHIP = 10;
    public static final int MEMBER_ID_LENGTH = 8;
    public static final int MEMBER_PASSWD_LENGTH = 4;
    public static final int MEMBER_QUALIFY_AGE = 18;
    public static final int MAX_STOCKIST_RECS = 50;
    public static final SalesmanBean EMPTY_ARRAY_MEMBER[] = new SalesmanBean[0];
    private SalesmanBroker broker;

    public SalesmanManager()
    {
        broker = null;
    }

    public SalesmanManager(Connection conn)
    {
        super(conn);
        broker = null;
    }

    private SalesmanBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new SalesmanBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }

    public static String defineMbrshipStatus(int status)
    {
        String title = "";
        switch(status)
        {
        case 10: // '\n'
            title = "ACTIVE";
            break;

        case 20: // '\024'
            title = "ACTIVE";
            break;

        case 0: // '\0'
            title = "PENDING";
            break;

        case 5: // '\005'
            title = "PENDING_REJECT";
            break;

        case 30: // '\036'
            title = "SUSPENDED";
            break;

        case 40: // '('
            title = "TERMINATED";
            break;

        case 50: // '2'
            title = "TRANSFERRED";
            break;
        }
        return title;
    }

    public static String defineRegisterType(int Register)
    {
        String title = "";
        switch(Register)
        {
        case 0: // '\n'
            title = "PAKET 300rb";
            break;

        case 1: // '\n'
            title = "PAKET 150rb";
            break;

        case 2: // '\024'
            title = "PAKET 389rb";
            break;
        
        case 3: // '\024'
            title = "";
            break;            

        case 4: // '\024'
            title = "PAKET 180rb";
            break;
        }
       return title;
    }

    public static String defineRegisterType2(String Register)
    {
        String title = "";
        if(Register == null)
            return title;
        if(Register.equals("0"))
            title = "PAKET 300rb";
        else
        if(Register.equals("1"))
            title = "PAKET 150rb";
        else
        if(Register.equals("2"))
            title = "PAKET 389rb";
        else
        if(Register.equals("4"))
            title = "PAKET 180rb";
        else        
        if(Register.equals(""))
            title = "";
        return title;
    }
    
    public static String defineMbrType(String type)
    {
        String title = "";
        if(type == null)
            return title;
        if(type.equals("Q"))
            title = "HQ";
        else
        if(type.equals("P"))
            title = "SECRET";
        else
        if(type.equals("C"))
            title = "COMPANY";
        else
        if(type.equals("I"))
            title = "INDIVIDUAL";
        else
        if(type.equals("G"))
            title = "GUESS";
        else
        if(type.equals("S"))
            title = "STAGG";
        return title;
    }


    public FIFOMap getMapForRecords(boolean showDefault)
        throws Exception
    {
        String records = "records";
        FIFOMap map = new FIFOMap();
        if(showDefault)
            map.put("", "");
        map.put("50", (new StringBuilder("50 ")).append(records).toString());
        map.put("100", (new StringBuilder("100 ")).append(records).toString());
        map.put("200", (new StringBuilder("200 ")).append(records).toString());
        map.put("500", (new StringBuilder("500 ")).append(records).toString());
        map.put("1000", (new StringBuilder("1000 ")).append(records).toString());
        map.put("5000", (new StringBuilder("5000 ")).append(records).toString());
        map.put("10000", (new StringBuilder("10000 ")).append(records).toString());
        map.put("50000", (new StringBuilder("50000 ")).append(records).toString());
        return map;
    }

    public FIFOMap getMapForOrderBy()
        throws Exception
    {
        FIFOMap maps = new FIFOMap();
        maps.put("mbr_mbrid", "ID");
        maps.put("mbr_name", "Name");
        maps.put("mbr_intrid", "Upline ID");
        maps.put("mbr_placementid", "Sponsor ID");
        maps.put("mbr_type", "Type");
        maps.put("mbr_identityno", "I.C. / Incorporation No.");
        maps.put("mbr_mobileno", "Mobile No");
        maps.put("mbr_gender", "Gender");
        maps.put("mbr_marital", "Marital Status");
        return maps;
    }

    public FIFOMap getMapForSearchBy()
        throws Exception
    {
        FIFOMap map = new FIFOMap();
        map.put("mbr_mbrid", "ID");
        map.put("mbr_name", "Name");
        map.put("mbr_mobileno", "Mobile");
        map.put("mbr_identityno", "I.C. / Incorporation No.");
        return map;
    }
    
    
    public FIFOMap getMapForSearchBy2()
        throws Exception
    {
        FIFOMap map = new FIFOMap();
        map.put("mbr_mobileno", "Mobile");        
        map.put("mbr_mbrid", "ID");
        map.put("mbr_name", "Name");
        map.put("mbr_identityno", "I.C. / Incorporation No.");
        return map;
    }    

    public FIFOMap getMapForMbrshipStatus(boolean showDefault)
        throws Exception
    {
        FIFOMap map = new FIFOMap();
        if(showDefault)
            map.put("", "Any");
        map.put(String.valueOf(10), defineMbrshipStatus(10));
        map.put(String.valueOf(30), defineMbrshipStatus(30));
        map.put(String.valueOf(40), defineMbrshipStatus(40));
        return map;
    }

    public FIFOMap getMapForMbrshipStatus(boolean showDefault, int excludeKey)
        throws Exception
    {
        FIFOMap map = new FIFOMap();
        if(showDefault)
            map.put("", "");
        if(excludeKey != 10)
            map.put(String.valueOf(10), defineMbrshipStatus(10));
        if(excludeKey != 30)
            map.put(String.valueOf(30), defineMbrshipStatus(30));
        if(excludeKey != 40)
            map.put(String.valueOf(40), defineMbrshipStatus(40));
        return map;
    }

    public FIFOMap getMapForRegisterType(boolean showDefault)
        throws Exception
    {
        FIFOMap map = new FIFOMap();
        if(showDefault)
            map.put("", "Any");
        map.put(String.valueOf(1), defineRegisterType(1));
        map.put(String.valueOf(2), defineRegisterType(2));        
        return map;
    }

    public FIFOMap getMapForRegisterType(boolean showDefault, int excludeKey)
        throws Exception
    {
        FIFOMap map = new FIFOMap();
        if(showDefault)
            map.put("", "");
        if(excludeKey != 1)
            map.put(String.valueOf(1), defineRegisterType(1));
        if(excludeKey != 2)
            map.put(String.valueOf(2), defineRegisterType(2));
        if(excludeKey != 3)
            map.put(String.valueOf(3), defineRegisterType(3));
        return map;
    }


    public FIFOMap getMapForMemberType()
        throws Exception
    {
        FIFOMap map = new FIFOMap();
        map.put("", "Any");
        map.put("I", "Individual");
        map.put("C", "Company");
        return map;
    }

    
    public FIFOMap getMapForIdentityType()
        throws Exception
    {
        FIFOMap map = new FIFOMap();
        map.put("I", "IC No.");
        return map;
    }

    public FIFOMap getMapForGenderType()
        throws Exception
    {
        FIFOMap map = new FIFOMap();
        map.put("", "Any");
        map.put("M", "Male");
        map.put("F", "Female");
        return map;
    }

    public FIFOMap getMapForMaritalType()
        throws Exception
    {
        FIFOMap map = new FIFOMap();
        map.put("", "Any");
        map.put("S", "Single");
        map.put("M", "Married");
        return map;
    }

    private void prepareNewMember(SalesmanBean member)
        throws MvcException
    {
        LoginUserBean loginuser = getLoginUser();
        member.setBonusTree(0);
        member.setBonusRank(0);
        member.setStatus(10);
        member.setHomeBranchID(loginuser.getOutletID());
        member.setStd_createBy(loginuser.getUserId());
        member.setRegister(member.getRegister());
        
        if(member.getIdentityType().equals("C"))            
        {
            member.setCompanyName(member.getName());
            member.setCompanyRegNo(member.getIdentityNo());
        } else
        if(member.getIdentityType().equals("I") && member.getNric() == null)
            member.setNric(member.getIdentityNo());
        else
        if(member.getIdentityType().equals("P") && member.getPassport() == null)
            member.setPassport(member.getIdentityNo());
        else
        if(member.getOldNric() == null)
            member.setOldNric(member.getIdentityNo());
        if(member.getIntroducerID() != null)
        {
            SalesmanBean intrBean = getMemberByID(member.getIntroducerID(), false);
            if(intrBean != null)
            {
                member.setIntroducerName(intrBean.getName());
                member.setIntroducerIdentityNo(intrBean.getIdentityNo());
            }
        }
        if(member.getPlacementID() != null)
        {
            SalesmanBean placeBean = getMemberByID(member.getPlacementID(), false);
            if(placeBean != null)
            {
                member.setPlacementName(placeBean.getName());
                member.setPlacementIdentityNo(placeBean.getIdentityNo());
            }
        }
       // System.out.println("masuk determineInvestorType reg " + reg + " JoinPeriod " + joinperiod + " dan apbv " + apbv);   
    }

    public void assignPassword(SalesmanBean member)
        throws MvcException
    {
        try
        {
            PasswordGenerator passwordGenerator = new PasswordGenerator(4, false, false, "isAplhanum");
            String passwd = null;
            if(member.isChkPin())
                passwd = member.getPassword();
            else
                passwd = passwordGenerator.getNewPassword();
            DesEncrypt encryptPassword = new DesEncrypt();
            member.setPassword(encryptPassword.encrypt(passwd));
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
    }

    private void upperCaseBean(SalesmanBean bean)
    {
        if(bean == null)
            return;
        bean.setMemberID(bean.getMemberID().toUpperCase());
        if(bean.getIntroducerID() != null)
            bean.setIntroducerID(bean.getIntroducerID().toUpperCase());
        if(bean.getPlacementID() != null)
            bean.setPlacementID(bean.getPlacementID().toUpperCase());
    }

    private void parseBean(SalesmanBean bean, HttpServletRequest request, boolean parseMemberBeanOnly)
        throws Exception
    {
        RequestParser reqParser = getRequestParser();
        reqParser.parse(bean, request);
        try
        {
            bean.setCompanyRegDate(Sys.parseDate(bean.getCompanyRegDateStr()));
        }
        catch(Exception e)
        {
            if(bean.getCompanyRegDateStr() != null && bean.getCompanyRegDateStr().length() > 0)
                throw new Exception("Fail to parse Incorporation Date");
            bean.setCompanyRegDate(null);
        }
        try
        {
            bean.setDob(Sys.parseDate(bean.getDobStr()));
        }
        catch(Exception e)
        {
            if(bean.getDobStr() != null && bean.getDobStr().length() > 0)
                throw new Exception("Fail to parse DOB");
            bean.setDob(null);
        }
        String noPin = request.getParameter("nopin");
        if(noPin != null)
            bean.setChkPin(false);
        else
            bean.setChkPin(true);
        if(!parseMemberBeanOnly)
        {
            if(bean.getAddress() == null)
                bean.setAddress(new AddressBean());
            if(bean.getPayeeBank() == null)
                bean.setPayeeBank(new PayeeBankBean());
            if(bean.getSupervisor() == null)
                bean.setSupervisor(new SupervisorBean());
            if(bean.getSpouse() == null)
                bean.setSpouse(new SpouseBean());
            if(bean.getBeneficiary() == null)
                bean.setBeneficiary(new BeneficiaryBean());
            reqParser.parse(bean.getAddress(), request);
            reqParser.parse(bean.getPayeeBank(), request);
            reqParser.parse(bean.getSupervisor(), request);
            reqParser.parse(bean.getSpouse(), request);
            reqParser.parse(bean.getBeneficiary(), request);
            try
            {
                bean.getSpouse().setSpouseDob(Sys.parseDate(bean.getSpouse().getSpouseDobStr()));
            }
            catch(Exception e)
            {
                if(bean.getSpouse().getSpouseDobStr() != null && bean.getSpouse().getSpouseDobStr().length() > 0)
                    throw new Exception("Fail to parse Spouse DOB");
                bean.getSpouse().setSpouseDob(null);
            }
        }
    }

    public boolean isMember(String memberID)
        throws MvcException
    {
        boolean status = false;
        try
        {
            SalesmanBean bean = getMemberByID(memberID, false);
            if(bean != null)
                status = true;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        return status;
    }

    public boolean isActiveMember(String memberID)
        throws MvcException
    {
        boolean status = false;
        try
        {
            SalesmanBean bean = getMemberByID(memberID, false);
            if(bean != null)
                status = bean.getStatus() == 10;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        return status;
    }

    public boolean isHiddenMember(String memberID)
        throws MvcException
    {
        boolean status = false;
        try
        {
            SalesmanBean bean = getMemberByID(memberID, false);
            if(bean != null)
                status = bean.isHidden();
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        return status;
    }

    private MvcReturnBean checkPreRegisterForm(HttpServletRequest request)
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        try
        {
            SalesmanBean member = new SalesmanBean();
            parseBean(member, request, true);
            if(checkRegisterInput(member, returnBean, request))
            {
                if(checkRegisterChecklist(member, returnBean))
                {
                    prepareNewMember(member);
                    returnBean.done();
                } else
                {
                    returnBean.fail();
                }
            } else
            {
                returnBean.fail();
            }
            StringBuffer sbParam = new StringBuffer();
            sbParam.append((new StringBuilder("&MemberID=")).append(member.getMemberID()).toString());
            sbParam.append((new StringBuilder("&IntroducerID=")).append(member.getIntroducerID()).toString());
            sbParam.append((new StringBuilder("&IntroducerName=")).append(member.getIntroducerName()).toString());
            sbParam.append((new StringBuilder("&IntroducerContact=")).append(member.getIntroducerContact()).toString());
            sbParam.append((new StringBuilder("&PlacementID=")).append(member.getPlacementID()).toString());
            sbParam.append((new StringBuilder("&BonusDateStr=")).append(member.getBonusPeriodID()).toString());
            sbParam.append((new StringBuilder("&JoinDateStr=")).append(member.getJoinDateStr()).toString());
            sbParam.append((new StringBuilder("&Type=")).append(member.getType()).toString());
            sbParam.append((new StringBuilder("&Register=")).append(member.getRegister()).toString());            
            sbParam.append((new StringBuilder("&Name=")).append(member.getName()).toString());
            sbParam.append((new StringBuilder("&IdentityNo=")).append(member.getIdentityNo()).toString());
            sbParam.append((new StringBuilder("&IdentityType=")).append(member.getIdentityType()).toString());
            if(!member.isChkPin())
            {
                sbParam.append("&nopin=f");
                sbParam.append("&Password=");
            } else
            {
                sbParam.append((new StringBuilder("&Password=")).append(member.getPassword()).toString());
                sbParam.append((new StringBuilder("&BonusPeriodID=")).append(member.getBonusPeriodID()).toString());
            }
            returnBean.addReturnObject("ReturnParam", sbParam.toString());
        }
        catch(Exception e)
        {
            Log.error(e);
            returnBean.setException(e);
            returnBean.fail();
        }
        return returnBean;
    }

/*    
 
 private MvcReturnBean checkRegister(HttpServletRequest request)
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        MemberBean member = new MemberBean();
            parseBean(member, request, true);
            if(checkRegisterInput(member, returnBean, request))
            {
                if(checkRegisterChecklist(member, returnBean))
                {
                    returnBean.fail();
                }
            } else
            {
                returnBean.fail();
            }
         
         return returnBean;
    }
  */
    
    private boolean checkRegisterInput(SalesmanBean member, MvcReturnBean returnBean, HttpServletRequest request)
    {
        if(member.getMemberID() == null || member.getMemberID() != null && member.getMemberID().length() <= 0)
            returnBean.addError("No Distributor ID specified");
        if(member.isChkPin())
        {
            MemberIdBean idBean = (new MemberPrintManager()).getIdBean(member.getMemberID());
            if(idBean != null)
            {
                if(idBean.getStatus() == 0)
                {
                    if(member.getPassword() == null || !idBean.getEpin().equals(member.getPassword()))
                        returnBean.addError("Pin number NOT MATCHED.");
                } 
                else
                {
                    returnBean.addError("This member ID had been USED.");
                }
            } else
            {
                returnBean.addError("This member ID is NOT EXIST in the System.");
            }
        }
        
        checkIntroducer(member, returnBean);
        try
        {
            member.setJoinDate(Sys.parseDate(member.getJoinDateStr()));
        }
        catch(Exception e)
        {
            if(member.getJoinDateStr() != null && member.getJoinDateStr().length() > 0)
                returnBean.addError("Fail to parse Join Date");
            else
                member.setJoinDate(new Date());
        }
        try
        {
            member.setJoinTime(new Time(Sys.parseTime(member.getJoinTimeStr()).getTime()));
        }
        catch(Exception ignore)
        {
            if(member.getJoinTimeStr() != null && member.getJoinTimeStr().length() > 0)
                returnBean.addError("Fail to parse Join Time");
        }
        if(member.getType() == null || member.getType() != null && member.getType().length() <= 0)
            returnBean.addError("No Membership Type specified");

        // if(member.getRegister() == 0)     // && member.getRegister().length() <= 0)
        //    returnBean.addError("No Register Type specified");
        
        if(member.getRegFormNo() == null || member.getRegFormNo() != null && member.getRegFormNo().length() <= 0)
            returnBean.addError("No Register Form No. specified");
        if(member.getName() == null || member.getName() != null && member.getName().length() <= 0)
            returnBean.addError("No Name specified");
        if(member.getIdentityType() == null || member.getIdentityType() != null && member.getIdentityType().length() <= 0)
            returnBean.addError("No Identity Type specified");
        if(member.getIdentityNo() == null || member.getIdentityNo() != null && member.getIdentityNo().length() <= 0)
            returnBean.addError("No Identity No. specified");
        try
        {
            member.setCompanyRegDate(Sys.parseDate(member.getCompanyRegDateStr()));
        }
        catch(Exception e)
        {
            if(member.getCompanyRegDateStr() != null && member.getCompanyRegDateStr().length() > 0)
                returnBean.addError("Fail to parse Incorporation Date");
        }
        try
        {
            member.setDob(Sys.parseDate(member.getDobStr()));
            if(member.getDob() != null && PersonUtil.isBelowAge(member.getDob(), 18))
                returnBean.addError("The member is under age 18");
        }
        catch(Exception e)
        {
            if(member.getDobStr() != null && member.getDobStr().length() > 0)
                returnBean.addError("Fail to parse DOB");
        }
        if(member.getSpouse() != null)
            try
            {
                member.getSpouse().setSpouseDob(Sys.parseDate(member.getSpouse().getSpouseDobStr()));
            }
            catch(Exception e)
            {
                if(member.getSpouse().getSpouseDobStr() != null && member.getSpouse().getSpouseDobStr().length() > 0)
                    returnBean.addError("Fail to parse Spouse DOB");
            }
        
        checkBonusPeriodInfo(member, returnBean, request);
        return !returnBean.hasErrorMessages();
    }

    private boolean RegisterInput(SalesmanBean member, MvcReturnBean returnBean, HttpServletRequest request)
    {
        if(member.getMemberID() == null || member.getMemberID() != null && member.getMemberID().length() <= 0)
            returnBean.addError("No Distributor ID specified");

        if(member.isChkPin())
        {
            MemberIdBean idBean = (new MemberPrintManager()).getIdBean(member.getMemberID());
            if(idBean != null)
            {
                if(idBean.getStatus() == 0)
                {
                    if(member.getPassword() == null || !idBean.getEpin().equals(member.getPassword()))
                        returnBean.addError("Pin number NOT MATCHED.");
                } 
                else
                {
                    returnBean.addError("Entry Successfully ....");
                }
            }

	    else
            {
                returnBean.addError("This member ID is NOT EXIST in the System.");
            }
        }
        
        return !returnBean.hasErrorMessages();
    }
    
    private void checkIntroducer(SalesmanBean member, MvcReturnBean returnBean)
    {
        boolean chkIntrBean;
        boolean chkPlaceBean;
        SalesmanBean intrBean;
        SalesmanBean placeBean;
        Connection conn;
        chkIntrBean = false;
        chkPlaceBean = false;
        intrBean = null;
        placeBean = null;
        conn = null;
        try
        {
            conn = getConnection();
            if(member.hasPlacementRef())
            {
                if(!member.hasIntroducerRef())
                    member.setIntroducerID(member.getPlacementID());
            } else
            {
                returnBean.addError("No Sponsor ID is specified");
            }
            if(member.hasIntroducerRef())
                try
                {
                    if(member.getChkIntrID() != null && member.getChkIntrID().equals("true"))
                        chkIntrBean = true;
                    intrBean = getMemberByID(member.getIntroducerID(), false);
                    if(intrBean == null && !chkIntrBean)
                    {
                        returnBean.addError("No Upline ID found in the system ");
                        returnBean.addReturnObject("ChkIntrID", "true");
                    }
                }
                catch(Exception ex)
                {
                    returnBean.addError(ex.getMessage());
                }
            if(member.hasPlacementRef())
                try
                {
                    if(member.getChkPlaceID() != null && member.getChkPlaceID().equals("true"))
                        chkPlaceBean = true;
                    placeBean = getMemberByID(member.getPlacementID(), false);
                    if(placeBean == null && !chkPlaceBean)
                    {
                        returnBean.addError("No Sponsor ID found in the system ");
                        returnBean.addReturnObject("ChkPlaceID", "true");
                    }
                }
                catch(Exception ex)
                {
                    returnBean.addError(ex.getMessage());
                }
            try
            {
                if(member.hasPlacementRef() && member.hasIntroducerRef() && placeBean != null && !member.getIntroducerID().equalsIgnoreCase(member.getPlacementID()))
                {
                    SponsorTreeManager ntwkMgr = new SponsorTreeManager(conn);
                    boolean isDownline = ntwkMgr.isDownline(member.getIntroducerID(), member.getPlacementID());
                    if(!isDownline && intrBean != null)
                        returnBean.addError("Upline ID is not Sponsor downline");
                }
            }
            catch(Exception ex)
            {
                returnBean.addError(ex.getMessage());
            }
            if(member.getMemberID() != null && member.getIntroducerID() != null && member.getMemberID().equalsIgnoreCase(member.getIntroducerID()))
                returnBean.addError("Upline ID cannot same as Member ID");
            if(member.getMemberID() != null && member.getPlacementID() != null && member.getMemberID().equalsIgnoreCase(member.getPlacementID()))
                returnBean.addError("Sponsor ID cannot same as Member ID");
            if(intrBean != null)
            {
                member.setIntroducerName(intrBean.getName());
                member.setIntroducerIdentityNo(intrBean.getIdentityNo());
                member.setIntroducerMissing("N");
            } else
            {
                member.setIntroducerMissing("Y");
            }
            if(placeBean != null)
            {
                member.setPlacementName(placeBean.getName());
                member.setPlacementIdentityNo(placeBean.getIdentityNo());
                member.setPlacementMissing("N");
            } else
            {
                member.setPlacementMissing("Y");
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            returnBean.addError(e.getMessage());
            // break MISSING_BLOCK_LABEL_496;
        }
        // Exception exception;
        // exception;

        finally
        {
        releaseConnection(conn);
        // return chkIntrBean;
        }
    }

    private boolean checkRegisterChecklist(SalesmanBean member, MvcReturnBean returnBean)
        throws MvcException
    {
        boolean success;
        Connection conn;
        if(member == null)
            throw new IllegalArgumentException("No member specified");
        success = false;
        SalesmanChecklist chkList = null;
        conn = null;
        try
        {
            conn = getConnection();
            chkList = getBroker(conn).checkRegisterChecklist(member);
            if(chkList != null && chkList.hasError())
                returnBean.addReturnObject("MemberChkList", chkList);
            else
                success = true;
        }
        catch(Exception e)
        {
            Log.error(e);
            returnBean.setException(e);
            // break MISSING_BLOCK_LABEL_108;
        }

        finally
        {
        releaseConnection(conn);
        return success;
        }
    }

    private boolean checkDupIdentity(SalesmanBean member, MvcReturnBean returnBean)
        throws MvcException
    {
        boolean success;
        Connection conn;
        if(member == null)
            throw new IllegalArgumentException("No member specified");
        success = false;
        SalesmanChecklist chkList = null;
        conn = null;
        try
        {
            conn = getConnection();
            chkList = getBroker(conn).checkDupIdentity(member);
            if(chkList != null && chkList.hasError())
                returnBean.addReturnObject("MemberChkList", chkList);
            else
                success = true;
        }
        catch(Exception e)
        {
            Log.error(e);
            returnBean.setException(e);
        }
        finally
        {
        releaseConnection(conn);
        return success;
        }
    }

    private MvcReturnBean searchMemberSelection(HttpServletRequest request)
        throws MvcException
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        try
        {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            if(formSubmitted)
            {
                Date joinDtFrom = null;
                Date joinDtTo = null;
                Date birthDt = null;
                SQLConditionsBean cond = new SQLConditionsBean();
                String conditions = " where mbr_status <> 50 ";
                String orderby = request.getParameter("OrderBy");
                if(orderby != null && orderby.length() > 0)
                    cond.setOrderby((new StringBuilder(" order by ")).append(orderby).append(" asc").toString());
                String limits = request.getParameter("Limits");
                if(limits != null && limits.length() > 0)
                    cond.setLimitConditions((new StringBuilder(" limit 0, ")).append(limits).toString());
                String joinDtFromStr = request.getParameter("JoinDateFrom");
                String joinDtToStr = request.getParameter("JoinDateTo");
                String birthDtStr = request.getParameter("BirthDate");
                try
                {
                    joinDtFrom = Sys.parseDate(joinDtFromStr);
                }
                catch(Exception exception) { }
                try
                {
                    joinDtTo = Sys.parseDate(joinDtToStr);
                }
                catch(Exception exception1) { }
                try
                {
                    birthDt = Sys.parseDate(birthDtStr);
                }
                catch(Exception exception2) { }
                if(joinDtFrom != null)
                {
                    java.sql.Date sqlDtFrom = new java.sql.Date(joinDtFrom.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_joindate >= '").append(sqlDtFrom).append("'").toString();
                }
                if(joinDtTo != null)
                {
                    java.sql.Date sqlDtTo = new java.sql.Date(joinDtTo.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_joindate <= '").append(sqlDtTo).append("'").toString();
                }
                if(birthDt != null)
                {
                    java.sql.Date sqlBirthDt = new java.sql.Date(birthDt.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_dob = '").append(sqlBirthDt).append("'").toString();
                }
                String homeBranchID = request.getParameter("HomeBranchID");
                if(homeBranchID != null && homeBranchID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_home_branchid = '").append(homeBranchID).append("' ").toString();
                String status = request.getParameter("Status");
                if(status != null && status.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_status = ").append(status).toString();
                String memberID = request.getParameter("MemberID");
                if(memberID != null && memberID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_mbrid LIKE '%").append(memberID.trim()).append("%' ").toString();
                String memberName = request.getParameter("MemberName");
                if(memberName != null && memberName.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_name LIKE '%").append(memberName.trim()).append("%' ").toString();
                String type = request.getParameter("Type");
                if(type != null && type.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_type = '").append(type.trim()).append("' ").toString();
                String identityNo = request.getParameter("IdentityNo");
                if(identityNo != null && identityNo.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_identityno LIKE '%").append(identityNo.trim()).append("%' ").toString();
                String mobileNo = request.getParameter("MobileNo");
                if(mobileNo != null && mobileNo.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_mobileno LIKE '%").append(mobileNo.trim()).append("%' ").toString();
                String gender = request.getParameter("Gender");
                if(gender != null && gender.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_gender = '").append(gender.trim()).append("' ").toString();
                String marital = request.getParameter("Marital");
                if(marital != null && marital.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_marital = '").append(marital.trim()).append("' ").toString();
                String birthDay = request.getParameter("BirthDay");
                if(birthDay != null && birthDay.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and DAYOFMONTH(mbr_dob) = ").append(birthDay.trim()).append(" ").toString();
                String birthMonth = request.getParameter("BirthMonth");
                if(birthMonth != null && birthMonth.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and MONTH(mbr_dob) = ").append(birthMonth.trim()).append(" ").toString();
                String birthYear = request.getParameter("BirthYear");
                if(birthYear != null && birthYear.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and YEAR(mbr_dob) = ").append(birthYear.trim()).append(" ").toString();
                    // Tambahan untuk Hidden Member
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_hidden = 'N'").toString();
                cond.setConditions(conditions);
                returnBean.addReturnObject("MemberList", getMemberList(cond));
            }
            returnBean.addReturnObject("MbrshipType", getMapForMbrshipStatus(true));
            returnBean.addReturnObject("MemberType", getMapForMemberType());
            returnBean.addReturnObject("GenderType", getMapForGenderType());
            returnBean.addReturnObject("MaritalType", getMapForMaritalType());
            returnBean.addReturnObject("OrderBy", getMapForOrderBy());
            returnBean.addReturnObject("ShowRecords", getMapForRecords(false));
        }
        catch(Exception ex)
        {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }

    private MvcReturnBean searchMemberBy(int taskId, HttpServletRequest request)
        throws Exception
    {
        MvcReturnBean returnBean;
        Connection conn;
        returnBean = new MvcReturnBean();
        conn = null;
        try
        {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            if(formSubmitted)
            {
                conn = getConnection();
                SQLConditionsBean cond = new SQLConditionsBean();
                String conditions = " where mbr_status <> 50 ";
                String orderby = request.getParameter("OrderBy");
                if(orderby != null && orderby.length() > 0)
                    cond.setOrderby((new StringBuilder(" order by ")).append(orderby).append(" asc").toString());
                String limits = request.getParameter("Limits");
                if(limits != null && limits.length() > 0)
                    cond.setLimitConditions((new StringBuilder(" limit 0, ")).append(limits).toString());
                if(taskId == 0xf423f)
                {
                    String inList[] = (String[])null;
                    String refID = request.getParameter("RefID");
                    if(refID != null && refID.length() > 0)
                        inList = (new SponsorTreeManager(conn)).getDownlineIDList(refID);
                    if(inList != null && inList.length > 0)
                    {
                        StringBuffer sb = new StringBuffer();
                        for(int i = 0; i < inList.length; i++)
                        {
                            if(i > 0)
                                sb.append(",");
                            sb.append("'").append(inList[i]).append("'");
                        }

                        conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_mbrid in (").append(sb.toString()).append(") ").toString();
                    }
                }
                String filterTypes[] = (String[])null;
                switch(taskId)
                {
                case 104011: 
                case 202011: 
                case 999999: 
                    filterTypes = (new String[] {
                        "R", "Q", "P"
                    });
                    break;

                case 104012: 
                    filterTypes = (new String[] {
                        "R", "P"
                    });
                    break;

                case 104013: 
                    filterTypes = (new String[] {
                        "R"
                    });
                    break;
                }
                if(filterTypes != null && filterTypes.length > 0)
                {
                    StringBuffer sb = new StringBuffer();
                    for(int i = 0; i < filterTypes.length; i++)
                    {
                        if(i > 0)
                            sb.append(",");
                        sb.append("'").append(filterTypes[i]).append("'");
                    }

                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_type not in (").append(sb.toString()).append(") ").toString();
                }
                String searchBy = request.getParameter("SearchBy");
                String keyword = request.getParameter("Keyword");
                
                if(searchBy != null && keyword != null)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and ").append(searchBy.trim()).append(" LIKE '%").append(keyword.trim()).append("%' ").toString();
                cond.setConditions(conditions);
                returnBean.addReturnObject("MemberList", getMemberList(cond));
            }
            returnBean.addReturnObject("SearchBy", getMapForSearchBy());
            returnBean.addReturnObject("ShowRecords", getMapForRecords(false));
        }
        catch(Exception ex)
        {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        finally
        {
        releaseConnection(conn);
        return returnBean;
        }
    }

    private MvcReturnBean searchMemberBy2(int taskId, HttpServletRequest request)
        throws Exception
    {
        MvcReturnBean returnBean;
        Connection conn;
        returnBean = new MvcReturnBean();
        conn = null;
        try
        {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            if(formSubmitted)
            {
                conn = getConnection();
                SQLConditionsBean cond = new SQLConditionsBean();
                String conditions = " where mbr_status <> 50 ";
                String orderby = request.getParameter("OrderBy");
                if(orderby != null && orderby.length() > 0)
                    cond.setOrderby((new StringBuilder(" order by ")).append(orderby).append(" asc").toString());
                String limits = request.getParameter("Limits");
                if(limits != null && limits.length() > 0)
                    cond.setLimitConditions((new StringBuilder(" limit 0, ")).append(limits).toString());
                if(taskId == 0xf423f)
                {
                    String inList[] = (String[])null;
                    String refID = request.getParameter("RefID");
                    if(refID != null && refID.length() > 0)
                        inList = (new SponsorTreeManager(conn)).getDownlineIDList(refID);
                    if(inList != null && inList.length > 0)
                    {
                        StringBuffer sb = new StringBuffer();
                        for(int i = 0; i < inList.length; i++)
                        {
                            if(i > 0)
                                sb.append(",");
                            sb.append("'").append(inList[i]).append("'");
                        }

                        conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_mbrid in (").append(sb.toString()).append(") ").toString();
                    }
                }
                String filterTypes[] = (String[])null;
                switch(taskId)
                {
                case 104011: 
                case 202011: 
                case 999999: 
                    filterTypes = (new String[] {
                        "R", "Q", "P"
                    });
                    break;

                case 104012: 
                    filterTypes = (new String[] {
                        "R", "P"
                    });
                    break;

                case 104013: 
                    filterTypes = (new String[] {
                        "R"
                    });
                    break;
                }
                if(filterTypes != null && filterTypes.length > 0)
                {
                    StringBuffer sb = new StringBuffer();
                    for(int i = 0; i < filterTypes.length; i++)
                    {
                        if(i > 0)
                            sb.append(",");
                        sb.append("'").append(filterTypes[i]).append("'");
                    }

                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and mbr_type not in (").append(sb.toString()).append(") ").toString();
                }
                String searchBy = request.getParameter("SearchBy");
                String keyword = request.getParameter("Keyword");
                
                if(searchBy != null && keyword != null)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and ").append(searchBy.trim()).append(" LIKE '%").append(keyword.trim()).append("%' ").toString();
                cond.setConditions(conditions);
                returnBean.addReturnObject("MemberList", getMemberList(cond));
            }
            returnBean.addReturnObject("SearchBy", getMapForSearchBy2());
            returnBean.addReturnObject("ShowRecords", getMapForRecords(false));
        }
        
        catch(Exception ex)
        {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        finally
        {
        releaseConnection(conn);
        return returnBean;
        }
    }

    public SalesmanBean[] getMemberList(SQLConditionsBean conditions)
        throws MvcException
    {
        SalesmanBean beans[];
        Connection conn;
        beans = EMPTY_ARRAY_MEMBER;
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getMemberList(conditions);
            if(!list.isEmpty())
                beans = (SalesmanBean[])list.toArray(beans);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return beans;
        }
    }

    public SalesmanBean[] searchMemberSelectionForStockist(String memberID, String name, String identityNo, String mobileNo, Date joinDateFrom, Date joinDateTo)
        throws Exception
    {
        SalesmanBean beans[];
        Connection conn;
        beans = EMPTY_ARRAY_MEMBER;
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).searchMemberSelectionForStockist(memberID, name, identityNo, mobileNo, joinDateFrom, joinDateTo);
            if(!list.isEmpty())
                beans = (SalesmanBean[])list.toArray(EMPTY_ARRAY_MEMBER);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return beans;
        }
    }

    public SalesmanBean[] getMemberListByID(String memberID)
        throws MvcException
    {
        SalesmanBean beans[];
        Connection conn;
        if(memberID == null)
            throw new IllegalArgumentException("No memberID specified");
        beans = EMPTY_ARRAY_MEMBER;
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getMemberListByID(memberID);
            if(!list.isEmpty())
                beans = (SalesmanBean[])list.toArray(beans);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return beans;
        }
    }

    public SalesmanBean getMemberByID(String memberID, boolean parseFullInfo)
        throws MvcException
    {
        return getMemberByID(memberID, null, parseFullInfo);
    }

    public SalesmanBean getMemberByID(String memberID, String branchID, boolean parseFullInfo)
        throws MvcException
    {
        SalesmanBean member;
        Connection conn;
        member = null;
        conn = null;
        try
        {
            conn = getConnection();
            member = getBroker(conn).getMemberByID(memberID, branchID, parseFullInfo);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return member;
        }
    }

    public SalesmanBean getMemberBySeq(int memberSeq, boolean parseFullInfo)
        throws MvcException
    {
        SalesmanBean member;
        Connection conn;
        member = null;
        conn = null;
        try
        {
            conn = getConnection();
            member = getBroker(conn).getMemberBySeq(memberSeq, parseFullInfo);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return member;
        }
    }

    public SalesmanBean getMember(int memberSeq, String memberID, boolean parseFullInfo)
        throws MvcException
    {
        SalesmanBean member;
        Connection conn;
        member = null;
        conn = null;
        try
        {
            conn = getConnection();
            member = getBroker(conn).getMember(memberSeq, memberID, parseFullInfo);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return member;
        }
    }

    public String getMemberIDBySeq(int memberSeq)
        throws MvcException
    {
        String memberID;
        Connection conn;
        memberID = null;
        conn = null;
        try
        {
            conn = getConnection();
            memberID = getBroker(conn).getMemberIDBySeq(memberSeq);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return memberID;
        }
    }

    private MvcReturnBean registerMember(int registerStatus, HttpServletRequest request)
        throws MvcException
    {
       boolean insert;
        String syncAdd;
        SalesmanBean member;
        MvcReturnBean returnBean;
        insert = false;
        syncAdd = "syncAdd";
        member = new SalesmanBean();
        returnBean = new MvcReturnBean();
        try
        {
            member.setRegStatus(registerStatus);
            if(registerStatus == 10)
                parseBean(member, request, false);
            else
                parseBean(member, request, true);
        }
        catch(Exception ex)
        {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        
        // return returnBean;
        
        if(checkRegisterInput(member, returnBean, request))
            
           returnBean.fail();
        // return returnBean;
           
        try
        {
            upperCaseBean(member);
            prepareNewMember(member);
            assignPassword(member);
            synchronized(syncAdd)
            {
                if(checkRegisterChecklist(member, returnBean))
                {
                    insert = addMember(member);
                    (new MemberPrintManager()).updateIdStatus(member.getMemberID(), getLoginUser().getUserId());
                } else
                {
                    returnBean.fail();
                }
            }
            if(insert)
            {
                returnBean.addReturnObject("MemberSeq", String.valueOf(member.getMemberSeq()));
                returnBean.addReturnObject("MemberID", member.getMemberID());
                if(!member.isChkPin())
                    returnBean.addReturnObject("nopin", "f");
                addMemberBonusStatus(member);
                if(member.isChkPin())
                    addMemberStartedPackBv(member);
                insertSponsorTree(member.getMemberID(), member.getIntroducerID());
            } else
            {
                returnBean.fail();
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            returnBean.addError(e.getMessage());
            returnBean.fail();
        }
        return returnBean;
        }
    

    private MvcReturnBean transferMembership(HttpServletRequest request)
        throws MvcException
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        SalesmanBean owner;
        owner = getMemberByID(request.getParameter("MemberID"), true);
        if(owner != null)
        {
            owner.setStatus(50);
        } else
        {    
          returnBean.addError("Record not found.");
          returnBean.fail();
         // return returnBean;
        }
        
        try
        {
            SalesmanBean newer = getMemberByID(owner.getMemberID(), true);
            parseBean(newer, request, false);
            upperCaseBean(newer);
            if(checkDupIdentity(newer, returnBean))
                transferMembership(owner, newer);
            else
                returnBean.fail();
        }
        catch(Exception ex)
        {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
            throw new MvcException(ex);
        }
        return returnBean;
    }

    private MvcReturnBean updateMember(HttpServletRequest request)
        throws MvcException
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        SalesmanBean member;
        String memberID = request.getParameter("MemberID");
        if(memberID == null)
            memberID = getLoginUser().getUserId();
        member = getMemberByID(request.getParameter("MemberID"), true);
        if(member != null)
        returnBean.addError("Record not found.");
        returnBean.fail();
        // return returnBean;
        
        try
        {
            parseBean(member, request, false);
            if(member.getRegStatus() == 0)
                member.setRegStatus(10);
            updateMember(member);
        }
        catch(Exception ex)
        {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }

    private MvcReturnBean updatePassword(String memberID, int taskID, HttpServletRequest request, boolean checkCurrent, int firstLogin)
        throws MvcException
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        SalesmanBean bean;
        bean = getMemberByID(memberID, true);
        if(bean != null)
        // returnBean.addError((new StringBuilder("Record not found fpr -> ")).append(memberID).toString());
        // returnBean.fail();
        // return returnBean;
        
        try
        {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            if(formSubmitted)
            {
                DesEncrypt encryptor = new DesEncrypt();
                String newPwd = request.getParameter("Password");
                String newPwdConfirm = request.getParameter("ConfirmPassword");
                String filledCurrentPwd = request.getParameter("CurrentPassword");
                String currentPwd = encryptor.decrypt(bean.getPassword());
                if(checkCurrent)
                    if(filledCurrentPwd.length() < 4 || filledCurrentPwd.length() > 10)
                        returnBean.addError("Invalid Password. Password length 4-10 chars.");
                    else
                    if(!currentPwd.equals(filledCurrentPwd))
                        returnBean.addError("Current Password NOT match.");
                if(newPwd.length() < 4 || newPwd.length() > 10 || newPwdConfirm.length() < 4 || newPwdConfirm.length() > 10)
                    returnBean.addError("<br>Invalid Password. Password length 4-10 chars.");
                if(!newPwd.equals(newPwdConfirm))
                    returnBean.addError("<br>New Password and Confirm New Password NOT match.");
                if(!returnBean.hasErrorMessages())
                {
                    bean.setLoginStatus(firstLogin);
                    bean.setPassword(encryptor.encrypt(newPwd));
                    if(updateMember(bean))
                    {
                        String msg = "New password is updated successfully.";
                        returnBean.setTaskStatus(4);
                        returnBean.setSysMessage(msg);
                    } else
                    {
                        returnBean.fail();
                    }
                }
            }
            returnBean.addReturnObject("MemberBean", bean);
        }
        
        catch(Exception ex)
        {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }

    private boolean changeIntroducer(SalesmanBean bean)
        throws Exception
    {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            status = (new SponsorTreeManager(conn)).changeIntroducer(bean.getMemberID(), bean.getIntroducerID());
            status = getBroker(conn).updateMember(bean);
        }
        catch(Exception e)
        {
            conn.rollback();
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
         conn.commit();
        conn.setAutoCommit(true);
        releaseConnection(conn);
        return status;
        }
    }

    private boolean transferMembership(SalesmanBean owner, SalesmanBean newer)
        throws Exception
    {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            status = updateMember(newer);
            // status = updateMember(owner);            
            // status = addMember(newer);
        }
        catch(Exception e)
        {
            conn.rollback();
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        conn.commit();
        conn.setAutoCommit(true);
        releaseConnection(conn);
        return status;
        }
    }

    private boolean addMemberBonusStatus(SalesmanBean member)
        throws MvcException
    {
        boolean status;
        Connection conn;
        if(member == null)
            throw new IllegalArgumentException("No member specified");
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            status = getBroker(conn).addMemberBonusStatus(member);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
         releaseConnection(conn);
        return status;
        }
    }

    private boolean updateMemberBonusStatus(int rank, double pbv_maintenance, double pgbv_maintenance, String memberid)
        throws MvcException
    {
        boolean status;
        Connection conn;
        if(memberid == null)
            throw new IllegalArgumentException("No member specified");
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            status = getBroker(conn).updateMemberBonusStatus(rank, pbv_maintenance, pgbv_maintenance, memberid);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
         releaseConnection(conn);
        return status;
        }
    }

    private double[] getMemberBonusStatus(String memberid)
        throws MvcException
    {
        double values[];
        Connection conn;
        if(memberid == null)
            throw new IllegalArgumentException("No member specified");
        values = (double[])null;
        conn = null;
        try
        {
            conn = getConnection();
            values = getBroker(conn).getMemberBonusStatus(memberid);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return values;
        }
    }

    private boolean addMemberStartedPackBv(SalesmanBean member)
        throws MvcException
    {
        boolean status;
        Connection conn;
        if(member == null)
            throw new IllegalArgumentException("No member specified");
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            BvWalletBean bean = new BvWalletBean();
            Date bonusDate = Sys.parseDate(member.getBonusPeriodID());
            bean.setBonusDate(bonusDate);
            bean.setPeriodID(member.getBonusPeriodID());
            bean.setOwnerID(member.getMemberID());
            bean.setOwnerType(member.getType());
            bean.setOwnerName(member.getName());
            bean.setTrxType("ISAL");
            if (member.getRegister() == 2)
                bean.setBvIn(110D);
            else                
                bean.setBvIn(0.0D);            
            bean.setBvIn1(110D);
            if (member.getRegister() == 4)
                bean.setBvOut1(110D);
            else                
                bean.setBvOut1(0.0D);
            bean.setStd_createBy(member.getStd_createBy());
            bean.setStd_createDate(member.getStd_createDate());
            bean.setStd_createTime(member.getStd_createTime());
            long seqID = (new BvWalletManager(conn)).insertDistributorBvItem(bean);
            if(seqID > 0L)
                status = true;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return status;
        }
    }

    private boolean addMember(SalesmanBean member)
        throws MvcException
    {
        boolean status;
        Connection conn;
        if(member == null)
            throw new IllegalArgumentException("No member specified");
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            member.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
            if(member.getRegStatus() == 0)
                status = getBroker(conn).quickRegisterMember(member);
            else
            if(member.getRegStatus() == 10)
                status = getBroker(conn).fullRegisterMember(member);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return status;
        }
    }

    private boolean updateMember(SalesmanBean member)
        throws MvcException
    {
        boolean status;
        Connection conn;
        if(member == null)
            throw new IllegalArgumentException("No member specified");
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            member.parseModificationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
            status = getBroker(conn).updateMember(member);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return status;
        }
    }

    private boolean insertSponsorTree(String memberID, String introducerID)
        throws MvcException
    {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            SponsorTreeManager ntwkMgr = new SponsorTreeManager(conn);
            status = ntwkMgr.addSponsorTreeNode(memberID, introducerID);
        }
        catch(Exception e)
        {
            status = false;
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return status;
        }
    }

    private boolean runMemberIDFactory(MvcReturnBean returnBean, SalesmanBean bean)
    {
        boolean status = false;
        try
        {
            MemberIDInterface memberIdInterface = MemberIDFactory.getMemberIDMgr("Sequence Basis");
            Object result = memberIdInterface.generateMemberID(8, bean.getRegPrefix(), bean.getMemberSeq());
            if(result != null)
            {
                bean.setMemberID((String)result);
                status = true;
            }
        }
        catch(Exception e)
        {
            status = false;
            returnBean.setException(e);
            Log.error(e);
        }
        return status;
    }

    private void checkBonusPeriodInfo(SalesmanBean bean, MvcReturnBean returnBean, HttpServletRequest request)
    {
        BonusPeriodManager bonusPeriodManager = new BonusPeriodManager();
        boolean isBonusDateActive = false;
        try
        {
            Date bonusDate = Sys.parseDate(request.getParameter("BonusDate"));
            isBonusDateActive = bonusPeriodManager.isBonusPeriodActive(new java.sql.Date(bonusDate.getTime()), 50);
            if(isBonusDateActive)
                bean.setBonusPeriodID(Sys.getDateFormater().format(bonusDate));
            else
                returnBean.addError("Bonus Date is closed");
        }
        catch(Exception e)
        {
            returnBean.addError("Invalid Bonus Date Format");
        }
         System.out.println("masuk checkBonusPeriodInfo BonusDate " + isBonusDateActive );   
    }
    
    
    public MvcReturnBean getList()
        throws Exception
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        SalesmanBean beans[] = getAllCurency();
         System.out.println("masuk getList " );   
        returnBean.addReturnObject("List", beans);
        return returnBean;
    }

    public SalesmanBean[] getAllCurency()
        throws MvcException
    {
        SalesmanBean clist[];
        Connection conn;
        clist = new SalesmanBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getFullList();
            if(!list.isEmpty())
                clist = (SalesmanBean[])list.toArray(new SalesmanBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return clist;
        }
    }

     

    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginuser)
    {
        setLoginUser(loginuser);
        MvcReturnBean returnBean = null;
        boolean formSubmitted = request.getParameter("SubmitData") != null;
           
        try
        {
            switch(taskId)
            {
            default:
                break;

            case 107238: 
                returnBean = getList();
                break;
                
                
            case 104002: 
            case 202001: 
            {
                if(formSubmitted)
                {
                    returnBean = checkPreRegisterForm(request);
                    if(returnBean.getTaskStatus() == 1)
                    {
                        String params = (String)returnBean.getReturnObject("ReturnParam");
                        returnBean.setTaskStatus(3);
                        returnBean.setAlternateReturnMethod(2);
                        returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(taskId != 0x31511 ? 0x19643 : 0x31512, request)))).append(params).toString());
                    } 
   
                }
                 
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                    returnBean.addReturnObject("IdentityType", getMapForIdentityType());
                break;
            }

            case 104001: 
            case 104003: 
            case 202002: 
            {
                if(formSubmitted)
                {
                    int registerStatus = taskId != 0x19641 ? 10 : 0;
                    
                    returnBean = registerMember(registerStatus, request);
                    if(returnBean.getTaskStatus() == 1)
                    {
                        int nextTaskID = taskId;
                        if(taskId == 0x19643)
                            nextTaskID = 0x19642;
                        else
                        if(taskId == 0x31512)
                            nextTaskID = 0x31511;
                        
                        StringBuffer sbParam = new StringBuffer();
                        sbParam.append("&MemberSeq=").append(returnBean.getReturnObject("MemberSeq")).append("&TaskID=").append(String.valueOf(nextTaskID)).append("&MemberID=").append(returnBean.getReturnObject("MemberID"));
                        String noPin = (String)returnBean.getReturnObject("nopin");
                        if(noPin != null)
                            sbParam.append("&nopin=").append(noPin);
                        returnBean.setTaskStatus(3);
                        returnBean.setAlternateReturnMethod(2);
                        returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(taskId != 0x31512 ? 0x19644 : 0x31513, request)))).append(sbParam.toString()).toString());                        
                    }
                }
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                if(taskId == 0x19643 || taskId == 0x31512)
                {
                    returnBean.addReturnObject("MemberID", request.getParameter("MemberID"));
                    returnBean.addReturnObject("IntroducerID", request.getParameter("IntroducerID"));
                    returnBean.addReturnObject("IntroducerName", request.getParameter("IntroducerName"));
                    returnBean.addReturnObject("IntroducerContact", request.getParameter("IntroducerContact"));
                    returnBean.addReturnObject("PlacementID", request.getParameter("PlacementID"));
                    returnBean.addReturnObject("BonusDateStr", request.getParameter("BonusDateStr"));
                    returnBean.addReturnObject("JoinDateStr", request.getParameter("JoinDateStr"));
                    returnBean.addReturnObject("Type", request.getParameter("Type"));
                    returnBean.addReturnObject("Register", request.getParameter("Register"));
                    returnBean.addReturnObject("Name", request.getParameter("Name"));
                    returnBean.addReturnObject("IdentityNo", request.getParameter("IdentityNo"));
                    returnBean.addReturnObject("IdentityType", request.getParameter("IdentityType"));
                    String noPin = request.getParameter("nopin");
                    if(noPin != null)
                        returnBean.addReturnObject("nopin", request.getParameter("nopin"));
                    returnBean.addReturnObject("BonusPeriodID", request.getParameter("BonusPeriodID"));
                } else
                {
                    returnBean.addReturnObject("IdentityType", getMapForIdentityType());
                }
                
                 System.out.println("nopin " + request.getParameter("nopin") + " Type " + request.getParameter("Type") + " Register " + request.getParameter("Register"));   
                break;
            }

            case 104004: 
            case 104006: 
            case 104007: 
            case 202003: 
            {
                String memberID = request.getParameter("MemberID");
                String memberSeq = request.getParameter("MemberSeq");
                SalesmanBean bean = null;
                returnBean = new MvcReturnBean();
                if(memberID != null && memberID.trim().length() > 0)
                    bean = getMemberByID(memberID, true);
                else
                if(memberSeq != null && memberSeq.trim().length() > 0)
                    bean = getMemberBySeq(Integer.parseInt(memberSeq), true);
                if(bean == null)
                    returnBean.setSysMessage("Record not found.");
                returnBean.addReturnObject("MemberBean", bean);
                if(taskId == 0x19644 || taskId == 0x31513)
                    returnBean.addReturnObject("TaskID", request.getParameter("TaskID"));
                break;
            }

            case 300015: 
            case 300016: 
            {
                returnBean = new MvcReturnBean();
                String memberID = getLoginUser().getUserId();
                SalesmanBean bean = getMemberByID(memberID, true);
                if(bean != null)
                {
                    SalesmanBean intrBean = getMemberByID(bean.getIntroducerID(), true);
                    SalesmanBean placeBean = getMemberByID(bean.getPlacementID(), true);
                    bean.setIntroducer(intrBean);
                    bean.setPlacement(placeBean);
                } else
                {
                    returnBean.addError("Fail to retrieve profile");
                }
                if(taskId == 0x493ef && formSubmitted)
                {
                    returnBean = updateMember(request);
                    if(returnBean.getTaskStatus() == 1)
                    {
                        returnBean.setTaskStatus(3);
                        returnBean.setAlternateReturnMethod(2);
                        returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(0x493f0, request)))).append("&MemberID=").append(memberID).toString());
                    }
                }
                returnBean.addReturnObject("MemberBean", bean);
                break;
            }

            case 202006: 
            {
                String memberID = request.getParameter("MemberID");
                SalesmanBean bean = null;
                returnBean = new MvcReturnBean();
                if(memberID != null && memberID.trim().length() > 0)
                    bean = getMemberByID(memberID, getLoginUser().getOutletID(), true);
                if(bean == null)
                    returnBean.setSysMessage("Record not found.");
                returnBean.addReturnObject("MemberBean", bean);
                break;
            }

            case 104008: 
            case 104009: 
            case 104010: 
            {
                boolean next = false;
                SalesmanBean bean = null;
                int nextTaskID = 0x19647;
                String memberID = request.getParameter("MemberID");
                if(formSubmitted)
                {
                    returnBean = updateMember(request);
                    if(returnBean.getTaskStatus() == 1)
                    {
                        returnBean.setTaskStatus(3);
                        returnBean.setAlternateReturnMethod(2);
                        returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(nextTaskID, request)))).append("&MemberID=").append(memberID).toString());
                        next = true;
                    }
                }
                if(next)
                    break;
                if(memberID != null && memberID.trim().length() > 0)
                    bean = getMemberByID(memberID, true);
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                if(bean == null && formSubmitted)
                    returnBean.addError("Record not found.");
                returnBean.addReturnObject("MemberBean", bean);
                break;
            }

            case 104015: 
            {
                returnBean = new MvcReturnBean();
                boolean next = false;
                boolean search = false;
                SalesmanBean bean = null;
                String memberID = request.getParameter("MemberID");
                if(memberID != null && memberID.trim().length() > 0)
                {
                    bean = getMemberByID(memberID, true);
                    search = true;
                }
                if(formSubmitted)
                {
                    parseBean(bean, request, true);
                    checkIntroducer(bean, returnBean);
                    if(!returnBean.hasErrorMessages())
                    {
                        upperCaseBean(bean);
                        boolean status = changeIntroducer(bean);
                        if(status)
                        {
                            String msg = "Change Introducer executed successfully. \n Please launch the Parse Upline Tree at Bonus > Backend Tasks function to reflect the changes. ";
                            returnBean.setTaskStatus(4);
                            returnBean.setSysMessage(msg);
                            next = true;
                        } else
                        {
                            returnBean.fail();
                        }
                    } else
                    {
                        returnBean.fail();
                    }
                }
                if(next)
                    break;
                if(search && bean == null)
                    returnBean.addError("Record not found.");
                returnBean.addReturnObject("MemberBean", bean);
                break;
            }

            case 300017: 
            {
                boolean next = false;
                SalesmanBean bean = null;
                String memberID = getLoginUser().getUserId();
                if(formSubmitted)
                {
                    returnBean = updatePassword(memberID, taskId, request, true, 0);
                    next = returnBean.getTaskStatus() == 1;
                }
                if(next)
                    break;
                if(memberID != null && memberID.trim().length() > 0)
                    bean = getMemberByID(memberID, true);
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                if(bean == null)
                    returnBean.addError("Record not found.");
                returnBean.addReturnObject("MemberBean", bean);
                break;
            }

            case 104016: 
            {
                boolean next = false;
                SalesmanBean bean = null;
                String memberID = request.getParameter("MemberID");
                if(formSubmitted)
                {
                    returnBean = updatePassword(memberID, taskId, request, false, 1);
                    next = returnBean.getTaskStatus() == 1;
                }
                if(next)
                    break;
                if(memberID != null && memberID.trim().length() > 0)
                    bean = getMemberByID(memberID, true);
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                if(bean == null && formSubmitted)
                    returnBean.addError("Record not found.");
                returnBean.addReturnObject("MemberBean", bean);
                break;
            }

            case 104017: 
            {
                boolean next = false;
                boolean search = false;
                SalesmanBean bean = null;
                String memberID = request.getParameter("MemberID");
                if(memberID != null && memberID.trim().length() > 0)
                {
                    bean = getMemberByID(memberID, true);
                    search = true;
                }
                if(formSubmitted)
                {
                    returnBean = updateMember(request);
                    if(returnBean.getTaskStatus() == 1)
                    {
                        int nextTaskID = 0x19647;
                        returnBean.setTaskStatus(3);
                        returnBean.setAlternateReturnMethod(2);
                        returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(nextTaskID, request)))).append("&MemberID=").append(memberID).toString());
                        next = true;
                    }
                }
                if(next)
                    break;
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                if(bean != null)
                    returnBean.addReturnObject("MbrshipType", getMapForMbrshipStatus(false, bean.getStatus()));
                else
                if(search && bean == null)
                    returnBean.addError("Record not found.");
                returnBean.addReturnObject("MemberBean", bean);
                break;
            }

            case 104018: 
            {
                boolean next = false;
                boolean search = false;
                SalesmanBean bean = null;
                String memberID = request.getParameter("MemberID");
                if(memberID != null && memberID.trim().length() > 0)
                {
                    bean = getMemberByID(memberID, true);
                    search = true;
                }
                if(formSubmitted)
                {
                    returnBean = transferMembership(request);
                    if(returnBean.getTaskStatus() == 1)
                    {
                        int nextTaskID = 0x19647;
                        returnBean.setTaskStatus(3);
                        returnBean.setAlternateReturnMethod(2);
                        returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(nextTaskID, request)))).append("&MemberID=").append(memberID).toString());
                        next = true;
                    }
                }
                if(next)
                    break;
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                if(search && bean == null)
                    returnBean.addError("Record not found.");
                returnBean.addReturnObject("MemberBean", bean);
                break;
            }

            case 104011: 
            case 104012: 
            case 104013: 
            {
                returnBean = searchMemberBy(taskId, request);
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                String formName = request.getParameter("FormName");
                String objName = request.getParameter("ObjName");
                String propName = request.getParameter("PropName");
                if(formName == null)
                    formName = "";
                if(objName == null)
                    objName = "";
                if(propName == null)
                    propName = "";
                returnBean.addReturnObject("FormName", formName);
                returnBean.addReturnObject("ObjName", objName);
                returnBean.addReturnObject("PropName", propName);
                returnBean.addReturnObject("TaskID", String.valueOf(taskId));
                break;
            }                
                
            case 202011: 
            {
                returnBean = searchMemberBy2(taskId, request);
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                String formName = request.getParameter("FormName");
                String objName = request.getParameter("ObjName");
                String propName = request.getParameter("PropName");
                if(formName == null)
                    formName = "";
                if(objName == null)
                    objName = "";
                if(propName == null)
                    propName = "";
                returnBean.addReturnObject("FormName", formName);
                returnBean.addReturnObject("ObjName", objName);
                returnBean.addReturnObject("PropName", propName);
                returnBean.addReturnObject("TaskID", String.valueOf(taskId));
                break;
            }

            case 104014: 
            {
                returnBean = searchMemberSelection(request);
                break;
            }

            case 202005: 
            {
                returnBean = new MvcReturnBean();
                SalesmanBean beans[] = EMPTY_ARRAY_MEMBER;
                Date joinDtFrom = null;
                Date joinDtTo = null;
                if(!formSubmitted)
                    break;
                String memberID = request.getParameter("MemberID");
                String name = request.getParameter("MemberName");
                String identity = request.getParameter("IdentityNo");
                String mobile = request.getParameter("MobileNo");
                try
                {
                    if(joinDtFrom == null)
                        joinDtFrom = Sys.parseDate(request.getParameter("JoinDateFrom"));
                    if(joinDtTo == null)
                        joinDtTo = Sys.parseDate(request.getParameter("JoinDateTo"));
                }
                catch(Exception exception) { }
                beans = searchMemberSelectionForStockist(memberID, name, identity, mobile, joinDtFrom, joinDtTo);
                if(beans.length <= 0)
                    returnBean.addMessage("No record found !!!");
                returnBean.addReturnObject("MemberList", beans);
                break;
            }

            case 104028: 
            {
                returnBean = new MvcReturnBean();
                SalesmanBean bean = null;
                double values[] = (double[])null;
                MvcReturnBean _return = (MvcReturnBean)request.getAttribute("MvcReturnBean");
                if(_return != null)
                    returnBean = _return;
                String memberID = request.getParameter("MemberID");
                if(memberID != null)
                {
                    bean = getMemberByID(memberID, true);
                    if(bean == null)
                        returnBean.addError("Record not found.");
                    else
                        values = getMemberBonusStatus(memberID);
                    returnBean.addReturnObject("MemberRankings", BonusConstants.getMapForRankings(false));
                }
                returnBean.addReturnObject("MemberBean", bean);
                returnBean.addReturnObject("MemberBnsMaint", values);
                break;
            }

            case 104029: 
            {
                returnBean = new MvcReturnBean();
                SalesmanBean bean = null;
                String memberID = request.getParameter("MemberID");
                String newRank = request.getParameter("NewRank");
                String minPBV = request.getParameter("MINPBV");
                String minPGBV = request.getParameter("MINPGBV");
                if(memberID != null)
                {
                    bean = getMemberByID(memberID, true);
                    if(bean == null)
                    {
                        returnBean.addError("Member ID not found.");
                        returnBean.fail();
                        break;
                    }
                    int fixedRank = 0;
                    double pbv_maintain = 0.0D;
                    double pgbv_maintain = 0.0D;
                    try
                    {
                        fixedRank = Integer.parseInt(newRank);
                    }
                    catch(NumberFormatException numex)
                    {
                        returnBean.addError("Invalid Rank value.");
                        returnBean.fail();
                    }
                    try
                    {
                        pbv_maintain = Double.parseDouble(minPBV);
                    }
                    catch(NumberFormatException numex)
                    {
                        returnBean.addError("Invalid MIN PBV value.");
                        returnBean.fail();
                    }
                    try
                    {
                        pgbv_maintain = Double.parseDouble(minPGBV);
                    }
                    catch(NumberFormatException numex)
                    {
                        returnBean.addError("Invalid MIN PGBV value.");
                        returnBean.fail();
                    }
                    if(returnBean.isFail())
                        break;
                    bean.setBonusRank(fixedRank);
                    boolean isSuccess = updateMember(bean);
                    if(isSuccess)
                        updateMemberBonusStatus(fixedRank, pbv_maintain, pgbv_maintain, memberID);
                    if(isSuccess)
                    {
                        returnBean.addMessage("MDL008");
                        returnBean.addReturnParameter("MemberID", memberID);
                        returnBean.done();
                    } else
                    {
                        returnBean.addError("MDL009");
                        returnBean.fail();
                    }
                } else
                {
                    returnBean.addError("Member ID not found.");
                    returnBean.fail();
                }
                break;
            }
            }
        }
        catch(Exception e)
        {
            if(returnBean == null)
                returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }
        return returnBean;
    }

}
