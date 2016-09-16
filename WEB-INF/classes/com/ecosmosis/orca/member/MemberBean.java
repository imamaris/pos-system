// Decompiled Progress by Dodi
// DeCompiled : MemberBean.class

package com.ecosmosis.orca.member;

import com.ecosmosis.common.bank.BankBean;
import com.ecosmosis.common.bank.BankManager;
import com.ecosmosis.orca.bvwallet.BvWalletBean;
import com.ecosmosis.orca.bvwallet.BvWalletManager;
import com.ecosmosis.common.locations.LocationBean;
import com.ecosmosis.mvc.bean.MvcBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.orca.bean.*;
import java.sql.*;
import java.util.Date;

public class MemberBean extends MvcBean
{

    public static String FIELD_SEQ = "mbr_seq";
    public static String FIELD_ID = "mbr_mbrid";
    public static String FIELD_MBRTYPE = "mbr_type";
    public static String FIELD_MBRREG = "mbr_register";
    
    public static String FIELD_JOIN_DATE = "mbr_joindate";
    public static String FIELD_JOIN_DATE_FROM = "mbr_joindate_from";
    public static String FIELD_JOIN_DATE_TO = "mbr_joindate_to";
    public static String FIELD_NAME = "mbr_name";
    public static String FIELD_IDENTITY_NO = "mbr_identityno";
    public static String FIELD_REGFORM_NO = "mbr_register_formno";
    public static String FIELD_MBRSHIP_STATUS = "mbr_status";
    public static String FIELD_OFFICE = "mbr_officeno";
    public static String FIELD_FAX = "mbr_faxno";
    public static String FIELD_HOME = "mbr_homeno";
    public static String FIELD_MOBILE = "mbr_mobileno";
    private int memberSeq;
    private String memberID;
    private String password;
    private String epin;
    private String homeBranchID;
    private String payoutCurrency;
    private String type;
    private int register;
    private Date joinDate;
    private Time joinTime;
    private String title;
    private String name;
    private String firstName;
    private String lastName;
    private String displayName;
    private String identityNo;
    private String identityType;
    private String companyName;
    private String companyRegNo;
    private Date companyRegDate;
    private String nric;
    private String oldNric;
    private String passport;
    private String incomeTaxNo;
    private Date dob;
    private String gender;
    private String nationalityID;
    private String race;
    private String marital;
    private int children;
    private String occupation;
    private String occupationPosition;
    private String language;
    private String remark;
    private String officeNo;
    private String officeExtNo;
    private String faxNo;
    private String homeNo;
    private String mobileNo;
    private String email;
    private int bonusRank;
    private int bonusTree;
    private String introducerID;
    private String introducerName;
    private String introducerIdentityNo;
    private String introducerContact;
    private String introducerMissing;
    private String placementID;
    private String placementName;
    private String placementIdentityNo;
    private String placementContact;
    private String originalID;
    private String placementMissing;
    private String regFormNo;
    private int regRunningNo;
    private String regPrefix;
    private int regStatus;
    private int loginStatus;
    private int status;
    private String hidden;
    private String locale;
    private boolean changePassword;
    private String joinDateStr;
    private String joinTimeStr;
    private String companyRegDateStr;
    private String dobStr;
    
    private String idCRM;
    private String segmentationCRM;
    private Date   validCRM ;
    
    private String ethnic; //Updated By Ferdi 2015-01-23
    
    private int age;
    private String chkIntrID;
    private String chkPlaceID;
    private String bonusPeriodID;
    private AddressBean address;
    private PayeeBankBean payeeBank;
    private SupervisorBean supervisor;
    private SpouseBean spouse;
    private BeneficiaryBean beneficiary;
    private LocationBean selfNationality;
    private LocationBean spouseNationality;
    private LocationBean beneficiaryNationality;
    private MemberBean introducer;
    private MemberBean placement;
    private boolean chkPin;

    // tambahan new register report
    private String branch;
    private int jumlah;
    
    public MemberBean()
    {
        chkIntrID = null;
        chkPlaceID = null;
        bonusPeriodID = null;
        chkPin = true;
        
        branch = null;
        jumlah = 0;
    }

    public int getAge()
    {
        return age;
    }

    public void setAge(int age)
    {
        this.age = age;
    }

    public int getBonusRank()
    {
        return bonusRank;
    }

    public void setBonusRank(int bonusRank)
    {
        this.bonusRank = bonusRank;
    }

    public int getBonusTree()
    {
        return bonusTree;
    }

    public void setBonusTree(int bonusTree)
    {
        this.bonusTree = bonusTree;
    }

    public int getChildren()
    {
        return children;
    }

    public void setChildren(int children)
    {
        this.children = children;
    }

    public String getCompanyName()
    {
        return companyName;
    }

    public void setCompanyName(String companyName)
    {
        this.companyName = companyName;
    }

    public String getCompanyRegNo()
    {
        return companyRegNo;
    }

    public void setCompanyRegNo(String companyRegNo)
    {
        this.companyRegNo = companyRegNo;
    }

    public Date getCompanyRegDate()
    {
        return companyRegDate;
    }

    public void setCompanyRegDate(Date companyRegDate)
    {
        this.companyRegDate = companyRegDate;
    }

    public String getCompanyRegDateStr()
    {
        return companyRegDateStr;
    }

    public void setCompanyRegDateStr(String companyRegDateStr)
    {
        this.companyRegDateStr = companyRegDateStr;
    }

    public String getDisplayName()
    {
        return displayName;
    }

    public void setDisplayName(String displayName)
    {
        this.displayName = displayName;
    }

    public Date getDob()
    {
        return dob;
    }

    public void setDob(Date dob)
    {
        this.dob = dob;
    }

    public String getEmail()
    {
        return email;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    public String getEpin()
    {
        return epin;
    }

    public void setEpin(String epin)
    {
        this.epin = epin;
    }

    public String getFaxNo()
    {
        return faxNo;
    }

    public void setFaxNo(String faxNo)
    {
        this.faxNo = faxNo;
    }

    public String getFirstName()
    {
        return firstName;
    }

    public void setFirstName(String firstName)
    {
        this.firstName = firstName;
    }

    public String getGender()
    {
        return gender;
    }

    public void setGender(String gender)
    {
        this.gender = gender;
    }

    public boolean isHidden()
    {
        return hidden.equalsIgnoreCase("Y");
    }

    public void setHidden(String hidden)
    {
        this.hidden = hidden;
    }

    public String getHomeBranchID()
    {
        return homeBranchID;
    }

    public void setHomeBranchID(String homeBranchID)
    {
        this.homeBranchID = homeBranchID;
    }

    public String getHomeNo()
    {
        return homeNo;
    }

    public void setHomeNo(String homeNo)
    {
        this.homeNo = homeNo;
    }

    public String getIdentityNo()
    {
        return identityNo;
    }

    public void setIdentityNo(String identityNo)
    {
        this.identityNo = identityNo;
    }

    public String getIdentityType()
    {
        return identityType;
    }

    public void setIdentityType(String identityType)
    {
        this.identityType = identityType;
    }

    public String getIncomeTaxNo()
    {
        return incomeTaxNo;
    }

    public void setIncomeTaxNo(String incomeTaxNo)
    {
        this.incomeTaxNo = incomeTaxNo;
    }

    public Date getJoinDate()
    {
        return joinDate;
    }

    public void setJoinDate(Date joinDate)
    {
        this.joinDate = joinDate;
    }

    public Time getJoinTime()
    {
        return joinTime;
    }

    public void setJoinTime(Time joinTime)
    {
        this.joinTime = joinTime;
    }

    public String getLanguage()
    {
        return language;
    }

    public void setLanguage(String language)
    {
        this.language = language;
    }

    public String getLastName()
    {
        return lastName;
    }

    public void setLastName(String lastName)
    {
        this.lastName = lastName;
    }

    public int getLoginStatus()
    {
        return loginStatus;
    }

    public void setLoginStatus(int loginStatus)
    {
        this.loginStatus = loginStatus;
    }

    public String getMarital()
    {
        return marital;
    }

    public void setMarital(String marital)
    {
        this.marital = marital;
    }

    public String getMemberID()
    {
        return memberID;
    }

    public void setMemberID(String memberID)
    {
        this.memberID = memberID;
    }

    public int getMemberSeq()
    {
        return memberSeq;
    }

    public void setMemberSeq(int memberSeq)
    {
        this.memberSeq = memberSeq;
    }

    public String getMobileNo()
    {
        return mobileNo;
    }

    public void setMobileNo(String mobileNo)
    {
        this.mobileNo = mobileNo;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getNationalityID()
    {
        return nationalityID;
    }

    public void setNationalityID(String nationalityID)
    {
        this.nationalityID = nationalityID;
    }

    public String getNric()
    {
        return nric;
    }

    public void setNric(String nric)
    {
        this.nric = nric;
    }

    public String getOccupation()
    {
        return occupation;
    }

    public void setOccupation(String occupation)
    {
        this.occupation = occupation;
    }

    public String getOccupationPosition()
    {
        return occupationPosition;
    }

    public void setOccupationPosition(String occupationPosition)
    {
        this.occupationPosition = occupationPosition;
    }

    public String getOfficeExtNo()
    {
        return officeExtNo;
    }

    public void setOfficeExtNo(String officeExtNo)
    {
        this.officeExtNo = officeExtNo;
    }

    public String getOfficeNo()
    {
        return officeNo;
    }

    public void setOfficeNo(String officeNo)
    {
        this.officeNo = officeNo;
    }

    public String getOldNric()
    {
        return oldNric;
    }

    public void setOldNric(String oldNric)
    {
        this.oldNric = oldNric;
    }

    public String getPassport()
    {
        return passport;
    }

    public void setPassport(String passport)
    {
        this.passport = passport;
    }

    public String getPassword()
    {
        return password;
    }

    public void setPassword(String password)
    {
        this.password = password;
    }

    public String getPayoutCurrency()
    {
        return payoutCurrency;
    }

    public void setPayoutCurrency(String payoutCurrency)
    {
        this.payoutCurrency = payoutCurrency;
    }

    public String getRace()
    {
        return race;
    }

    public void setRace(String race)
    {
        this.race = race;
    }

    public String getRegFormNo()
    {
        return regFormNo;
    }

    public void setRegFormNo(String regFormNo)
    {
        this.regFormNo = regFormNo;
    }

    public String getRegPrefix()
    {
        return regPrefix;
    }

    public void setRegPrefix(String regPrefix)
    {
        this.regPrefix = regPrefix;
    }

    public int getRegRunningNo()
    {
        return regRunningNo;
    }

    public void setRegRunningNo(int regRunningNo)
    {
        this.regRunningNo = regRunningNo;
    }

    public int getRegStatus()
    {
        return regStatus;
    }

    public void setRegStatus(int regStatus)
    {
        this.regStatus = regStatus;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

    public int getStatus()
    {
        return status;
    }

    public void setStatus(int status)
    {
        this.status = status;
    }

    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public int getRegister()
    {
        return register;
    }

    public void setRegister(int register)
    {
        this.register = register;
    }
 
    /*
    public String getRegister()
    {
        return register;
    }

    public void setRegister(String register)
    {
        this.register = register;
    }
    */
    
    public String getIntroducerContact()
    {
        return introducerContact;
    }

    public void setIntroducerContact(String introducerContact)
    {
        this.introducerContact = introducerContact;
    }

    public String getIntroducerID()
    {
        return introducerID;
    }

    public void setIntroducerID(String introducerID)
    {
        this.introducerID = introducerID;
    }

    public String getIntroducerName()
    {
        return introducerName;
    }

    public void setIntroducerName(String introducerName)
    {
        this.introducerName = introducerName;
    }

    public String getIntroducerIdentityNo()
    {
        return introducerIdentityNo;
    }

    public void setIntroducerIdentityNo(String introducerIdentityNo)
    {
        this.introducerIdentityNo = introducerIdentityNo;
    }

    public String getIntroducerMissing()
    {
        return introducerMissing;
    }

    public void setIntroducerMissing(String introducerMissing)
    {
        this.introducerMissing = introducerMissing;
    }

    public String getPlacementContact()
    {
        return placementContact;
    }

    public void setPlacementContact(String placementContact)
    {
        this.placementContact = placementContact;
    }
    
    public String getPlacementID()
    {
        return placementID;
    }

    public void setPlacementID(String placementID)
    {
        this.placementID = placementID;
    }

    public String getOriginalID()
    {
        return originalID;
    }

    public void setOriginalID(String originalID)
    {
        this.originalID = originalID;
    }

    public String getPlacementIdentityNo()
    {
        return placementIdentityNo;
    }

    public void setPlacementIdentityNo(String placementIdentityNo)
    {
        this.placementIdentityNo = placementIdentityNo;
    }

    public String getPlacementName()
    {
        return placementName;
    }

    public void setPlacementName(String placementName)
    {
        this.placementName = placementName;
    }

    public String getPlacementMissing()
    {
        return placementMissing;
    }

    public void setPlacementMissing(String placementMissing)
    {
        this.placementMissing = placementMissing;
    }

    public String getLocale()
    {
        return locale;
    }

    public void setLocale(String locale)
    {
        this.locale = locale;
    }

    public boolean isChangePassword()
    {
        return changePassword;
    }

    public void setChangePassword(boolean changePassword)
    {
        this.changePassword = changePassword;
    }

    public AddressBean getAddress()
    {
        return address;
    }

    public void setAddress(AddressBean address)
    {
        this.address = address;
    }

    public PayeeBankBean getPayeeBank()
    {
        return payeeBank;
    }

    public void setPayeeBank(PayeeBankBean payeeBank)
    {
        this.payeeBank = payeeBank;
    }

/*    public BvWalletBean getbvWallet()
    {
        return bvWallet;
    }

    public void setbvWallet(BvWalletBean bvWallet)
    {
        this.bvWallet = bvWallet;
    }
*/
  
    public BeneficiaryBean getBeneficiary()
    {
        return beneficiary;
    }

    public void setBeneficiary(BeneficiaryBean beneficiary)
    {
        this.beneficiary = beneficiary;
    }

    public MemberBean getIntroducer()
    {
        return introducer;
    }

    public void setIntroducer(MemberBean introducer)
    {
        this.introducer = introducer;
    }

    public MemberBean getPlacement()
    {
        return placement;
    }

    public void setPlacement(MemberBean placement)
    {
        this.placement = placement;
    }

    public SpouseBean getSpouse()
    {
        return spouse;
    }

    public void setSpouse(SpouseBean spouse)
    {
        this.spouse = spouse;
    }

    public SupervisorBean getSupervisor()
    {
        return supervisor;
    }

    public void setSupervisor(SupervisorBean supervisor)
    {
        this.supervisor = supervisor;
    }

    public String getDobStr()
    {
        return dobStr;
    }

    public void setDobStr(String dobStr)
    {
        this.dobStr = dobStr;
    }

    public String getJoinDateStr()
    {
        return joinDateStr;
    }

    public void setJoinDateStr(String joinDateStr)
    {
        this.joinDateStr = joinDateStr;
    }

    public String getJoinTimeStr()
    {
        return joinTimeStr;
    }

    public void setJoinTimeStr(String joinTimeStr)
    {
        this.joinTimeStr = joinTimeStr;
    }

    public LocationBean getBeneficiaryNationality()
    {
        return beneficiaryNationality;
    }

    public void setBeneficiaryNationality(LocationBean beneficiaryNationality)
    {
        this.beneficiaryNationality = beneficiaryNationality;
    }

    public LocationBean getSelfNationality()
    {
        return selfNationality;
    }

    public void setSelfNationality(LocationBean selfNationality)
    {
        this.selfNationality = selfNationality;
    }

    public LocationBean getSpouseNationality()
    {
        return spouseNationality;
    }

    public void setSpouseNationality(LocationBean spouseNationality)
    {
        this.spouseNationality = spouseNationality;
    }

    public boolean hasIntroducerRef()
    {
        boolean status = false;
        if(getIntroducerID() != null && getIntroducerID().length() > 0)
            status = true;
        return status;
    }

    public boolean hasPlacementRef()
    {
        boolean status = false;
        if(getPlacementID() != null && getPlacementID().length() > 0)
            status = true;
        return status;
    }

    public String getContactInfo()
    {
        boolean hasAnd = false;
        StringBuffer sb = new StringBuffer(50);
        if(homeNo != null && homeNo.length() > 0)
        {
            sb.append("(H) ").append(homeNo);
            hasAnd = true;
        }
        if(mobileNo != null && mobileNo.length() > 0)
        {
            if(hasAnd)
                sb.append("\n");
            else
                hasAnd = true;
            sb.append("(M) ").append(mobileNo);
        }
        if(officeNo != null && officeNo.length() > 0)
        {
            if(hasAnd)
                sb.append("\n");
            else
                hasAnd = true;
            sb.append("(O) ").append(officeNo);
        }
        if(faxNo != null && faxNo.length() > 0)
        {
            if(hasAnd)
                sb.append("\n");
            else
                hasAnd = true;
            sb.append("(F)").append(faxNo);
        }
        if(sb.length() > 0)
            return sb.toString();
        else
            return null;
    }

    public String getChkIntrID()
    {
        return chkIntrID;
    }

    public void setChkIntrID(String chkIntrID)
    {
        this.chkIntrID = chkIntrID;
    }

    public String getChkPlaceID()
    {
        return chkPlaceID;
    }

    public void setChkPlaceID(String chkPlaceID)
    {
        this.chkPlaceID = chkPlaceID;
    }

    public String getBonusPeriodID()
    {
        return bonusPeriodID;
    }

    public void setBonusPeriodID(String bonusPeriodID)
    {
        this.bonusPeriodID = bonusPeriodID;
    }


    
    public String getBranch()
    {
        return branch;
    }

    public void setBranch(String branch)
    {
        this.branch = branch;
    }    
    
    public int getJumlah()
    {
        return jumlah;
    }

    public void setJumlah(int jumlah)
    {
        this.jumlah = jumlah;
    }  
    
    protected void parseAllBean(ResultSet rs)
        throws MvcException, SQLException
    {
        parseAllBean(rs, "");
    }

    protected void parseAllBean(ResultSet rs, String prefix)
        throws MvcException, SQLException
    {
        if(prefix == null)
            prefix = "";
        parseMemberBean(rs, prefix);
        parseAddressBean(rs, prefix);
        parsePayeeBankBean(rs, prefix);
        
        // parseBvWalletBean(rs, prefix);
        
        parseSupervisorBean(rs, prefix);
        parseSpouseBean(rs, prefix);
        parseBeneficiaryBean(rs, prefix);
    }

    protected void parseSimpleBean(ResultSet rs)
        throws MvcException, SQLException
    {
        parseSimpleBean(rs, "");
    }

    public void parseSimpleBean(ResultSet rs, String prefix)
        throws MvcException, SQLException
    {
        if(prefix == null)
            prefix = "";
        parseMemberBean(rs, prefix);
        parseAddressBean(rs, prefix);
        parsePayeeBankBean(rs, prefix);
        // parseBvWalletBean(rs, prefix);
    }

    public void parseMemberBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setMemberSeq(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_seq").toString()));
        setMemberID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mbrid").toString()));
        setPassword(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_passwd").toString()));
        setEpin(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_epin").toString()));
        setHomeBranchID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_home_branchid").toString()));
        setBonusRank(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_bonus_rank").toString()));
        setBonusTree(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_bonus_tree").toString()));
        setPayoutCurrency(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_payout_currency").toString()));
        setType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_type").toString()));
        setRegister(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_register").toString()));
        setJoinDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("mbr_joindate").toString()));
        setJoinTime(rs.getTime((new StringBuilder(String.valueOf(prefix))).append("mbr_jointime").toString()));
        setTitle(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_title").toString()));
        setName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_name").toString()));
        setFirstName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_firstname").toString()));
        setLastName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_lastname").toString()));
        setDisplayName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_displayname").toString()));
        setIdentityNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_identityno").toString()));
        setIdentityType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_identitytype").toString()));
        setCompanyName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_company_name").toString()));
        setCompanyRegNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_company_registerno").toString()));
        setCompanyRegDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("mbr_company_registerdate").toString()));
        setNric(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_nric").toString()));
        setOldNric(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_oldnric").toString()));
        setPassport(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_passport").toString()));
        setIncomeTaxNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_income_taxno").toString()));
        setDob(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("mbr_dob").toString()));
        setGender(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_gender").toString()));
        setNationalityID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_nationalityid").toString()));
        setRace(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_race").toString()));
        setMarital(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_marital").toString()));
        setChildren(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_children").toString()));
        setLoginStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_login_status").toString()));
        setOccupation(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_occupation").toString()));
        setOccupationPosition(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_occupation_position").toString()));
        setLanguage(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_language").toString()));
        setOfficeNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_officeno").toString()));
        setFaxNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_faxno").toString()));
        setHomeNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_homeno").toString()));
        setMobileNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mobileno").toString()));
        setEmail(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_email").toString()));
        setIntroducerID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_intrid").toString()));
        setIntroducerName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_intr_name").toString()));
        setIntroducerIdentityNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_intr_identityno").toString()));
        setIntroducerContact(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_intr_contact").toString()));
        setIntroducerMissing(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_intr_missing").toString()));
        setPlacementID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_placementid").toString()));
        setPlacementName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_placement_name").toString()));
        setPlacementIdentityNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_placement_identityno").toString()));
        setPlacementContact(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_placement_contact").toString()));
        setOriginalID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_id_original").toString()));
        setPlacementMissing(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_placement_missing").toString()));
        setRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_remark").toString()));
        setRegFormNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_register_formno").toString()));
        setRegRunningNo(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_register_runningno").toString()));
        setRegPrefix(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_register_prefix").toString()));
        setRegStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_register_status").toString()));
        setLoginStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_login_status").toString()));
        setStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_status").toString()));
        setHidden(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_hidden").toString()));
        setLocale(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_locale").toString()));
        setChangePassword(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_login_status").toString()) != 0);
        setIdCRM(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_idcrm").toString()));
        setValidCRM(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("mbr_idcrm_valid").toString()));
        setSegmentationCRM(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_segmentation").toString()));
        setEthnic(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_ethnic").toString())); //Updated By Ferdi 2015-01-23
        
        parseInfo(rs, prefix);
    }

    public void parseMemberBeanNew(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setMemberSeq(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_seq").toString()));
        setMemberID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mbrid").toString()));
        setPassword(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_passwd").toString()));
        setEpin(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_epin").toString()));
        setHomeBranchID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_home_branchid").toString()));
        setBonusRank(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_bonus_rank").toString()));
        setBonusTree(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_bonus_tree").toString()));
        setPayoutCurrency(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_payout_currency").toString()));
        setType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_type").toString()));
        setRegister(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_register").toString()));
        // setRegister(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_register").toString()));
        setJoinDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("mbr_joindate").toString()));
        setJoinTime(rs.getTime((new StringBuilder(String.valueOf(prefix))).append("mbr_jointime").toString()));
        setTitle(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_title").toString()));
        setName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_name").toString()));
        setFirstName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_firstname").toString()));
        setLastName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_lastname").toString()));
        setDisplayName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_displayname").toString()));
        setIdentityNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_identityno").toString()));
        setIdentityType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_identitytype").toString()));
        setCompanyName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_company_name").toString()));
        setCompanyRegNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_company_registerno").toString()));
        setCompanyRegDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("mbr_company_registerdate").toString()));
        setNric(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_nric").toString()));
        setOldNric(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_oldnric").toString()));
        setPassport(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_passport").toString()));
        setIncomeTaxNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_income_taxno").toString()));
        setDob(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("mbr_dob").toString()));
        setGender(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_gender").toString()));
        setNationalityID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_nationalityid").toString()));
        setRace(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_race").toString()));
        setMarital(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_marital").toString()));
        setChildren(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_children").toString()));
        setLoginStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_login_status").toString()));
        setOccupation(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_occupation").toString()));
        setOccupationPosition(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_occupation_position").toString()));
        setLanguage(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_language").toString()));
        setOfficeNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_officeno").toString()));
        setFaxNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_faxno").toString()));
        setHomeNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_homeno").toString()));
        setMobileNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mobileno").toString()));
        setEmail(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_email").toString()));
        setIntroducerID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_intrid").toString()));
        setIntroducerName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_intr_name").toString()));
        setIntroducerIdentityNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_intr_identityno").toString()));
        setIntroducerContact(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_intr_contact").toString()));
        setIntroducerMissing(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_intr_missing").toString()));
        setPlacementID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_placementid").toString()));
        setPlacementName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_placement_name").toString()));
        setPlacementIdentityNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_placement_identityno").toString()));
        setPlacementContact(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_placement_contact").toString()));
        setOriginalID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_id_original").toString()));
        setPlacementMissing(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_placement_missing").toString()));
        setRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_remark").toString()));
        setRegFormNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_register_formno").toString()));
        setRegRunningNo(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_register_runningno").toString()));
        setRegPrefix(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_register_prefix").toString()));
        setRegStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_register_status").toString()));
        setLoginStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_login_status").toString()));
        setStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_status").toString()));
        setHidden(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_hidden").toString()));
        setLocale(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_locale").toString()));
        setChangePassword(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_login_status").toString()) != 0);
        setBranch(rs.getString((new StringBuilder(String.valueOf(prefix))).append("loc_branch").toString()));
        setJumlah(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("jumlah").toString()));
        parseInfo(rs, prefix);
    }
    
    
    public void parseAddressBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        AddressBean address = new AddressBean();
        address.setAddressLine1(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_address_line1").toString()));
        address.setAddressLine2(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_address_line2").toString()));
        address.setZipCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_zipcode").toString()));
        address.setCountryID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_countryid").toString()));
        address.setRegionID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_regioinid").toString()));
        address.setStateID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_stateid").toString()));
        address.setCityID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_cityid").toString()));
        address.setMailAddressLine1(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mailing_address_line1").toString()));
        address.setMailAddressLine2(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mailing_address_line2").toString()));
        address.setMailZipCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mailing_zipcode").toString()));
        address.setMailCountryID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mailing_countryid").toString()));
        address.setMailRegionID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mailing_regioinid").toString()));
        address.setMailStateID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mailing_stateid").toString()));
        address.setMailCityID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mailing_cityid").toString()));
        setAddress(address);
    }

    public void parsePayeeBankBean(ResultSet rs, String prefix)
        throws MvcException, SQLException
    {
        if(prefix == null)
            prefix = "";
        PayeeBankBean payeeBank = new PayeeBankBean();
        payeeBank.setBankID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bankid").toString()));
        payeeBank.setBankAcctNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bank_acctno").toString()));
        payeeBank.setBankAcctType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bank_accttype").toString()));
        payeeBank.setBankBranch(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bank_branch").toString()));
        payeeBank.setBankPayeeName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_payee_name").toString()));
        payeeBank.setBankPayeeNric(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_payee_nric").toString()));
        if(payeeBank.getBankID() != null && payeeBank.getBankID().length() > 0)
        {
            BankManager bankManager = new BankManager();
            BankBean bankBean = bankManager.getBank(payeeBank.getBankID());
            payeeBank.setBankBean(bankBean);
        }
        setPayeeBank(payeeBank);
    }

/*    public void parseBvWalletBean(ResultSet rs, String prefix)
        throws MvcException, SQLException
    {
        if(prefix == null)
            prefix = "";
        BvWalletBean bvWallet = new BvWalletBean();
        bvWallet.setBvIn1(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("bvw_bv1_in").toString()));
        bvWallet.setBonusDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("bvw_bonusdate").toString()));
        if(bvWallet.getOwnerID() != null && bvWallet.getOwnerID().length() > 0)
        {
            BvWalletManager bvWalletManager = new BvWalletManager();
            // BvWalletBean bvWalletbean = bvWalletManager.
            // bvWallet.setBonusDate(bvWalletbean);
        }
        setPayeeBank(payeeBank);
    }

  */  
    
    public void parseSupervisorBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        SupervisorBean supervisor = new SupervisorBean();
        supervisor.setSuperTitle(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_supervisor_title").toString()));
        supervisor.setSuperName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_supervisor_name").toString()));
        supervisor.setSuperFirstName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_supervisor_firstname").toString()));
        supervisor.setSuperLastName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_supervisor_lastname").toString()));
        supervisor.setSuperNric(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_supervisor_nric").toString()));
        supervisor.setSuperOccupationPosition(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_supervisor_position").toString()));
        supervisor.setSuperOfficeNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_supervisor_officeno").toString()));
        supervisor.setSuperFaxNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_supervisor_faxno").toString()));
        supervisor.setSuperHomeNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_supervisor_homeno").toString()));
        supervisor.setSuperMobileNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_supervisor_mobileno").toString()));
        setSupervisor(supervisor);
    }

    public void parseSpouseBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        SpouseBean spouse = new SpouseBean();
        spouse.setSpouseName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_spouse_name").toString()));
        spouse.setSpouseFirstName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_spouse_firstname").toString()));
        spouse.setSpouseLastName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_spouse_lastname").toString()));
        spouse.setSpouseNric(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_spouse_nric").toString()));
        spouse.setSpouseOldNric(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_spouse_oldnric").toString()));
        spouse.setSpouseDob(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("mbr_spouse_dob").toString()));
        spouse.setSpouseNationalityID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_spouse_nationalityid").toString()));
        spouse.setSpouseRace(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_spouse_race").toString()));
        spouse.setSpouseOccupation(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_spouse_occupation").toString()));
        spouse.setSpouseContact(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_spouse_contact").toString()));
        setSpouse(spouse);
    }

    public void parseBeneficiaryBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        BeneficiaryBean beneficiary = new BeneficiaryBean();
        beneficiary.setBfName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bf_name").toString()));
        beneficiary.setBfFirstName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bf_firstname").toString()));
        beneficiary.setBfLastName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bf_lastname").toString()));
        beneficiary.setBfNric(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bf_nric").toString()));
        beneficiary.setBfOldNric(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bf_oldnric").toString()));
        beneficiary.setBfDob(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("mbr_bf_dob").toString()));
        beneficiary.setBfGender(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bf_gender").toString()));
        beneficiary.setBfNationalityID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bf_nationalityid").toString()));
        beneficiary.setBfRace(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bf_race").toString()));
        beneficiary.setBfOccupation(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bf_occupation").toString()));
        beneficiary.setBfContact(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bf_contact").toString()));
        beneficiary.setBfRelationship(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_bf_relship").toString()));
        setBeneficiary(beneficiary);
    }

    public void parseLocation(ResultSet rs)
        throws SQLException
    {
        LocationBean temp = null;
        temp = new LocationBean();
        temp.setName(rs.getString("selfnat_loc_name"));
        setSelfNationality(temp);
        temp = new LocationBean();
        temp.setName(rs.getString("spnat_loc_name"));
        setSpouseNationality(temp);
        temp = new LocationBean();
        temp.setName(rs.getString("bfnat_loc_name"));
        setBeneficiaryNationality(temp);
        
        temp = new LocationBean();
        temp.setName(rs.getString("ctry_loc_name"));
        getAddress().setCountry(temp);
        
        temp = new LocationBean();
        temp.setName(rs.getString("state_loc_name"));
        getAddress().setRegion(temp);                
        
        temp = new LocationBean();
        temp.setName(rs.getString("state_loc_name"));
        getAddress().setState(temp);
        
        temp = new LocationBean();
        temp.setName(rs.getString("city_loc_name"));
        getAddress().setCity(temp);
        
        temp = new LocationBean();
        temp.setName(rs.getString("mail_ctry_loc_name"));
        getAddress().setMailCountry(temp);
        temp = new LocationBean();
        temp.setName(rs.getString("mail_state_loc_name"));
        getAddress().setMailState(temp);
        temp = new LocationBean();
        temp.setName(rs.getString("mail_city_loc_name"));
        getAddress().setMailCity(temp);
    }

    public void parseBank(ResultSet rs)
        throws SQLException
    {
        BankBean bank = new BankBean();
        bank.setBankID(rs.getString("bnk_bankid"));
        bank.setCountryID(rs.getString("bnk_countryid"));
        bank.setName(rs.getString("bnk_name"));
        bank.setOtherName(rs.getString("bnk_othername"));
        bank.setSwiftCode(rs.getString("bnk_swiftcode"));
        bank.setStatus(rs.getString("bnk_status"));
        getPayeeBank().setBankBean(bank);
    }

    public boolean isChkPin()
    {
        return chkPin;
    }

    public void setChkPin(boolean chkPin)
    {
        this.chkPin = chkPin;
    }

    public String getIdCRM() {
        return idCRM;
    }

    public void setIdCRM(String idCRM) {
        this.idCRM = idCRM;
    }

    public String getSegmentationCRM() {
        return segmentationCRM;
    }

    public void setSegmentationCRM(String segmentationCRM) {
        this.segmentationCRM = segmentationCRM;
    }

    public Date getValidCRM() {
        return validCRM;
    }

    public void setValidCRM(Date validCRM) {
        this.validCRM = validCRM;
    }
    
    //Updated By Ferdi 2015-01-23
    public String getEthnic() {
        return ethnic;
    }

    public void setEthnic(String ethnic) {
        this.ethnic = ethnic;
    }
    //

}
